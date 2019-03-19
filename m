Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059A620248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCSTD7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:03:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45715 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSTD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:03:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so27830wra.12
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Er5e6FusaGd1w83UJSHBRvaHOVh/8y4EJKYSOvT3/qE=;
        b=EgR8+5NAYqxLlQTJDa/jpPWdOBfDsp3fzno3MWC0t6SuiPXPpUe/JECrgP3nHDZ6ov
         +r9XUv3RRW+RHDa/uEGSXTNaiktZUTLSdzpCjsSXiy7SLvmhgFkznWDuC9LWKlLIVsl/
         xA6KvgcOZJ59ipHoR31E1rpAAaR9z0R4hiJFur/bpnTWI3hxz2mtBj5N0AshDM2BGx0B
         ozl3lJKV0h/2OBrLBd3ccrRxwaxzZtt3m79ywpTexBK5dR2slES723aQFsW+CDrbhkYH
         wPY8iAx30sTY+XjRh38ESVPPtPbqN+eALic+AARw+lDczcx2d7cMm7/pkjVxqUkRUfUx
         uujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Er5e6FusaGd1w83UJSHBRvaHOVh/8y4EJKYSOvT3/qE=;
        b=tWSdZh+G9AcVqXmJeBH4HoqLyszWPpdP7XtdjZL0VVHGB2/EREP+3Li3Q3gliIAbfM
         o3QXVYtUzPz7pbuutUq/U0GXaOOgNHdskvFHWk+XzBEsZ0b0RWliTyfpEZjD65BeusTu
         GPF+/2WSBaTVYco8KZnpXPMYNgwafwROLE2SbbWAXABhM3l7/fQB+Gca0lbskTyyI83U
         DXfkCZs0kxZrD7Z4MeauqC5w8ZU5I+iMkL/DAdmzUrN0m0MqKxtWUyO1hu13xpxzCsWq
         qFnxj4pS5ZalMB34yrsXnLGgl4JUTPYDQr0WJCe6YJprrbhiym/SauYz0Qy+PsXamjwm
         GMzw==
X-Gm-Message-State: APjAAAUHdmNg2QyniThGrOHapqn6msHZPrPblYhjVY5gxBiL6oLF5Yq4
        gq8mC1GkWBA8LzbFgBN8iPJU3tfQBDQ=
X-Google-Smtp-Source: APXvYqwpS+L1a8Amv5eQphYrhWke4n6qpNm1E1iCGHZIEs5yZFMhEK5qrFNh+H9sVpNFQ8bSY19rBg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr17898583wrn.21.1553022236408;
        Tue, 19 Mar 2019 12:03:56 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:03:55 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 01/11] sequencer: always discard index after checkout
Date:   Tue, 19 Mar 2019 19:03:07 +0000
Message-Id: <20190319190317.6632-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the checkout runs in a separate process our index will be out of date
so it should be discarded. The existing callers are not doing this
consistently so do it here to avoid the callers having to worry about
it.

This fixes some test failures that happen if do_interactive_rebase() is
called without forking rebase--interactive which we will implement
shortly. Running

  git rebase -i master topic

starting on master created empty todo lists because all the commits in
topic were marked as cherry-picks. After topic was checked out in
prepare_branch_to_be_rebased() the working tree contained the contents
from topic but the index contained master and the cache entries were
still valid. This meant that diff_populate_filespec() which loads the
blobs when calculating patch-id's ended up reading the contents for
master from the working tree which actually contained topic.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    It would perhaps be better to pass around the_index rather than
    the_repository

 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 27 +++++++++++++++++----------
 sequencer.h                   |  3 ++-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 4535523bf5..d1a4ac1b84 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -171,7 +171,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 
-	if (prepare_branch_to_be_rebased(opts, switch_to))
+	if (prepare_branch_to_be_rebased(the_repository, opts, switch_to))
 		return -1;
 
 	if (get_revision_ranges(upstream, onto, &head_hash,
diff --git a/sequencer.c b/sequencer.c
index 281a8ade19..ccc0160800 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3418,10 +3418,11 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
-static int run_git_checkout(struct replay_opts *opts, const char *commit,
-			    const char *action)
+static int run_git_checkout(struct repository *r, struct replay_opts *opts,
+			    const char *commit, const char *action)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	int ret;
 
 	cmd.git_cmd = 1;
 
@@ -3430,25 +3431,31 @@ static int run_git_checkout(struct replay_opts *opts, const char *commit,
 	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
 
 	if (opts->verbose)
-		return run_command(&cmd);
+		ret = run_command(&cmd);
 	else
-		return run_command_silent_on_success(&cmd);
+		ret = run_command_silent_on_success(&cmd);
+
+	if (!ret)
+		discard_index(r->index);
+
+	return ret;
 }
 
-int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
+int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
+				 const char *commit)
 {
 	const char *action;
 
 	if (commit && *commit) {
 		action = reflog_message(opts, "start", "checkout %s", commit);
-		if (run_git_checkout(opts, commit, action))
+		if (run_git_checkout(r, opts, commit, action))
 			return error(_("could not checkout %s"), commit);
 	}
 
 	return 0;
 }
 
-static int checkout_onto(struct replay_opts *opts,
+static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const char *onto,
 			 const char *orig_head)
 {
@@ -3458,7 +3465,7 @@ static int checkout_onto(struct replay_opts *opts,
 	if (get_oid(orig_head, &oid))
 		return error(_("%s: not a valid OID"), orig_head);
 
-	if (run_git_checkout(opts, onto, action)) {
+	if (run_git_checkout(r, opts, onto, action)) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
@@ -4786,7 +4793,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
 	    todo_list_check(todo_list, &new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
-		checkout_onto(opts, onto_name, onto, orig_head);
+		checkout_onto(r, opts, onto_name, onto, orig_head);
 		todo_list_release(&new_todo);
 
 		return -1;
@@ -4805,7 +4812,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
+	if (checkout_onto(r, opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
diff --git a/sequencer.h b/sequencer.h
index a515ee4457..6c55aa4200 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -175,7 +175,8 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
-int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
+				 const char *commit);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.21.0

