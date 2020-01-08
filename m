Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFCC33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4253D206F0
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/U5jAnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAHAcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:32:39 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43539 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHAcj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 19:32:39 -0500
Received: by mail-lf1-f42.google.com with SMTP id 9so1077945lfq.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 16:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=D5cBPoJ+bkzlrwmAxsbIv53DJcaL6s4H3Ffs4mxHJJ8=;
        b=E/U5jAnOI/rNJNGnk5ZisFpmV9NJ2OK6IaXWgnz7WWigCJSsSHJ/gU4GteqjxRQ7d5
         OLER/xmhS4yAq1DaMWyxG00HvQfiotwRe7U8I/bUd06/i3fFJKPNuE0F0PCSga56wmwa
         RtJKOSGCJ8sHzpsuTmu/6EvQbQmKwfP+eyQx8JcR9zsgXehVoGdjtUK/0G62xfhTQEO/
         dso1D2/ZsY+bvkFlG+8thN4krSEqa8YRBtzphQCVXGPpoERsVP8/zCZACZJNXdWr1kHE
         R7LVlZ6gNdHggyUiYeZB28NxDHjXbE7k4hw8XoaiLJO5FNXn0FO2Vax2UHeQWMw4r5mX
         JpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=D5cBPoJ+bkzlrwmAxsbIv53DJcaL6s4H3Ffs4mxHJJ8=;
        b=A+HR5/9rSy4p07mZoOlaKuJKe5ph21oqjVXsCFdndvN9R0tO47SfjMm1Af/owGrgSx
         Lf7AapdSOoIrVm4ogz5dZ+bSmlWEz8BuOLuiNiNGp7l2F0jfgj9y96R0CRRTUzxWr4nZ
         hXwE2B3agd9V51ekO4lk+ZlXY8QPoLI+HjV2amUk5IDnGI1f1cSAf7hOHFjqbZzD/rMn
         pxVwvjc/mQPO+7mnL92/HgXrI8qq9PDTPz3AsQ1zJUTHUvERkZtK0Tac3DaqVeiKtH7o
         8IwEJ1sRLNfIon5ipJzd82hJFEv58N1Y2QyXB/0nn5T9g+SvDxZ/UL/YYpu2Sz5Ya0ol
         SkdA==
X-Gm-Message-State: APjAAAW4/a2/LxrQTaloQ0S0VSx08eOUKQMGNgD4RweViaWZAXVh1W/w
        FYHUH8xjXwX9kAkeKwlWD5g=
X-Google-Smtp-Source: APXvYqzOc48JPhrKqRCYIEkvfgAAe11xRWTUpYunZrGcX5dHpZyy8OLCw9iPyLb5mf2422Jz5ZNT7Q==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr1200984lfj.27.1578443556172;
        Tue, 07 Jan 2020 16:32:36 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id j19sm573989lfb.90.2020.01.07.16.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 16:32:35 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 6/9] commit-graph: test commit-graph write --changed-paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <85bfdfa59c48891343e3eeb740a4b3554405909a.1576879520.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 01:32:29 +0100
In-Reply-To: <85bfdfa59c48891343e3eeb740a4b3554405909a.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:17
        +0000")
Message-ID: <86r20awzxe.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Add tests for the --changed-paths feature when writing
> commit-graphs.

It doesn't look however as if this test is actually testing the _Bloom
filter_ functionality itself -- because this test looks like
copy'n'paste of t/t5324-split-commit-graph.sh, just with
`--changed-paths` added to the `git commit-graph write` invocation, and
added checking via enhanced test-tool that there are Bloom filter chunks
("bloom_indexes" and "bloom_data").

Please correct me if I am wrong, but this looks like a simple sanity
check for me.

>
> RFC Notes:
> I plan to split this test across some of the earlier commits
> as appropriate.

About adding tests to earlier commits in this series:

1. Testing Bloom filter functionality:
   - creating Bloom filter and adding elements to it
   - testing Bloom filter functionality
     - for element in set the answer is "maybe"
     - for element not in set the answer is "no" or "maybe"
   - automatic resizing works (6 and 7 elements)
   - it works for different number of hash functions,
     and different number of bits per element (maybe?)

2. Testing Bloom filter for commit changeset:
   - it works for commit with no changes
   - it works for merge commit with no changes to first parent
     (`git merge --strategy=3Dours`)
   - with number of changes that require filter size change
   - with maximal number of changes, one changed file less,
     one changed file more
   - that for file deeper in hierarchy, path/to/file, all of
     changed directories (path/to/ and path/) are also added

3. Test writing and reading commit-graph with Bloom filters
   - that after writing Bloom filters with `--changed-paths`
     the data is present in commit-graph files
   - it works correctly with split commit-graph
   - it doesn't crash if confronted with unknown settings:
     hash version different than 1, different number of hash
     functions, different number of bits per element

4. Bloom filter specific `git commit-graph verify` parts
   - fail if Bloom filter chunks appear multiple times
   - fail if only one of BIDX or BDAT chunks are present
   - fail if BIDX is not monotonic, that is if size of Bloom filter
     for a commit is negative
   - fail if BDAT size does not agree with BIDX,
     being either too small, or too large
   - check if values of number of hash functions
     and number of bits per element added are sane

5. Using Bloom filters to speed up Git operations
   - test that with and without Bloom filters (or commit-graph)
     the following operations work the same:
     - git log -- <path/to/file>
     - git log -- <path/to/directory>
     - git log -- '*.c'  # or other glob pattern
     - git log -- <file1> <file2>
     - git log --follow <file>
     - maybe also `git log --full-history -- <file>`
   - if possible, add performance tests, see `t/perf`

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  t/helper/test-read-graph.c    |   4 +
>  t/t5325-commit-graph-bloom.sh | 255 ++++++++++++++++++++++++++++++++++
>  2 files changed, 259 insertions(+)
>  create mode 100755 t/t5325-commit-graph-bloom.sh
>
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index d2884efe0a..aff597c7a3 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" commit_metadata");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
> +	if (graph->chunk_bloom_indexes)
> +		printf(" bloom_indexes");
> +	if (graph->chunk_bloom_data)
> +		printf(" bloom_data");

All right, though it is very basic information.

>  	printf("\n");
>=20=20
>  	UNLEAK(graph);
> diff --git a/t/t5325-commit-graph-bloom.sh b/t/t5325-commit-graph-bloom.sh
> new file mode 100755
> index 0000000000..d7ef0e7fb3
> --- /dev/null
> +++ b/t/t5325-commit-graph-bloom.sh
> @@ -0,0 +1,255 @@
> +#!/bin/sh
> +
> +test_description=3D'commit graph with bloom filters'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup repo' '
> +	git init &&
> +	git config core.commitGraph true &&
> +	git config gc.writeCommitGraph false &&
> +	infodir=3D".git/objects/info" &&
> +	graphdir=3D"$infodir/commit-graphs" &&
> +	test_oid_init
> +'
> +
> +graph_read_expect() {

Style: space between function name and parentheses, i.e.

  +graph_read_expect () {

> +	OPTIONAL=3D""

Not used anywhere.

> +	NUM_CHUNKS=3D5
> +	if test ! -z $2

It might be good idea to add names to those parameters by setting some
local variables to $1 and $2; or, alternatively add comment describing
this function.

> +	then
> +		OPTIONAL=3D" $2"
> +		NUM_CHUNKS=3D$((NUM_CHUNKS + $(echo "$2" | wc -w)))
> +	fi
> +	cat >expect <<- EOF
> +	header: 43475048 1 1 $NUM_CHUNKS 0
> +	num_commits: $1
> +	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
> +	EOF
> +	test-tool read-graph >output &&
> +	test_cmp expect output
> +}

No comments below this point...

Best,

  Jakub Nar=C4=99bski


> +
> +test_expect_success 'create commits and write commit-graph' '
> +	for i in $(test_seq 3)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git commit-graph write --reachable --changed-paths &&
> +	test_path_is_file $infodir/commit-graph &&
> +	graph_read_expect 3
> +'
> +
> +graph_git_two_modes() {
> +	git -c core.commitGraph=3Dtrue $1 >output
> +	git -c core.commitGraph=3Dfalse $1 >expect
> +	test_cmp expect output
> +}
> +
> +graph_git_behavior() {
> +	MSG=3D$1
> +	BRANCH=3D$2
> +	COMPARE=3D$3
> +	test_expect_success "check normal git operations: $MSG" '
> +		graph_git_two_modes "log --oneline $BRANCH" &&
> +		graph_git_two_modes "log --topo-order $BRANCH" &&
> +		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
> +		graph_git_two_modes "branch -vv" &&
> +		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
> +	'
> +}
> +
> +graph_git_behavior 'graph exists' commits/3 commits/1
> +
> +verify_chain_files_exist() {
> +	for hash in $(cat $1/commit-graph-chain)
> +	do
> +		test_path_is_file $1/graph-$hash.graph || return 1
> +	done
> +}
> +
> +test_expect_success 'add more commits, and write a new base graph' '
> +	git reset --hard commits/1 &&
> +	for i in $(test_seq 4 5)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/2 &&
> +	for i in $(test_seq 6 10)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/2 &&
> +	git merge commits/4 &&
> +	git branch merge/1 &&
> +	git reset --hard commits/4 &&
> +	git merge commits/6 &&
> +	git branch merge/2 &&
> +	git commit-graph write --reachable --changed-paths &&
> +	graph_read_expect 12
> +'
> +
> +test_expect_success 'fork and fail to base a chain on a commit-graph fil=
e' '
> +	test_when_finished rm -rf fork &&
> +	git clone . fork &&
> +	(
> +		cd fork &&
> +		rm .git/objects/info/commit-graph &&
> +		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
> +		test_commit new-commit &&
> +		git commit-graph write --reachable --split --changed-paths &&
> +		test_path_is_file $graphdir/commit-graph-chain &&
> +		test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +		verify_chain_files_exist $graphdir
> +	)
> +'
> +
> +test_expect_success 'add three more commits, write a tip graph' '
> +	git reset --hard commits/3 &&
> +	git merge merge/1 &&
> +	git merge commits/5 &&
> +	git merge merge/2 &&
> +	git branch merge/3 &&
> +	git commit-graph write --reachable --split --changed-paths &&
> +	test_path_is_missing $infodir/commit-graph &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count =3D 2 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'
> +
> +graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
> +
> +test_expect_success 'add one commit, write a tip graph' '
> +	test_commit 11 &&
> +	git branch commits/11 &&
> +	git commit-graph write --reachable --split --changed-paths &&
> +	test_path_is_missing $infodir/commit-graph &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count =3D 3 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'
> +
> +graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11=
 commits/6
> +
> +test_expect_success 'add one commit, write a merged graph' '
> +	test_commit 12 &&
> +	git branch commits/12 &&
> +	git commit-graph write --reachable --split --changed-paths &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count =3D 2 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'
> +
> +graph_git_behavior 'merged commit-graph: commit 12 vs 6' commits/12 comm=
its/6
> +
> +test_expect_success 'create fork and chain across alternate' '
> +	git clone . fork &&
> +	(
> +		cd fork &&
> +		git config core.commitGraph true &&
> +		rm -rf $graphdir &&
> +		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
> +		test_commit 13 &&
> +		git branch commits/13 &&
> +		git commit-graph write --reachable --split --changed-paths &&
> +		test_path_is_file $graphdir/commit-graph-chain &&
> +		test_line_count =3D 3 $graphdir/commit-graph-chain &&
> +		ls $graphdir/graph-*.graph >graph-files &&
> +		test_line_count =3D 1 graph-files &&
> +		git -c core.commitGraph=3Dtrue  rev-list HEAD >expect &&
> +		git -c core.commitGraph=3Dfalse rev-list HEAD >actual &&
> +		test_cmp expect actual &&
> +		test_commit 14 &&
> +		git commit-graph write --reachable --split --changed-paths --object-di=
r=3D.git/objects/ &&
> +		test_line_count =3D 3 $graphdir/commit-graph-chain &&
> +		ls $graphdir/graph-*.graph >graph-files &&
> +		test_line_count =3D 1 graph-files
> +	)
> +'
> +
> +graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
> +
> +test_expect_success 'test merge stragety constants' '
> +	git clone . merge-2 &&
> +	(
> +		cd merge-2 &&
> +		git config core.commitGraph true &&
> +		test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +		test_commit 14 &&
> +		git commit-graph write --reachable --split --changed-paths --size-mult=
iple=3D2 &&
> +		test_line_count =3D 3 $graphdir/commit-graph-chain
> +
> +	) &&
> +	git clone . merge-10 &&
> +	(
> +		cd merge-10 &&
> +		git config core.commitGraph true &&
> +		test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +		test_commit 14 &&
> +		git commit-graph write --reachable --split --changed-paths --size-mult=
iple=3D10 &&
> +		test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +		ls $graphdir/graph-*.graph >graph-files &&
> +		test_line_count =3D 1 graph-files
> +	) &&
> +	git clone . merge-10-expire &&
> +	(
> +		cd merge-10-expire &&
> +		git config core.commitGraph true &&
> +		test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +		test_commit 15 &&
> +		git commit-graph write --reachable --split --changed-paths --size-mult=
iple=3D10 --expire-time=3D1980-01-01 &&
> +		test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +		ls $graphdir/graph-*.graph >graph-files &&
> +		test_line_count =3D 3 graph-files
> +	) &&
> +	git clone --no-hardlinks . max-commits &&
> +	(
> +		cd max-commits &&
> +		git config core.commitGraph true &&
> +		test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +		test_commit 16 &&
> +		test_commit 17 &&
> +		git commit-graph write --reachable --split --changed-paths --max-commi=
ts=3D1 &&
> +		test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +		ls $graphdir/graph-*.graph >graph-files &&
> +		test_line_count =3D 1 graph-files
> +	)
> +'
> +
> +test_expect_success 'remove commit-graph-chain file after flattening' '
> +	git clone . flatten &&
> +	(
> +		cd flatten &&
> +		test_line_count =3D 2 $graphdir/commit-graph-chain &&
> +		git commit-graph write --reachable &&
> +		test_path_is_missing $graphdir/commit-graph-chain &&
> +		ls $graphdir >graph-files &&
> +		test_must_be_empty graph-files
> +	)
> +'
> +
> +graph_git_behavior 'graph exists' merge/octopus commits/12
> +
> +test_expect_success 'split across alternate where alternate is not split=
' '
> +	git commit-graph write --reachable &&
> +	test_path_is_file .git/objects/info/commit-graph &&
> +	cp .git/objects/info/commit-graph . &&
> +	git clone --no-hardlinks . alt-split &&
> +	(
> +		cd alt-split &&
> +		rm -f .git/objects/info/commit-graph &&
> +		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
> +		test_commit 18 &&
> +		git commit-graph write --reachable --split --changed-paths &&
> +		test_line_count =3D 1 $graphdir/commit-graph-chain
> +	) &&
> +	test_cmp commit-graph .git/objects/info/commit-graph
> +'
> +
> +test_done
