Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F27E583
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847454; cv=none; b=XSHS3V6MZTAWYWZCNoEEUkgzMj6EMuZqBb00jCv7aHAwjn6gnPVhgfrMRwNTmwH62YduzzYB0vYAVOdowX5tlndme0ao6+ZVfZCACRVvb2exa4ukRhQLfWNPesvl3GDQhAZ75Ff8Kvm9n3YH/Nd80mwGa6N3Dh4X0hb27LdNvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847454; c=relaxed/simple;
	bh=MNZSgGo6UitWonYONsBoyHzJ5q56OFFJdZjurv459PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0Lb3nbb7l5g1Ff9//H2beII3IpyrGGqd6dHZiGLSGEadS3b7nlpehpheY9O94nUq+lc7pDUl8ODlhOhqC7Gv3ZY7Aq2AJ4lG0J0+OzvreZJUQrl3vQr7LtbDjAl0+5uIwt7TnqmiZKScgjD3mK6FwpXTWHeaM+HdiDnagR9La4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=KPkIyqUw; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="KPkIyqUw"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBO22U017014
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:24:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847442; bh=MNZSgGo6UitWonYONsBoyHzJ5q56OFFJdZjurv459PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KPkIyqUwc03uLewTbf0pBpU3RTQzJx8Xh2K+dOm5muW1b7mGPwB7MN+RdnBmQqxup
	 mNkdoeNke6jyu6JiCY+QlXkXAJGbDEWMAe/T6m9gmOWqmEuGCg1S0nXswxDR7XhDko
	 KAYl7ZKjD4USeqx1t4ACRgBmy6I8vQguM6zHpCFM=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 1/5] MyFirstObjectWalk: use additional arg in config_fn_t
Date: Tue, 19 Mar 2024 12:23:11 +0100
Message-ID: <babf04295ee461a5c37574a032c6bc105bb1f31e.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
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

