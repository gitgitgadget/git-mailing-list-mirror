Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C6C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AABC64D9F
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBPM5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBPM5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:57:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D2C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:56:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v7so12804522wrr.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iGC5nUQJfJOeBSZYYuhr7iPsrFDWhvJcCLJptlW4EbA=;
        b=G1LAaGbUxxinIvk+jo64sYz8Ms9FucjUCGNVLOoEa0G5QhUEGDPfNUj0VjiBKL2gwL
         o20N1ZDjyljDQacRoSSHzWVyzXk7GiZB+Zw5r0R0ued5bL8nCGRAqlmJ09uxB5jvpgs1
         2CDSlKr2utJ1HWZFZvIDyb58h7uYl1dBq0rR4+C5Ub1DYvf5vVFY1BWqCQiu9xPrbExV
         PA59Wl/VM84oZzPNx0T8x1I3K7pT5OorsjHRz63uZHDR8s2uUEZN/E4AkeHTrmeePxMU
         lFQzpKif5gYWUyxj+HRSGrnrIMHhyctJJqrxkJJDbphiZ4G19HEKLLACblNJl2zX0eoK
         puUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iGC5nUQJfJOeBSZYYuhr7iPsrFDWhvJcCLJptlW4EbA=;
        b=HhRjS6glWh8tEHTa3Q2FGs9KMNnLxFaVy+5aohlqmoB6B36uulpbO6HSmzgR0Tbje5
         dTWezhQJ1/cDBPbtwHs+YUXcsYuH852xUuUTdtQKX8pD+pMgBl2MsfLwE7RDiJSOt3vw
         c8qqXGGYbu/9aGuMHjfWXtuO9XkaiVXN+URxkIPuQwLgtTAwRVWHau5MAEY1k+k1uWH7
         Sx6qUiGiqHtwkx3I6MHSgDWHclFcnT8N7FnVZmek9YUGCuZ2Gn1CTgz04AXTPU1ooDoN
         iMN4pKiRf7o/xq8WFJkBewQOgC2HbAhNHcaewsEcqQVKwLxa79yYy3VKoGYiiE/nlhak
         VLIQ==
X-Gm-Message-State: AOAM532E4LB/xsADZDNmKNnPRgSI4uoTihPyyxiFjrJ6egViHybldp8o
        NMh/9y+dmxjtnc6wjPhktTjpAGcUA/A=
X-Google-Smtp-Source: ABdhPJyaPEBe4HSDjsWUuT61/9V1QQcKJJGSEsMGcvepRNN7emiImpspSBRbVJfyRIeKweZhgZOX5A==
X-Received: by 2002:adf:df81:: with SMTP id z1mr23250439wrl.259.1613480199934;
        Tue, 16 Feb 2021 04:56:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm28623835wru.53.2021.02.16.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 04:56:39 -0800 (PST)
Message-Id: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Feb 2021 12:56:35 +0000
Subject: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git user may should travel the diff list to choice file diff to view, if
they exit in midway,they must travel it again. By starting from the
specified file method, provides a possibility for this user-friendly
solution.

this patch's origin discuss is here:
https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com/

Thanks!

Junio C Hamano (1):
  diff: --{rotate,skip}-to=<path>

ZheNing Hu (1):
  difftool.c: learn a new way start at specified file

 Documentation/diff-options.txt |  8 ++++
 Documentation/git-difftool.txt | 10 +++++
 Documentation/gitdiffcore.txt  | 21 ++++++++++
 Makefile                       |  1 +
 builtin/diff-files.c           |  1 +
 builtin/diff-index.c           |  2 +
 builtin/diff-tree.c            |  3 ++
 builtin/diff.c                 |  1 +
 diff.c                         | 21 ++++++++++
 diff.h                         | 21 ++++++++++
 diffcore-rotate.c              | 46 ++++++++++++++++++++++
 diffcore.h                     |  1 +
 t/t4056-diff-order.sh          | 72 +++++++++++++++++++++++++++++++++-
 t/t7800-difftool.sh            | 30 ++++++++++++++
 14 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 diffcore-rotate.c


base-commit: c6102b758572c7515f606b2423dfe38934fe6764
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/870

Range-diff vs v4:

 1:  3accfb942301 ! 1:  fb4bfd0f8b16 difftool.c: learn a new way start at specified file
     @@
       ## Metadata ##
     -Author: ZheNing Hu <adlternative@gmail.com>
     +Author: Junio C Hamano <gitster@pobox.com>
      
       ## Commit message ##
     -    difftool.c: learn a new way start at specified file
     -
     -    `git difftool` only allow us to select file to view in turn.
     -    If there is a commit with many files and we exit in the search,
     -    We will have to traverse list again to get the file diff which
     -    we want to see. Therefore, here is a new method: user can use
     -    `git difftool --start-from=<filename>` to start viewing from
     -    the specified file, This will improve the user experience.
     -
     -    `difftool --start-from=<file>` will pass the file name to
     -    `diffcore-rotate`, it will traverse all files in diff_queue,
     -    if it finds a matching file, it will rearrange the order of
     -    diff_filepair of diff_queue, Rotate the file specified by the
     -    user to the first one. If the file name specified by the user
     -    does not match any item in the diff queue, Git will also rotate
     -    the queue, it will find the the first file name larger than the
     -    specified file name as the first element of the new diff_queue.
     -    This will help users find their mistakes.
     -
     -    Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     -
     - ## Documentation/git-difftool.txt ##
     -@@ Documentation/git-difftool.txt: OPTIONS
     - 	This is the default behaviour; the option is provided to
     - 	override any configuration settings.
     - 
     -+--start-from=<file>::
     -+	Start viewing diff from the specified file.
     -+
     - -t <tool>::
     - --tool=<tool>::
     - 	Use the diff tool specified by <tool>.  Valid values include
     +    diff: --{rotate,skip}-to=<path>
     +
     +    In the implementation of "git difftool", there is a case where the
     +    user wants to start viewing the diffs at a specific path and
     +    continue on to the rest, optionally wrapping around to the
     +    beginning.  Since it is somewhat cumbersome to implement such a
     +    feature as a post-processing step of "git diff" output, let's
     +    support it internally with two new options.
     +
     +     - "git diff --rotate-to=C", when the resulting patch would show
     +       paths A B C D E without the option, would "rotate" the paths to
     +       shows patch to C D E A B instead.  It is an error when there is
     +       no patch for C is shown.
     +
     +     - "git diff --skip-to=C" would instead "skip" the paths before C,
     +       and shows patch to C D E.  Again, it is an error when there is no
     +       patch for C is shown.
     +
     +     - "git log [-p]" also accepts these two options, but it is not an
     +       error if there is no change to the specified path.  Instead, the
     +       set of output paths are rotated or skipped to the specified path
     +       or the first path that sorts after the specified path.
     +
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +
     + ## Documentation/diff-options.txt ##
     +@@ Documentation/diff-options.txt: matches a pattern if removing any number of the final pathname
     + components matches the pattern.  For example, the pattern "`foo*bar`"
     + matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
     + 
     ++--skip-to=<file>::
     ++--rotate-to=<file::
     ++	Discard the files before the named <file> from the output
     ++	(i.e. 'skip to'), or move them to the end of the output
     ++	(i.e. 'rotate to').  These were invented primarily for use
     ++	of the `git difftool` command, and may not be very useful
     ++	otherwise.
     ++
     + ifndef::git-format-patch[]
     + -R::
     + 	Swap two inputs; that is, show differences from index or
     +
     + ## Documentation/gitdiffcore.txt ##
     +@@ Documentation/gitdiffcore.txt: into another list.  There are currently 5 such transformations:
     + - diffcore-merge-broken
     + - diffcore-pickaxe
     + - diffcore-order
     ++- diffcore-rotate
     + 
     + These are applied in sequence.  The set of filepairs 'git diff-{asterisk}'
     + commands find are used as the input to diffcore-break, and
     +@@ Documentation/gitdiffcore.txt: Documentation
     + t
     + ------------------------------------------------
     + 
     ++diffcore-rotate: For Changing At Which Path Output Starts
     ++---------------------------------------------------------
     ++
     ++This transformation takes one pathname, and rotates the set of
     ++filepairs so that the filepair for the given pathname comes first,
     ++optionally discarding the paths that come before it.  This is used
     ++to implement the `--skip-to` and the `--rotate-to` options.  It is
     ++an error when the specified pathname is not in the set of filepairs,
     ++but it is not useful to error out when used with "git log" family of
     ++commands, because it is unreasonable to expect that a given path
     ++would be modified by each and every commit shown by the "git log"
     ++command.  For this reason, when used with "git log", the filepair
     ++that sorts the same as, or the first one that sorts after, the given
     ++pathname is where the output starts.
     ++
     ++Use of this transformation combined with diffcore-order will produce
     ++unexpected results, as the input to this transformation is likely
     ++not sorted when diffcore-order is in effect.
     ++
     ++
     + SEE ALSO
     + --------
     + linkgit:git-diff[1],
      
       ## Makefile ##
      @@ Makefile: LIB_OBJS += diffcore-delta.o
     @@ Makefile: LIB_OBJS += diffcore-delta.o
       LIB_OBJS += dir.o
       LIB_OBJS += editor.o
      
     + ## builtin/diff-files.c ##
     +@@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char *prefix)
     + 	}
     + 	if (!rev.diffopt.output_format)
     + 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
     ++	rev.diffopt.rotate_to_strict = 1;
     + 
     + 	/*
     + 	 * Make sure there are NO revision (i.e. pending object) parameter,
     +
     + ## builtin/diff-index.c ##
     +@@ builtin/diff-index.c: int cmd_diff_index(int argc, const char **argv, const char *prefix)
     + 	if (!rev.diffopt.output_format)
     + 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
     + 
     ++	rev.diffopt.rotate_to_strict = 1;
     ++
     + 	/*
     + 	 * Make sure there is one revision (i.e. pending object),
     + 	 * and there is no revision filtering parameters.
     +
     + ## builtin/diff-tree.c ##
     +@@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *prefix)
     + 	if (merge_base && opt->pending.nr != 2)
     + 		die(_("--merge-base only works with two commits"));
     + 
     ++	opt->diffopt.rotate_to_strict = 1;
     ++
     + 	/*
     + 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
     + 	 * perfectly valid for revision range parser to yield "b ^a",
     +@@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *prefix)
     + 		int saved_nrl = 0;
     + 		int saved_dcctc = 0;
     + 
     ++		opt->diffopt.rotate_to_strict = 0;
     + 		if (opt->diffopt.detect_rename) {
     + 			if (!the_index.cache)
     + 				repo_read_index(the_repository);
     +
     + ## builtin/diff.c ##
     +@@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
     + 	}
     + 
     + 	rev.diffopt.flags.recursive = 1;
     ++	rev.diffopt.rotate_to_strict = 1;
     + 
     + 	setup_diff_pager(&rev.diffopt);
     + 
     +
       ## diff.c ##
     +@@ diff.c: static int diff_opt_word_diff_regex(const struct option *opt,
     + 	return 0;
     + }
     + 
     ++static int diff_opt_rotate_to(const struct option *opt, const char *arg, int unset)
     ++{
     ++	struct diff_options *options = opt->value;
     ++
     ++	BUG_ON_OPT_NEG(unset);
     ++	if (!strcmp(opt->long_name, "skip-to"))
     ++		options->skip_instead_of_rotate = 1;
     ++	else
     ++		options->skip_instead_of_rotate = 0;
     ++	options->rotate_to = arg;
     ++	return 0;
     ++}
     ++
     + static void prep_parse_options(struct diff_options *options)
     + {
     + 	struct option parseopts[] = {
      @@ diff.c: static void prep_parse_options(struct diff_options *options)
       			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
       		OPT_FILENAME('O', NULL, &options->orderfile,
       			     N_("control the order in which files appear in the output")),
     -+		OPT_STRING(0, "rotate-to", &options->rotate_to, N_("<path>"),
     -+			   N_("show the change in the specified path first")),
     -+		OPT_STRING(0, "start-from", &options->rotate_to, N_("<path>"),
     -+			   N_("pass from difftool to diff, has the same effort as `rotate-to`")),
     ++		OPT_CALLBACK_F(0, "rotate-to", options, N_("<path>"),
     ++			       N_("show the change in the specified path first"),
     ++			       PARSE_OPT_NONEG, diff_opt_rotate_to),
     ++		OPT_CALLBACK_F(0, "skip-to", options, N_("<path>"),
     ++			       N_("skip the output to the specified path"),
     ++			       PARSE_OPT_NONEG, diff_opt_rotate_to),
       		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
       			       N_("look for differences that change the number of occurrences of the specified object"),
       			       PARSE_OPT_NONEG, diff_opt_find_object),
     @@ diff.c: void diffcore_std(struct diff_options *options)
       	if (options->orderfile)
       		diffcore_order(options->orderfile);
      +	if (options->rotate_to)
     -+		diffcore_rotate(options->rotate_to);
     ++		diffcore_rotate(options);
       	if (!options->found_follow)
       		/* See try_to_follow_renames() in tree-diff.c */
       		diff_resolve_rename_copy();
      
       ## diff.h ##
      @@ diff.h: enum diff_submodule_format {
     -  */
       struct diff_options {
       	const char *orderfile;
     -+	const char *rotate_to;
       
     ++	/*
     ++	 * "--rotate-to=<file>" would start showing at <file> and when
     ++	 * the output reaches the end, wrap around by default.
     ++	 * Setting skip_instead_of_rotate to true stops the output at the
     ++	 * end, effectively discarding the earlier part of the output
     ++	 * before <file>'s diff (this is used to implement the
     ++	 * "--skip-to=<file>" option).
     ++	 *
     ++	 * When rotate_to_strict is set, it is an error if there is no
     ++	 * <file> in the diff.  Otherwise, the output starts at the
     ++	 * path that is the same as, or first path that sorts after,
     ++	 * <file>.  Because it is unreasonable to require the exact
     ++	 * match for "git log -p --rotate-to=<file>" (i.e. not all
     ++	 * commit would touch that single <file>), "git log" sets it
     ++	 * to false.  "git diff" sets it to true to detect an error
     ++	 * in the command line option.
     ++	 */
     ++	const char *rotate_to;
     ++	int skip_instead_of_rotate;
     ++	int rotate_to_strict;
     ++
       	/**
       	 * A constant string (can and typically does contain newlines to look for
     + 	 * a block of text, not just a single line) to filter out the filepairs
      
       ## diffcore-rotate.c (new) ##
      @@
     @@ diffcore-rotate.c (new)
      +#include "diff.h"
      +#include "diffcore.h"
      +
     -+void diffcore_rotate(const char *rotate_to_filename)
     ++void diffcore_rotate(struct diff_options *opt)
      +{
      +	struct diff_queue_struct *q = &diff_queued_diff;
      +	struct diff_queue_struct outq;
     @@ diffcore-rotate.c (new)
      +	if (!q->nr)
      +		return;
      +
     -+	for (i = 0; i < q->nr; i++)
     -+		if (strcmp(rotate_to_filename, q->queue[i]->two->path) <= 0)
     -+			break;
     -+	/* we did not find the specified path */
     -+	if (q->nr <= i)
     ++	for (i = 0; i < q->nr; i++) {
     ++		int cmp = strcmp(opt->rotate_to, q->queue[i]->two->path);
     ++		if (!cmp)
     ++			break; /* exact match */
     ++		if (!opt->rotate_to_strict && cmp < 0)
     ++			break; /* q->queue[i] is now past the target pathname */
     ++	}
     ++
     ++	if (q->nr <= i) {
     ++		/* we did not find the specified path */
     ++		if (opt->rotate_to_strict)
     ++			die(_("No such path '%s' in the diff"), opt->rotate_to);
      +		return;
     ++	}
      +
      +	DIFF_QUEUE_CLEAR(&outq);
      +	rotate_to = i;
      +
      +	for (i = rotate_to; i < q->nr; i++)
      +		diff_q(&outq, q->queue[i]);
     -+	for (i = 0; i < rotate_to; i++)
     -+		diff_q(&outq, q->queue[i]);
     -+
     ++	for (i = 0; i < rotate_to; i++) {
     ++		if (opt->skip_instead_of_rotate)
     ++			diff_free_filepair(q->queue[i]);
     ++		else
     ++			diff_q(&outq, q->queue[i]);
     ++	}
      +	free(q->queue);
      +	*q = outq;
      +}
     @@ diffcore.h: void diffcore_rename(struct diff_options *);
       void diffcore_merge_broken(void);
       void diffcore_pickaxe(struct diff_options *);
       void diffcore_order(const char *orderfile);
     -+void diffcore_rotate(const char *rotate_to_filename);
     ++void diffcore_rotate(struct diff_options *);
       
       /* low-level interface to diffcore_order */
       struct obj_order {
      
     - ## t/t7800-difftool.sh ##
     -@@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
     - 	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
     - '
     - 
     -+test_expect_success 'difftool --start-from' '
     -+	difftool_test_setup &&
     -+	test_when_finished git reset --hard &&
     -+	echo 1 >1 &&
     -+	echo 2 >2 &&
     -+	echo 4 >4 &&
     -+	git add 1 2 4 &&
     -+	git commit -a -m "124" &&
     -+	git difftool --no-prompt --extcmd=cat --start-from="2" HEAD^  >output &&
     + ## t/t4056-diff-order.sh ##
     +@@
     + #!/bin/sh
     + 
     +-test_description='diff order'
     ++test_description='diff order & rotate'
     + 
     + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +@@ t/t4056-diff-order.sh: do
     + 	'
     + done
     + 
     ++### rotate and skip
     ++
     ++test_expect_success 'rotate and skip setup' '
     ++	>sample1.t &&
     ++	>sample2.t &&
     ++	>sample3.t &&
     ++	>sample4.t &&
     ++	git add sample[1234].t &&
     ++	git commit -m "added" sample[1234].t &&
     ++	echo modified >>sample1.t &&
     ++	echo modified >>sample2.t &&
     ++	echo modified >>sample4.t &&
     ++	git commit -m "updated" sample[1234].t
     ++'
     ++
     ++test_expect_success 'diff --rotate-to' '
     ++	git diff --rotate-to=sample2.t --name-only HEAD^ >actual &&
     ++	test_write_lines sample2.t sample4.t sample1.t >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'diff --skip-to' '
     ++	git diff --skip-to=sample2.t --name-only HEAD^ >actual &&
     ++	test_write_lines sample2.t sample4.t >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'diff --rotate/skip-to error condition' '
     ++	test_must_fail git diff --rotate-to=sample3.t HEAD^ &&
     ++	test_must_fail git diff --skip-to=sample3.t HEAD^
     ++'
     ++
     ++test_expect_success 'log --rotate-to' '
     ++	git log --rotate-to=sample3.t --raw HEAD~2.. >raw &&
     ++	# just distill the commit header and paths
     ++	sed -n -e "s/^commit.*/commit/p" \
     ++	       -e "/^:/s/^.*	//p" raw >actual &&
     ++
      +	cat >expect <<-\EOF &&
     -+	2
     -+	4
     -+	1
     ++	commit
     ++	sample4.t
     ++	sample1.t
     ++	sample2.t
     ++	commit
     ++	sample3.t
     ++	sample4.t
     ++	sample1.t
     ++	sample2.t
      +	EOF
     -+	test_cmp output expect &&
     -+	git difftool --no-prompt --extcmd=cat --start-from="3" HEAD^  >output &&
     ++
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'log --skip-to' '
     ++	git log --skip-to=sample3.t --raw HEAD~2.. >raw &&
     ++	# just distill the commit header and paths
     ++	sed -n -e "s/^commit.*/commit/p" \
     ++	       -e "/^:/s/^.*	//p" raw >actual &&
     ++
      +	cat >expect <<-\EOF &&
     -+	4
     -+	1
     -+	2
     ++	commit
     ++	sample4.t
     ++	commit
     ++	sample3.t
     ++	sample4.t
      +	EOF
     -+	test_cmp output expect
     ++
     ++	test_cmp expect actual
      +'
     ++
       test_done
 -:  ------------ > 2:  98e2707ee2fa difftool.c: learn a new way start at specified file

-- 
gitgitgadget
