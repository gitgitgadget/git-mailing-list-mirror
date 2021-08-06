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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92573C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A37610FF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbhHFMCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343517AbhHFMCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C7AC061799
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so22375372pjb.3
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WgmNKNanX9X8ALNVyb8rV6slbVPgX5pJ/fApnFkIvQ=;
        b=SLmhWWbtdgfQvx+idGXEOnqAd0TI98SUYG91StWPBN2oET0CQaizN5btogibD37v2B
         2YI0dQJtjMVIv7BLhSNT/Lcertwpe9LAJoNgHIrP4xuU/t7YuVJAYr2r8HWde5wMhayn
         Y66vuEXAfmamfQ61MQphPqO+hiV/sliCqfRgvmTW/WwE6/0wnd+xdlpU2x/MH7QAvRBs
         o+/rk9ijGodrEHt01fCGz9Zo4TwzNzTIR4dczgLNsg1+Zh1tbD2sI4E/L+YKoWfQmQfr
         WiPW96R5I+2cCnNYLKAXpWnd+cyfM41dtM6Tva5We5j/HtqSkMrqz/z4ywWJuPMcz3R+
         kVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WgmNKNanX9X8ALNVyb8rV6slbVPgX5pJ/fApnFkIvQ=;
        b=Ft4SEHQ2xpv6+by0zYi602EM0pMr98IcU5hx3GCnRqYQblNy0UNQw2hTIYV0ReQwVU
         qlZSPIkGAXVNTVCWTyrmsc/aZ5wDhXgu3mOI29SW+xeLqJSRnVrlpAef3cjnZhspIvIu
         YIUs2qEwSgexc47e4eq9GWyAIYgL1KXix+F7JTjoL9PqqoHzgvBglz5MiG1wpBHUa7SO
         VgeDvxtLayodA3XffK0H52tvvg6MJdQb8whwwVr5EIdiRuB2O/b3TSd9J4uOiDziI1Zs
         w1W/DNn42F+ckkJ7o3PFrf//hSPpr3w1a3Dy/PaHVRwRkaIxnk6nf/y80IW15cncAmMf
         jKqg==
X-Gm-Message-State: AOAM532nWJ6K/2dCjdQky7+QLQoQtIOZm/gc1we50z6kVzUD92FaeIU5
        FxweNfxVVy5ZOs3F133k17g=
X-Google-Smtp-Source: ABdhPJwrTHAYuFef8rLJetFOiAGQtM+QtWU/SCfD9OkQxGYiU14RvW5yKdhNbL4h12rzDO7J5zPEMA==
X-Received: by 2002:a63:e947:: with SMTP id q7mr831669pgj.324.1628251357329;
        Fri, 06 Aug 2021 05:02:37 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:37 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 7/8] submodule--helper: remove add-config subcommand
Date:   Fri,  6 Aug 2021 17:31:46 +0530
Message-Id: <20210806120147.73349-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
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
index 1257066a0f..a858c2be29 100644
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

