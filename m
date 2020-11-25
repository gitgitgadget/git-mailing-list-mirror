Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F4C64E7B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DD720872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugjUmvYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgKYD3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:53 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBCC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:53 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id l10so169366oom.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwSOR7TtLX10jNB6vkoYgbT/6H2+sLaxG6xXL9lz/2I=;
        b=ugjUmvYnvrGfXypb3a70CD6bAvKWF21eayz/YHxHO7pdfbBPPL3+Qozljt2eoTWhXU
         5+N6eVmjAdEd1XcrV4NuHPO8me6K/32yPaziwMeM4WqYjdGHmvbq8d9p61kgm8UB5yqc
         S1KC6/iKPIG/xleTWw4RZ+PZ2NNWaUboDQ8kyisPmDLOBRqOAM32h0NF/6tYem+dmyxm
         /Y23TZ7f0ii5Kuhmejaent1rsnapNCgplcfp5z27m/AmuG6Ra0RCLIojpMRz2b2nxrQp
         Yz9d+t0jrWulD78QZJgzon7XUQu+/lqamVKQMCP0orDmtq2SheUGFSmztZBr+A0ngbiG
         mzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwSOR7TtLX10jNB6vkoYgbT/6H2+sLaxG6xXL9lz/2I=;
        b=P6lzPABM6OjCVF/sELTcla+oVP7wqqRmvD2naCMKg0l5dTyZtaE5IJRHxnpnSfLzMz
         0pC4SksLBoExbj6jCByODRPZK7birLsp9ONYbb97zqPZ+OZDQ4YtCnTqgbhdjVFnIjSz
         Wi3E2LHZIpLAdmBTUJ+anLXHKBWfv5vhjNMK5SwA0U+q8rSSH0cbk0teukCGES1Db6Mm
         sXkPuEbmkzEABX3RYM+LuQkMkYNIno9TJ1a9fb4L1R2wY01b8waUbp4aDqoA6jwAF4N3
         xN9shLW7vIqxlnPaD3tHGPqxVb3gCAEqjXjAdHETJVJotdR04IXh3NGZuynKQZ0NyUZV
         ro1g==
X-Gm-Message-State: AOAM533wLfA7HGK98M/nWghHyfSTylbUmnJ9eslm6Nkltqhr4uNp0vxD
        lePSrgXZ9sCSArTnDPS8huWbNFvgKmVGqQ==
X-Google-Smtp-Source: ABdhPJyss8e1nCjbUjIcZodVHo45VkDVdcXX3XxT8lZg9trrt5zCEkt1F71HxikxoEsyoyT7niKQrw==
X-Received: by 2002:a4a:b409:: with SMTP id y9mr1280990oon.70.1606274992391;
        Tue, 24 Nov 2020 19:29:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m109sm567356otc.30.2020.11.24.19.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 07/10] rebase: add REBASE_DEFAULT
Date:   Tue, 24 Nov 2020 21:29:35 -0600
Message-Id: <20201125032938.786393-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So that we can distinguish when the user has forced an option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 20 ++++++++------------
 rebase.h       |  3 ++-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 479bdaf0ee..0df7d27343 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,8 +27,6 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
-static int default_mode;
-
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -346,9 +344,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	default_mode = 1;
-
-	return REBASE_FALSE;
+	return REBASE_DEFAULT;
 }
 
 /**
@@ -443,7 +439,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -456,7 +452,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -471,7 +467,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -948,7 +944,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1008,12 +1004,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase && merge_heads.nr > 1)
+	if (opt_rebase >= REBASE_TRUE && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
+	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
@@ -1028,7 +1024,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"invocation.\n"));
 	}
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
diff --git a/rebase.h b/rebase.h
index cc723d4748..34d4acfd74 100644
--- a/rebase.h
+++ b/rebase.h
@@ -3,7 +3,8 @@
 
 enum rebase_type {
 	REBASE_INVALID = -1,
-	REBASE_FALSE = 0,
+	REBASE_DEFAULT = 0,
+	REBASE_FALSE,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
 	REBASE_MERGES,
-- 
2.29.2

