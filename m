Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3276DC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLOJdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiLOJdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B602C650
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so32360973ejm.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIHC85V9uhi1fT0ZMThc1Uwkld8TJa8CRuqYUoItrJ0=;
        b=XtkhyBF7z7Eabw6T/szZJxyOfuzFs0oCpJFUp8x38iwlGXqgIohibuFkbtH7m9Sp+j
         GzOk5wu8KQQLj/ywR949HSj8NDncv44Z0JuPVIIc00L9dcG4l4+ed2PyTb72PKO3ponA
         RYKu4Tu6XKhvO3BJjrlVh8816KyozU+RPdOLl4f4TUiRFa0fdJYFONcbzROcLfTNFJnp
         OZXYawrfEHnoR1+Vl389CAfYwUiZ2urFFxg/ZwCPNnkVr/d4stLMVRTc97C11lr2LiN7
         zsWQenYNelN+vKNSEA/g0ko0YD/82Ez+rRGAKsiVTNugsU8Q1nu02JqTSmxfMYCeFoyd
         VSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIHC85V9uhi1fT0ZMThc1Uwkld8TJa8CRuqYUoItrJ0=;
        b=taRbEer+8DS7HVNY115YEgJPvnjih1Xn51xA+g26OID6ddlFrdgbr6dJGUgXkwtLHN
         7xEzps7b02zu9fn6OQkaKsxakJfAv9abrTStaq5QowGosZK7k4e2VoSyvBbCaKy2lSJ+
         qSe3AxC5LsgvUYoOVOCUxF24+MsWbY8SXGKvhpGD1Rm5/j9YHfFiGb1aTcry6kAqKIW3
         L+xUPeueHrAMjzxu8bfWSWH7ZZ/avUrRiUYx8jyDx8k70um2hHZUrrh9FwaHmLe0xZhm
         S/6czEbwueuEHbgmB4Z32GwMk19G+PJgS6IhPJl7rZBTjxf3gu7sAp8MY/+jvfqOmq3F
         NIRw==
X-Gm-Message-State: ANoB5pkVZS7k/f143gnaKwR4YnXl0uPOxxj5yCtPlB6qssB8aB4JLuIs
        k8H5LoiMIZiaW5E1qK91PuEKl5IyVm/0jQ==
X-Google-Smtp-Source: AA0mqf4x57TRDAXgTEAUCukpxYQRJ3u53N0NFNx0JdNvWgjL9wnuZImgxK4dTVmVs9REeSmY81EU4w==
X-Received: by 2002:a17:906:fd53:b0:7c0:a247:2f3c with SMTP id wi19-20020a170906fd5300b007c0a2472f3cmr19536852ejb.1.1671096782526;
        Thu, 15 Dec 2022 01:33:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:33:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] submodule--helper: convert "sync" to its own "--super-prefix"
Date:   Thu, 15 Dec 2022 10:32:47 +0100
Message-Id: <patch-v4-6.9-8dff576df7d-20221215T083502Z-avarab@gmail.com>
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
2.39.0.rc2.1048.g0e5493b8d5b

