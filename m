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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FBC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0354613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhGEMf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhGEMf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3FC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u11so20612025oiv.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Af52J6U3Q6JrsFdXd3iebD1QolicSqph543lfeYQaA=;
        b=ZK4Eu6Msr2CLj3p5gTQVUMHYod4Ie9JTHWWLmee/gx36u0BOw/1dcW/HAYdLg2iay0
         gbgpMPN9empE+AQOLVaGz4nbtb+V1WGlWbYfY9WDhoBXrozWYaxn47XGFgiWvMrwED4F
         qBHtXGlTx7o93h7qGQYfy67Rz7CTJ/HOlCv+zbdlEsg4CsqaVXezZgXectyaCtpFw8GK
         yD9+21od99uZKGkY52HXyMBjjMjS9SAWS8uKSWAUg7uvxHlTgg0O9ziEIoWgJgDNijM8
         wIXB6r/a2vQyF5FLWjw2LeTyic68JYPnuf5PAzwfu+OPShVvki1WeHHBAVe+cyLljskn
         BRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Af52J6U3Q6JrsFdXd3iebD1QolicSqph543lfeYQaA=;
        b=uN7Cdlq7Vif3eT9nju0J5w0vDFN11fEEhDx4Q/3ygZjUgxL308XsP8E/CrKHt9Tabo
         mJuQhH1lEhwboTNzCWV9Q7eNxCBnDbe9Ge8VmV4MgCL/rnUnQSkqcM1of4bt3HyBZqI9
         AFmrjAE6+UjNCoe4IvUzXqNfr9idF6pHbiActKRLKvJABun+Xs7HGy/uhLyfYBO8p5FE
         Gh1IFj/MlvzvFdQIrofMhigbxlfD00T5GP7AeLotK/LOzT57vgGpMQNSVJE9ZVC0U9gS
         AFMyBSCf+snSjPrehmJPyuaafO2ILt1KI+X6I+yqDxzUeQtHiht4ikXH4KJJ8ygu6liW
         +qaQ==
X-Gm-Message-State: AOAM531A/UC6libvbSSh2ipXJ9rhMor5pfYJKz4jUkXiRUkRtxwVnVyS
        3wPGNldh5oVPP1woRKn9QJ38qWdXrWsujw==
X-Google-Smtp-Source: ABdhPJyfwq5LgUGjJUkkBfXYxITDhEccjOQILYdUbqWxO4podTGRWOtIAnvvsYJ0LRtHrTmX+K/nDg==
X-Received: by 2002:aca:4541:: with SMTP id s62mr10129777oia.156.1625488370804;
        Mon, 05 Jul 2021 05:32:50 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id f3sm2683925otc.49.2021.07.05.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 23/35] rebase: add REBASE_DEFAULT
Date:   Mon,  5 Jul 2021 07:31:57 -0500
Message-Id: <20210705123209.1808663-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
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
index 0d76b54186..94fc8b0739 100644
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
@@ -949,7 +947,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int rebase_unspecified = 0;
 	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
@@ -971,8 +968,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase(&rebase_unspecified);
+	if (!opt_rebase)
+		opt_rebase = config_get_rebase();
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
@@ -983,7 +980,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1043,17 +1040,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
2.32.0.36.g70aac2b1aa

