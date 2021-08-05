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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFCC4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96F5610CC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhHEHUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbhHEHUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDCC0613C1
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:20:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so12741295pjr.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PeTlolYUUEdH50YFM+tYWul3tHUIpiVifHEE94XnWs=;
        b=mZFhmqG0tTcaSJGYzkPnsztugTDlAOJEr3JxgwPSQpL/QmXqlRfciJi/hiwUkaG3Xc
         jOALrxkepY6zXQcHIqIcvOAwnCZLMCxJw5TEdkdkE9mTkG2Ykeo1MxBJv9Er/qTs1kAa
         nc8gQlV3E5tiSVkC9xHpF9rQZSiIlLlOSOstHLls2TVmHx1ZeDKc50TP1mlvJk1O4qvn
         vk3n0cHq90P580PCh2ExE2Kz4BqVKhcaA5OPOVDY34uSVXrQn05Cy61aC/AEDeFLYaQw
         8FfHBlLy1tqE75estXMHojnzHI7ZyrHjtFzW+BCrwqIAyihX0Ry2imakkhgffxtHWuJy
         kGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PeTlolYUUEdH50YFM+tYWul3tHUIpiVifHEE94XnWs=;
        b=tjxA2p48UUMxcBf5Nzvk+4UE8YUt+y7qzsqkoEYGLuSUIyft220HbwZ7iyXHQa+0L1
         RHzQt8uGrJ4YmiyP6Gk8i0okdMhk9IAyFicL0vu09e67R3VitPYo6iFk+jLB9fboKs2s
         RwbXnVEehaiM2IbpX5+coyXKp2wz4s6lZv0/GPQ0WLy7AaRnukeVu/aRG7i56VyNf3LN
         iShyrzesQj/Lu9JtBOJ7qVnLujbWNJQjAdBxkTClsI6Mpd86edNQLfZyRee3HPmRN3eJ
         LPWAm53EfmRaT2qzDkTLPZAYC6AXWqU3yBoreeRRTrWn1/X+btE+RGisEw8WXzNSbhr8
         cl0w==
X-Gm-Message-State: AOAM531M+bikMTyRCxIy48sC358uvDWUkjhxTYUxZgkPwGENrPGmBYuW
        AOpNoBc0p2kTY4H+0v6+RaPhPR9ZothRBDYu
X-Google-Smtp-Source: ABdhPJxGKZJ8gLSueaoDgq738rVzBXscLcGx5B4w9foDAYXiz6A3qqtGzZnOXf0iqbJJZN+Fh66+xQ==
X-Received: by 2002:a17:90a:ea82:: with SMTP id h2mr3286480pjz.99.1628148008628;
        Thu, 05 Aug 2021 00:20:08 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.20.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:20:08 -0700 (PDT)
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
Subject: [GSoC] [PATCH 7/8] submodule--helper: remove add-config subcommand
Date:   Thu,  5 Aug 2021 12:49:16 +0530
Message-Id: <20210805071917.29500-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
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
index 700cc8bbeb..da83e8e2a5 100644
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
@@ -3158,7 +3110,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add-config", add_config, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
-- 
2.32.0

