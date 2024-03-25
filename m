Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87736D1A3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373316; cv=none; b=e4A3sWsexNPQOCpZuuplFr02xgPOLaGIhI5PNl49AZF3OnXbp3pKm4m6+/LuqNR1aP9yGse0bEFII3Z00iqZvE18S+2v7u6IW6baocGHjAl1YwvwZk0o1Wb0TF6K6JVRYbNEY3rWySuqFs6rDL5rXBWu9T1gSir5rUfx81mob+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373316; c=relaxed/simple;
	bh=MNZSgGo6UitWonYONsBoyHzJ5q56OFFJdZjurv459PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QooIN+sAyUbB1cwTmX06ye58x2+Upt0TeHskxC+1JHbQsOSqFs2sBA4fLnk6hF85aqEl1dMEmBugTCvAVs17/zmTv/uKzaygTR4cMSwpO7g8/NDSr4k+coggX0Kv5oETfmjeWEVI8Npx+kJm1ThFYWL5vEZxVOfisL6zsp5wQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Pb7Isk9C; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Pb7Isk9C"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJOHA003609
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372765; bh=MNZSgGo6UitWonYONsBoyHzJ5q56OFFJdZjurv459PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb7Isk9CgFOj4iBlTJBGSRbtkGnyngsL3cJM4CcrKbXpuPoJYweC7JVe6Jc5xagPC
	 l/DgOlazZCOtIoomc2n+UTiPdly8vAxf0qRRGxQw9dbN2Rpbu4+XdUbCL9Sfc3Y1nd
	 uVWD5zzwth9uZXnZgAs9n2Sgt3wHn5kW+ghC4m3c=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 1/5] MyFirstObjectWalk: use additional arg in config_fn_t
Date: Mon, 25 Mar 2024 13:33:32 +0100
Message-ID: <0eeb4b78ac91c2bddf775fdea34ce5c0515ff205.1711368499.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
argument to config_fn_t but did not change relevant function calls
in Documentation/MyFirstObjectWalk.txt.

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

