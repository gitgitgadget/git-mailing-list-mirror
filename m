Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061DC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D6B61073
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhFHMSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFHMSo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:18:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E9C061787
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 05:16:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z8so21297641wrp.12
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hd5NrxT3sYzOEkIdDOEzM0FYqpxg1ObNZB4s0T4HFF0=;
        b=SOEQGOcB/ha2ySsedbpn6DF4LCNU/+GuVKqk2xv28i7U57MTR8mpmbeOt9n/tkRMii
         yFvQg6gEhbDmlt4kliYngemSjHR0rnK//ZXsU5d+uFa0/WX4DUTvMICHvB05vi/re3M8
         mIM1q2VTeL7vBEX3m3yTMZIA910awRXa7pU65I2GsANveb/qGAzbJ5tSywKOsZdOnUPR
         Di7cGb2Y03YNSY9FNCvlCKV3qiP0zLRqKwRBXluN6JTmdItyPj79vKmY6qPoe5NsDrO7
         cvzij0VQGoNbodxatXsmmIFCLHxgngG8ood7xe7kb6i1uW8lrs6O03KQJ18c+d8jCy3H
         72EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hd5NrxT3sYzOEkIdDOEzM0FYqpxg1ObNZB4s0T4HFF0=;
        b=bvNTHzrrrAzHGyghMDiUTD42jgsdG1CYKg2tj/2XO6+t2YQ0phuZsw/Jl42nAJQpGA
         u/zCA7O+rISo6CwLCy3ZxF5YupcJxuL5WkLSnVkbT4jXV8WSpT79C9X3Ktr0v4SQrY/a
         WQ49owwZvLeU3qv+yeK+qpHeElrjfwS8n03ajnkzguL/yUiOnxgWpLU6w1PsuprEpUIh
         xchzVNI1hT5jNCIpfFyb1ClVpfylGd53yjYbvGWNZWWLYai4Z7ZI92B1JamsrENm6r3r
         3b35v3q6DXhUu3/ns6mscgksN3WprnK8psbiRl9U6zlaK6AVvFXdXrcXv4r5X12q7yS/
         fjbg==
X-Gm-Message-State: AOAM530ikXepIzHxxEjsR2jlzgWmR31XWJERzQ/uvBrtS1NFoFLN5VFv
        E6yOBKrHXr9fErfxSpaxD9auZNSBFvtcHg==
X-Google-Smtp-Source: ABdhPJxDg9MCAsent5B0VJkeIZycnHnYpzBS+S3VlPKt7uEraA/FFmbcDao59Uxu35TZgsODPeaJJw==
X-Received: by 2002:adf:ba02:: with SMTP id o2mr2946818wrg.234.1623154599105;
        Tue, 08 Jun 2021 05:16:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20sm12976378wmc.39.2021.06.08.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:16:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] revision.h: unify "disable_stdin" and "read_from_stdin"
Date:   Tue,  8 Jun 2021 14:16:28 +0200
Message-Id: <patch-2.4-002e0f1cf7-20210608T121008Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03) we
added the "disable_stdin" flag, and then much later in
a12cbe23ef7 (rev-list: make empty --stdin not an error, 2018-08-22) we
gained a "read_from_stdin" flag.

The interaction between these is more subtle than they might appear at
first sight, as noted in a12cbe23ef7. "read_stdin" is not the inverse
of "disable_stdin", rather we read stdin if we see the "--stdin"
option.

The "read" is intended to understood as "I read it", not "you should
read it". Let's avoid this confusion by using "consume" and "consumed"
instead, i.e. a word whose present and past tense isn't the same.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c        |  4 ++--
 builtin/blame.c     |  2 +-
 builtin/diff-tree.c |  2 +-
 builtin/rev-list.c  |  2 +-
 revision.c          |  4 ++--
 revision.h          | 23 ++++++++++++++++++++---
 sequencer.c         |  4 ++--
 7 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..3a6c8455b4 100644
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
index 641523ff9a..c9f66c58c4 100644
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
index f33d30d57b..fc548ebe16 100644
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
index 7677b1af5a..88bd9ef954 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -651,7 +651,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr) &&
-	     !revs.rev_input_given && !revs.read_from_stdin) ||
+	     !revs.rev_input_given && !revs.consumed_stdin_per_option) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/revision.c b/revision.c
index 8140561b6c..69b3812093 100644
--- a/revision.c
+++ b/revision.c
@@ -2741,11 +2741,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 
 			if (!strcmp(arg, "--stdin")) {
-				if (revs->disable_stdin) {
+				if (revs->stdin_handling == REV_INFO_STDIN_IGNORE) {
 					argv[left++] = arg;
 					continue;
 				}
-				if (revs->read_from_stdin++)
+				if (revs->consumed_stdin_per_option++)
 					die("--stdin given twice?");
 				read_revisions_from_stdin(revs, &prune_data);
 				continue;
diff --git a/revision.h b/revision.h
index 93aa012f51..03231f089f 100644
--- a/revision.h
+++ b/revision.h
@@ -86,6 +86,11 @@ struct rev_cmdline_info {
 struct oidset;
 struct topo_walk_info;
 
+enum rev_info_stdin {
+	REV_INFO_STDIN_CONSUME_ON_OPTION = 0,
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
+	 * Defaults to reading if we see it with
+	 * REV_INFO_STDIN_CONSUME_ON_OPTION.
+	 *
+	 * Can be set to REV_INFO_STDIN_IGNORE to ignore any provided
+	 * --stdin option.
+	 */
+	enum rev_info_stdin stdin_handling;
+
+	/*
+	 * Did we read from stdin due to stdin_handling ==
+	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
+	 * option?
 	 */
-	int read_from_stdin;
+	int consumed_stdin_per_option;
 
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
index 0bec01cf38..4e73bd79d6 100644
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
2.32.0.rc3.434.gd8aed1f08a7

