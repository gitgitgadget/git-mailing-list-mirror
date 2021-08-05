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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E85C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AD61029
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhHEHmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbhHEHmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9458C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ca5so6758292pjb.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9wD3p/s/nP5k2Pl25OVVZ4hei8Nernjc4lgNCXspgI=;
        b=S29nGuSs2Ucf+qlIbt/4EVyyD7A1UCzGrOq9icMP45TkkxZuxrfrlJXNW93yQ5aisz
         iVYU2egXtdhcER5pmYoyTsBbhp9PlQG8r6Pa9FhVj7Na6LjOEKPf6LtYkjX850OeJfQd
         BztdYyiBGcjpnNWAdQplm0vwwK5i+FPv3C6ZiG6QvVwwjCi2x1QYYn6txxicymWP5uY9
         yk5acXY8QqDexWES+eTg35xL3c+XOBT1/3TmfGjh2d9PiDYgV5bIxysjfoGhQUPN6wPZ
         mqwbMGz64YsPPzpfjtKWZsh97ACrxhItffpoRINzfByP7Qm+6gFLUINTCZ3/jjK6QxW9
         i9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9wD3p/s/nP5k2Pl25OVVZ4hei8Nernjc4lgNCXspgI=;
        b=cDE6s3TejFDkhQLyBg7vd6is00FkGCotyehKjjs5XKibCWqrKUy1Lk8gJ9CK1O4IUp
         rPo+R8Fzsu/GP4CqtTXUqQk9f0pMnB40p6bL0zdcJjxbBRdyJjKqiK/TYFiFKdqDSp20
         yFGPVP6IHkm/KaNH/Qjxtrx3cqIUKePPob/cze5GY9CI48LP6J9ExvR7q4YKFrSwTg0S
         NeoQP2+GNOyBONJuW44rkHUqLyCS2LTLxMfZQad2sDxXALphEJrMeCH4nfHk9sZT4zJG
         GYN0l5LCaPWEkfi3VRD8aM45Rv6zEY7dJAjtR+vg+surmXXh6qO+3Jkb7EE+W59lYgcw
         hhbQ==
X-Gm-Message-State: AOAM531xVRZ2rlr2neOkvSd84HpYySklsidQYOg0uqPFqFsRkgHTOD0Y
        XiQehnuJij8+lI8n2OqatDA=
X-Google-Smtp-Source: ABdhPJymwzO7VjLephxWeys+sOr4H9fkqciOyRXmtLtMkKVpeFRSh9z1Li3F8jp3eYC5/6aTECBa7A==
X-Received: by 2002:a63:5855:: with SMTP id i21mr768361pgm.77.1628149317498;
        Thu, 05 Aug 2021 00:41:57 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:57 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 7/9] submodule--helper: remove add-clone subcommand
Date:   Thu,  5 Aug 2021 13:10:52 +0530
Message-Id: <20210805074054.29916-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
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
index 05ae9ebe50..700cc8bbeb 100644
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
@@ -3217,7 +3158,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add-clone", add_clone, 0},
 	{"add-config", add_config, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
-- 
2.32.0

