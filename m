Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E0C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKITe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiKITer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B4205EA
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v17so28604667edc.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSdHPmSbrhVd9hc3fbKqQQD80mn1mnx/4Eh+1uml4Wk=;
        b=c5yiCJlzvzRa2+eQEpRnyC/tXInRUJMUlfgAgPR6HEyQr2/4hsgeFzr2CRqjMwrd77
         apluYyC1xt829iiDM2nX2KUBToIYIyqlBsKcLJfx8ggywiqzzKk6sT3waIdctOYlbo1R
         YBc54WV+zZlEsGY2Cx2mECqftfaTGK6sIOuJm6uVxHRASwAsNpd5ScMfeBO0ddRGZTdb
         DeloeQJf4E3nV2rdMlWCgaq9S6h/Moovq6S2Zd9PLxLsAC/4ykxTwMpFNDPRlcX5FCsM
         w35z7b6RQ8H3vSCg5W94evRucDt6TfHJRK8FXzW2IR4bdbI5lTV7KScP/tDJrItsGZIp
         t1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSdHPmSbrhVd9hc3fbKqQQD80mn1mnx/4Eh+1uml4Wk=;
        b=mcMwY3BdLImX/2vGsb/dYSEeezheWWar8H807GBhjIgZE9xngNGQtgOHWvjSoznL5J
         xGWmeTesfc2K14M2I+w9vj7shVXjdqqKuOLcRAYvqRasnVsy9aYDtJrnw9ZEby4K77cv
         91ziGKE0GLMOXBbXppDHfKQXEFaVZoa3s94CXvBYeTBo2TV3kZ5DRmJ6iJmZAIYd1Pq+
         IJ1U1q+Vb0sz9q1prR/NKxUyVzAOdbykI+CXxEZ/jRf2eiWwxx9yTezuVyp/bUjcCKj5
         qPAwZuUmrkCe1T5u77goLJmv0s7QRosFLtvMZ65+6+35DVEntWf8LsAZGXTk/U26uf2q
         cyiw==
X-Gm-Message-State: ACrzQf3n45GhEaESKfv0ek84IczSDzRNpNyc/ntQk9CGmklxeiXKUkfz
        FRvCSxrTJ0YwO8YQIyZ4AOYLpuojybzv+Q==
X-Google-Smtp-Source: AMsMyM6LaxAlQrOJ9gqrajFfqDOFHPKjJVbkpS13YBy0/KZNo0U/9mOy9XaHxl19lKJIDPcp6+OarQ==
X-Received: by 2002:a05:6402:366:b0:463:11e8:13cb with SMTP id s6-20020a056402036600b0046311e813cbmr59944566edw.367.1668022484372;
        Wed, 09 Nov 2022 11:34:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/8] submodule--helper: convert "sync" to its own "--super-prefix"
Date:   Wed,  9 Nov 2022 20:34:32 +0100
Message-Id: <RFC-patch-4.8-5ffe4407e46-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 989c75280af..db58fd5b2c4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1214,12 +1214,13 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 
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
@@ -1250,7 +1251,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		super_config_url = xstrdup("");
 	}
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
 
 	if (!(flags & OPT_QUIET))
 		printf(_("Synchronizing submodule url for '%s'\n"),
@@ -1287,10 +1288,11 @@ static void sync_submodule(const char *path, const char *prefix,
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
@@ -1313,7 +1315,8 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 {
 	struct sync_cb *info = cb_data;
 
-	sync_submodule(list_item->name, info->prefix, info->flags);
+	sync_submodule(list_item->name, info->prefix, info->super_prefix,
+		       info->flags);
 }
 
 static int module_sync(int argc, const char **argv, const char *prefix)
@@ -1323,7 +1326,9 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
+	const char *super_prefix = NULL;
 	struct option module_sync_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
 		OPT_BOOL(0, "recursive", &recursive,
 			N_("recurse into nested submodules")),
@@ -1342,6 +1347,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 
 	info.prefix = prefix;
+	info.super_prefix = super_prefix;
 	if (quiet)
 		info.flags |= OPT_QUIET;
 	if (recursive)
@@ -2890,7 +2896,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	config_name = xstrfmt("submodule.%s.url", path);
 
 	config_set_in_gitmodules_file_gently(config_name, newurl);
-	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
+	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
 
 	free(config_name);
 
@@ -3395,8 +3401,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "status") && strcmp(subcmd, "sync") &&
-	    get_super_prefix())
+	    strcmp(subcmd, "status") && get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1467.g709fbdff1a9

