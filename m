Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEAB2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbdCBA5C (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:57:02 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33996 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pg0-f45.google.com with SMTP id p5so25808527pga.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4vzjgVOtb+QzAW4YWU4DYYFUpyRUgOrmBo6VEaH4pc=;
        b=tyFF232WWHDjHAcEZh+LI6rYrEuXaU7TsUZ6qqH/lbCimbmkPH0V/esJu5n/5kvVIh
         lo/VSzZ5aG3l8jL9heaiYMevxQVZFsdH6r4k1XQnfXosQ3xl+hBr2P5e784hvUYicKIS
         mYcgX+jIUOpsnJgvsTcdDzt2ofkjkugWSnDciIC/Jgmhsj580/BnN383qWAhXqY3JJXj
         mvfndDL71K6YnXrjXvzVzUqY0gh5f4gvtY3lrcf4yLG+ghMH50II2bzWO1vR63HVSNNa
         q2xCPrquCOd5DH7vxMEGDjUYsjZfyRusH/yz5ar74yha7BVDBoRUSN4ugMFKZkXVCYHe
         ngLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4vzjgVOtb+QzAW4YWU4DYYFUpyRUgOrmBo6VEaH4pc=;
        b=V4sOXspzVTjGKr27UtGgI1xE4ak4w6IqEeQe+wek0CtdiGptAjQgAOw4RlQSRAtE7R
         xfJ1jLLFiz6ppKa2OAnEhqT5E9vdK4sD47bij5FQxoq9UcmPFIvJzpoaDhWeeEb0ork8
         z2vBGPvUqu59l6BanDl2Pyl98Yco8BnIIrxIuNwQRGFFJPM3GMKLivN5ka1JufYmfK18
         Jbk1+6EWoKKfEW3cH9Zc6nF7UEHOn3zWvw9wVN9g3iUdJ/9NJV0hBRAMBE2eFe0uMjhq
         ypFOpFanTGQKh7/IaXK86C5ohndXAZGT7nhohWAHXm1zrvWcfFYsxzAWC3AQBOFz61dU
         fO2Q==
X-Gm-Message-State: AMke39lR/ljymc9+qoKzLAHVrKU3/k2zMTy0lzSerS4vQXnMgUh4qRI8X2ReenVZ4iuOwYkw
X-Received: by 10.98.101.71 with SMTP id z68mr12337636pfb.25.1488415691308;
        Wed, 01 Mar 2017 16:48:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id b70sm12763591pfc.100.2017.03.01.16.48.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 06/18] make is_submodule_populated gently
Date:   Wed,  1 Mar 2017 16:47:47 -0800
Message-Id: <20170302004759.27852-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need the gentle version in a later patch. As we have just one caller,
migrate the caller.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c | 2 +-
 submodule.c    | 7 ++-----
 submodule.h    | 8 +++++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef499..b17835aed6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -616,7 +616,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 {
 	if (!is_submodule_initialized(path))
 		return 0;
-	if (!is_submodule_populated(path)) {
+	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
 		 * If searching history, check for the presense of the
 		 * submodule's gitdir before skipping the submodule.
diff --git a/submodule.c b/submodule.c
index 3b98766a6b..0e55372f37 100644
--- a/submodule.c
+++ b/submodule.c
@@ -234,15 +234,12 @@ int is_submodule_initialized(const char *path)
 	return ret;
 }
 
-/*
- * Determine if a submodule has been populated at a given 'path'
- */
-int is_submodule_populated(const char *path)
+int is_submodule_populated_gently(const char *path, int *return_error_code)
 {
 	int ret = 0;
 	char *gitdir = xstrfmt("%s/.git", path);
 
-	if (resolve_gitdir(gitdir))
+	if (resolve_gitdir_gently(gitdir, return_error_code))
 		ret = 1;
 
 	free(gitdir);
diff --git a/submodule.h b/submodule.h
index 05ab674f06..0b915bd3ac 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,7 +41,13 @@ extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
-extern int is_submodule_populated(const char *path);
+/*
+ * Determine if a submodule has been populated at a given 'path' by checking if
+ * the <path>/.git resolves to a valid git repository.
+ * If return_error_code is NULL, die on error.
+ * Otherwise the return error code is the same as of resolve_gitdir_gently.
+ */
+extern int is_submodule_populated_gently(const char *path, int *return_error_code);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.12.0.rc1.52.ge239d7e709.dirty

