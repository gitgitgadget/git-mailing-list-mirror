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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CCC4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A3230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLETyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgLETyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:50 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F20C08E85F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:39 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l200so10477494oig.9
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ06cAB5AmKT5HiWVn5FUicxmys+2v/iFY1g1DfVc9k=;
        b=oci14OW5Z/SPSWU+Ps8vpyoNXWVKrnqRaOS5fUp7MarK6skxe4zHmppA3O3X5wt5r1
         D3tZSCM/p8+Xo/pBvM+enkklsyZ8N96cQM7DUktuqhXb0ru/WjwM/XrFY6RWk5fxevJ6
         W73NRhGfYcZALqRkK2dMiWMGmn/B442LiTNwLJ0An0PxQm24D459h5esiABD5KJhUEtx
         O81B6Na38i62rgFIiZtyHBDxdqlZvMPbLSNTIlwyQAlRLDWxMBbQTIGhUDT8M3KAi87k
         qD6scpPNlR1QnwsAI/JqbYcG+cr32v0AOUPeUg870RA0FUHrGMRbeG03fQAEAkoeOy+s
         0mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ06cAB5AmKT5HiWVn5FUicxmys+2v/iFY1g1DfVc9k=;
        b=NQyJlweSL0gvzCPcF+sq/rcQ9VAtYZOuqWlQwHD9doFTGmteHtUN4f4IjKrmfart7a
         AYyjyhuzS95lAoOOgu3Cn9fzGfW7Yy1RFuLfRLpr/E5joPm0Gge1Hl/is5kzTQmJJAzF
         E1NPfLvBOkf7tHbC9E2zHXvcnjwXI0BlPFcSlJKP2PRhqFgktxf2dF7MzALFdpGqa9Pb
         iHN4evw/RqOUz7nYORme6GsCxTOIaT64UXzezq0/bBJWUVlulovCDW6UUZod5IvKG4PH
         3w9zNI6kS1KHXmZXYE6qrjFPebgnBVAsiP3wjDvas5Fugd7iBwTWV3PLy/kRQie+R7xe
         fnyQ==
X-Gm-Message-State: AOAM533gLs4uDse/NDCzkJCPITeov0mJZAF3fH/j17nkhXM4a+M0lCsp
        i6urcFFBBZ/aR4h4GP2m1p7Ttk7P8b9BVA==
X-Google-Smtp-Source: ABdhPJzqWTKo0fG9r5k3SRAeGYwIaf2RwJ1OjrN/237IoSCC1w8QmUfR21zZSwmoSZB8E1V1NjsULQ==
X-Received: by 2002:a05:6808:61a:: with SMTP id y26mr7393841oih.72.1607198018250;
        Sat, 05 Dec 2020 11:53:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f10sm1174638oti.11.2020.12.05.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/16] rebase: add REBASE_DEFAULT
Date:   Sat,  5 Dec 2020 13:53:08 -0600
Message-Id: <20201205195313.1557473-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By introducing a default we can distinguish when the user has forced an
option.

Therefore there's no need for an extra "default_mode" variable (it's the
same as opt_rebase == REBASE_DEFAULT), not is there any need to
initialize opt_rebase to an invalid value.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 24 ++++++++++--------------
 rebase.h       |  3 ++-
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 2bd6ee9d19..347ac89eee 100644
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
@@ -76,7 +74,7 @@ static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase = -1;
+static enum rebase_type opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -348,9 +346,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	default_mode = 1;
-
-	return REBASE_FALSE;
+	return REBASE_DEFAULT;
 }
 
 /**
@@ -445,7 +441,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -458,7 +454,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -473,7 +469,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -938,7 +934,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
-	if (opt_rebase < 0)
+	if (!opt_rebase)
 		opt_rebase = config_get_rebase();
 
 	if (read_cache_unmerged())
@@ -950,7 +946,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1010,12 +1006,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase && merge_heads.nr > 1)
+	if (opt_rebase >= REBASE_TRUE && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
+	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
 			"You can squelch this message by running one of the following commands:\n"
@@ -1031,7 +1027,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			));
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

