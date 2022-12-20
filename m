Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743EC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiLTMno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiLTMnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C7B1ADAD
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10994617wme.5
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSawEkKO6Js8shHf0JFoncSlsLgifQEAyRvuXo8IeJc=;
        b=KMxrdTDhSxHA100VR24P9yRdybsxsMJVGUpnx1f5V9KcJvS5OxG7K53EhROQ0VGRm9
         jY4ptFqqCZxyEc67gGLudw3UtRUgSQN1bMOplpraa1H4o4TowdAufiauMm3H4O/YNCnn
         080rha1SSgkraCvXIzA8M9zyXiOvj+pe32FP3VTf2bRQaZSWrXZoe5qsly2eNywulKA9
         1TgmKpTFmlOIqV3ONmYCUMGEzr+TdSOM376NQHyBGx6I3979e/7mMhp1yblmu2NUPmRt
         TEgpAGF4DDx4/jijbwYrYQfLHEUYkUlkpcwUdRW+SGDu8FcGOkNwm4bJO+ZlKKacqm8y
         io+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSawEkKO6Js8shHf0JFoncSlsLgifQEAyRvuXo8IeJc=;
        b=bFSY2a69Fz4N+yjvSWTpuGgxfpB3P3lanFv3LClxKiRYah3Z8TbsBD3FdpnfIrUaTU
         u05jzHsjUMsNhJSt+xZmx255Pkk/TqPCSZMv9yqBtlOliIjH6VuedZwkh+cn40cggUBO
         P/7D0LtVlYznr/dNcC/wDks05t59a61mae1ETq21traAUKNvNS6aOERoVNhAEoE+6NQ6
         DZyoFLiA6cpueGjOWv6QmjKHq9WLNJpjSh9xrIqj8CPttX2VKKOvwTVK3NJ1/w2eWSNP
         LZ4z4eKBnymum3j4A1p6FMSyjXNemZCbDKiDfm1ixNw5lr2u+PCmNEbjBzuelU8RSk4f
         q78w==
X-Gm-Message-State: ANoB5pnm1oAKKV0C18ppG+ZfZl8ZKM2E4t0JjYlZl5XUxerOXq7be2MY
        0ZWtFDnPP5sv7MFDTxwc8+YztIaHVZdYtQ==
X-Google-Smtp-Source: AA0mqf6yqAMvaAp3ICh4zNEz0MJY4627t16YLP44/z+Gb8Q6NCjLIpRdLxHa2Aj6PlEpsYjBUOc8Tw==
X-Received: by 2002:a05:600c:35ce:b0:3d1:c8e3:2452 with SMTP id r14-20020a05600c35ce00b003d1c8e32452mr35819949wmq.30.1671540008319;
        Tue, 20 Dec 2022 04:40:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 7/9] submodule--helper: convert "status" to its own "--super-prefix"
Date:   Tue, 20 Dec 2022 13:39:54 +0100
Message-Id: <patch-v5-7.9-1ccd1a57b64-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7262ce72edf..448896f1b1d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -573,6 +573,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 struct status_cb {
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int flags;
 };
 #define STATUS_CB_INIT { 0 }
@@ -611,7 +612,7 @@ static int handle_submodule_head_ref(const char *refname UNUSED,
 
 static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     unsigned int ce_flags, const char *prefix,
-			     unsigned int flags)
+			     const char *super_prefix, unsigned int flags)
 {
 	char *displaypath;
 	struct strvec diff_files_args = STRVEC_INIT;
@@ -627,8 +628,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
-	displaypath = get_submodule_displaypath(path, prefix,
-						get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
 		print_status(flags, 'U', path, null_oid(), displaypath);
@@ -686,10 +686,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
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
@@ -713,7 +713,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 	struct status_cb *info = cb_data;
 
 	status_submodule(list_item->name, &list_item->oid, list_item->ce_flags,
-			 info->prefix, info->flags);
+			 info->prefix, info->super_prefix, info->flags);
 }
 
 static int module_status(int argc, const char **argv, const char *prefix)
@@ -723,6 +723,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_status_options[] = {
+		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&quiet, N_("suppress submodule status output")),
 		OPT_BIT(0, "cached", &info.flags, N_("use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
 		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
@@ -3395,7 +3396,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "status") && get_super_prefix())
+	    get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.39.0.1071.g97ce8966538

