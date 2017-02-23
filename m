Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF182022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBWXEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:24 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36093 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWXEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:23 -0500
Received: by mail-pg0-f48.google.com with SMTP id s67so2257272pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vAJDFM5tMcGcXBfJ/cMnQAgNWy3EV9iASGT4ejm9LUo=;
        b=YTO5MMVJK8DUOOB34xcgpxfcL7VaITlYLJ81MAbN5USQsgaVNlGNSY0M/gQpdPnclN
         hvWWh0k4/aEBUxRGX0xbji27LtSYS+BO6baANVKF4PX7IzEAS4Az78mkHK+1HMsgp//H
         JQZ5amjPRDF9mH2cpE7JIaBQvx4qmVa7qXKR0PeZH27MYz7L31KwCf9KjlN088cnETaJ
         QnjOETNO8nRdum9pXHSuk486NKody2r+NZckQrZugfUpDzScplFsembYL7Zohof/tNWA
         EWbky1oCs5DiIwVA2HSq2WxN8AxX+NvF/8i5w8XBS4FHTdPaXcwZiUqI5UW7gVZNLpaH
         8XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAJDFM5tMcGcXBfJ/cMnQAgNWy3EV9iASGT4ejm9LUo=;
        b=E048VZnfSrR44sMXPMZ1Ykk3cIx5IWuo7+lsbtiPQR48gBHkPNEQM51iZ7Ae+NoNQa
         DyfVAi7FmM5m6isSC9L2LnjrsyovUoR4/UFz+IF6oy+Srex4hEHAuPoc6dUIlTnjVMoH
         O15eCV2aJMjWyEmlj9bh9QVDaU9orv7LuGmTKN5uc1kCvawE+6LkpFbtyw8QdmU1av9X
         hn76E+hq34RSozDxr9aOvY3cZABqNrifYNmZvEh5u48bPkBY2cIS+/tdctdinvqOApSu
         foi95KT497C4afoZyjYx6QNky2Qi/Nr/Us1ApCq28mvSE/T90BfTcbYXDTlwLcwxSfaB
         NAhw==
X-Gm-Message-State: AMke39lbxh8FO2dIsUpVQEW+pY2W0FbrfD3D+L0RG7FtMDjyHqm958FyGS2Kke0M6VlIiKdQ
X-Received: by 10.84.218.204 with SMTP id g12mr57172145plm.78.1487890676448;
        Thu, 23 Feb 2017 14:57:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id m6sm11621088pgn.58.2017.02.23.14.57.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 04/15] make is_submodule_populated gently
Date:   Thu, 23 Feb 2017 14:57:24 -0800
Message-Id: <20170223225735.10994-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

