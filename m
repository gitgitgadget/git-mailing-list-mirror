Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D1D20357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbdGNOpO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754494AbdGNOpM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnTjW-1e8v1m13VO-00hhAl; Fri, 14
 Jul 2017 16:45:00 +0200
Date:   Fri, 14 Jul 2017 16:44:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 02/10] rebase -i: generate the script via rebase--helper
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <814284075336e715dd52859e69aeb41226624af7.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/Ea+G91CM5BmMwhCKcTGFby1zuRyrFdSTHrZqT7Vl1Gfm4ALhdg
 FSpIQtKdVJu/Ms8+7UOz5ECUnhpXdjzKthg8OZA+zU5nK/bsU6Q5TXiIleo74xf4MRwESGQ
 SP6vJkAAjgPFhyq1FJ1m05+MuYF6Xlq2Gacw0LIyTEOmD7ZN/6y1hxSNDXv09LCYnf9/uhM
 TS8m3Wd2uOxptvQ5V2b1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1P6y5VR+BaE=:pt/hQRN3gpP9Oa90YtQJF1
 3wWaoJNh4t0VCEl53/l9H/2fXk7KuT/vpHs/UYOzBBzCs1VrfzAdM48uyJBpYEnY2CVCSVlYB
 GDAS6tRHWxLyvZafjHVP/rpypNdxfHrzhSBW4Yitueo7J+AnwVOZWRk/R9lVgVHe4yJB8WUuo
 UpZ+DJQcYPcxUicaotZQ2foO6bP1ytxCDkxHVAtOBopp8XGRglEcxnicpik8Zq0BqKRqtMsMM
 h2zR5D7t3sD8YEmap+VR+kfPibcz/IpnH2CG09qFaHwtPcHmnCwSoDNH0Vf5afHwV3t510zo9
 p6/p0CJPhmFYe4GuBdc3lbxw2Ted9sc5G+eFZxWu6gV23O+Pey0n3pyQN/DY7VX0zXjG7CfSh
 p5FkCG9bIVSk1xKMHYhCyUM/hYjXJm1EXxI1rFzXBSXqIkp8NwHp/68tipsC8Zsb3ekd2+PiI
 nv38TxtE34/VlRuytG71WeJwYDuc+KDG3TQdR5MlE7YPt3t52Sd/8IqgYQ2CZkOFfX0eHyJUZ
 wcGqojPVtAIUAFfzjW7pd7iWoiE4IBcZgEHJN+oA0hqsU+a+BI5s8gKY8Ki/S5wuLLLq6aZng
 kzPUb7h6TlBYmdfuXCyXYLsMq7Cn4muH9VImZa/d2g7n4y1A1L8sRtq9MdfezY498cBTdDRPh
 0AOC3N7jwpthjKygJMgXfRMKjlxKMM5L+UH1dLrftoRgvQUDGR3IJ4/70CQYDIM5jw77GvU68
 213ZpPUai+pp/RtudnGomIJMerskH8HINPghaecjZRKDIC+0RC/4O1hoYehyU08fczdMfSuXN
 YqOjOuAY3NgtMZ/AHJ2jGq/50IC3qM9LaTHIPQ0NBycisBaK2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first step of an interactive rebase is to generate the so-called "todo
script", to be stored in the state directory as "git-rebase-todo" and to
be edited by the user.

Originally, we adjusted the output of `git log <options>` using a simple
sed script. Over the course of the years, the code became more
complicated. We now use shell scripting to edit the output of `git log`
conditionally, depending whether to keep "empty" commits (i.e. commits
that do not change any files).

On platforms where shell scripting is not native, this can be a serious
drag. And it opens the door for incompatibilities between platforms when
it comes to shell scripting or to Unix-y commands.

Let's just re-implement the todo script generation in plain C, using the
revision machinery directly.

This is substantially faster, improving the speed relative to the
shell script version of the interactive rebase from 2x to 3x on Windows.

Note that the rearrange_squash() function in git-rebase--interactive
relied on the fact that we set the "format" variable to the config setting
rebase.instructionFormat. Relying on a side effect like this is no good,
hence we explicitly perform that assignment (possibly again) in
rearrange_squash().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   |  8 +++++++-
 git-rebase--interactive.sh | 44 +++++++++++++++++++++--------------------
 sequencer.c                | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index c82b4dce683..613053276e6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,15 +12,19 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT
+		CONTINUE = 1, ABORT, MAKE_SCRIPT
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
+		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
 				ABORT),
+		OPT_CMDMODE(0, "make-script", &command,
+			N_("make rebase script"), MAKE_SCRIPT),
 		OPT_END()
 	};
 
@@ -37,5 +41,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
+	if (command == MAKE_SCRIPT && argc > 1)
+		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 90b1fbe9cf6..05766835de1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -785,6 +785,7 @@ collapse_todo_ids() {
 # each log message will be re-retrieved in order to normalize the
 # autosquash arrangement
 rearrange_squash () {
+	format=$(git config --get rebase.instructionFormat)
 	# extract fixup!/squash! lines and resolve any referenced sha1's
 	while read -r pick sha1 message
 	do
@@ -1210,26 +1211,27 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-format=$(git config --get rebase.instructionFormat)
-# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-git rev-list $merges_option --format="%m%H ${format:-%s}" \
-	--reverse --left-right --topo-order \
-	$revisions ${restrict_revision+^$restrict_revision} | \
-	sed -n "s/^>//p" |
-while read -r sha1 rest
-do
-
-	if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-	then
-		comment_out="$comment_char "
-	else
-		comment_out=
-	fi
+if test t != "$preserve_merges"
+then
+	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		$revisions ${restrict_revision+^$restrict_revision} >"$todo"
+else
+	format=$(git config --get rebase.instructionFormat)
+	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+	git rev-list $merges_option --format="%m%H ${format:-%s}" \
+		--reverse --left-right --topo-order \
+		$revisions ${restrict_revision+^$restrict_revision} | \
+		sed -n "s/^>//p" |
+	while read -r sha1 rest
+	do
+
+		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+		then
+			comment_out="$comment_char "
+		else
+			comment_out=
+		fi
 
-	if test t != "$preserve_merges"
-	then
-		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-	else
 		if test -z "$rebase_root"
 		then
 			preserve=t
@@ -1248,8 +1250,8 @@ do
 			touch "$rewritten"/$sha1
 			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
 		fi
-	fi
-done
+	done
+fi
 
 # Watch for commits that been dropped by --cherry-pick
 if test t = "$preserve_merges"
diff --git a/sequencer.c b/sequencer.c
index 3010faf8639..afcb3d00a32 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2413,3 +2413,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 
 	strbuf_release(&sob);
 }
+
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv)
+{
+	char *format = NULL;
+	struct pretty_print_context pp = {0};
+	struct strbuf buf = STRBUF_INIT;
+	struct rev_info revs;
+	struct commit *commit;
+
+	init_revisions(&revs, NULL);
+	revs.verbose_header = 1;
+	revs.max_parents = 1;
+	revs.cherry_pick = 1;
+	revs.limited = 1;
+	revs.reverse = 1;
+	revs.right_only = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+
+	revs.pretty_given = 1;
+	git_config_get_string("rebase.instructionFormat", &format);
+	if (!format || !*format) {
+		free(format);
+		format = xstrdup("%s");
+	}
+	get_commit_format(format, &revs);
+	free(format);
+	pp.fmt = revs.commit_format;
+	pp.output_encoding = get_log_output_encoding();
+
+	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+		return error(_("make_script: unhandled options"));
+
+	if (prepare_revision_walk(&revs) < 0)
+		return error(_("make_script: error preparing revisions"));
+
+	while ((commit = get_revision(&revs))) {
+		strbuf_reset(&buf);
+		if (!keep_empty && is_original_commit_empty(commit))
+			strbuf_addf(&buf, "%c ", comment_line_char);
+		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
+		pretty_print_commit(&pp, commit, &buf);
+		strbuf_addch(&buf, '\n');
+		fputs(buf.buf, out);
+	}
+	strbuf_release(&buf);
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index f885b68395f..83f2943b7a9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
+int sequencer_make_script(int keep_empty, FILE *out,
+		int argc, const char **argv);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.13.3.windows.1.13.gaf0c2223da0


