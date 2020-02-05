Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D0CC3524B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66821582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HphgJTbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgBEA2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:28:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36715 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEA2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:28:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so49737pgc.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKNtiRcCwhuOg7OE830HiKLLljVb5qRm/PycaZzY5uQ=;
        b=HphgJTbRy6NZ7mu1NWDKKUQxpHCiFTkW7LrpURSUJ7Fs9vzvOILjShw9Plp08dfden
         Evb+iXbtW0HcsqT87ETlL5r93szkPSGoNBZngAiorOkqcie9UlzKANcVD5yk5BomZEAf
         d1bhlG0qncVZssB3NeFQ8ek7jWLLlVxu6pj5ijwx+/2cCR9RQnsQKZQy2f4NaOVKaFuh
         T+wPUPFUJgmtMmP+7hqr/BCQTlxLw+dRMz1OVAEZ0KBfarwBd5+Ec8EBsb55VUu/mbIT
         OuDM0PGPkwJkbaXCE8FXC2HW8LVF+6tOGY/PhR1VUBHBLiK+XV5QNHkGGeEpB+k1fbLm
         YIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKNtiRcCwhuOg7OE830HiKLLljVb5qRm/PycaZzY5uQ=;
        b=W1i4gMAybrW+7PnQUvJ6wLmr/IwVp/JZTPxK7XOjuhQ61X7F2MTpo2EM0GPI0mAzV+
         i0TFWDRKVgaZMxIj2j5s1ATeTvRbjGIcrnGl8ET0agCpdq2Af7vuCC+gZP/1to36xLbG
         lmFJvVwMPNBOiWPrlNfg3RYTfAYLhc4GGHXpMxOhi0p9GxaSNvmYM/j9ovOyIqOpugAO
         OmnkJaTxjste6uS7uoH2qOJPV4ACd2+JaffVe4X9DIK3umi41aLd2GGhRmlvuoLVgiT1
         u83v3IA6WqWrboaQ/vfyDxS8jLdwv7u8ICmvRPYeJA+XPD0pfmWnCUrF4O3+HUWgpfIM
         IBPw==
X-Gm-Message-State: APjAAAUn37W7QkuUBlMPQf3+NXW4TdoNOURKjR5US8ND1a6uYc7PZLmZ
        TMjEuti5FeGrHi99dkO0nztY3ezVfVj06g==
X-Google-Smtp-Source: APXvYqzyj/vza9EEkoi3hb8gCzjMMA+RsmydWISSE+NTsPa32t26XncfIMqIvGgK+hbLyRdpxGA1+Q==
X-Received: by 2002:aa7:968c:: with SMTP id f12mr33714677pfk.235.1580862511964;
        Tue, 04 Feb 2020 16:28:31 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id c26sm7318179pfj.8.2020.02.04.16.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:28:31 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:28:29 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <cover.1580862307.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is an updated 'v2' of my series to introduce new splitting and
merging options to the 'commit-graph write' builtin.

These patches are updated to be based on the latest changes in the
series upon which this is based (tb/commit-graph-use-odb), and contain
some other fixes that I picked up during the last round of review. For
convenience, I included a range-diff against 'v1' below.

Thanks as always for your review.

Taylor

Taylor Blau (3):
  builtin/commit-graph.c: support '--split[=<strategy>]'
  builtin/commit-graph.c: introduce '--input=<source>'
  builtin/commit-graph.c: support '--input=none'

 Documentation/git-commit-graph.txt |  50 ++++++++-----
 builtin/commit-graph.c             | 115 +++++++++++++++++++++++------
 commit-graph.c                     |  28 ++++---
 commit-graph.h                     |  10 ++-
 t/t5318-commit-graph.sh            |   4 +-
 t/t5324-split-commit-graph.sh      |  53 ++++++++++++-
 6 files changed, 204 insertions(+), 56 deletions(-)

Range-diff against v1:
1:  470bbe3cef ! 1:  3e19d50148 builtin/commit-graph.c: support '--split[=<strategy>]'
    @@ Commit message
         With '--split', the commit-graph machinery writes new commits in another
         incremental commit-graph which is part of the existing chain, and
         optionally decides to condense the chain into a single commit-graph.
    -    This is done to ensure that the aysmptotic behavior of looking up a
    +    This is done to ensure that the asymptotic behavior of looking up a
         commit in an incremental chain is dominated by the number of
         incrementals in that chain. It can be controlled by the '--max-commits'
         and '--size-multiple' options.
    @@ Documentation/git-commit-graph.txt: or `--stdin-packs`.)
     +conducted, and the remaining options are ignored. Conversely, if
     +`--split=no-merge` is specified, a merge is never performed, and the
     +remaining options are ignored. A bare `--split` defers to the remaining
    -+options. (Note that merging a chain of commit graphs replaces the
    -+existing chain with a length-1 chain where the first and only
    -+incremental holds the entire graph).
    ++options.
      +
      * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
      tip file would have `N` commits and the previous tip has `M` commits and
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
     +	enum commit_graph_split_flags *flags = opt->value;
     +
     +	opts.split = 1;
    -+	if (!arg)
    ++	if (!arg) {
    ++		*flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
     +		return 0;
    ++	}
     +
     +	if (!strcmp(arg, "merge-all"))
     +		*flags = COMMIT_GRAPH_SPLIT_MERGE_REQUIRED;
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)

      ## commit-graph.c ##
     @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
    +
    + 	int max_commits = 0;
    + 	int size_mult = 2;
    ++	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
    +
    + 	if (ctx->split_opts) {
    + 		max_commits = ctx->split_opts->max_commits;
    +
    + 		if (ctx->split_opts->size_multiple)
    + 			size_mult = ctx->split_opts->size_multiple;
    ++
    ++		flags = ctx->split_opts->flags;
    + 	}
    +
    + 	g = ctx->r->objects->commit_graph;
      	num_commits = ctx->commits.nr;
      	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;

    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
     -		    (max_commits && num_commits > max_commits))) {
     -		if (g->odb != ctx->odb)
     -			break;
    -+	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
    ++	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
     +		while (g && (g->num_commits <= size_mult * num_commits ||
     +			    (max_commits && num_commits > max_commits) ||
    -+			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
    ++			    (flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
     +			if (g->odb != ctx->odb)
     +				break;

    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      	}

     -	if (!ctx->commits.nr)
    -+	if (!ctx->commits.nr && (!ctx->split || ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))
    ++	if (!ctx->commits.nr && (!ctx->split_opts || ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))
      		goto cleanup;

      	if (ctx->split) {
    @@ commit-graph.h: enum commit_graph_write_flags {
      };

     +enum commit_graph_split_flags {
    -+	COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
    ++	COMMIT_GRAPH_SPLIT_MERGE_AUTO       = 0,
     +	COMMIT_GRAPH_SPLIT_MERGE_REQUIRED   = 1,
     +	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 2
     +};
2:  1b585fe4e7 ! 2:  1589bc1d69 builtin/commit-graph.c: introduce '--input=<source>'
    @@ Documentation/git-commit-graph.txt: $ git commit-graph write

      ## builtin/commit-graph.c ##
     @@
    +
      static char const * const builtin_commit_graph_usage[] = {
      	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
    - 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
    +-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
     -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
    -+	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
    ++	N_("git commit-graph write [--object-dir <objdir>] "
    ++	   "[--split[=<strategy>]] "
    ++	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
      	   "[--[no-]progress] <split options>"),
      	NULL
      };
     @@ builtin/commit-graph.c: static const char * const builtin_commit_graph_verify_usage[] = {
    + };

      static const char * const builtin_commit_graph_write_usage[] = {
    - 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
    +-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
     -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
    -+	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
    ++	N_("git commit-graph write [--object-dir <objdir>] "
    ++	   "[--split[=<strategy>]] "
    ++	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
      	   "[--[no-]progress] <split options>"),
      	NULL
      };
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      		}

      ## t/t5318-commit-graph.sh ##
    -@@ t/t5318-commit-graph.sh: test_expect_success 'write graph with no packs' '
    - 	test_path_is_missing $objdir/info/commit-graph
    - '
    -
    --test_expect_success 'exit with correct error on bad input to --stdin-packs' '
    -+test_expect_success 'exit with correct error on bad input to --input=stdin-packs' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    - 	echo doesnotexist >in &&
    --	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
    -+	test_expect_code 1 git commit-graph write --input=stdin-packs <in 2>stderr &&
    - 	test_i18ngrep "error adding pack" stderr
    - '
    -
    -@@ t/t5318-commit-graph.sh: test_expect_success 'create commits and repack' '
    - 	git repack
    - '
    -
    --test_expect_success 'exit with correct error on bad input to --stdin-commits' '
    -+test_expect_success 'exit with correct error on bad input to --input=stdin-commits' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    --	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
    -+	echo HEAD | test_expect_code 1 git commit-graph write --input=stdin-commits 2>stderr &&
    - 	test_i18ngrep "invalid commit object id" stderr &&
    - 	# valid tree OID, but not a commit OID
    --	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
    -+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --input=stdin-commits 2>stderr &&
    - 	test_i18ngrep "invalid commit object id" stderr
    - '
    -
     @@ t/t5318-commit-graph.sh: graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2

      test_expect_success 'build graph from latest pack with closure' '
    @@ t/t5318-commit-graph.sh: test_expect_success 'build graph from commits with clos
      	test_path_is_file $objdir/info/commit-graph &&
      	graph_read_expect "6"
      '
    -@@ t/t5318-commit-graph.sh: graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merg
    -
    - test_expect_success 'build graph from commits with append' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    --	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
    -+	git rev-parse merge/3 | git commit-graph write --input=stdin-commits --input=append &&
    - 	test_path_is_file $objdir/info/commit-graph &&
    - 	graph_read_expect "10" "extra_edges"
    - '
    -@@ t/t5318-commit-graph.sh: graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
    -
    - test_expect_success 'build graph using --reachable' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    --	git commit-graph write --reachable &&
    -+	git commit-graph write --input=reachable &&
    - 	test_path_is_file $objdir/info/commit-graph &&
    - 	graph_read_expect "11" "extra_edges"
    - '
    -@@ t/t5318-commit-graph.sh: test_expect_success 'perform fast-forward merge in full repo' '
    - test_expect_success 'check that gc computes commit-graph' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    - 	git commit --allow-empty -m "blank" &&
    --	git commit-graph write --reachable &&
    -+	git commit-graph write --input=reachable &&
    - 	cp $objdir/info/commit-graph commit-graph-before-gc &&
    - 	git reset --hard HEAD~1 &&
    - 	git config gc.writeCommitGraph true &&
    - 	git gc &&
    - 	cp $objdir/info/commit-graph commit-graph-after-gc &&
    - 	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
    --	git commit-graph write --reachable &&
    -+	git commit-graph write --input=reachable &&
    - 	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
    - '
    -
    -@@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit-graph' '
    - 	git clone full replace &&
    - 	(
    - 		cd replace &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_file .git/objects/info/commit-graph &&
    - 		git replace HEAD~1 HEAD~2 &&
    - 		git -c core.commitGraph=false log >expect &&
    - 		git -c core.commitGraph=true log >actual &&
    - 		test_cmp expect actual &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		git -c core.commitGraph=false --no-replace-objects log >expect &&
    - 		git -c core.commitGraph=true --no-replace-objects log >actual &&
    - 		test_cmp expect actual &&
    - 		rm -rf .git/objects/info/commit-graph &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_file .git/objects/info/commit-graph
    - 	)
    - '
    -@@ t/t5318-commit-graph.sh: test_expect_success 'commit grafts invalidate commit-graph' '
    - 	git clone full graft &&
    - 	(
    - 		cd graft &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_file .git/objects/info/commit-graph &&
    - 		H1=$(git rev-parse --verify HEAD~1) &&
    - 		H3=$(git rev-parse --verify HEAD~3) &&
    -@@ t/t5318-commit-graph.sh: test_expect_success 'commit grafts invalidate commit-graph' '
    - 		git -c core.commitGraph=false log >expect &&
    - 		git -c core.commitGraph=true log >actual &&
    - 		test_cmp expect actual &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		git -c core.commitGraph=false --no-replace-objects log >expect &&
    - 		git -c core.commitGraph=true --no-replace-objects log >actual &&
    - 		test_cmp expect actual &&
    - 		rm -rf .git/objects/info/commit-graph &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_missing .git/objects/info/commit-graph
    - 	)
    - '
    -@@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit-graph' '
    - 	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&
    - 	(
    - 		cd shallow &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_missing .git/objects/info/commit-graph &&
    - 		git fetch origin --unshallow &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_file .git/objects/info/commit-graph
    - 	)
    - '
    -@@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit-graph' '
    -
    - test_expect_success 'git commit-graph verify' '
    - 	cd "$TRASH_DIRECTORY/full" &&
    --	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
    -+	git rev-parse commits/8 | git commit-graph write --input=stdin-commits &&
    - 	git commit-graph verify >output
    - '
    -
    -@@ t/t5318-commit-graph.sh: test_expect_success 'setup non-the_repository tests' '
    - 	test_commit -C repo two &&
    - 	git -C repo config core.commitGraph true &&
    - 	git -C repo rev-parse two | \
    --		git -C repo commit-graph write --stdin-commits
    -+		git -C repo commit-graph write --input=stdin-commits
    - '
    -
    - test_expect_success 'parse_commit_in_graph works for non-the_repository' '
    -@@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (broken parent)' '
    - 		EOF
    - 		broken="$(git hash-object -w -t commit --literally broken)" &&
    - 		git commit-tree -p "$broken" -m "good commit" "$empty" >good &&
    --		test_must_fail git commit-graph write --stdin-commits \
    -+		test_must_fail git commit-graph write --input=stdin-commits \
    - 			<good 2>test_err &&
    - 		test_i18ngrep "unable to parse commit" test_err
    - 	)
    -@@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missing tree)' '
    - 		EOF
    - 		broken="$(git hash-object -w -t commit --literally broken)" &&
    - 		git commit-tree -p "$broken" -m "good" "$tree" >good &&
    --		test_must_fail git commit-graph write --stdin-commits \
    -+		test_must_fail git commit-graph write --input=stdin-commits \
    - 			<good 2>test_err &&
    - 		test_i18ngrep "unable to parse commit" test_err
    - 	)

      ## t/t5324-split-commit-graph.sh ##
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'create commits and write commit-graph' '
    @@ t/t5324-split-commit-graph.sh: test_expect_success 'create commits and write com
      	test_path_is_file $infodir/commit-graph &&
      	graph_read_expect 3
      '
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'add more commits, and write a new base graph' '
    - 	git reset --hard commits/4 &&
    - 	git merge commits/6 &&
    - 	git branch merge/2 &&
    --	git commit-graph write --reachable &&
    -+	git commit-graph write --input=reachable &&
    - 	graph_read_expect 12
    - '
    -
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'fork and fail to base a chain on a commit-graph file' '
    - 		rm .git/objects/info/commit-graph &&
    - 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
    - 		test_commit new-commit &&
    --		git commit-graph write --reachable --split &&
    -+		git commit-graph write --input=reachable --split &&
    - 		test_path_is_file $graphdir/commit-graph-chain &&
    - 		test_line_count = 1 $graphdir/commit-graph-chain &&
    - 		verify_chain_files_exist $graphdir
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'add three more commits, write a tip graph' '
    - 	git merge commits/5 &&
    - 	git merge merge/2 &&
    - 	git branch merge/3 &&
    --	git commit-graph write --reachable --split &&
    -+	git commit-graph write --input=reachable --split &&
    - 	test_path_is_missing $infodir/commit-graph &&
    - 	test_path_is_file $graphdir/commit-graph-chain &&
    - 	ls $graphdir/graph-*.graph >graph-files &&
    -@@ t/t5324-split-commit-graph.sh: graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
    - test_expect_success 'add one commit, write a tip graph' '
    - 	test_commit 11 &&
    - 	git branch commits/11 &&
    --	git commit-graph write --reachable --split &&
    -+	git commit-graph write --input=reachable --split &&
    - 	test_path_is_missing $infodir/commit-graph &&
    - 	test_path_is_file $graphdir/commit-graph-chain &&
    - 	ls $graphdir/graph-*.graph >graph-files &&
    -@@ t/t5324-split-commit-graph.sh: graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits
    - test_expect_success 'add one commit, write a merged graph' '
    - 	test_commit 12 &&
    - 	git branch commits/12 &&
    --	git commit-graph write --reachable --split &&
    -+	git commit-graph write --input=reachable --split &&
    - 	test_path_is_file $graphdir/commit-graph-chain &&
    - 	test_line_count = 2 $graphdir/commit-graph-chain &&
    - 	ls $graphdir/graph-*.graph >graph-files &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'create fork and chain across alternate' '
    - 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
    - 		test_commit 13 &&
    - 		git branch commits/13 &&
    --		git commit-graph write --reachable --split &&
    -+		git commit-graph write --input=reachable --split &&
    - 		test_path_is_file $graphdir/commit-graph-chain &&
    - 		test_line_count = 3 $graphdir/commit-graph-chain &&
    - 		ls $graphdir/graph-*.graph >graph-files &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'create fork and chain across alternate' '
    - 		git -c core.commitGraph=false rev-list HEAD >actual &&
    - 		test_cmp expect actual &&
    - 		test_commit 14 &&
    --		git commit-graph write --reachable --split --object-dir=.git/objects/ &&
    -+		git commit-graph write --input=reachable --split --object-dir=.git/objects/ &&
    - 		test_line_count = 3 $graphdir/commit-graph-chain &&
    - 		ls $graphdir/graph-*.graph >graph-files &&
    - 		test_line_count = 1 graph-files
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'test merge stragety constants' '
    - 		git config core.commitGraph true &&
    - 		test_line_count = 2 $graphdir/commit-graph-chain &&
    - 		test_commit 14 &&
    --		git commit-graph write --reachable --split --size-multiple=2 &&
    -+		git commit-graph write --input=reachable --split --size-multiple=2 &&
    - 		test_line_count = 3 $graphdir/commit-graph-chain
    -
    - 	) &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'test merge stragety constants' '
    - 		git config core.commitGraph true &&
    - 		test_line_count = 2 $graphdir/commit-graph-chain &&
    - 		test_commit 14 &&
    --		git commit-graph write --reachable --split --size-multiple=10 &&
    -+		git commit-graph write --input=reachable --split --size-multiple=10 &&
    - 		test_line_count = 1 $graphdir/commit-graph-chain &&
    - 		ls $graphdir/graph-*.graph >graph-files &&
    - 		test_line_count = 1 graph-files
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'test merge stragety constants' '
    - 		git config core.commitGraph true &&
    - 		test_line_count = 2 $graphdir/commit-graph-chain &&
    - 		test_commit 15 &&
    --		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
    -+		git commit-graph write --input=reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
    - 		test_line_count = 1 $graphdir/commit-graph-chain &&
    - 		ls $graphdir/graph-*.graph >graph-files &&
    - 		test_line_count = 3 graph-files
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'test merge stragety constants' '
    - 		test_line_count = 2 $graphdir/commit-graph-chain &&
    - 		test_commit 16 &&
    - 		test_commit 17 &&
    --		git commit-graph write --reachable --split --max-commits=1 &&
    -+		git commit-graph write --input=reachable --split --max-commits=1 &&
    - 		test_line_count = 1 $graphdir/commit-graph-chain &&
    - 		ls $graphdir/graph-*.graph >graph-files &&
    - 		test_line_count = 1 graph-files
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'remove commit-graph-chain file after flattening' '
    - 	(
    - 		cd flatten &&
    - 		test_line_count = 2 $graphdir/commit-graph-chain &&
    --		git commit-graph write --reachable &&
    -+		git commit-graph write --input=reachable &&
    - 		test_path_is_missing $graphdir/commit-graph-chain &&
    - 		ls $graphdir >graph-files &&
    - 		test_line_count = 0 graph-files
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify across alternates' '
    - 		echo "$altdir" >.git/objects/info/alternates &&
    - 		git commit-graph verify --object-dir="$altdir/" &&
    - 		test_commit extra &&
    --		git commit-graph write --reachable --split &&
    -+		git commit-graph write --input=reachable --split &&
    - 		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
    - 		corrupt_file "$tip_file" 100 "\01" &&
    - 		test_must_fail git commit-graph verify --shallow 2>test_err &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'add octopus merge' '
    - 	git reset --hard commits/10 &&
    - 	git merge commits/3 commits/4 &&
    - 	git branch merge/octopus &&
    --	git commit-graph write --reachable --split &&
    -+	git commit-graph write --input=reachable --split &&
    - 	git commit-graph verify --progress 2>err &&
    - 	test_line_count = 3 err &&
    - 	test_i18ngrep ! warning err &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'add octopus merge' '
    - graph_git_behavior 'graph exists' merge/octopus commits/12
    -
    - test_expect_success 'split across alternate where alternate is not split' '
    --	git commit-graph write --reachable &&
    -+	git commit-graph write --input=reachable &&
    - 	test_path_is_file .git/objects/info/commit-graph &&
    - 	cp .git/objects/info/commit-graph . &&
    - 	git clone --no-hardlinks . alt-split &&
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'split across alternate where alternate is not split' '
    - 		rm -f .git/objects/info/commit-graph &&
    - 		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
    - 		test_commit 18 &&
    --		git commit-graph write --reachable --split &&
    -+		git commit-graph write --input=reachable --split &&
    - 		test_line_count = 1 $graphdir/commit-graph-chain
    - 	) &&
    - 	test_cmp commit-graph .git/objects/info/commit-graph
    -@@ t/t5324-split-commit-graph.sh: test_expect_success '--split=merge-all always merges incrementals' '
    - 	git rev-list -3 HEAD~4 >a &&
    - 	git rev-list -2 HEAD~2 >b &&
    - 	git rev-list -2 HEAD >c &&
    --	git commit-graph write --split=no-merge --stdin-commits <a &&
    --	git commit-graph write --split=no-merge --stdin-commits <b &&
    -+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
    -+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
    - 	test_line_count = 2 $graphdir/commit-graph-chain &&
    --	git commit-graph write --split=merge-all --stdin-commits <c &&
    -+	git commit-graph write --split=merge-all --input=stdin-commits <c &&
    - 	test_line_count = 1 $graphdir/commit-graph-chain
    - '
    -
    -@@ t/t5324-split-commit-graph.sh: test_expect_success '--split=no-merge always writes an incremental' '
    - 	git reset --hard commits/2 &&
    - 	git rev-list HEAD~1 >a &&
    - 	git rev-list HEAD >b &&
    --	git commit-graph write --split --stdin-commits <a &&
    --	git commit-graph write --split=no-merge --stdin-commits <b &&
    -+	git commit-graph write --split --input=stdin-commits <a &&
    -+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
    - 	test_line_count = 2 $graphdir/commit-graph-chain
    - '
    -
3:  a5d3367788 ! 3:  4c6425f0da builtin/commit-graph.c: support '--input=none'
    @@ Metadata
      ## Commit message ##
         builtin/commit-graph.c: support '--input=none'

    -    In the previous commit, we introduced '--[no-]merge', and alluded to the
    -    fact that '--merge' would be useful for callers who wish to always
    -    trigger a merge of an incremental chain.
    +    In the previous commit, we introduced '--split=<no-merge|merge-all>',
    +    and alluded to the fact that '--split=merge-all' would be useful for
    +    callers who wish to always trigger a merge of an incremental chain.

         There is a problem with the above approach, which is that there is no
         way to specify to the commit-graph builtin that a caller only wants to
    @@ Documentation/git-commit-graph.txt: COMMANDS
      'write'::

     -Write a commit-graph file based on the commits found in packfiles.
    -+Write a commit-graph file based on the commits specified:
    -+* With the `--input=stdin-packs` option, generate the new commit graph
    -+by walking objects only in the specified pack-indexes. (Cannot be
    -+combined with `--input=stdin-commits` or `--input=reachable`.)
    ++Write a commit-graph file based on the specified sources of input:
      +
    --With the `--input=stdin-packs` option, generate the new commit graph by
    --walking objects only in the specified pack-indexes. (Cannot be combined
    --with `--input=stdin-commits` or `--input=reachable`.)
    --+
    --With the `--input=stdin-commits` option, generate the new commit graph
    -+* With the `--input=stdin-commits` option, generate the new commit graph
    - by walking commits starting at the commits specified in stdin as a list
    - of OIDs in hex, one OID per line. (Cannot be combined with
    - `--input=stdin-packs` or `--input=reachable`.)
    - +
    --With the `--input=reachable` option, generate the new commit graph by
    -+* With the `--input=reachable` option, generate the new commit graph by
    - walking commits starting at all refs. (Cannot be combined with
    - `--input=stdin-commits` or `--input=stdin-packs`.)
    - +
    --With the `--input=append` option, include all commits that are present
    -+* With the `--input=append` option, include all commits that are present
    + With the `--input=stdin-packs` option, generate the new commit graph by
    + walking objects only in the specified pack-indexes. (Cannot be combined
    +@@ Documentation/git-commit-graph.txt: walking commits starting at all refs. (Cannot be combined with
    + With the `--input=append` option, include all commits that are present
      in the existing commit-graph file.
      +
    -+* With the `--input=none` option, behave as if `input=append` were
    ++With the `--input=none` option, behave as if `--input=append` were
     +given, but do not walk other packs to find additional commits.
     +
    -+If none of the above options are given, then commits found in
    -+packfiles are specified.
    ++If none of the above options are given, then generate the new
    ++commit-graph by walking over all pack-indexes.
     ++
      With the `--split[=<strategy>]` option, write the commit-graph as a
      chain of multiple commit-graph files stored in
      `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the

      ## builtin/commit-graph.c ##
    -@@
    - static char const * const builtin_commit_graph_usage[] = {
    +@@ builtin/commit-graph.c: static char const * const builtin_commit_graph_usage[] = {
      	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
    - 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
    --	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
    -+	   "[--split[=<strategy>]] "
    -+	   "[--input=<reachable|stdin-packs|stdin-commits|none>] "
    + 	N_("git commit-graph write [--object-dir <objdir>] "
    + 	   "[--split[=<strategy>]] "
    +-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
    ++	   "[--input=<reachable|stdin-packs|stdin-commits|append|none>] "
      	   "[--[no-]progress] <split options>"),
      	NULL
      };
     @@ builtin/commit-graph.c: static const char * const builtin_commit_graph_verify_usage[] = {
    -
      static const char * const builtin_commit_graph_write_usage[] = {
    - 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
    --	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
    -+	   "[--split[=<strategy>]] "
    -+	   "[--input=<reachable|stdin-packs|stdin-commits|none>] "
    + 	N_("git commit-graph write [--object-dir <objdir>] "
    + 	   "[--split[=<strategy>]] "
    +-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
    ++	   "[--input=<reachable|stdin-packs|stdin-commits|append|none>] "
      	   "[--[no-]progress] <split options>"),
      	NULL
      };
--
2.25.0.119.gaa12b7378b
