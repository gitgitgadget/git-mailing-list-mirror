Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7351AC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiKNKKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiKNKJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB6D129
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i10so18360953ejg.6
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRCdFYjTfOsvegKtrnHJBRpV1ae+SjwdE0nSYs7QLpg=;
        b=NLU6EeHtRgOhWZy63m/cDGBcGQauraYJFZ2xsK45RC/qjWL14zX2yNVi8dUXL/AuoD
         6BCE8wwnnXoYUyfA8WWJUlxNiau8WD57rjJcNgEe++o8Ibh0+u1gQ2tU7PSq6yy05NZr
         BcOZoDj6w4vjyLKLJNBwOx67VBIfZPuRNpfucwGHBD3m+Q0joePP6Sse283aIWgO/PA3
         qm0ct4DNwpBUHwduOTwmCLEaeIxHqS4vMGLM2Q6ecspNQuSmLPzsxDExPXFl75xZoKzr
         BwDD17p4/wvLqDBcWKHDE4Qu0SHxLO9OOI7NTezf6FDI2R7T8+cwJHqnqWwnGMF8ayX4
         fy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRCdFYjTfOsvegKtrnHJBRpV1ae+SjwdE0nSYs7QLpg=;
        b=T6tJuSznE5GIMAOcdrR1J0WCa8/dpQNm98RQObHT1JfjLHozqgkGVJoVrfQTQVyc0o
         odrdbbHzuIM2nwqG3x2kNTN12T1X0Arqre5qzK0qn0x8Gaokdj7l1vqhbTmTmqmiMcwj
         YcdT+xJZPjC2p5wIHvJWTvyIS0XXykhOx1CitePtdT5bql0K9fNX5tVivWsFboH/36ZK
         poBtAcsEJuYBc2UsU6AUesUbijEYjuapTL/P5dLZEM7P+6Bfp90hv9KdOP/mutni21qQ
         HmVY9jo8TNxGVonLFcXi2EIKsCH59rymJX5KRWQQv4IzPPguesyDhfB+7AbrEAVhkNfm
         zoQQ==
X-Gm-Message-State: ANoB5pkg8yon9cJryepHEVGbEX/Od9kXsNCtkJYlb65i652bf65t+/47
        C5KqtMFS6PMHn3NGXZRx4xc5Oi3qsr56EQ==
X-Google-Smtp-Source: AA0mqf6s8aD7czKRmmF0rWEt2q65ry2Buo8C5EuP4Y7IxLo7/MQPAAMw/pk3UwSjw0m5dR6uNi93wg==
X-Received: by 2002:a17:906:6c8d:b0:7ad:f2f9:2b49 with SMTP id s13-20020a1709066c8d00b007adf2f92b49mr9119444ejr.94.1668420540814;
        Mon, 14 Nov 2022 02:09:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] submodule--helper: convert "status" to its own "--super-prefix"
Date:   Mon, 14 Nov 2022 11:08:46 +0100
Message-Id: <patch-v2-06.10-67273f729e0-20221114T100803Z-avarab@gmail.com>
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
2.38.0.1471.ge4d8947e7aa

