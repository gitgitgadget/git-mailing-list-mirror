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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFECC4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349FE60F5B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGZMGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhGZMFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A7C061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k4so5244793wms.3
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtWSUblhIwb6qJqdRLxQ+YImbORm4FGLMMzAz58wc14=;
        b=HxGSHSpFpghroyER4A6DUL4h16ZnIa9PLSLcq5mcdUIAE4z9TbxtenkV599oIyrLVd
         sguO5xYsyNnNmYMW3cZq+iCmRXu9TXwcmDsRlB2B5NdGVLCh9056kfElPVfM7gNMzkqi
         J8W/tACzdu9Agvkgy97YXN9mn1PxpbWmrDXCCVtSGiH3AP9ocT4rQ7x3cbQC3PE0iJ1l
         WXfsSumlXiUv7dkfW+ylTVCV4Vt9eCnNVHFbtj1GOCk7zleaVfQiZSajGKKYGf8uoxDV
         6RZd0oUR5g4sw0Bddbyo4McUJgIh/DM0h72QMPNWo/LDYKMg2mwYvEbwT5M2P2IWOOgW
         bFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtWSUblhIwb6qJqdRLxQ+YImbORm4FGLMMzAz58wc14=;
        b=RzXP3FacrCL1KyvC7M+plYYVKFfd4dgIOUNPx1hUY7rkoH+QDf+/AO4ujcgCYs2e1F
         FGZMRsYekNL+Ryo0ZfQvL9YdN6OXEpRJkdQpCt3dwwg53SnkmKfstG9cusi9rk3oaKJr
         hwYesYGsom+iNsj+1v3V/Fo6Wdpbio6AQ1KCA3CiOE9pFAOpCISwOA8XUnME4xpul2DV
         zuTVRqZWioO4F5gALS41pRAfWz10V4isabv5h3wikwgwlrAVzOqGyuveVi1XnrmzACva
         /yDQgTRkHe2dyMA1siTPWvSELfVc5rd0YlXexwl7S1mQf0lcF2Xy+KVSUC+3UQ2YlOec
         Hh4A==
X-Gm-Message-State: AOAM531YPQjbkjcFMrPaWsfSVFUKzl83uapQvZ9hw1nFw2Vbt4PZEWjz
        7gAlcBzcYygDEwIkruEOE4xAuaSBFFJavA==
X-Google-Smtp-Source: ABdhPJxsJXfwEaIxoB2NX353TYIQQT1tIBS29LAxSjLgbQSZOYHKCJuQTjx8cAPwdlUiGmCOlkbD2w==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr1084446wmj.113.1627303574302;
        Mon, 26 Jul 2021 05:46:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm45155444wrg.68.2021.07.26.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/5] revision.h: refactor "disable_stdin" and "read_from_stdin"
Date:   Mon, 26 Jul 2021 14:46:07 +0200
Message-Id: <patch-2.5-4e5e6620245-20210726T124425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.956.g6b0c84ceda8
In-Reply-To: <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com> <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the two "disable_stdin" and "read_from_stdin" flags to an enum,
in preparation for a subsequent commit adding more flags.

The interaction between these is more subtle than they might appear at
first sight, as noted in a12cbe23ef7. "read_stdin" is not the inverse
of "disable_stdin", rather we read stdin if we see the "--stdin"
option.

The "read" is intended to understood as "I've read it already", not
"you should read it". Let's avoid this confusion by using "consume"
and "consumed" instead, i.e. a word whose present and past tense isn't
the same.

See 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03)
where we added the "disable_stdin" flag, and a12cbe23ef7 (rev-list:
make empty --stdin not an error, 2018-08-22) for the addition of the
"read_from_stdin" flag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c        |  4 ++--
 builtin/blame.c     |  2 +-
 builtin/diff-tree.c |  2 +-
 builtin/rev-list.c  |  2 +-
 revision.c          | 13 ++++++++-----
 revision.h          | 24 +++++++++++++++++++++---
 sequencer.c         |  4 ++--
 7 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81b..3a6c8455b47 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1355,7 +1355,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
-	rev_info.disable_stdin = 1;
+	rev_info.stdin_handling = REV_INFO_STDIN_IGNORE;
 	rev_info.show_root_diff = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev_info.no_commit_id = 1;
@@ -1390,7 +1390,7 @@ static void write_index_patch(const struct am_state *state)
 	fp = xfopen(am_path(state, "patch"), "w");
 	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
-	rev_info.disable_stdin = 1;
+	rev_info.stdin_handling = REV_INFO_STDIN_IGNORE;
 	rev_info.no_commit_id = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev_info.diffopt.use_color = 0;
diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..c9f66c58c46 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1061,7 +1061,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		argv[argc - 1] = "--";
 	}
 
-	revs.disable_stdin = 1;
+	revs.stdin_handling = REV_INFO_STDIN_IGNORE;
 	setup_revisions(argc, argv, &revs, NULL);
 	if (!revs.pending.nr && is_bare_repository()) {
 		struct commit *head_commit;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index f33d30d57bf..fc548ebe166 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -122,7 +122,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
 	opt->diff = 1;
-	opt->disable_stdin = 1;
+	opt->stdin_handling = REV_INFO_STDIN_IGNORE;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak = diff_tree_tweak_rev;
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 36cb909ebaa..f1778833401 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -666,7 +666,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr) &&
-	     !revs.rev_input_given && !revs.read_from_stdin) ||
+	     !revs.rev_input_given && !revs.consumed_stdin) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/revision.c b/revision.c
index 8140561b6c7..50909339a59 100644
--- a/revision.c
+++ b/revision.c
@@ -2741,14 +2741,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 
 			if (!strcmp(arg, "--stdin")) {
-				if (revs->disable_stdin) {
+				switch (revs->stdin_handling) {
+				case REV_INFO_STDIN_IGNORE:
 					argv[left++] = arg;
 					continue;
+				case REV_INFO_STDIN_CONSUME_ON_OPTION:
+					if (revs->consumed_stdin)
+						die("--stdin given twice?");
+					read_revisions_from_stdin(revs, &prune_data);
+					revs->consumed_stdin = 1;
+					continue;
 				}
-				if (revs->read_from_stdin++)
-					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
-				continue;
 			}
 
 			if (!strcmp(arg, "--end-of-options")) {
diff --git a/revision.h b/revision.h
index 7464434f600..99458cc0647 100644
--- a/revision.h
+++ b/revision.h
@@ -86,6 +86,11 @@ struct rev_cmdline_info {
 struct oidset;
 struct topo_walk_info;
 
+enum rev_info_stdin {
+	REV_INFO_STDIN_CONSUME_ON_OPTION,
+	REV_INFO_STDIN_IGNORE,
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -114,9 +119,22 @@ struct rev_info {
 	int rev_input_given;
 
 	/*
-	 * Whether we read from stdin due to the --stdin option.
+	 * How should we handle seeing --stdin?
+	 *
+	 * Defaults to REV_INFO_STDIN_CONSUME_ON_OPTION where we'll
+	 * attempt to read it if we see the --stdin option.
+	 *
+	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
+	 * option.
+	 */
+	enum rev_info_stdin stdin_handling;
+
+	/*
+	 * Did we read from stdin due to stdin_handling ==
+	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
+	 * option?
 	 */
-	int read_from_stdin;
+	unsigned int consumed_stdin:1;
 
 	/* topo-sort */
 	enum rev_sort_order sort_order;
@@ -217,7 +235,7 @@ struct rev_info {
 			preserve_subject:1,
 			encode_email_headers:1,
 			include_header:1;
-	unsigned int	disable_stdin:1;
+
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
 			track_first_time:1,
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..4e73bd79d69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3377,7 +3377,7 @@ static int make_patch(struct repository *r,
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
-	log_tree_opt.disable_stdin = 1;
+	log_tree_opt.stdin_handling = REV_INFO_STDIN_IGNORE;
 	log_tree_opt.no_commit_id = 1;
 	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
 	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
@@ -4513,7 +4513,7 @@ static int pick_commits(struct repository *r,
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
-			log_tree_opt.disable_stdin = 1;
+			log_tree_opt.stdin_handling = REV_INFO_STDIN_IGNORE;
 
 			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
 			    !get_oid(buf.buf, &orig) &&
-- 
2.32.0.956.g6b0c84ceda8

