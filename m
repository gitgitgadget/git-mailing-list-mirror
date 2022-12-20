Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FEC4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiLTMnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiLTMnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE61A209
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso8656601wmp.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APQFWZJOluBfdRADFJL/JOcm14XTW3WxU+DKh4pIz3M=;
        b=aR0trX7KyxmMUQ5BihE5H8msyKHa1S/+GpZkMGd7rVkS78Y97FWHWTaom6m/nqk6i4
         mwl/y5PyXFsFa6xfBsKrx6agT22cUzDh7wZhZH2qaLOE2oF8lJUgwxhuDXEldteNfMpo
         R9FhO8cZpc//Ce9IZ615MCcLPw974Iaks3vWA+hK+i7Krkbf5r0pUyf36s6laegftmtA
         jK5o83pN5d3NFuHY5Ubvqs2bfzCSVqO+MnBzW5vBqL57E8pk6wVzl9/TErZC582kzFNj
         3fkuiXWA0C45Mf0EQQ8gTz1Uuzwim2XOJ3glSRdBuTjJs/ahfHLM4w5vMydr/ROmPPuB
         0O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APQFWZJOluBfdRADFJL/JOcm14XTW3WxU+DKh4pIz3M=;
        b=m8Zh1zTl5Dp8Rh3yc6Yf/9cILFwZxVPMTufvD/cIYH7lesMpXek9DlR+0SczThmrBP
         PGjkDbSxrohRZEpPLSbydz59Xu/puCvvpEOIoBxOFREHEXld9aQTyXr5eyhUtLI7ldN8
         1zKMwopYoPia5okM4SZIcwgcIiKGoD/pKWSpTjuMamF6H3HVAronCfMcOIzkopVRxOLg
         pB1hAVZxyvAOmAT7xxGzzmzeo1Flk6r5Wdc8E9a2DxCbYxrrjA+jaIqqJpWwsE41r2Qp
         T+V/aP3DSrLMOpm68H2GDdadjZ/Cye+ovyEFhHCNgNseKd8IK1K6xwOmLzqT3n6M8Wgn
         hptg==
X-Gm-Message-State: AFqh2kp0ShetreTS0T4rMysj/Z0fqC435CKMOpbl5N0bLTwTN3fc0eiv
        o4VbgBDVLoJ2ZhxWTxQ0JIiUtxrYiGracw==
X-Google-Smtp-Source: AMrXdXtY+Y9bXGU+yGTJZS9pKISsOBdSCX0H+Y5pIw+kRewfKvq5JZy00+SX1JcA3T0OnAqQI+7rsw==
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id z12-20020a05600c220c00b003d23831e5c4mr1517416wml.40.1671540007391;
        Tue, 20 Dec 2022 04:40:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/9] submodule--helper: convert "sync" to its own "--super-prefix"
Date:   Tue, 20 Dec 2022 13:39:53 +0100
Message-Id: <patch-v5-6.9-ace2920ccff-20221220T104519Z-avarab@gmail.com>
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
"submodule--helper sync" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git" itself. See
that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2a6ced13f6d..7262ce72edf 100644
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
2.39.0.1071.g97ce8966538

