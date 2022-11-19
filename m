Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B177C43219
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiKSMmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiKSMli (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D176DFF6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so19038732ejc.7
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mCAjkSY1TGHxqypYwQ90x30RUo/JYzcijoSCTILXqk=;
        b=bdzdiKsp7avsxJ5bxgzgPaMVl55O61Y6nuGVc0IFP5KyxmbS8Ars8mfAI8jK7cZVs0
         0wtd10l9qVfK172cWy1ao4KPdYpuxmUigfpsRPcYyqBh0TbiTPNc+QGkZjFtds3XHMJp
         M6lrWBmyVs/2gX/z12pH5BdZpD3dezEBSjsqjaVY3FlOrXRBHNv68qpi8Nwu8d+S86qp
         OjP2F3A8TkVNQ62WlwmmnIFR8+7trYH7Fi+6urPIUpOb9uO3OzdbJMrp8aGxILySjx7S
         O0MioaMhU0XmExmVks2bsgThS30x8vhhqeHIP8zyLI3aF9MFwkH2UrZR6L6nqkuEJ5YP
         y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mCAjkSY1TGHxqypYwQ90x30RUo/JYzcijoSCTILXqk=;
        b=qo6wjjqLpKqwXb7pc3yCGaohJGTvLOUHXq1py7GKG01V63f8oaQAe2pqgE6g5HPbUX
         2tNKx4w1J5nqSbDFfJfDRArn+dCzOqwawwT/dV/sb1E5cHjAhIniUn6ZuR+v3yUj9RJq
         Iuta38ht2/KIriUhvzUI18yDQkJZbLc6A5zg+JFBGT9xj43h2xwjeD2WfsNZ2KxRbVic
         GSs+7/158IxhyeuoLatxqRSIfRF4hLU1hdaBKCMzbil5JO3UNU3qpizdvkkNGINjM7o9
         IDy0hfkFP8NZ7YrZlIGdZR1UVkSdt3IuXQik8XJE73Q8EvrlVLS+Mu+sobxcUCrU2lqi
         EDmQ==
X-Gm-Message-State: ANoB5pk5tsthxN4FtIfj5fmUALx1S5r9DsdVGwtyq4rramTLRQwjLAtk
        12YkvtcmHpsS3Au8DDEc7fwbdv6AeJ2fkg==
X-Google-Smtp-Source: AA0mqf6WjCQ9BrFTfg9s7YRJeQbOUiTvBayBS33ApaaChWLsl+oSPcVVwAae14sPfyNJuORil/RU9g==
X-Received: by 2002:a17:906:4c98:b0:7ad:b9f3:a66a with SMTP id q24-20020a1709064c9800b007adb9f3a66amr9661575eju.282.1668861695931;
        Sat, 19 Nov 2022 04:41:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] submodule--helper: convert "foreach" to its own "--super-prefix"
Date:   Sat, 19 Nov 2022 13:41:23 +0100
Message-Id: <patch-v3-4.9-da86eb3b867-20221119T122853Z-avarab@gmail.com>
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
"submodule--helper foreach" to use its own "--super-prefix", instead
of relying on the global "--super-prefix" argument to "git"
itself. See that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f6ebc64140..7c6f367fa00 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -278,6 +278,7 @@ struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	int quiet;
 	int recursive;
 };
@@ -294,7 +295,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	char *displaypath;
 
 	displaypath = get_submodule_displaypath(path, info->prefix,
-						get_super_prefix());
+						info->super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -364,10 +365,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_pushl(&cpr.args, "--super-prefix", NULL);
-		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
 			     NULL);
+		strvec_pushl(&cpr.args, "--super-prefix", NULL);
+		strvec_pushf(&cpr.args, "%s/", displaypath);
 
 		if (info->quiet)
 			strvec_push(&cpr.args, "--quiet");
@@ -391,6 +392,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option module_foreach_options[] = {
+		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
@@ -3390,8 +3392,8 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
-	    strcmp(subcmd, "sync") && get_super_prefix())
+	    strcmp(subcmd, "status") && strcmp(subcmd, "sync") &&
+	    get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1509.g9445af83948

