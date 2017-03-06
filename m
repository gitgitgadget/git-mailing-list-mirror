Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF9F20133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbdCGA7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:59:04 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34098 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754083AbdCGA7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:59:03 -0500
Received: by mail-pf0-f169.google.com with SMTP id v190so30394812pfb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 16:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4vzjgVOtb+QzAW4YWU4DYYFUpyRUgOrmBo6VEaH4pc=;
        b=l6Dw9v9RZeRlNsE0BKBBcqS4zlE4k8VgMyTuu/0261fROFmPYO76aQ1W3d7RslKvAF
         12FEz6/BSHVClVsaAwjWPaoYUlvKstFcJJZnKGkqLbKF2UlpvJoNNdxN9/VP2o1C5lfi
         IYrxHtAwthkfCLvkWp113ynz9aU2HH4yTXNYX1ZzWzrFZPneS8fpoH0+I47bRvrS1rax
         pEzIuGGziNGTnpyWGafHjPQVEeRixLXgu0O+YsJLoXpR/uyrhrAZ0ySO7V7S6Uh5zLLq
         pWcByQL9DXzL0XIc/KMcQwaIXTyKOGkDyeOZ5PbNaKNsliVvcTkt1p42axO0fom7gFWs
         kMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4vzjgVOtb+QzAW4YWU4DYYFUpyRUgOrmBo6VEaH4pc=;
        b=jKl0yuvEW/pUFQ7i8KCBtNUBHH473h8NmBaejgm5juLfjMvEMl94IHe2LvuVsGRWNN
         O9pN5Fi8rChWW0J5KVDbukMVlm8CTl3cneq50uabNQ3nzr8lNH+h0HeX0VZPdtHdeGc0
         KLJwJnSAPqPyh/dVovssEYeCsb6WUG8ZEApWLMH5VhvUK2SFv3AcD2QDcaUSAQBwtH5P
         p1/89KHIX3jg9nGJJJtPJFuqJPMzIjrcVEtH7gFOKa7Qr7LD4m4KAwrJEk48Clh8AGtq
         n0grHARKLjod/XbX5785/XzWeBd+vrBtQqcpUQ4pGmYVvOk50hzIuOZe2HX7asZ7Yv1D
         +4nQ==
X-Gm-Message-State: AMke39mErgj+AWCxI3FTvv+fnmSHOuKDtxVncO21CB24W2wC9xj0yexTPmo8gSWbdC5KPSnV
X-Received: by 10.99.105.66 with SMTP id e63mr22778444pgc.104.1488833971097;
        Mon, 06 Mar 2017 12:59:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id o189sm41542990pga.12.2017.03.06.12.59.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 06/18] make is_submodule_populated gently
Date:   Mon,  6 Mar 2017 12:59:07 -0800
Message-Id: <20170306205919.9713-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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

