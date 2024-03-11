Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19256B6A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193486; cv=none; b=fZrL5Eoazf38t1KMu9W4Kb936ozXi3POBnpuvqCRjGrDKgasmXYKjjUMT7yd4JNC+jdfGx+d7xYTygtGcJaKw0mSR8HEkQnnjUbGU//FVwYlZ9CDCm+N+oaq9qQlvihiYOjAIoB6tAOzJnRX5KN2Dw9whpx69JEntH2IJ/FaEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193486; c=relaxed/simple;
	bh=we4uyQZ6kvJ5QQsS3BkDzuy1zXqa9AZS2V4Hqpzn7tk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=mE7R+eJAAawisCNO6K1nHiwtURJcIz0AoyIGKifnpmKbh93dTbDcMpNLNwmBMI737zDA23urD81tk2Cj5vL3d5Fc3g1vCpbqVJZSIK2BONNLq1cdsYOPO5oTMs9BvMjfpSierrMqNxPe3sLEpcX9zj1sRWVR+/nC6LvHQybEUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=mEQWswkE; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="mEQWswkE"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42BLieA2032023
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 11 Mar 2024 22:44:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710193480; bh=we4uyQZ6kvJ5QQsS3BkDzuy1zXqa9AZS2V4Hqpzn7tk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References;
	b=mEQWswkEf5k3KHGaSIKRdvboFhD6KPkfHsXWRSbViuPTdUiUtF/Udahe0bAvkA/Tc
	 +NlzvT4JcXLAxNv7VHGG+PDJl+ArxOheE8l9pn22angmOvm6VfUSj7ZZYv/B0WDY5p
	 moA+oRyj0oqLnztdnqvkntJ8sl1UFd6ECODOgbeI=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Glen Choo <glencbz@gmail.com>
Subject: [PATCH 1/5] MyFirstObjectWalk: use additional arg in config_fn_t
In-Reply-To: <cover.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 11:11:11 +0100
Message-ID: <15b74566e07a39902556cd620e5cd6df1da3c7df.1710192973.git.dirk@gouders.net>
References: <cover.1710192973.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
argument to config_fn_t but did not change relevant function calls
in Documentation/MyFirstObjectWalk.txt.

Fix those calls and the example git_walken_config() to use
that additional argument.

Fixes: a4e7e317 (config: add ctx arg to config_fn_t)
Cc: Glen Choo <glencbz@gmail.com>
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

