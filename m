Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4D283FF6
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404967; cv=none; b=bDgynQLUoNWQa4O/R9a4H57nMQbhmywGU6EP6rbLehqQXftJ80uWT3scrj0whGIFC/d3mi1TYJh0SZ2fCl38CijjE9AZrnxCrXUBNLr4Q6GZZSq6HPKAemvxcYY3/zd70gRtIORQA4WLXsOVStY1+2eoi4OKFqXfUeQJy3pSuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404967; c=relaxed/simple;
	bh=wcNDalnO+PF/Q3Tb7qythG8X3hmgbPObXGJPgQqULMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsS8xX9zCGqM064sYpRshdLmw45c56qom1n1kc7/4eIDlrZGXIXqMECCodhW1uk+QBkzX2tCH7JSbtcZ63QkSk/wa9XIrRBIQCYATmsF1bJU2f6lUrT70fawKx1MeGiuPK9xzpsTUtMY6Y28/Sw1d0ST8GLU5Wc8BxfYokjYWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xDEPbOCl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xDEPbOCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=wcNDalnO+PF/Q3Tb7qythG8X3hmgbPObXGJPgQqULMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=xDEPbOClcdLSA7XjKTgnIoKGqEEAYJuPsypIJ3/cc7rrYFEtfiTXIwZvqt4AiKPoz
	 WvgUmYIFfGGUmsn+DXwzzB0UN2WEVbDLJbignHCh27tIZSR1hG0In0LqepWb7r9MsU
	 01CacEhJclDtV4lPL6L2l1OJ/Ze98jYgVCYTgQ6z8g52CK2M1gX5fO/s5zGBlzD9g9
	 jetrVfruEtWcus08NSIQgJxHbGBG8Jf/OPtqX0+9Eg9jK7PeO/Apb6gmGG1L7lZbnl
	 KS93jDteO7+8mFWxUseg3m45thPmb4BUyzBFRWwURvB7624/p4B/tBB1uM8SGPgI5D
	 2Cc72oRKjbciCHXR3SM4eFKKt2l0O/a+BoTzsFyBMDEU7jsMiwkikyLiH9KF0/n4an
	 Co8JfZyIbiAvBci0VczuT6mxynfujJvWBukmj+a+QHqA3OwUOzDiSzJpTFNQhNPKvr
	 KDrUTC2nSgP/1eLsIArxEmceKn/HBCDxUN1RoFCBXTQ/0/OIPwb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5976F20199;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 05/11] setup: use the default algorithm to initialize repo format
Date: Tue,  1 Jul 2025 21:22:31 +0000
Message-ID: <20250701212237.766774-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we define a new repository format with REPOSITORY_FORMAT_INIT, we
always use GIT_HASH_SHA1, and this value ends up getting used as the
default value to initialize a repository if none of the command line,
environment, or config tell us to do otherwise.

Because we might not always want to use SHA-1 as the default, let's
instead specify the default hash algorithm constant so that we will use
whatever the specified default is.

However, we also need to continue to read older repositories.  If we're
in a v0 repository or extensions.objectformat is not set, then we must
continue to default to the original hash algorithm: SHA-1.  If an
algorithm is set explicitly, however, it will override the hash_algo
member of the repository_format struct and we'll get the right value.

Similarly, if the repository was initialized before Git 0.99.3, then it
may lack a core.repositoryformatversion key, and some repositories lack
a config file altogether.  In both cases, format->version is -1 and we
need to assume that SHA-1 is in use.

Because clear_repository_format reinitializes the struct
repository_format and therefore sets the hash_algo member to the default
(which could in the future not be SHA-1), we need to reset this member
explicitly.  We know, however, that at the point we call
read_repository_format, we are actually reading an existing repository
and not initializing a new one or operating outside of a repository, so
we are not changing the default behavior back to SHA-1 if the default
algorithm is different.

It is potentially questionable that we ignore all repository
configuration if there is a config file but it doesn't have
core.repositoryformatversion set, in which case we reset all of the
configuration to the default.  However, it is unclear what the right
thing to do instead with such an old repository is and a simple git init
will add the missing entry, so for now, we simply honor what the
existing code does and reset the value to the default, simply adding our
initialization to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 5 ++++-
 setup.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 3d2b3e745b..03a61bd06a 100644
--- a/setup.c
+++ b/setup.c
@@ -835,9 +835,12 @@ static void init_repository_format(struct repository_format *format)
 int read_repository_format(struct repository_format *format, const char *path)
 {
 	clear_repository_format(format);
+	format->hash_algo = GIT_HASH_SHA1_LEGACY;
 	git_config_from_file(check_repo_format, path, format);
-	if (format->version == -1)
+	if (format->version == -1) {
 		clear_repository_format(format);
+		format->hash_algo = GIT_HASH_SHA1_LEGACY;
+	}
 	return format->version;
 }
 
diff --git a/setup.h b/setup.h
index 18dc3b7368..8522fa8575 100644
--- a/setup.h
+++ b/setup.h
@@ -149,7 +149,7 @@ struct repository_format {
 { \
 	.version = -1, \
 	.is_bare = -1, \
-	.hash_algo = GIT_HASH_SHA1, \
+	.hash_algo = GIT_HASH_DEFAULT, \
 	.ref_storage_format = REF_STORAGE_FORMAT_FILES, \
 	.unknown_extensions = STRING_LIST_INIT_DUP, \
 	.v1_only_extensions = STRING_LIST_INIT_DUP, \
