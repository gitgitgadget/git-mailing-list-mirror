Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167EFC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiKSMmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKSMlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:52 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F76885155
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f18so19095475ejz.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHmq0KJH1RMch2HUOcWaDb3YGfM8DqE3qdp/tfVsyZk=;
        b=Q3I1FkFSOUM150MqIz67qNAABr55hhtauopTwzaen0dj5RYmljpgp7xOz3ijHJMltF
         o+ep8E+kh2OdNOvxGI/szt9UNROqQS7pE55hp1v2W3jbRd2MnqH6i+XNqbBLrlGhH9uS
         IKYfTvZVvT5H/fFld9noAhBmEptEyvyjsRPQvH+Ki54ExLJi3JOUgEw08cBHiv8+V0Wq
         btesgBDtBTu+QHKRF7Znx964udwlTHAm6UYAUuT7CSkxTooCEX/mnSYOkvr5iwVc9uXy
         2X8NgnF9tIMB3o19HgczLOcN54zzLxFGT83wzVFngKLTqucGkWR3ZLWFYPOzGWFu8q7f
         Telw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHmq0KJH1RMch2HUOcWaDb3YGfM8DqE3qdp/tfVsyZk=;
        b=RzAZ9qZ6aUIR+OLSzgA6BCd3PBta8DznIePDGACYD5iCxwn5Ecph4AXcDvVtLfLaCb
         TnrdZtXUfwWN0koLhDoJabdltUrxP6EZu4jXgx+U35eeeo8j6jCYreAJ05jHzXwGW/Vn
         tV+zggNAMG0nXvYclWM9fKRSqBX4Jt9hqfACrWkhrdCjemtKp+mv0nrUdR2cnRus1YuS
         tmQR4chuZOGGnGT/C8UFIHI9Mv5YtnnyWZnx2tyo1VuM3976Fjz95VGnhBBDmdjqZVvI
         EhmB01ry4qN15vyz3ulLkcmgALo7/5YoxwbwzBhUHXegC8XVil87WYK7ZdH9jukcejZY
         3kzA==
X-Gm-Message-State: ANoB5ply1lFhGRq08TMwpFZYj+J2RJZMNDpU8yCATRsbz1VNfIW6UZzU
        NeTIhwrr6gSgcNWpDfw2taeWoHRWmNZhuQ==
X-Google-Smtp-Source: AA0mqf7DV1fnoLDp5PeuCyLmyfJnFRBWcpiQ0yaTOBAHpAPZr6PQ8ZX5L/lBikBqxq/P7t7bP9wz8Q==
X-Received: by 2002:a17:906:7fd6:b0:78d:b5be:e5f with SMTP id r22-20020a1709067fd600b0078db5be0e5fmr9220329ejs.601.1668861696816;
        Sat, 19 Nov 2022 04:41:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] submodule--helper: convert "sync" to its own "--super-prefix"
Date:   Sat, 19 Nov 2022 13:41:24 +0100
Message-Id: <patch-v3-5.9-2eb583148a6-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding commit to convert "absorbgitdirs", we can convert
"submodule--helper sync" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git" itself. See
that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7c6f367fa00..7ac51c3506d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1208,12 +1208,13 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 
 struct sync_cb {
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int flags;
 };
 #define SYNC_CB_INIT { 0 }
 
 static void sync_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *super_prefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	char *remote_key = NULL;
@@ -1244,8 +1245,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		super_config_url = xstrdup("");
 	}
 
-	displaypath = get_submodule_displaypath(path, prefix,
-						get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
 
 	if (!(flags & OPT_QUIET))
 		printf(_("Synchronizing submodule url for '%s'\n"),
@@ -1282,10 +1282,11 @@ static void sync_submodule(const char *path, const char *prefix,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_push(&cpr.args, "--super-prefix");
-		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "sync",
 			     "--recursive", NULL);
+		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushf(&cpr.args, "%s/", displaypath);
+
 
 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
@@ -1308,7 +1309,8 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 {
 	struct sync_cb *info = cb_data;
 
-	sync_submodule(list_item->name, info->prefix, info->flags);
+	sync_submodule(list_item->name, info->prefix, info->super_prefix,
+		       info->flags);
 }
 
 static int module_sync(int argc, const char **argv, const char *prefix)
@@ -1319,6 +1321,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int recursive = 0;
 	struct option module_sync_options[] = {
+		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
 		OPT_BOOL(0, "recursive", &recursive,
 			N_("recurse into nested submodules")),
@@ -2887,7 +2890,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	config_name = xstrfmt("submodule.%s.url", path);
 
 	config_set_in_gitmodules_file_gently(config_name, newurl);
-	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
+	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
 
 	free(config_name);
 
@@ -3392,8 +3395,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "status") && strcmp(subcmd, "sync") &&
-	    get_super_prefix())
+	    strcmp(subcmd, "status") && get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1509.g9445af83948

