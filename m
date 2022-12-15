Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B8EC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLOJdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLOJdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024965215C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r26so26178408edc.10
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blhpNHmJyDrK1Aa/+dag4BqH/AmF7c765hupRCGERtU=;
        b=CuKVck2UXrosmO2nuYezQfMYRRXXncQpS0ZNC8QsJ7thvBagzBO+CfMLkh+jXG3sXG
         NAZmwTCBQJ7rNjQeDBR4o+YxnB81QS832eYwKNZ9poHLfhZgmFtVM66k7ub12XA60+5L
         eq+7usN5ayHy5djoBmXSr5OXyi5rNctzO42Y1QuHba0TyLvwn/yjEn9nwRrUxs+dNDti
         SebZycEtDr4vJES3saVMewc35jEheQO21HxkzLL7psvI2O2eUpZieYRNmIPcH7mc753Y
         sPHjpLE6+WltYB/RsQ+GEhLKH0j67NeLzfQgZbc6I3EQdG62bHnldH1gAxVVlGbEF37E
         aslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blhpNHmJyDrK1Aa/+dag4BqH/AmF7c765hupRCGERtU=;
        b=MQKFT+kGr5OkxtKwJe55bYYISFtvrCg+halOEjIXfwK2eJlyXlNQe9gmMqoAsnyifU
         tqrtOic4+dQMZZxf1Cp9kjyPOavX5HeqnwH5WOPs1FI0Kd2okyd+ZmimGVu7WVmpmX8v
         51WaYUu6IYx5JlNIsy+f7/FwVce9dEUskkHzJGVq+PkcgsyrYkF2/iFXBfskpfWH8K3o
         +RZLaUTqzPAjsZpH4w4cEYihscHDM0DzZBm/t0dqINbPuccrOAiTHa95CpyKR0UY2u2h
         KhR0FfUP11whO+7FgMXelr2tHS0C3fRb4srNX+CK9+InH8z59jaIFSsehQcM0SqRz4gh
         i6VA==
X-Gm-Message-State: ANoB5pmhBTDtKNE8nn19z3042NLVLb2+vVNepNMk46Z2EbL4QjwD/uEI
        8uMjpozB+Fyk4H83AERHO1ZMB1SrVl2DSQ==
X-Google-Smtp-Source: AA0mqf7bKQkNFEQ+PtVFDCjmItoCfF4YpS3bLqmGhNOaD6Mhf94xjemsPMADZDmbKRpyLC6LEU8obQ==
X-Received: by 2002:aa7:cd6f:0:b0:46c:3f90:f5d9 with SMTP id ca15-20020aa7cd6f000000b0046c3f90f5d9mr24371955edb.5.1671096783447;
        Thu, 15 Dec 2022 01:33:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:33:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/9] submodule--helper: convert "status" to its own "--super-prefix"
Date:   Thu, 15 Dec 2022 10:32:48 +0100
Message-Id: <patch-v4-7.9-8800a433e29-20221215T083502Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
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
2.39.0.rc2.1048.g0e5493b8d5b

