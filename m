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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0911C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F88760ED6
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhHEHUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbhHEHUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FAFC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:20:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q2so5968115plr.11
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9wD3p/s/nP5k2Pl25OVVZ4hei8Nernjc4lgNCXspgI=;
        b=YNwLasq9X03Mmba26ayuj9zJEFxT0NBjzAJmFw7/tgwUswXM1VUFwORNC4LOa3DAgQ
         7XUrwvFK8ul34xbrALsOisUkI3SF+YdPNFOip+Q4cwMNEiQfLAArQsR2cpaX6EhwWbPp
         aDFS4cy/R9MjDYKvNlVymn3X/SraM+vkZanPnXfTwets2FQAur0sQBM3/JJAjjR0ozu8
         b58jUGmqWyTPNwtXYg8Ozff2ivZ2Q1e8TmGBFOUvh3Quh1med13Pb/oxVCP6DKdFAK9K
         a7horlEh74PcxA5L9ICCQXKoDRj4eY9ku5YFmwDkROnmKg9uo8n2naXPHq3BeWaEg6Nv
         9VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9wD3p/s/nP5k2Pl25OVVZ4hei8Nernjc4lgNCXspgI=;
        b=Ip8xM2lHkJUQItGefZ/Br/DnM7/fuNKw+vj5ZCQytVfaMdFFZ4y5oSrOe6jPgLDK1J
         70m9KDROBO+bVbqg76oBhgQy16DEBk7ESWQ96HzOmgYjtpVR83uecnsnNI5SFg5h5KSZ
         8+UqxzH716oirDuyzNp0LJ6qHDJ4mRvpF9A+oFGlb8Nr8tBjj56mw3dRBhkwJIRQRPpU
         awfmax4Q0wZ/MMUAmm936Yav2QR6tm0CKIQ31s/zSDm0meHkPyerF32wN6qRZ86R//fC
         j3kNwFSM0+47OJtmNmg3I1N8HhAR6HwSa/WRinqqPEwLpdnx3+erJNHZvz7tAk2On4hc
         kaTQ==
X-Gm-Message-State: AOAM533Ri3D/gaAtl+gkFHAp28kmzowLDfmVwMoqphnj0piMDhrv4sjx
        QkAJ45ZokKXRsfdMAnJaulBH5rQrMUzw+8Er
X-Google-Smtp-Source: ABdhPJwpzovu/x9nOGk/X6zA0SVm3NknuUXNrztNl+huRF3zGuR5hSR0sWN1hBz+m589bRmQjtElJg==
X-Received: by 2002:a17:902:c115:b029:12c:50d1:ebde with SMTP id 21-20020a170902c115b029012c50d1ebdemr2716266pli.67.1628148004204;
        Thu, 05 Aug 2021 00:20:04 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.20.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:20:03 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 6/8] submodule--helper: remove add-clone subcommand
Date:   Thu,  5 Aug 2021 12:49:15 +0530
Message-Id: <20210805071917.29500-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
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

