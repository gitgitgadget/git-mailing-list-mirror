Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F0B1FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 21:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbcLWVRI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 16:17:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50055 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760052AbcLWVRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 16:17:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9618A5A81F;
        Fri, 23 Dec 2016 16:17:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Xz5Dz/Zka1VTHcpBopcvt4RmHI=; b=sjf2Jb
        RxA5mH/Lqrekxf9wLo6sD7YtG4iznwt1HP3AWqE12XdGX1w88260t3CJ3TBbODW6
        ++xjmMlQYb4clKdc1VzTUSx9NaxGh/cdqyQgdUy9IwMGdrfp4m+iIN/6GZQ6CJMu
        vRW6/SEhML/nVCsCOjYcZHkcFv4mhhISGKUOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Le2KvP+Hswae1QSKLvm1yLV/7pJN9QV3
        Dgyogeio3OtFWAmuqpKmy1IaxlComG6tvCycLJw/eEwW9RKO3TTQ3VzBpJYEm8ir
        PMdhHq15qKzpVurwLCFs3P64mz8lkT1RrX2Z1qc7kIqDoVglve6V7PCMluOrFsrR
        EUAE+wsYBZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DDDE5A81D;
        Fri, 23 Dec 2016 16:17:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E613E5A81C;
        Fri, 23 Dec 2016 16:17:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
        <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
        <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
        <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
        <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
        <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
        <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Dec 2016 13:17:03 -0800
In-Reply-To: <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 23 Dec 2016 09:45:09 -0800")
Message-ID: <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27443F6C-C955-11E6-80F4-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I guess both you and Michael are in favor of just removing compaction
> variant without any renames, so let me prepare a reroll and queue
> that instead.  We can flip the default perhaps one release later.

-- >8 --
Subject: [PATCH] diff: retire "compaction" heuristics

When a patch inserts a block of lines, whose last lines are the
same as the existing lines that appear before the inserted block,
"git diff" can choose any place between these existing lines as the
boundary between the pre-context and the added lines (adjusting the
end of the inserted block as appropriate) to come up with variants
of the same patch, and some variants are easier to read than others.

We have been trying to improve the choice of this boundary, and Git
2.11 shipped with an experimental "compaction-heuristic".  Since
then another attempt to improve the logic further resulted in a new
"indent-heuristic" logic.  It is agreed that the latter gives better
result overall, and the former outlived its usefulness.

Retire "compaction", and keep "indent" as an experimental feature.
The latter hopefully will be turned on by default in a future
release, but that should be done as a separate step.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt            |  6 ++----
 Documentation/diff-heuristic-options.txt |  2 --
 builtin/blame.c                          |  5 ++---
 diff.c                                   | 23 +++-------------------
 git-add--interactive.perl                |  3 ---
 xdiff/xdiff.h                            |  3 +--
 xdiff/xdiffi.c                           | 33 --------------------------------
 7 files changed, 8 insertions(+), 67 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 58f4bd6afa..d8570f2a75 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -172,10 +172,8 @@ diff.tool::
 include::mergetools-diff.txt[]
 
 diff.indentHeuristic::
-diff.compactionHeuristic::
-	Set one of these options to `true` to enable one of two
-	experimental heuristics that shift diff hunk boundaries to
-	make patches easier to read.
+	Set this option to `true` to enable experimental heuristics
+	that shift diff hunk boundaries to make patches easier to read.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
index 36cb549df9..d4f3d95505 100644
--- a/Documentation/diff-heuristic-options.txt
+++ b/Documentation/diff-heuristic-options.txt
@@ -1,7 +1,5 @@
 --indent-heuristic::
 --no-indent-heuristic::
---compaction-heuristic::
---no-compaction-heuristic::
 	These are to help debugging and tuning experimental heuristics
 	(which are off by default) that shift diff hunk boundaries to
 	make patches easier to read.
diff --git a/builtin/blame.c b/builtin/blame.c
index 4ddfadb71f..ab54a5c1f4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2596,8 +2596,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * and are only included here to get included in the "-h"
 		 * output:
 		 */
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
+		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
@@ -2645,7 +2644,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 parse_done:
 	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
-	xdl_opts |= revs.diffopt.xdl_opts & (XDF_COMPACTION_HEURISTIC | XDF_INDENT_HEURISTIC);
+	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
diff --git a/diff.c b/diff.c
index 8981477c43..741ce8c68d 100644
--- a/diff.c
+++ b/diff.c
@@ -28,7 +28,6 @@
 
 static int diff_detect_rename_default;
 static int diff_indent_heuristic; /* experimental */
-static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -223,16 +222,8 @@ void init_diff_ui_defaults(void)
 
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.indentheuristic")) {
+	if (!strcmp(var, "diff.indentheuristic"))
 		diff_indent_heuristic = git_config_bool(var, value);
-		if (diff_indent_heuristic)
-			diff_compaction_heuristic = 0;
-	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
-		diff_compaction_heuristic = git_config_bool(var, value);
-		if (diff_compaction_heuristic)
-			diff_indent_heuristic = 0;
-	}
 	return 0;
 }
 
@@ -3380,8 +3371,6 @@ void diff_setup(struct diff_options *options)
 	options->xdl_opts |= diff_algorithm;
 	if (diff_indent_heuristic)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-	else if (diff_compaction_heuristic)
-		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3876,16 +3865,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic")) {
+	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
-	} else if (!strcmp(arg, "--no-indent-heuristic"))
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--compaction-heuristic")) {
-		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
+	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	} else if (!strcmp(arg, "--no-compaction-heuristic"))
-		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ee3d812695..5a55d80b9d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -46,7 +46,6 @@
 
 my $diff_algorithm = $repo->config('diff.algorithm');
 my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
-my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
 my $use_readkey = 0;
@@ -753,8 +752,6 @@ sub parse_diff {
 	}
 	if ($diff_indent_heuristic) {
 		splice @diff_cmd, 1, 0, "--indent-heuristic";
-	} elsif ($diff_compaction_heuristic) {
-		splice @diff_cmd, 1, 0, "--compaction-heuristic";
 	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, get_diff_reference($patch_mode_revision);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 8db16d4ae6..b090ad8eac 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,8 +41,7 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
-#define XDF_COMPACTION_HEURISTIC (1 << 8)
-#define XDF_INDENT_HEURISTIC (1 << 9)
+#define XDF_INDENT_HEURISTIC (1 << 8)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 760fbb6db7..93a65680a1 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,11 +400,6 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int is_blank_line(xrecord_t *rec, long flags)
-{
-	return xdl_blankline(rec->ptr, rec->size, flags);
-}
-
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 {
 	return (rec1->ha == rec2->ha &&
@@ -821,7 +816,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	struct xdlgroup g, go;
 	long earliest_end, end_matching_other;
 	long groupsize;
-	unsigned int blank_lines;
 
 	group_init(xdf, &g);
 	group_init(xdfo, &go);
@@ -846,13 +840,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			end_matching_other = -1;
 
-			/*
-			 * Boolean value that records whether there are any blank
-			 * lines that could be made to be the last line of this
-			 * group.
-			 */
-			blank_lines = 0;
-
 			/* Shift the group backward as much as possible: */
 			while (!group_slide_up(xdf, &g, flags))
 				if (group_previous(xdfo, &go))
@@ -869,11 +856,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 			/* Now shift the group forward as far as possible: */
 			while (1) {
-				if (!blank_lines)
-					blank_lines = is_blank_line(
-							xdf->recs[g.end - 1],
-							flags);
-
 				if (group_slide_down(xdf, &g, flags))
 					break;
 				if (group_next(xdfo, &go))
@@ -906,21 +888,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_previous(xdfo, &go))
 					xdl_bug("group sync broken sliding to match");
 			}
-		} else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
-			/*
-			 * Compaction heuristic: if it is possible to shift the
-			 * group to make its bottom line a blank line, do so.
-			 *
-			 * As we already shifted the group forward as far as
-			 * possible in the earlier loop, we only need to handle
-			 * backward shifts, not forward ones.
-			 */
-			while (!is_blank_line(xdf->recs[g.end - 1], flags)) {
-				if (group_slide_up(xdf, &g, flags))
-					xdl_bug("blank line disappeared");
-				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding to blank line");
-			}
 		} else if (flags & XDF_INDENT_HEURISTIC) {
 			/*
 			 * Indent heuristic: a group of pure add/delete lines
-- 
2.11.0-448-g09546ed716

