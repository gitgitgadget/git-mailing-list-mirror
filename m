Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF547F54
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538579; cv=none; b=cQ3v7bAg4K167nxJ+JRWoyJ+DUKMibkBQ17eJg79TB2v29TQ7QS6PRiDkdShgpQxkszGolEziTqMkYDMnwuTpXoaXepvipjVS74pb79OE/K3Ns72Gi0/33Dikhf9QFjqgakkV/zr8bU/BHNlbOZp1AEjheVtezaljFJBbHLFG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538579; c=relaxed/simple;
	bh=CpRomrezvQDUn43nIevebbmkF0ukq3h9qTDfjfXBaa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr8OYPar6g6/DipIIt9zUCHeVnHRngG+/Z7kckiD8ajXyM6ss1hUSHWiQ/nJ86g4qR/P8jSC34IbiYevXh7uNaNMxauPyqWNmgVJWNxJqNVMa/vCPpZKqngdmsqj+wbgLygT72Cnci/G5t2tAenlPO2gnoPIJ4BvOPu7oz9lEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=CfPepBhF; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="CfPepBhF"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBMlD0003288
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538567; bh=CpRomrezvQDUn43nIevebbmkF0ukq3h9qTDfjfXBaa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfPepBhFRkipYTWK7rMXVE5LjGdThQzxYmVxRLe8zPZ8jWuEP0MBJav+tWimzz8+c
	 /WZrWpFlklgDynD2fdyI6B4gTg+QyVmefZhiZWkaxv9Nc9oSPAJqQHPJCSbqikfZJ5
	 nBWZsjzbyV1C2OqUVn+xqyyybvKoMAa+P94ubb5I=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 1/5] MyFirstObjectWalk: use additional arg in config_fn_t
Date: Wed, 27 Mar 2024 12:22:12 +0100
Message-ID: <292ae6754843c2d400dd54fb162f71642b73c8f1.1711537370.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711537370.git.dirk@gouders.net>
References: <20240326130902.7111-1-dirk@gouders.net> <cover.1711537370.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a4e7e317f8 (config: add ctx arg to config_fn_t, 2023-06-28)
added a fourth argument to config_fn_t but did not change relevant
function calls in Documentation/MyFirstObjectWalk.txt.

Fix those calls and the example git_walken_config() to use
that additional argument.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index c68cdb11b9..cceac2df95 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -210,13 +210,14 @@ We'll also need to include the `config.h` header:
 
 ...
 
-static int git_walken_config(const char *var, const char *value, void *cb)
+static int git_walken_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *cb)
 {
 	/*
 	 * For now, we don't have any custom configuration, so fall back to
 	 * the default config.
 	 */
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 ----
 
@@ -389,10 +390,11 @@ modifying `rev_info.grep_filter`, which is a `struct grep_opt`.
 First some setup. Add `grep_config()` to `git_walken_config()`:
 
 ----
-static int git_walken_config(const char *var, const char *value, void *cb)
+static int git_walken_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *cb)
 {
-	grep_config(var, value, cb);
-	return git_default_config(var, value, cb);
+	grep_config(var, value, ctx, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 ----
 
-- 
2.43.0

