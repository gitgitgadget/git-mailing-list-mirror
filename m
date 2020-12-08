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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A96C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9523A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgLHA2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41568C0611CC
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:09 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 11so14337212oty.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0m5bCYu2A+ygXSPWwHnLigdWBuets4CxIRyPFOoEgDk=;
        b=k2uMycxdWV6kS3rCfSghVHGfFQUpLuxDhUSZtIF6B6WlgGw96+yjK2YDl/JEEHaV6m
         HG1HPgvne4BWaJf/ejEz8yUMeet3t0fGPjch4P7mbPRBoOA2+T3pUJKLPyTPgytmrFtu
         ycJUDHO/5w2bQuLkdmIo/PtLr4pFsPKrKdbx8kNZhQAweEjAkvAVAYsiIqcgJZUrqlea
         WMOzs6ntpExNAcWkDe9IWRGoglb5JFMJwDRHZOY2tAQ12SKReaP5lPlQjZEVY4YK33Dn
         PpFnQ7SwkI6IbYryy+ysq6fx+9Gp2ioE5tf5cl0COf9yIwopsc7qPeIGEo2zRyFUT08V
         wVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0m5bCYu2A+ygXSPWwHnLigdWBuets4CxIRyPFOoEgDk=;
        b=Cn8I1+wiX754CToBbOcmJxBhKK/IJBIpGt8B3YkDQuurR90NvNjXQj/0Rqp3RcABWr
         05MIyge/W1Ib0Bgm0KToziD2Tq0JXHn8N+TLOWMlyGyH8L1fWTjMH2IuF1hLweYQJ5Kp
         GHZOGapKIxACa9EQuxgIZ5dOMZP1P5GUZQXt+vmnBp5YQbDF8kjbNSXCaXdHqbFLCJL8
         nht3knKAiCx5OKt8LaPrdlY07ulWd65zRK6ol81wBbqkdNkPk7avrJrKV3wTvsMoU64d
         kHIGLuVsVriky9mSo7jQjfHl36ibhEOXm2byJcHzT7M4lKYP1f2iRG0v6n9A6CXvt7az
         GKfA==
X-Gm-Message-State: AOAM533oJn3rs8M0qaGCvkXcYxEbR9qJduFb7gA4exjXhAQTFBcqMdwS
        sJcByUYS2+VtxXcWzXx7k3vD7qTLAj15QI8h
X-Google-Smtp-Source: ABdhPJyV4zKS9VybKZfrI0MENRsjXwHdCBJZepnlb2G29pWIxorBcxQt13/VUF3cBnK7R4/1MhS8rg==
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr7312121otp.162.1607387228342;
        Mon, 07 Dec 2020 16:27:08 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d194sm3338637oig.3.2020.12.07.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:07 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/19] rebase: add REBASE_DEFAULT
Date:   Mon,  7 Dec 2020 18:26:40 -0600
Message-Id: <20201208002648.1370414-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
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
index f5bdae680f..350df6f3c5 100644
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
@@ -956,7 +952,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
-	if (opt_rebase < 0)
+	if (!opt_rebase)
 		opt_rebase = config_get_rebase();
 
 	if (read_cache_unmerged())
@@ -968,7 +964,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1028,12 +1024,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
 			"you need to specify if you want a merge, or a rebase.\n"
 			"You can squelch this message by running one of the following commands:\n"
@@ -1048,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"Read \"git pull --help\" for more information."));
 	}
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 
 		struct object_id newbase;
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

