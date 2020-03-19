{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}

module Data.Swagger.Internal.Orphans
  (
  ) where

import Control.Monad
import Control.Monad.Catch
import Data.Aeson
import Data.Swagger.Internal.Utils
import Data.Hashable
import Text.URI  as URI

instance Hashable (RText r)
instance Hashable URI
instance Hashable Authority
instance Hashable UserInfo
instance Hashable QueryParam

instance ToJSON URI where
  toJSON = toJSON . URI.render

instance FromJSON URI where
  parseJSON = parseJSON >=> either (fail . displayException) return . URI.mkURI

instance SwaggerMonoid URI where
  swaggerMempty = emptyURI
  swaggerMappend a b | b == emptyURI = a
  swaggerMappend _ b = b

instance ToJSON (RText Host) where
  toJSON = toJSON . URI.unRText

instance FromJSON (RText Host) where
  parseJSON = parseJSON >=> either (fail . displayException) return . URI.mkHost
