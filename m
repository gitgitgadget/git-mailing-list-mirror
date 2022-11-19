Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB590C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiKSMmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiKSMlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC6B79344
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n21so19014627ejb.9
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6fnov29Km6PoPkq5gQ0mLszmdabuUvwCuWXWxGqimY=;
        b=qpXy6Sk9RcbAmtPwNRApKNGH1MoYqL24l1WIE0akA1REPhuR9W2/epTiEoiTXxOI0K
         SqoMeSZL85ekdcHOIvnaeUt6KnsBLBdhCZPgBNIn9b7N0kvVDxYNQw62kPTDrhkN3RYx
         ig7u6MsFEFeGdaxXRbGZpADnNHQqHvxQq8OMAEt7z5EJj1EhSio+hEpwQw/5IG/K9oBN
         KP0FglkOt4J51Ookfp6SHqMZST8EGPZAPYVtdS0xvmx/waz0UN3vLxnzxvRyRadKM7Ka
         o03D6UTQshnHKITyJbI2PFcXkR6DDWyb4+nlD2mecPzlWJedisjri2PegbOzhnc2rqRC
         iHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6fnov29Km6PoPkq5gQ0mLszmdabuUvwCuWXWxGqimY=;
        b=J6GVFNk+tMILUDW1W54ZcQ0dvd8Z1xKq8w1KPcnxiULnuBlLVAfblaY9nHIRHVwZiu
         R7wJ0RUYyMWvZUV0Yqh69PEo5mh2do7s3PZ5Arl8+RXH025+8PQyIUP/yIUMFbzeFj4Y
         MsDzchTWFnd5xa6AlyZ90X04Yu/xB/oILbHd0ESvVU91ZOd5epaqkMWg36cP2ven+AKz
         HMakSxe6O9dkinIDk+tyAHdhNSqadOBhmfI3eLywA7tRB2RZMIjHk8qZ/Y89wntEd9XD
         GvT5aHmX0803cdO5cD32Nto1B92g56ilxFNCyDd1tvNOC68lJU5q3w8cuXpIR6QrTKiN
         O4uw==
X-Gm-Message-State: ANoB5pkZWWkuJIGkkiPHytGdaMMHmgyFmx51VoFWRq2nknN4i8N4XK0c
        jDzUnuN13hzwRMoBRmZbt8KixJajC72G0A==
X-Google-Smtp-Source: AA0mqf5P5wduADJmEG3r7ZmObsEwMEugNMRgv44JXqNvMTIlJTc3ZZkVZ69uKiQl16K9+wclKHfWuw==
X-Received: by 2002:a17:906:6892:b0:78d:ab48:bc84 with SMTP id n18-20020a170906689200b0078dab48bc84mr9851428ejr.22.1668861697713;
        Sat, 19 Nov 2022 04:41:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] submodule--helper: convert "status" to its own "--super-prefix"
Date:   Sat, 19 Nov 2022 13:41:25 +0100
Message-Id: <patch-v3-6.9-8d8925c7e1f-20221119T122853Z-avarab@gmail.com>
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
"submodule--helper status" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git" itself. See
that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7ac51c3506d..8a186b61b9d 100644
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
2.38.0.1509.g9445af83948

