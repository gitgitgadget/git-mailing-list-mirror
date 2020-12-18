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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5DC3526E
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C3123B98
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgLRVLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgLRVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50FC0611CA
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:41 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s2so4340247oij.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXD5U3guJClu2AEznHStFRdMM9B1SEyl0CgnQM9fnd0=;
        b=e8CbyHBX3canU1111zKCJ/Be+zO+Li7mDoaRDkCrI/P2414hxc93L1NBuWlNR2UUMr
         vrXQEuVh/02O1hftow2Mr/7jw5M7hv9GeVn4CXB2E1x0LIidfuoWyoePt+RrpN4uSwvu
         SrgsdYc9MaaIlKfqaAZEGGYev9asY3pvSztyVRA/tEOkfL+Lzpegi156U+UfNsGEmrAj
         GqfWg0nzaHJRo7GDH4AB87FNr8kB/q0TghyuHWvz4UQjXcnTi7Ya38B0VJ1AgRoQX0rM
         g6Af419IaFK2tedNIff8qENQRhtfSFR9lfmt5s3arYFNPmZ7XUcppNKXh2JGPUdEq1g4
         Op+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXD5U3guJClu2AEznHStFRdMM9B1SEyl0CgnQM9fnd0=;
        b=VTqxo4Hk9ss5BO3onKs+UihXXFuIHKKow9QloEkFGyg/9waWajKc9Tmjd3O1fRYQjn
         1BCQIKnsud2iFSv4cm0e8+l1GfqkuUeoRnwPjtaWBxvbEIsqpZU2RcY3BK3DfvTwV4n+
         h6aeUru4HXlgaw80QXKTSy5Yqg3eOp/ou0Ol7sh3WCt3W3zuH7hv09reDJm/mFTbzo0N
         DYHt/1xZdne+WtldW1kG9PVHEvBRgqlsiw022BFixYs4vgurBmssErb4ED5R7iWRAViA
         D/NggjVeq7jvfqkXFEgGatxa6EEM5e6gCY7taR9A6Io2/PUniS1FOGIsHYqkXvG4pyum
         NJeA==
X-Gm-Message-State: AOAM531/5KksVIBshmVVeuPfAYTnPKOHgXIUGfgWP7EGcGKCZcxXJsRA
        UHksSq3/XLwcLa0T9GnVFO3whCSYnXflTg==
X-Google-Smtp-Source: ABdhPJxc+275guVF+gepob92kD9tJJPj0VfBoUzoK4gd6LOBPqZrN/8blbC7jlJPA2dDTuiN5hgDOA==
X-Received: by 2002:aca:1004:: with SMTP id 4mr4153475oiq.4.1608325840925;
        Fri, 18 Dec 2020 13:10:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r10sm2194323oom.2.2020.12.18.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/13] rebase: add REBASE_DEFAULT
Date:   Fri, 18 Dec 2020 15:10:20 -0600
Message-Id: <20201218211026.1937168-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By introducing a default we can distinguish when the user has forced an
option.

Therefore there's no need pass around an extra variable variable (it's
the same as opt_rebase == REBASE_DEFAULT), nor is there any need to
initialize opt_rebase to an invalid value.

Additionally this will allow us to override the default with a
configuration, and subsequently the configuration with arguments.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 27 ++++++++++++---------------
 rebase.h       |  3 ++-
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1336b59b21..c0a90fa741 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -74,7 +74,7 @@ static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase = -1;
+static enum rebase_type opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -326,7 +326,7 @@ static const char *config_get_ff(void)
  * looks for the value of "pull.rebase". If both configuration keys do not
  * exist, returns REBASE_FALSE.
  */
-static enum rebase_type config_get_rebase(int *rebase_unspecified)
+static enum rebase_type config_get_rebase(void)
 {
 	struct branch *curr_branch = branch_get("HEAD");
 	const char *value;
@@ -346,9 +346,7 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	*rebase_unspecified = 1;
-
-	return REBASE_FALSE;
+	return REBASE_DEFAULT;
 }
 
 /**
@@ -443,7 +441,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -456,7 +454,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -471,7 +469,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -951,7 +949,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int rebase_unspecified = 0;
 	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
@@ -973,8 +970,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase(&rebase_unspecified);
+	if (!opt_rebase)
+		opt_rebase = config_get_rebase();
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
@@ -985,7 +982,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1045,17 +1042,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase && merge_heads.nr > 1)
+	if (opt_rebase >= REBASE_TRUE && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (rebase_unspecified && !opt_ff && !can_ff) {
+	if (!opt_rebase && !opt_ff && !can_ff) {
 		if (opt_verbosity >= 0)
 			show_advice_pull_non_ff();
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
2.30.0.rc0

