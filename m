Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2D5BAF0
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382400; cv=none; b=DOvApBp7nldk81VNULHDDBzzdIOnht8ogo9lBK00ySeK+Zf137qvY+nDooJ2Tj4hdmwbFZIeymhaomtBUkdhzbX9nAS9/OSH9saHhSQQ1hqMbTr/ErkcMYPHyzWZTGucMfmb5pzD6udg/MZcd7FKRuyQ/gr26PN1WNfnLsfiMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382400; c=relaxed/simple;
	bh=WsYYWRGVpcLhsdS2R6+GsUpk9ALw9eybKJVK6uFzvLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BETPpGcYCVy3GC+TxUYwwqfiMmBF+cCgiXxQC2mJUPg075Yv4OI93XuJe8iYndMc1M0FeNTZSXgG/hzuuboU1ZX6dReC7q+vajSXwuafTk4iXLuKnybmfzL2moL7CC+G1/Sl0xeTfRdWnv4teS8DBqZxYBxR2z3hTT/Xr1lHMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GrbTlBck; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GrbTlBck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=WsYYWRGVpcLhsdS2R6+GsUpk9ALw9eybKJVK6uFzvLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=GrbTlBckcUWEK3y7gU43LUdSmvvmXbnGIaOYmBjqE4hjXvF1O5Y9mjZZgaVUfF4gw
	 Xn4BG4E+11l6gnA4XGe8i+RfZtv49alBfPNfPldHUxWMZjup7+PUYVOM/iRy7a5rzl
	 +YErCbaA/uvGI4tZK1Oqfjwnhsnk3XHdTgjKAakRzs/jCe4xGDUv8nPjawm6m9owAt
	 JZC/Zd/k8zHiPNet0mMQ/dCbwQyrxALxMyCSE+J8npQgmL1sMb/IsYdhugG1io3N2P
	 Axe+vTU2eYeNbaBJ23jFMPI1rsVYd07v9LNveS1BPSnIGra2Lc8zDt+h6/Zs8daphe
	 Hi5DciCzxSzcZheOAOH6KFCbVr13iidLt/G6KykqWP5AHOi3sXuGILGclTzqghxidq
	 vhnw6/p+YCcKbNaK+o0aYLdJ5CPEBigjZmgt1zl6bb2tmC5tuq1meQzi0kv+Kcb5sG
	 mo+lN9vb1rxapmH9LVOh3ldkgIrjhDsT0Xnrpa8QnKwNpoLSxYK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DF5BD20196;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/10] setup: use the default algorithm to initialize repo format
Date: Fri, 20 Jun 2025 01:19:37 +0000
Message-ID: <20250620011943.586596-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
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
whatever the specified default is.  However, to make sure we continue to
read repositories without a specified hash algorithm as SHA-1, default
the repository format to the original hash algorithm (SHA-1) when
reading the repository format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 5 ++++-
 setup.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 641c857ed5..fb38824a2b 100644
--- a/setup.c
+++ b/setup.c
@@ -835,9 +835,12 @@ static void init_repository_format(struct repository_format *format)
 int read_repository_format(struct repository_format *format, const char *path)
 {
 	clear_repository_format(format);
+	format->hash_algo = GIT_HASH_ORIGINAL;
 	git_config_from_file(check_repo_format, path, format);
-	if (format->version == -1)
+	if (format->version == -1) {
 		clear_repository_format(format);
+		format->hash_algo = GIT_HASH_ORIGINAL;
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
