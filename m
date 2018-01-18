Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712671FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeARPfl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:35:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:51920 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbeARPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:35:38 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgoiC-1eP33q33ku-00M1Fe; Thu, 18
 Jan 2018 16:35:30 +0100
Date:   Thu, 18 Jan 2018 16:35:30 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 2/8] sequencer: introduce the `merge` command
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
Message-ID: <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1UgI5QFcw+je+Ozbpzd0qpJP6fuVJz0ag/qr1zFpWyBhkotFEPW
 PtjrAkHq9keYxMtY8JGli+cPw6Ufhc2J4PaQ6bX9U6VFj/Sz4nVz3iICixsPfRdBivXqx2G
 l6VJSRK+qo4yvXHgA8scYodZs1eJkxp3GQn2Ba9nz6H6qO+DVReB2C50zxvc9ncbhANNnmO
 pkvRuNcSY7H7d3ghqpOLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y4YX54KO8e4=:sA72ClUo1aRH7eH9pnW1rf
 rAC2Ciwd0Mfye+VO+OABvshiY4GKAROUqETuIJIUplxiIgiqdeChdaamvo+oc6UV3avlL0qSk
 4HA8tZolO8e5LWQs+yARumfrP2dH2zwT2/vyFoV9lRhmS2D0EQ3PAsLhPGh9POy+JpDSXYxLn
 Ufn2zOTxiHfLxaxpdSM80lnBCSE1SB1iYsQxklLx1oITKLqeAbP6axPAcHPUCu56OB9Zwhh7S
 lZtugwnUD2d/ZkvWPTtILYFk4CdspquPcqTiSSNNdoTc7TVRYp01RgT8p26wm0g6BB0mpHcAO
 bKQeHOIA6kjFCYCxlefAHGqhZSYb2P1a8qKpuT5bstIH9VaQCXIAnIiSI7Ty3+K7lsHPZEPUI
 UmurwSuUEgPVcz6qSoPDSEdZ5n6RsFz7HFBwXyLEA+lbsVUaBACDvNv7is193sYAlXqMTIU9I
 tdehbIybMLuaV6Q7GAeOeFBqiQy7bG3COcRKipviNdz+YHuYreWnb4Q2/r8HDdxZBJWbefEyh
 fRk+5JBh1xHsBjWgwUQ0xunm7T0ncZsO7lHNA8nVE0kIpty59RXeWpi7Q/e9SiOrEHO5LZYXj
 HMVZOAVDKVbihUc+u8OkUSZ8dW8ZPR8cg0TFqldgvYBuVHQXQr03GN5wFaf3HIXdwrYMuoZ9t
 kRcTF/JX8DIZds+sUC4KN5mT8Gmr2fEPCOOSTWTjebsCHPgkwfTowHi6CK6Ymq36xrWEGJKvF
 /FkkU9NnxPSnfVabRGBOtJFz12KnlZrc8lg+pXJXxxAHruW5aD7h50uSoBqRgo0ujhNIEKw3j
 t1TvJqQ8udLSL1/6+TyrkICvxjax4UMcdsThjnxW3KpauMdJPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is part of the effort to reimplement `--preserve-merges` with
a substantially improved design, a design that has been developed in the
Git for Windows project to maintain the dozens of Windows-specific patch
series on top of upstream Git.

The previous patch implemented the `label`, `bud` and `reset` commands
to label commits and to reset to a labeled commits. This patch adds the
`merge` command, with the following syntax:

	merge <commit> <rev> <oneline>

The <commit> parameter in this instance is the *original* merge commit,
whose author and message will be used for the to-be-created merge
commit.

The <rev> parameter refers to the (possibly rewritten) revision to
merge. Let's see an example of a todo list:

	label onto

	# Branch abc
	bud
	pick deadbeef Hello, world!
	label abc

	bud
	pick cafecafe And now for something completely different
	merge baaabaaa abc Merge the branch 'abc' into master

To support creating *new* merges, i.e. without copying the commit
message from an existing commit, use the special value `-` as <commit>
parameter (in which case the text after the <rev> parameter is used as
commit message):

	merge - abc This will be the actual commit message of the merge

This comes in handy when splitting a branch into two or more branches.

Note: this patch only adds support for recursive merges, to keep things
simple. Support for octopus merges will be added later in this patch
series, support for merges using strategies other than the recursive
merge is left for future contributions.

The design of the `merge` command as introduced by this patch only
supports creating new merge commits with exactly two parents, i.e. it
adds no support for octopus merges.

We will introduce support for octopus merges in a later commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   1 +
 sequencer.c                | 146 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3d2cd19d65a..5bf1ea3781f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -165,6 +165,7 @@ d, drop = remove commit
 l, label = label current HEAD with a name
 t, reset = reset HEAD to a label
 b, bud = reset HEAD to the revision labeled 'onto'
+m, merge = create a merge commit using a given commit's message
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index 91cc55a002f..567cfcbbe8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -779,6 +779,7 @@ enum todo_command {
 	TODO_LABEL,
 	TODO_RESET,
 	TODO_BUD,
+	TODO_MERGE,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -800,6 +801,7 @@ static struct {
 	{ 'l', "label" },
 	{ 't', "reset" },
 	{ 'b', "bud" },
+	{ 'm', "merge" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1304,14 +1306,20 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	}
 
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	saved = *end_of_object_name;
+	if (item->command == TODO_MERGE && *bol == '-' &&
+	    bol + 1 == end_of_object_name) {
+		item->commit = NULL;
+		return 0;
+	}
+
 	*end_of_object_name = '\0';
 	status = get_oid(bol, &commit_oid);
 	*end_of_object_name = saved;
 
-	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
-	item->arg_len = (int)(eol - item->arg);
-
 	if (status < 0)
 		return -1;
 
@@ -2069,6 +2077,132 @@ static int do_reset(const char *name, int len)
 	return ret;
 }
 
+static int do_merge(struct commit *commit, const char *arg, int arg_len,
+		    struct replay_opts *opts)
+{
+	int merge_arg_len;
+	struct strbuf ref_name = STRBUF_INIT;
+	struct commit *head_commit, *merge_commit, *i;
+	struct commit_list *common, *j, *reversed = NULL;
+	struct merge_options o;
+	int ret;
+	static struct lock_file lock;
+
+	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
+		if (isspace(arg[merge_arg_len]))
+			break;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	if (commit) {
+		const char *message = get_commit_buffer(commit, NULL);
+		const char *body;
+		int len;
+
+		if (!message) {
+			rollback_lock_file(&lock);
+			return error(_("could not get commit message of '%s'"),
+				     oid_to_hex(&commit->object.oid));
+		}
+		write_author_script(message);
+		find_commit_subject(message, &body);
+		len = strlen(body);
+		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
+			error_errno(_("Could not write '%s'"),
+				    git_path_merge_msg());
+			unuse_commit_buffer(commit, message);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+		unuse_commit_buffer(commit, message);
+	} else {
+		const char *p = arg + merge_arg_len;
+		struct strbuf buf = STRBUF_INIT;
+		int len;
+
+		strbuf_addf(&buf, "author %s", git_author_info(0));
+		write_author_script(buf.buf);
+		strbuf_reset(&buf);
+
+		p += strspn(p, " \t");
+		if (*p)
+			len = strlen(p);
+		else {
+			strbuf_addf(&buf, "Merge branch '%.*s'",
+				    merge_arg_len, arg);
+			p = buf.buf;
+			len = buf.len;
+		}
+
+		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
+			error_errno(_("Could not write '%s'"),
+				    git_path_merge_msg());
+			strbuf_release(&buf);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+		strbuf_release(&buf);
+	}
+
+	head_commit = lookup_commit_reference_by_name("HEAD");
+	if (!head_commit) {
+		rollback_lock_file(&lock);
+		return error(_("Cannot merge without a current revision"));
+	}
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
+	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
+	if (!merge_commit) {
+		/* fall back to non-rewritten ref or commit */
+		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
+		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
+	}
+	if (!merge_commit) {
+		error(_("could not resolve '%s'"), ref_name.buf);
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
+		      git_path_merge_head(), 0);
+	write_message("no-ff", 5, git_path_merge_mode(), 0);
+
+	common = get_merge_bases(head_commit, merge_commit);
+	for (j = common; j; j = j->next)
+		commit_list_insert(j->item, &reversed);
+	free_commit_list(common);
+
+	read_cache();
+	init_merge_options(&o);
+	o.branch1 = "HEAD";
+	o.branch2 = ref_name.buf;
+	o.buffer_output = 2;
+
+	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
+	if (ret <= 0)
+		fputs(o.obuf.buf, stdout);
+	strbuf_release(&o.obuf);
+	if (ret < 0) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return error(_("conflicts while merging '%.*s'"),
+			     merge_arg_len, arg);
+	}
+
+	if (active_cache_changed &&
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
+		strbuf_release(&ref_name);
+		return error(_("merge: Unable to write new index file"));
+	}
+	rollback_lock_file(&lock);
+
+	ret = run_git_commit(git_path_merge_msg(), opts, 0);
+	strbuf_release(&ref_name);
+
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2258,6 +2392,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_reset(item->arg, item->arg_len);
 		else if (item->command == TODO_BUD)
 			res = do_reset("onto", 4);
+		else if (item->command == TODO_MERGE)
+			res = do_merge(item->commit,
+				       item->arg, item->arg_len, opts);
 		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
@@ -2757,7 +2894,8 @@ int transform_todos(unsigned flags)
 					  oid_to_hex(&item->commit->object.oid);
 
 			strbuf_addf(&buf, " %s", oid);
-		}
+		} else if (item->command == TODO_MERGE)
+			strbuf_addstr(&buf, " -");
 		/* add all the rest */
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9


