Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF3C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiKNKJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKNKJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A51B79D
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u24so16466877edd.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVIFVZ1+LdLl6/2osbbfsJZFqTCk7hYRi7JUyyR27QY=;
        b=XLQY/uAMoTHEczm1j7dNLvQQ6ApuPXcrGDjesvGV2Awu4Z4aB+d/tRCNTZ9DR4xG93
         vypEywNJrsEf1MTFti6onSkEv/N9Q9MuUCHnnT06yvQeOATkYvZn4F1zF18Esn8FM6Wl
         g3mzoKwCdwZVL72vRy2PlhVWaMja5LyZKi7ukeWnYQ3y5ukTva4ceAqHztc3WUlEdi8R
         lDNQ/5GcJ2iFbhO+SDJhMtaGcPx9QpUKk4fdggsmFe0t1kdchNBioIBOKi3baxKV/aMu
         Z7QwGv3CiB+KTIpLuM6iEVFbPb9TBcrQ86ZBwQKImtmcHB/TiEZfZ8ELIxRtCQafUi/t
         3Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVIFVZ1+LdLl6/2osbbfsJZFqTCk7hYRi7JUyyR27QY=;
        b=YgfdS+fT99H5qmhCuPHHvWlXF6dNyMtE3wel465RpEKxoPJxHFDpFOp20lr9x51ABg
         Sdyyp6BbyisaiJL/NPevL4/ZfhCNEWtUN40U2e2gWOVGPR80sWbhOJ0EMjPIaEqLypv6
         Vbw+S/0gSFrMaq7hP2JBch2n5mINIt6fNc06VZeJCiEa2rmfJ1F2LVtgDNMI2o8j4+d5
         xVyH07WeNiEUTCwmA698oN0mEkH9wn0dNbCkbR16a98LqIIDX7EAhjmo4VHf6+oNvD+L
         HW8XVcCLkZZB04e4BXKJ4TCO4BnrXVqb01Rz6aPOMj6UvG9VL4A2cMv0Mb5TkyMjSPxs
         mkSA==
X-Gm-Message-State: ANoB5pkWCOEGvNUA7yhbkhgk1wYwOWnS+El0zlJXVtpWN+pRV0tYsrwb
        FI9vl3Vra9Bd6FwBcTMMzvy7WcrckxoBYg==
X-Google-Smtp-Source: AA0mqf7iBy+lBTISiqYiu4qQSBCOftAjOZkoPeatFBSfskerayPqtlmYKPJbcY7rzmwfaGpP1pdg1w==
X-Received: by 2002:a05:6402:1850:b0:467:3015:ad42 with SMTP id v16-20020a056402185000b004673015ad42mr10633535edy.259.1668420539760;
        Mon, 14 Nov 2022 02:08:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] submodule--helper: convert "sync" to its own "--super-prefix"
Date:   Mon, 14 Nov 2022 11:08:45 +0100
Message-Id: <patch-v2-05.10-933c752513d-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
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
2.38.0.1471.ge4d8947e7aa

