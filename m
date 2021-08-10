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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96BC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E91B60E09
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbhHJLsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbhHJLrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4663BC0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so20616973plr.11
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbOFHg/LUZHa705OksnmWu/rR+vSdZbUpTXbCqEHrdE=;
        b=OVPQiL+AEQsFcI44IjsArc7uFEHMkmnpWheDvEZUYjocnjuAbVlhhHF0vJ2XqdTyzk
         moBeX0pqS6Zdj5nEmQKAUztLpN5EObLW40ZsRx8oqztByKv+KrmYeAT/m1e+NCNEw8pD
         ZSasb//R4FlZTu8XViIwwKtULjAnt5cNDe7KJ7kYrsZ71WzDN+d7x9jckbLAf1ubGBT6
         zJm8aWM7qt1NWBK5w6NydhITpuZLV/Qp+tmbnRfx8Ur5sKWnfRbUhLD6Z8EA2sN4H44x
         PChF3750baOh4b0eXYbRg0SlzPdvRWPABv/azqjgsMVAuY2E8EtsMYLYSkAMBSvROint
         z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbOFHg/LUZHa705OksnmWu/rR+vSdZbUpTXbCqEHrdE=;
        b=Y0mtShw7qmk4TJD/tW4/Wo11FOGa37SlNZTAzJKM8gN/EKe+AmcOCACcoxJEnfMRiK
         bALvpGurzar8OgRB5avaGAqKgLt5vMDkknnCC5nbbcyG46GeupST9TbB+pOHW4Rzl2D1
         jcKOlhyMSeSSTfdd4nTfvxYR0IA9vP0sdnkYvl9mrnWIZAPxaQbpOzSpB5L4tYYoSPZi
         KOWaqxnNOHxJPO29X7/Mqamj6YdQnvr1DIYxbbqaNmydM9jVdt6N+oJrKMo/ecOP+qzo
         WVYleEHPRZXip9f7LksG/72ngKI4EPxkx7B37YJAyEUt7qsUEFNKMck7UDGv4PrVWf3J
         EB4w==
X-Gm-Message-State: AOAM5312Qh+U/VoHdwN6UJfqQBfLfn47Y8znTj1X0xbV0T3FLVXW7lgr
        UuFdOwxIqBmpGBVU05b50ngRRaEXtw/8EA==
X-Google-Smtp-Source: ABdhPJzwOxsqO34SQhz+7pNvhgXvipsjmBfUcdq2kzW3pKqZBLFnTbHTDwG9hkd1PqHC5KqJki6chA==
X-Received: by 2002:a63:f011:: with SMTP id k17mr200080pgh.391.1628596047897;
        Tue, 10 Aug 2021 04:47:27 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:27 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 6/9] submodule--helper: remove add-clone subcommand
Date:   Tue, 10 Aug 2021 17:16:38 +0530
Message-Id: <20210810114641.27188-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
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
index bbc5b4d9fd..6ab7de7741 100644
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

