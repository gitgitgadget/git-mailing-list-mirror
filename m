Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE6C07E9B
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4213161249
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGILJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhGILJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 07:09:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E66C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:06:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v5so11638550wrt.3
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EY77LNxSBLgxi9S5FrLjsJr++ryDedrMnTamY1nOacU=;
        b=V4D0BtjCeToM/NHgq3t/MjiML1kZ4v68rOQXJo96lGptXpE5Hgwijzt/oHEWn7+8Mk
         HgvMYwGG+iJga06uE+CryV+6hMJwuQVxFC9SBtDHYsm6t1pABh4L+Y8eOd3ZAOd2Kzam
         a4wX3czmaccIY/V30WQ5N1IACx/s5cmMiqShDqwnGRQvQMTnB46RsxXhPeZ4aP5qNiHH
         9sEf+BC4wNd9ke/tysIoiBpd3i5S9Rv0kA1XOIgtpDPdLV9ZkbS63CxfqNKZe6+RIceu
         2QrekmQ2VfUBN5C9Kfwh8+te2etOZtXb30oJe1/J9Ge2r5upWAcuc4DfOpFzbMG2Leyp
         VYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EY77LNxSBLgxi9S5FrLjsJr++ryDedrMnTamY1nOacU=;
        b=hvoUTNURTuyyIojWV8u4NCKy5WwABX7DXrwRdSe9BDT48Nxzg0Ns1cqRXVHCcxyu73
         bUcsEtC/+zLaRBdhq7p+IDn0/nexkt8zDXpkDcNQybnlE0FeeOFY0Va31IweoCMtff3D
         hlR86HBqXRx44DXqvmfp0lsSqZgFG9MjsZqGec4J/CO1I1/rid3MYkdUv5J/uPn3zax+
         PK+IAzlhqL8RLgnXpXgFgG4TN/1uDcYKsY08p2Of9rdV6r06ubLu9W6d5BrljTX8ho+p
         xqkzOvXZjEPiTUdwP+w1qovatvjPgErFzDn/QibaZVdpB+T39E8YWZ/7eGSSBp+OFIWi
         ToPQ==
X-Gm-Message-State: AOAM5336mYja3sIpdZWe4BMEi9DBiT9i9qEmoF3Ng3QvFvXQ+NYpJq/I
        fpt8kWrponcW+vI2lhvDkTXIR15W9HqiFA==
X-Google-Smtp-Source: ABdhPJy006DvfrXtbx8Yn9Yl/LvLfavSUGT7u2f4LcyJ5hUXdDDbg7KPm7xHATA+FPzF8CglTnpXgw==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr30955073wrr.336.1625828781540;
        Fri, 09 Jul 2021 04:06:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a4sm4978167wru.55.2021.07.09.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:06:20 -0700 (PDT)
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
Subject: [PATCH v4 2/5] revision.h: refactor "disable_stdin" and "read_from_stdin"
Date:   Fri,  9 Jul 2021 13:06:13 +0200
Message-Id: <patch-2.5-630feb06650-20210709T105851Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com> <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
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
 revision.h          | 23 ++++++++++++++++++++---
 sequencer.c         |  4 ++--
 7 files changed, 35 insertions(+), 15 deletions(-)

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
index 7677b1af5a4..524632ba328 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -651,7 +651,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr) &&
-	     !revs.rev_input_given && !revs.read_from_stdin) ||
+	     !revs.rev_input_given && !revs.consumed_stdin) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/revision.c b/revision.c
index cddd0542a65..f30b9d40af4 100644
--- a/revision.c
+++ b/revision.c
@@ -2742,14 +2742,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
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
index 5c5510d4220..a942b1250ad 100644
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
+	int consumed_stdin:1;
 
 	/* topo-sort */
 	enum rev_sort_order sort_order;
@@ -216,7 +234,6 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1,
 			encode_email_headers:1;
-	unsigned int	disable_stdin:1;
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
2.32.0.636.g43e71d69cff

