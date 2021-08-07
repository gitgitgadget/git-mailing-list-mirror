Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07382C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C6161163
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhHGHRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhHGHRg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39088C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:17:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j1so20063278pjv.3
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4Ixvdig+iVi+/YHopq/0oQi3oXJRiBED8Nh2SNx8Qo=;
        b=M9C5mxDy2Gv9ZjD2DtJcoN9z6ywLuAxk5EmqO+LNk9LEez62gtOnGctX9WObPGpAbX
         wloaDV5VyHvkWiAgsipAeSc5eaAOiLf68oeK8hhuQgAJWWgJiAeUFHLwGBvDd3RoKFx1
         bUGJUgjO03csTkFcC4NVyyv3DQq55moYSW+5hxIJWlyHq2YQxH9XZsZyElZ+zQQzJRcG
         d15dE6/uY8OcP7jsqBuJEs7C4+w1kh3GqDVlZAbx4A6mVcjJP+jAxd/B5hKFqF6nWK3+
         MINxDi+jZ8uSF8Kf7DNZGoFSOwNcscoacVPrGWEBLh47VDHb0Fby33H7JCLHyJkVPoiD
         n3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4Ixvdig+iVi+/YHopq/0oQi3oXJRiBED8Nh2SNx8Qo=;
        b=aGn6JETZhrIYstQavhgeXQqIdWHW5KJ97kz+7QAj07WG0YB9quAmzPMjXZ6jStjCAP
         I0pTlL30jnNnKXyLXlDwEmzXsaZgAW5Vh9NecpSckA8sFaLu8NQDX3QZkI6RSoug4Vel
         9V6hMwgO2SfucHb8RyIwXgyBnWSrwIYLkoPxuTbjsokAiQSjrIhhhYuYKgXNsd1vSHq8
         J/Ff6cOCj2MKQTX17pcgkGnhIyOWYuwq3zmaBRnvrNBPyACkT0zfA66/0FnGrrhfwD5V
         n0DjkDJu8xjQTphy1Jdqo29xCS0T6ZzK4U+4U4MClpU0IK1A3ImTQOS19/7DM5HjR7e+
         c9MA==
X-Gm-Message-State: AOAM531N4zDFQeqdkCp9ufSrcjEfSAin+ReGq5+7lNGvWsioND4VxqiS
        ZchD14Zl2reaFMsef9oaOOY=
X-Google-Smtp-Source: ABdhPJwcaRjvFUO69xyNfokZhrjaDCLwDZmh3jwPq3/XrdjkXJ7eCq8RHj75s5ji0oulg4seHHnOLg==
X-Received: by 2002:a17:90b:2286:: with SMTP id kx6mr25423698pjb.11.1628320637812;
        Sat, 07 Aug 2021 00:17:17 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.17.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:17:17 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 6/8] submodule--helper: remove add-clone subcommand
Date:   Sat,  7 Aug 2021 12:46:11 +0530
Message-Id: <20210807071613.99610-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer need this subcommand, as all of its functionality is being
called by the newly-introduced `module_add()` directly within C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 60 -------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3aa3ae8b61..5932438d65 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2860,65 +2860,6 @@ static int add_submodule(const struct add_data *add_data)
 	return 0;
 }
 
-static int add_clone(int argc, const char **argv, const char *prefix)
-{
-	int force = 0, quiet = 0, dissociate = 0, progress = 0;
-	struct add_data add_data = ADD_DATA_INIT;
-
-	struct option options[] = {
-		OPT_STRING('b', "branch", &add_data.branch,
-			   N_("branch"),
-			   N_("branch of repository to checkout on cloning")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
-		OPT_STRING(0, "path", &add_data.sm_path,
-			   N_("path"),
-			   N_("where the new submodule will be cloned to")),
-		OPT_STRING(0, "name", &add_data.sm_name,
-			   N_("string"),
-			   N_("name of the new submodule")),
-		OPT_STRING(0, "url", &add_data.realrepo,
-			   N_("string"),
-			   N_("url where to clone the submodule from")),
-		OPT_STRING(0, "reference", &add_data.reference_path,
-			   N_("repo"),
-			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &dissociate,
-			 N_("use --reference only while cloning")),
-		OPT_INTEGER(0, "depth", &add_data.depth,
-			    N_("depth for shallow clones")),
-		OPT_BOOL(0, "progress", &progress,
-			 N_("force cloning progress")),
-		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper add-clone [<options>...] "
-		   "--url <url> --path <path> --name <name>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc != 0)
-		usage_with_options(usage, options);
-
-	add_data.prefix = prefix;
-	add_data.progress = !!progress;
-	add_data.dissociate = !!dissociate;
-	add_data.force = !!force;
-	add_data.quiet = !!quiet;
-
-	if (add_submodule(&add_data))
-		return 1;
-
-	return 0;
-}
-
 static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
 {
 	char *key;
@@ -3220,7 +3161,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add-clone", add_clone, 0},
 	{"add-config", add_config, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
-- 
2.32.0

