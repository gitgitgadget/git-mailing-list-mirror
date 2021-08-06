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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC54C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D347B60EBC
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbhHFMCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhHFMCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84015C061799
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso17313647pjf.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlJvr0ayij0LGv+4cMwXLnzRkIFnDxFvlLYonnAE+oo=;
        b=o+qcuOjlhteDi+mFGOM9NKdKIjBOysXWeaKK3gJkglh0eoOnbB78TAiTxs5f/8wffS
         U5oPvQzlCqIvh8zwJzyQl8s9Zq2WeHTT/BhxKs/cbas1KXvw28yySUbda/nTt600QNoR
         EdtQuYWbHg0+O4kHxnvJnXjG+KnP0jBAWsCYNK1XzcYpp9le7kZU8RXeXgn2rxn4wQHV
         53VyHCSS6hrgGA53wBcFvDencwXtfxEkmy4LnP9ufQbcYWJmIqrhsPdGR1sKu2WAn8i3
         zxZcDpjhe+5laWG/zGlKngLfTZ4OWLgW8/7ThLhze7iUwQ2CdP505GfAz99/Ph8hgdUG
         A3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlJvr0ayij0LGv+4cMwXLnzRkIFnDxFvlLYonnAE+oo=;
        b=Ebb6xJ5984KpKl0skT600iuOPojTmrFgu1VaiFmMHGrmtF4Hp8Bdha9t0XRoHFlDCM
         hs1WhuhwxHj7ButHt5h0GNS2jCEM3Dk1M9fes9GdqwxMvKzmy7UntMucFVdruroyyf36
         Bml+y3apSc7wMyiyGFpkeRHjbM8nIVoc3Bf3uYirM0582krneIwS41q9CbbpYxgAyNkF
         09BkH3wcq0pRrB4z7k/6TTklBZK8hx2OW+h8Bezz3bUhcgq88iqOFl3kFz2iP7Kf6JHQ
         HQrOc6pIWgjDwCEkY5zl7wqtFyoht3sWt3LYbxcnb8Hy3kkMJOVloMmHmovYAgNgQwcO
         6itQ==
X-Gm-Message-State: AOAM533jxqmQEWDST/NZx0E2tENj+VR/qLGWxtahm8AzCbWPrC0XU8W1
        lzLFThG7w5lC6wHZ9QVrgW0=
X-Google-Smtp-Source: ABdhPJw9mAF8+649eG3IV5iCwKrtOwayPciF2lSzPlBRMqLIbkOUw6ZOeN66uBbZjYfn30+vDOChig==
X-Received: by 2002:a17:902:7481:b029:12c:9cf8:bc5f with SMTP id h1-20020a1709027481b029012c9cf8bc5fmr8378982pll.52.1628251353124;
        Fri, 06 Aug 2021 05:02:33 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:32 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 6/8] submodule--helper: remove add-clone subcommand
Date:   Fri,  6 Aug 2021 17:31:45 +0530
Message-Id: <20210806120147.73349-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
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
index f31e5a9bde..1257066a0f 100644
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

