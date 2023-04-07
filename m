Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906ACC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjDGHZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjDGHZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F51A5F8
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso9879917wms.5
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r99VpLl2c9eXbN/lJ4kLt/D8QaiW9A8ougIHgBkAfEA=;
        b=KseE3NSvN4+OBG1j1yvICFai7LvU42706n+mpvzlOQXO8fwXmvr6kyG/3L0L/yVwa/
         rUEyCQZPlAcvISCqmf78EHGjSOoTlWnwh/cttjPVL9BBvnnY8RHUXNwmS9lV7gdWdr6P
         C/aLVXfr17TiBds6qvpwnwMMVoRo2eTGLV0GHEd1SO9wv3WpfXNL6nkeeFWgi3zFqP/C
         1knYJIGUPzNWriTBzN6AacPVA2KiDnjYLdZfdehWblQ3KnUu8etzXycH5P9EFNjh2pLD
         /ZU11IikKaL+jrcHjpL/5Gy2creGnLAjGPmW88PwoMPR/NkD0hmWY7tnjUkcocTOYC83
         9m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r99VpLl2c9eXbN/lJ4kLt/D8QaiW9A8ougIHgBkAfEA=;
        b=s2kcmAK2oD7rmFHyMYie67z/Rd0fHjuNgUMaHBu+QlmwJnoF1CgI4KjW+QIMuRTlnr
         0NqEbk/1mNTZGVCO7GCZ9p7DibVdwkPUV/xElRJiuknsijQSIbghSJFzlyTixXmc29WU
         tCY5FB+hKi0rG1SEg1jOvJz96MAHhNYF9L6L85viXSmF7Uzf61N6fa43KPfVieagZzhj
         0KsBTXHw5RRSP4oMBmiy2OrhyJTEII3U6/DHTFrjls3PPTxUZhJpyIeumjOjykC7X/fe
         w5CqI8+XnBvhCmsqemsXH9cy4v8ME5Bh12MdBCTzXPY0tiY/+QG1pG+FTA5UCTaEjplh
         KdvA==
X-Gm-Message-State: AAQBX9ehXorIpnGcGXGiUZi7z1f86FKaunuSADETbyRSN2DhcLJOQS5o
        ypSd4sKhJdVCw2Bj+ppcBuCPO/u//8wGww==
X-Google-Smtp-Source: AKy350YY/26ps7XIZAQ4sCjmFbyk86uqwl7vODlUB72Eb8Xds5Ea2wA1nuY+cwdOZdv/xo88+6s0uA==
X-Received: by 2002:a05:600c:28f:b0:3dc:4b87:a570 with SMTP id 15-20020a05600c028f00b003dc4b87a570mr564557wmk.35.1680852291403;
        Fri, 07 Apr 2023 00:24:51 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/14] replay: introduce guess_new_base()
Date:   Fri,  7 Apr 2023 09:24:13 +0200
Message-Id: <20230407072415.1360068-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In many cases the `--onto` option is not necessary as we can guess the
branch we would like to replay onto.

So let's introduce guess_new_base() for that purpose and make `--onto`
optional.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt |  8 ++++-
 builtin/replay.c             | 61 +++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 7a83f70343..ce2cafc42e 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
 SYNOPSIS
 --------
 [verse]
-'git replay' --onto <newbase> <revision-range>...
+'git replay' [--onto <newbase>] <revision-range>...
 
 DESCRIPTION
 -----------
@@ -20,6 +20,12 @@ references.  However, the output of this command is meant to be used
 as input to `git update-ref --stdin`, which would update the relevant
 branches.
 
+When the `--onto <newbase>` option is not passed, the commits will be
+replayed onto a base guessed from the `<revision-range>`.  For example
+if the `<revision-range>` is `origin/main..mybranch` then `mybranch`
+was probably based on an old version of `origin/main`, so we will
+replay it on the newest version of that branch.
+
 OPTIONS
 -------
 
diff --git a/builtin/replay.c b/builtin/replay.c
index 63513ea6f1..af948af73c 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -75,6 +75,54 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+static struct commit *guess_new_base(struct rev_cmdline_info *info)
+{
+	struct commit *new_base = NULL;
+	int i, bottom_commits = 0;
+
+	/*
+	 * When the user specifies e.g.
+	 *   git replay origin/main..mybranch
+	 *   git replay ^origin/next mybranch1 mybranch2
+	 * we want to be able to determine where to replay the commits.  In
+	 * these examples, the branches are probably based on an old version
+	 * of either origin/main or origin/next, so we want to replay on the
+	 * newest version of that branch.  In contrast we would want to error
+	 * out if they ran
+	 *   git replay ^origin/master ^origin/next mybranch
+	 *   git replay mybranch~2..mybranch
+	 * the first of those because there's no unique base to choose, and
+	 * the second because they'd likely just be replaying commits on top
+	 * of the same commit and not making any difference.
+	 */
+	for (i = 0; i < info->nr; i++) {
+		struct rev_cmdline_entry *e = info->rev + i;
+		struct object_id oid;
+		char *fullname = NULL;
+
+		if (!(e->flags & BOTTOM))
+			continue;
+
+		/*
+		 * We need a unique base commit to know where to replay; error
+		 * out if not unique.
+		 *
+		 * Also, we usually don't want to replay commits on the same
+		 * base they started on, so only accept this as the base if
+		 * it uniquely names some ref.
+		 */
+		if (bottom_commits++ ||
+		    dwim_ref(e->name, strlen(e->name), &oid, &fullname, 0) != 1)
+			die(_("cannot determine where to replay commits; please specify --onto"));
+
+		free(fullname);
+		new_base = lookup_commit_reference_gently(the_repository,
+							  &e->item->oid, 1);
+	}
+
+	return new_base;
+}
+
 static struct commit *pick_regular_commit(struct commit *pickme,
 					  struct commit *last_commit,
 					  struct merge_options *merge_opt,
@@ -117,7 +165,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay --onto <newbase> <revision-range>..."),
+		N_("git replay [--onto <newbase>] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -130,12 +178,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (!onto_name) {
-		error(_("option --onto is mandatory"));
-		usage_with_options(replay_usage, replay_options);
-	}
-
-	onto = peel_committish(onto_name);
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
@@ -151,6 +193,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
+	if (onto_name)
+		onto = peel_committish(onto_name);
+	else
+		onto = guess_new_base(&revs.cmdline);
+
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
-- 
2.40.0.228.gb2eb5bb98e

