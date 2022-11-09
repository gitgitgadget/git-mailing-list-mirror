Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3BC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiKITfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKITer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5F2098B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i21so28589799edj.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw1Js8AUaTa5WPdexSQ2pclpqgXMsk9jhtT/Apsqfa0=;
        b=RfSVeBgRBq8XPf8qt3mzhGD0oek/E2DwEI0BpWscqPTnZ5em23Jmo6NlrmrpRYNrxD
         A82kY+6kdavUub14gmd4JbU7WTvoRGbbIfRXjV0Pppg14MVILPOgnitONAxTtShdVDS5
         /HBivP9VNRBvm+llx6O6aNzRx2eeNMK9J1Eh/+3udjmV1l9ueLkNQvI+uOkNXabKtH+j
         Ety+A86WJObJfWeOGgTGcN5ATOfdDjEUoUleCwgCYA/8Ye8xQegSgkoTYviLejGpz2HN
         lQnywOvj47iZR115wIohQsqUjdj96oKVNiPfbXDUFhPPpaDj+Fd0acr3DQ4WimqdHr+Y
         QELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw1Js8AUaTa5WPdexSQ2pclpqgXMsk9jhtT/Apsqfa0=;
        b=OnFbVQSC7UoH6TYWlwAyYNJtREdG0ccVh+cV3NBcfhXhirHQEhgAFNs85SdUfNgLeS
         gCnt/XQatjO2JZo+7kRJRfUF6OjizsR66aA/MVskDywghonpNuvtwJytwlYCBlQUJl/3
         0ZxaXHy9dmuAWaPwu8gp6tzQc12dhAFMr/AsxSKuoXBZXgA2fqOGPNsJIW9AMxE30QzJ
         eOr/UB1orCRyH2yaSCDZ3CcSxibAtPVaaXbs/tC3gK5ah/h+YSyLNM/Zvs0sQ4YZF6K9
         HjoAAwSqvcjdO07ZNotThGu+45uIS0HvyYc0u+ktjfZzb1R621Avs510AA38QKGLpxuG
         KGvw==
X-Gm-Message-State: ACrzQf3zOwEzTc/ZcxiPBZx6V4epphG7dTKOLZ7QRuFKOBVYquLW+qZQ
        IukEGRY4dcnzimFhCHYpvgB8U0COKAA9kQ==
X-Google-Smtp-Source: AMsMyM7xNHjh+OR00E6s6WyVKFtnUhmRMf/tsKDspI4ALdS0utpyOKbFmCIDvBmtrgM8O1QYtpAPRA==
X-Received: by 2002:a05:6402:524e:b0:461:fa05:aff8 with SMTP id t14-20020a056402524e00b00461fa05aff8mr61126617edd.283.1668022485365;
        Wed, 09 Nov 2022 11:34:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 5/8] submodule--helper: convert "status" to its own "--super-prefix"
Date:   Wed,  9 Nov 2022 20:34:33 +0100
Message-Id: <RFC-patch-5.8-a46540b63c2-20221109T192315Z-avarab@gmail.com>
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
"submodule--helper status" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git" itself. See
that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db58fd5b2c4..40939b0b18e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -581,6 +581,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 struct status_cb {
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int flags;
 };
 #define STATUS_CB_INIT { 0 }
@@ -619,7 +620,7 @@ static int handle_submodule_head_ref(const char *refname UNUSED,
 
 static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     unsigned int ce_flags, const char *prefix,
-			     unsigned int flags)
+			     const char *super_prefix, unsigned int flags)
 {
 	char *displaypath;
 	struct strvec diff_files_args = STRVEC_INIT;
@@ -635,7 +636,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
 		print_status(flags, 'U', path, null_oid(), displaypath);
@@ -693,10 +694,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_push(&cpr.args, "--super-prefix");
-		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "status",
 			     "--recursive", NULL);
+		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushf(&cpr.args, "%s/", displaypath);
 
 		if (flags & OPT_CACHED)
 			strvec_push(&cpr.args, "--cached");
@@ -720,7 +721,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 	struct status_cb *info = cb_data;
 
 	status_submodule(list_item->name, &list_item->oid, list_item->ce_flags,
-			 info->prefix, info->flags);
+			 info->prefix, info->super_prefix, info->flags);
 }
 
 static int module_status(int argc, const char **argv, const char *prefix)
@@ -729,7 +730,9 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
+	const char *super_prefix = NULL;
 	struct option module_status_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT__QUIET(&quiet, N_("suppress submodule status output")),
 		OPT_BIT(0, "cached", &info.flags, N_("use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
 		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
@@ -748,6 +751,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 
 	info.prefix = prefix;
+	info.super_prefix = super_prefix;
 	if (quiet)
 		info.flags |= OPT_QUIET;
 
@@ -3401,7 +3405,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "status") && get_super_prefix())
+	    get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1467.g709fbdff1a9

