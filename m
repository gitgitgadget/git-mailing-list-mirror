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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A4C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6060F0F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHGHRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhHGHRj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CEDC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:17:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z3so10199903plg.8
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VerDo6WCLGukMTTzg2NEC3AEcYJXQGjN+FkojerC2vA=;
        b=B8EvjS/C1DKw51u8oNUYfFkrqEzVbJZnqAAyas97tF0Gy2xq3riUjfO8zsA5FTjw1y
         Y20+Vip14j499oxfstJB+r91PhGBfb+YiGQHe0c0IFPBkc8cTvPQki+LKC8xz5oWhI9K
         4XFth1lc/hrXK5PJMV5ev4xmY7hsyn1rQ1dZRPoFlsRsgtg5V+wykusaf1RjUSGUvH+l
         dC31JHBK0hx/qRqDwbqZ2rugpmRHU5acm9qbrXti9TpdWDxFdfG+RhlEpfnqDbXKurRK
         90fkRyFf+NWuWHTte6bqrQEFAYzdsgtjcXEPBRoTuHWP0nEY6hApOkCYGj9Pae2xCf9T
         CDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VerDo6WCLGukMTTzg2NEC3AEcYJXQGjN+FkojerC2vA=;
        b=ZlKUE8L2l6WEoxa/Srjh6O1+jV8P83u+RYj+niAK5eHJuEvKzPV9YBb6q7xtAzFB7M
         OHOCBAnpqAjz6IE3B/+40h1nK5Toc9tzN7AyVMkok0UBhcsBzYh6WqlUp7YZzGH/Qgqu
         4vUATX8G/wrGS5kDL2C3zK2cAKLuL2IxaCRXCuyX2i1mJzsp4wKzmDINRUQ793s0bO5G
         7l6jDeeleeW4yGcGddWgf3c+xuJ0YTr3ny9BmgVUyUi09QBNCnc1ARXmHF9zYY50K5My
         I2s8IPaCT988fJNm66kjcDEH1w2CSF9hgxsGE1GpxQJe6G4e6X2fjcA9Agaz9HrN2NLZ
         Ot3A==
X-Gm-Message-State: AOAM533B29ZzCfXSGZwLrJ2uDIbrjzHxKfHc/Nb6QlbMr3v6PutXqFZC
        RAzjasxJMR6RpuVq9FFEzn0=
X-Google-Smtp-Source: ABdhPJyt8De0LDqmEgzDYxijnWz6wcsBmbpJ78A3gjNi9AQpNyreAjHgmYXP1dwQ5XoffhDP3DXpfA==
X-Received: by 2002:a63:1709:: with SMTP id x9mr1026070pgl.28.1628320642019;
        Sat, 07 Aug 2021 00:17:22 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:17:21 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 7/8] submodule--helper: remove add-config subcommand
Date:   Sat,  7 Aug 2021 12:46:12 +0530
Message-Id: <20210807071613.99610-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also no longer needed is this subcommand, as all of its functionality is
being called by the newly-introduced `module_add()` directly within C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 49 -------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5932438d65..d526423a0c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2939,54 +2939,6 @@ static void configure_added_submodule(struct add_data *add_data)
 	}
 }
 
-static int add_config(int argc, const char **argv, const char *prefix)
-{
-	int force = 0;
-	struct add_data add_data = ADD_DATA_INIT;
-
-	struct option options[] = {
-		OPT_STRING('b', "branch", &add_data.branch,
-			   N_("branch"),
-			   N_("branch of repository to store in "
-			      "the submodule configuration")),
-		OPT_STRING(0, "url", &add_data.repo,
-			   N_("string"),
-			   N_("url to clone submodule from")),
-		OPT_STRING(0, "resolved-url", &add_data.realrepo,
-			   N_("string"),
-			   N_("url to clone the submodule from, after it has "
-			      "been dereferenced relative to parent's url, "
-			      "in the case where <url> is a relative url")),
-		OPT_STRING(0, "path", &add_data.sm_path,
-			   N_("path"),
-			   N_("where the new submodule will be cloned to")),
-		OPT_STRING(0, "name", &add_data.sm_name,
-			   N_("string"),
-			   N_("name of the new submodule")),
-		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper add-config "
-		   "[--force|-f] [--branch|-b <branch>] "
-		   "--url <url> --resolved-url <resolved-url> "
-		   "--path <path> --name <name>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc)
-		usage_with_options(usage, options);
-
-	add_data.force = !!force;
-	configure_added_submodule(&add_data);
-
-	return 0;
-}
-
 static void die_on_index_match(const char *path, int force)
 {
 	struct pathspec ps;
@@ -3161,7 +3113,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add-config", add_config, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
-- 
2.32.0

