Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E653C2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087672074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKnfq7hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDDBMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:16 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42235 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDDBMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:13 -0400
Received: by mail-qv1-f68.google.com with SMTP id ca9so4583858qvb.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSfI4RaIoissbL4WDRYdrBycXshlTKxbIEm6Sl/3cLY=;
        b=bKnfq7hUqGE2cpBjiDe7lDg1phcNxFfLMkmrqJaZuh8X5iBa3G/8IdL4PoSNmajRlk
         1ov+W0p3WYrOX1h3RwmNj6T3wvoWX3g8PJmgpzHuiP37G/aacnyIyBiOgGcA+8gL3gW1
         AejFowNegV7YF53iR8Jr8XD04jYtzrfuHPyocMvw3hN16U1FE+LD4we54wxO8FV1H7bl
         ahBXEwyjM5Nc7Pv5OgZzIGsxhR8ZhmgHlTjWzSTXWxRBxYip1Jy1x7qJSWdioH6h38ib
         kqvNHLI5QuoFP89syGYu4JKKfAQB/qL0FG3iXoHF27aKTyfiNYIUdOeHJ1nUEAkeXRPS
         9jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSfI4RaIoissbL4WDRYdrBycXshlTKxbIEm6Sl/3cLY=;
        b=CqSKNlbgkPzfgpWpn7Boyt4FleiQ5lXmgSOWpRyRvJOxWvWhKIf9SZGaiy9T763Rky
         bVnSoRZfz0cvhAt0YrZT4PJoQhtZ63lm0IExaUNcajfn79xryvJh8XV1aEu5mKSgyheD
         ij3eNt81HL30A52NB1ybs5JyBDyDwSgNFyCyCTXE8OE4izeFuPTN/6sT9N/M8s8Zgrzg
         VXVrz1YrpF5he3sCf4PBQGLNdia3TcH2EblOnat+G16KIIub12o5GVEeWCb6KKUpVhO1
         Tvo+sVb7UMdQuvBO8GGejab8yvYBFu29iBz2agA/yHC3tvnLPOKjS6TFt2hZHUIx+ZhJ
         sNQw==
X-Gm-Message-State: AGi0PubtskjlCU0OkxzzbsiLSiKwAzaKsw5GVYmYApU05wvDr0tyg+w9
        9rUgY57jwSWkZRCLQi3MFnr0HGX2
X-Google-Smtp-Source: APiQypJiHMHxzSMUO5jHRvTmDK3aumth67RSthjBUfNsTm5xLvZ3WWK5hhDjtNINekQeRf7zgg20/Q==
X-Received: by 2002:ad4:45ae:: with SMTP id y14mr11291388qvu.119.1585962732643;
        Fri, 03 Apr 2020 18:12:12 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:12 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 13/23] rebase: generify reset_head()
Date:   Fri,  3 Apr 2020 21:11:26 -0400
Message-Id: <fe57e21dbc70d02e4462f28bc36752abd4f6c279.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on lib-ifying reset_head() so we need it to
be more generic. Make it more generic by making it accept a
`struct repository` argument instead of implicitly using the non-repo
functions. Also, make it accept a `const char *default_reflog_action`
argument so that the default action of "rebase" isn't hardcoded in.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 64 ++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 29745176cb..0f650a798e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,8 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 
+#define DEFAULT_REFLOG_ACTION "rebase"
+
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
@@ -767,9 +769,10 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-static int reset_head(struct object_id *oid, const char *action,
+static int reset_head(struct repository *r, struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
-		      const char *reflog_orig_head, const char *reflog_head)
+		      const char *reflog_orig_head, const char *reflog_head,
+		      const char *default_reflog_action)
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
@@ -791,7 +794,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
-	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -810,26 +813,26 @@ static int reset_head(struct object_id *oid, const char *action,
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = the_repository->index;
-	unpack_tree_opts.dst_index = the_repository->index;
+	unpack_tree_opts.src_index = r->index;
+	unpack_tree_opts.dst_index = r->index;
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
 
-	if (repo_read_index_unmerged(the_repository) < 0) {
+	if (repo_read_index_unmerged(r) < 0) {
 		ret = error(_("could not read index"));
 		goto leave_reset_head;
 	}
 
-	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++], &head_oid)) {
+	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
 			    oid_to_hex(&head_oid));
 		goto leave_reset_head;
 	}
 
-	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
+	if (!fill_tree_descriptor(r, &desc[nr++], oid)) {
 		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
 		goto leave_reset_head;
 	}
@@ -840,16 +843,16 @@ static int reset_head(struct object_id *oid, const char *action,
 	}
 
 	tree = parse_tree_indirect(oid);
-	prime_cache_tree(the_repository, the_repository->index, tree);
+	prime_cache_tree(r, r->index, tree);
 
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
+	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));
 		goto leave_reset_head;
 	}
 
 reset_head_refs:
 	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
@@ -911,8 +914,10 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(NULL, "", opts->head_name, RESET_HEAD_REFS_ONLY,
-			 orig_head_reflog.buf, head_reflog.buf);
+	ret = reset_head(the_repository, NULL, "", opts->head_name,
+			 RESET_HEAD_REFS_ONLY,
+			 orig_head_reflog.buf, head_reflog.buf,
+			 DEFAULT_REFLOG_ACTION);
 
 	strbuf_release(&orig_head_reflog);
 	strbuf_release(&head_reflog);
@@ -1000,8 +1005,9 @@ static int run_am(struct rebase_options *opts)
 		free(rebased_patches);
 		argv_array_clear(&am.args);
 
-		reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
-			   "HEAD", NULL);
+		reset_head(the_repository, &opts->orig_head, "checkout",
+			   opts->head_name, 0,
+			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -1656,8 +1662,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
-			       NULL, NULL) < 0)
+		if (reset_head(the_repository, NULL, "reset", NULL, RESET_HEAD_HARD,
+			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1674,9 +1680,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(&options.orig_head, "reset",
+		if (reset_head(the_repository, &options.orig_head, "reset",
 			       options.head_name, RESET_HEAD_HARD,
-			       NULL, NULL) < 0)
+			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository, 0);
@@ -2068,8 +2074,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				    options.state_dir);
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(NULL, "reset --hard",
-				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
+			if (reset_head(the_repository, NULL, "reset --hard",
+				       NULL, RESET_HEAD_HARD, NULL, NULL,
+				       DEFAULT_REFLOG_ACTION) < 0)
 				die(_("could not reset --hard"));
 
 			if (discard_index(the_repository->index) < 0 ||
@@ -2109,10 +2116,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				strbuf_addf(&buf, "%s: checkout %s",
 					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 					    options.switch_to);
-				if (reset_head(&options.orig_head, "checkout",
+				if (reset_head(the_repository,
+					       &options.orig_head, "checkout",
 					       options.head_name,
 					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-					       NULL, buf.buf) < 0) {
+					       NULL, buf.buf,
+					       DEFAULT_REFLOG_ACTION) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
 						      options.switch_to);
@@ -2184,10 +2193,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(&options.onto->object.oid, "checkout", NULL,
+	if (reset_head(the_repository, &options.onto->object.oid, "checkout", NULL,
 		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, msg.buf))
+		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
@@ -2202,8 +2211,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(NULL, "Fast-forwarded", options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
+		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
+			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
+			   DEFAULT_REFLOG_ACTION);
 		strbuf_release(&msg);
 		ret = !!finish_rebase(&options);
 		goto cleanup;
-- 
2.26.0.159.g23e2136ad0

