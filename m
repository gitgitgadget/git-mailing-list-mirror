Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CEF2022A
	for <e@80x24.org>; Tue,  1 Nov 2016 21:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbcKAVGT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:06:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50371 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754616AbcKAVGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:06:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58C9249F2B;
        Tue,  1 Nov 2016 17:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f/EGcz8CcmV4yygyLeQ1ANl3Gc8=; b=Ea5ZV7
        0SVZa0/AfktnWZ0zwUZVJG0a44XhIq/PS0+fKHotvxQHKZBsOKz36ui9Ht+X8hEe
        MJMaVklV9sBhmAMzkLDx5nxU/ws7TxOekQLrI4USNiCqvzshidfS9Ih6Y39c1JQY
        HhLw9oFLcMF6zpq30g8oP9fvnJdjdrUoNoodk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ONJ98sjjSyt2/+ueaQRwoHuytwRhSb56
        5tb5XbmwvtVDja3UKOwjU4lb56YSE590K3y7DE0e3+T2Ft1Zv95uyRdf2iiGitBO
        1nQwJ9wJnC+HAQzWTYNZ7+rsiv98FaWV1yOW0j4LvcFHm8YE42fe/5N5iqoP4mVI
        /CHay68aR4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F49E49F2A;
        Tue,  1 Nov 2016 17:05:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8284149F29;
        Tue,  1 Nov 2016 17:05:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
        <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
        <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
        <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
Date:   Tue, 01 Nov 2016 14:05:57 -0700
In-Reply-To: <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 1 Nov 2016 16:59:16 -0400")
Message-ID: <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC9D760E-A076-11E6-9FE8-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We've already released a version with --compaction-heuristic, so we are
> stuck keeping it forever either way.

While I do not necessarily agree with this conclusion (we've already
released it labelled as experimental; can't we freely take it
away?), that may be of lessor impact.  I like it better.

If it involves renaming and swapping, however, we may be talking
about a change that we cannot deliver with confidence in less than a
week before -rc1, which sounds, eh, suboptimal.

FWIW, here is how the removal of compaction without renaming looks
like.

 Documentation/diff-heuristic-options.txt |  2 --
 builtin/blame.c                          |  3 +--
 diff.c                                   | 23 +++--------------------
 git-add--interactive.perl                |  3 ---
 xdiff/xdiff.h                            |  3 +--
 xdiff/xdiffi.c                           | 15 ---------------
 6 files changed, 5 insertions(+), 44 deletions(-)

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
index 4ddfadb71f..f45416a6c3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2597,7 +2597,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * output:
 		 */
 		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 
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
index 760fbb6db7..f9be87fdfb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -906,21 +906,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
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
