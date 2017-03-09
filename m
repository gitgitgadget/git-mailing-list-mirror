Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0C9202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbdCIWQu (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:50 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36790 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdCIWQF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:05 -0500
Received: by mail-pg0-f45.google.com with SMTP id g2so13777469pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nrncTUSN0yu8QnmMWTBFCxea5KW7pvbqQ4CaiXv+eoY=;
        b=S7N8YenzlJbNO0J1CnDz4HMUT+PHSLGzfSUxkR++4im/5oKx+1jCaCWqSC88K1Naol
         y5C/jU/LXhm8g3g6tM4290ARLwOIY2sW7f1+cK6p7Eta31zV0W11sBUSYIbJjhrrFA4i
         Glp3heXXEzfaKpzf8S1DBt4toqTRmsIEHg89aS98uwXTaKd7ttpZWdgFRwpcOGR84yu2
         D7aNf/zVE9WUEBjzek4FMv1VAS/nhz8SHZ56wSeRNnclScjLzFqy6xZ8l+fMWKkfoXw0
         PLn/edJza0Ra/zSMQXyIqnlZFWXuRTMwhsgdLbg0WC38zvmBid1nVyKW/avy46Bq//ti
         DnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nrncTUSN0yu8QnmMWTBFCxea5KW7pvbqQ4CaiXv+eoY=;
        b=ECqTYiV6DESYF0eJg4eyo4gB49r+V7g6KguvR363Q2YVPudFXcLYcgXLAee1UhdjVt
         YQwoi7q/bSuz5qyE+wHF2bYK4UtBjo7B/bqviv44mPB+d1N32QDCAPRMdb0EQcZ5KCEP
         MdEriAoanl2e+ua6jm9aZODnQWxWPbz6lYOPvBJVZ80AnLvzoRxMy4Rv7sgQ7At8z5yv
         5/8/4BdCFZeuLzqOqv93YA6Md/sP0etc5ULOhtnLzWHiUMxmB9qkVW/LZrTiWrwYdJM8
         QlE7XhslGtdmhqxJ9fO5gyBU/h7Q7gzrehiLoxbssG+yN9cIzwjb1L8xROuV0gPwuPF8
         Rk/Q==
X-Gm-Message-State: AMke39kYx6GXm9U6+lVdVIe48lvSxCuI3wNOz15CJJk1g9umSPcGXR9wwMeiytSe8H5pGAaL
X-Received: by 10.84.248.4 with SMTP id p4mr20344058pll.72.1489097763930;
        Thu, 09 Mar 2017 14:16:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id h14sm14465136pgn.41.2017.03.09.14.16.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 06/17] make is_submodule_populated gently
Date:   Thu,  9 Mar 2017 14:15:32 -0800
Message-Id: <20170309221543.15897-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

