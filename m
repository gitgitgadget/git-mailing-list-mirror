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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35959C432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1835660EBB
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhHJLsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhHJLsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7BC061798
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so4955146pjb.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YL1IOJ999jNLt5fw3vwXHiPo0WllV4TQ4Lqxx1o34AA=;
        b=imIhZUycwux4i29/i17a0nnEIGmZoQqCc2ChZS0Mq32k0ac5jciX8Y2QGqUXCvCOVU
         wuE5lxf1vyeOtgLHHzWVl7BVD6FC9/aKAJ4KFWPAZ7o89pzo592ZMdtMXr91wq3K6W2K
         mnN+zedAbcPhQjuRFTVGXgi4thH9bqHd7ZvU43l9E7krfgwmZEDAejAaUfyP4/KAmn2S
         M3hCIAoLoUYpKlpxZpv+jbr+ID6j9/GXIod58+FBWUQNErxCTaoXC/7ttp9bbc8mqTz6
         2rACssleDlgImfRv9lCebbD4zResNkb/WqMVZCsv/Nsplg2FsBv29vR0Lb/w6CG7e9Sx
         x5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL1IOJ999jNLt5fw3vwXHiPo0WllV4TQ4Lqxx1o34AA=;
        b=fTkBE3jTNrZhr7LcRUvoYi6VvQer4bqrRlp9mhbRjbabzIL1YqpCJxiCo6/NYsypmS
         gZg76JCEIhwiI1rtGcTrd0VuDsxvPb26BfvLzfy9AY/ZqaQzgz2HZpNQ6DPKvSkzMJZU
         TbgNwW1WT9qTZn2Q4qkwvJpQpESpRZnfo83Cfqhxj/UivMLMdOa8+VeHWqHjVeszqj2o
         hehaPNDhomaQKCMLu9EAPjtaKbGM+KFRwDRldFMvIfPPoxvTw9YsC0gIdDXdBsaBs7g7
         CizSCBLFxBH+yfCwlwWtr6Jv4iblS+XKrghd2wpVPTXNHZ0V7EHHdyhVznrfaMh0wLCE
         Hehg==
X-Gm-Message-State: AOAM531v/vz3Y/3swKmnnObMxb7sdP9RGwCeEYlXpqvMw188my5YC0j1
        uIIFE3JlhWS/3efNcCZo7Jg=
X-Google-Smtp-Source: ABdhPJzr5CuJSurWdPcoLwfD7UQyyIFFhW/eOBlWKebKBENPxdEZyXze/KWihrYY8mhsiwfu8IiHIQ==
X-Received: by 2002:a62:8451:0:b029:3cd:ed80:1521 with SMTP id k78-20020a6284510000b02903cded801521mr2059122pfd.51.1628596052120;
        Tue, 10 Aug 2021 04:47:32 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:31 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 7/9] submodule--helper: remove add-config subcommand
Date:   Tue, 10 Aug 2021 17:16:39 +0530
Message-Id: <20210810114641.27188-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
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
index 6ab7de7741..0baff16686 100644
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

