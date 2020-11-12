Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63774C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71F822201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 10:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/UP0GQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKLKE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKLKE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 05:04:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA4C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 02:04:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 34so484937pgp.10
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oCl6zu16OIyczck0Sron0+9rp3lNPPtr1/HMEuCC/sY=;
        b=C/UP0GQfgfoeO5ZfjmKwuZKY9Cd3Ov88xQW7DS6EROL2Ek8O9T/xTpYRLZv+Vv4aOL
         U/VtDLrRm7TeSsVa+QR0qgb+HTWOmPof1ayEOK3n19PRu+KnDVl+s3lMlQaPpbK6lCTS
         ydi3KaqOKgLOS0t7GyTyfy83NbvSUJ9QUruD6/RIyiYCeGrLC3hT7M7jwaNDlNpDOLhU
         jFV41EHntEwQEfH//ectPjdeJ+4A5oH2LDkQwhQ4wBwPHDl+ZrvMTOrAZnA9fwlZWqHT
         CMyp77kzeklUI6wQdo0XITsV4QEPwfsUN0W3b09U/Fo2fDd5V/uMNPPwp9jS0PO2a48f
         wcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=oCl6zu16OIyczck0Sron0+9rp3lNPPtr1/HMEuCC/sY=;
        b=FfVqS+DtLsUZJ1Z5KW3YyS7Te0BieGnpeKemBbZTTF/8Y1bYi8D82oEylCT/9NboPD
         Div6g3H8/nytP3MK5RtfiZYobk1dZilF/R/jMj5WiyTT1ym4hoNaoajC5eC6n9lRddgT
         yu0GcpVFC5FcTzI50/5U9zNdMqWuHRVt/oDz8jzUH3NaelDVVu20tkskyUpfzYtz0wNn
         7/ElZ+gjhOMJa9U9QZDxZRtP3uPVF5BQt6c/k+Tz3ESMP/2UYRbaT+xaxSJ/OGUs4hbS
         uBgq9brzqNnRVhL1C3mNoakrhxoJhgeXHuxzaGGDQ2PKNb0+JZFAkDdxCZjXEYvx1vUW
         Iq/A==
X-Gm-Message-State: AOAM530rmNhBZzeh6CGVh/1FhdL8tp5lnwKCT6JbPkUfmDiTQz1BS2tc
        bxByM9bqFcXCxraDm7KyqdE=
X-Google-Smtp-Source: ABdhPJweyjgBLaKM+E92jgv/6j3RW9StuCRNnObAe6P7pgIRK/7exr6gKdJ5/vit27BovCXmsDc6CA==
X-Received: by 2002:a17:90a:fa4:: with SMTP id 33mr9056052pjz.47.1605175467273;
        Thu, 12 Nov 2020 02:04:27 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:85:6919:d63:e400:befb:5e41])
        by smtp.gmail.com with ESMTPSA id e22sm5881638pfd.153.2020.11.12.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:04:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:31:33 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 08/10] commit-graph: use generation v2 only if entire
 chain does
Message-ID: <20201112100133.GA2691@Abhishek-Arch>
Reply-To: 85zh41sxow.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <8ec119edc66814ad4d63908c79437a7f9dd3c08c.1602079786.git.gitgitgadget@gmail.com>
 <85zh41sxow.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85zh41sxow.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 01, 2020 at 01:55:11AM +0100, Jakub Narębski wrote:
> Hi Abhishek,
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > Since there are released versions of Git that understand generation
> > numbers in the commit-graph's CDAT chunk but do not understand the GDAT
> > chunk, the following scenario is possible:
> >
> > 1. "New" Git writes a commit-graph with the GDAT chunk.
> > 2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
> 
> All right.
> 
> >
> > Because of the current use of inspecting the current layer for a
> > chunk_generation_data pointer, the commits in the lower layer will be
> > interpreted as having very large generation values (commit date plus
> > offset) compared to the generation numbers in the top layer (topological
> > level). This violates the expectation that the generation of a parent is
> > strictly smaller than the generation of a child.
> 
> I think this paragraphs tries too much to be concise, with the result it
> is less clear than it could be.  Perhaps it would be better to separate
> "what-if" from the current behavior.
> 
>   If each layer of split commit-graph is treated independently, as it
>   were the case before this commit, with Git inspecting only the current
>   layer for chunk_generation_data pointer, commits in the lower layer
>   (one with GDAT) would have corrected commit date as their generation
>   number, while commits in the upper layer would have topological levels
>   as their generation.  Corrected commit dates have usually much larger
>   values than topological levels.  This means that if we take two
>   commits, one from the upper layer, and one reachable from it in the
>   lower layer, then the expectation that the generation of a parent is
>   smaller than the generation of a child would be violated.
> 

Thanks, that's better.

> >
> > It is difficult to expose this issue in a test. Since we _start_ with
> > artificially low generation numbers, any commit walk that prioritizes
> > generation numbers will walk all of the commits with high generation
> > number before walking the commits with low generation number. In all the
> > cases I tried, the commit-graph layers themselves "protect" any
> > incorrect behavior since none of the commits in the lower layer can
> > reach the commits in the upper layer.
> 
> I don't quite understand the issue here. Unless none of the following
> query commands short-circuit and all walk the commit graph regardless of
> what generation numbers tell them, they should give different results
> with and without the commit graph, if we take two commits one from lower
> layer of split commit graph with GDAT, and one commit from the higher
> layer without GDAT, one lower reachable from the other higher.
> 
> We have the following query commands that we can check:
>   $ git merge-base --is-ancestor <lower> <higher>
>   $ git merge-base --independent <lower> <higher>
>   
>   $ git tag --contains <tag-to-lower>
>   $ git tag --merged <tag-to-higher>
>   $ git branch --contains <branch-to-lower>
>   $ git branch --merged <branch-to-higher>
> 
> The second set of queries require for those commits to be tagged, or
> have branch pointing at them, respectively.
> 
> Also, shouldn't `git commit-graph verify` fail with split commit graph
> where the top layer is created with GIT_TEST_COMMIT_GRAPH_NO_GDAT=1?
> 
> Let's assume that we have the following history, with newer commits
> shown on top like in `git log --graph --oneline --all`:
> 
>           topological     corrected         generation
>           level           commit date       number^*
> 
>       d    3                                3
>       |
>    c  |    3                                3
>    |  |                                                 without GDAT
>  ..|..|.....[layer.boundary]........................................
>    |  |                                                    with GDAT
>    |  b    2              1112912113        1112912113
>    |  |
>    a  |    2              1112912053        1112912053
>    | /
>    |/
>    r       1              1112911993        1112911993
> 
> *) each layer inspected individually.
> 
> With such history, we can for example reach 'a' from 'c', thus
> `git merge-base --is-ancestor a b` should return true value, but
> without this commit gen(a) > gen(c), instead of gen(a) <= gen(c);
> I use here weaker reachability condition, but the one that works
> also for commits outside the commit-graph (and those for which
> generation numbers overflows).
> 

The original explanation was given by Dr. Stolee and he might not have
thought exhaustively about the issue.

In any case, your explanation and the history make sense to me. I will
try to add test and report back to the mailing list if something goes
wrong.

Thank you for clarifying in such detail.

> >
> > This issue would manifest itself as a performance problem in this case,
> > especially with something like "git log --graph" since the low
> > generation numbers would cause the in-degree queue to walk all of the
> > commits in the lower layer before allowing the topo-order queue to write
> > anything to output (depending on the size of the upper layer).
> 
> All right, that's good explanation.
> 
> ...
>
> > @@ -2030,6 +2047,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
> >  		}
> >  	}
> >  
> > +	if (!ctx->write_generation_data && g->chunk_generation_data)
> > +		ctx->write_generation_data = 1;
> > +
> 
> This needs more careful examination, and looking at larger context of
> those lines.
> 
> At this point, unless `--split=replace` option is used, 'g' points to
> the bottom layer out of all topmost layers being merged. We know that if
> there are GDAT-less layers then these must be top layers, so this means
> that we can write GDAT chunk in the result of the merge -- because we
> would be replacing all possible GDAT-less layers (and maybe some with
> GDAT) with a single layer with the GDAT chunk.
> 
> The ctx->write_generation_data is set to true unless environment
> variable GIT_TEST_COMMIT_GRAPH_NO_GDAT is true, and that in
> write_commit_graph() it would be set to false if topmost layer doesn't
> have GDAT chunk, and to true if `--split=replace` option is used; see
> below.
> 
> Looks good to me.
> 
> 
> NOTE that this means that GIT_TEST_COMMIT_GRAPH_NO_GDAT prevents from
> writing GDAT chunk with generation data v2 unless we are merging layers,
> or replacing all of them with a single layer: then it is _ignored_.
> 
> Should we clarify this fact in the description of GIT_TEST_COMMIT_GRAPH_NO_GDAT
> in t/README?  Currently it reads:
> 
>   GIT_TEST_COMMIT_GRAPH_NO_GDAT=<boolean>, when true, forces the
>   commit-graph to be written without generation data chunk.

I think it's better to *not* write generation data chunk if
GIT_TEST_COMMIT_GRAPH_NO_GDAT is set even though all GDAT-less layers
are merged, that is:

  if (!ctx->write_generation_data &&
      g->chunk_generation_data &&
     !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
    ctx->write_generation_data = 1;

With this change, we would have a method to force-write commit-graph
without generation data chunk regardless of the shape of split
commit-graph files.

> 
> ...
>
> > diff --git a/commit-graph.h b/commit-graph.h
> > index 19a02001fd..ad52130883 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -64,6 +64,7 @@ struct commit_graph {
> >  	struct object_directory *odb;
> >  
> >  	uint32_t num_commits_in_base;
> > +	unsigned int read_generation_data;
> >  	struct commit_graph *base_graph;
> 
> All right, this new field is here to propagate to each layer the
> information whether we can read from the generation number v2 data
> chunk.
> 
> Though I am not sure whether this field should be added here, and
> whether it should be `unsigned int` (we don't have to be that careful
> about saving space for this type).
> 

I cannot think of a more appropriate struct than `struct commit_graph`. 
Any particular suggestions?

> > 
> >  	const uint32_t *chunk_oid_fanout;
> > diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> > index 651df89ab2..d0949a9eb8 100755
> > --- a/t/t5324-split-commit-graph.sh
> > +++ b/t/t5324-split-commit-graph.sh
> > @@ -440,4 +440,90 @@ test_expect_success '--split=replace with partial Bloom data' '
> >  	verify_chain_files_exist $graphdir
> >  '
> >  
> > +test_expect_success 'setup repo for mixed generation commit-graph-chain' '
> > +	mkdir mixed &&
> 
> This should probably go just before cd-ing into just created
> subdirectory.
> 
> > +	graphdir=".git/objects/info/commit-graphs" &&
> > +	test_oid_cache <<-EOM &&
> > +	oid_version sha1:1
> > +	oid_version sha256:2
> > +	EOM
> 
> Minor nitpick: Why use "EOM", which is used only twice in Git the test
> suite, and not the conventional "EOF" (used at least 4000 times)?

Right, both instances of "EOM" are actually my own. I looked up some
test script for oid cache that did use EOM when I first wrote the tests
but it's changed now. Will replace.
> 
> > +	cd "$TRASH_DIRECTORY/mixed" &&
> 
> The t/README says:
> 
>    - Don't chdir around in tests.  It is not sufficient to chdir to
>      somewhere and then chdir back to the original location later in
>      the test, as any intermediate step can fail and abort the test,
>      causing the next test to start in an unexpected directory.  Do so
>      inside a subshell if necessary.
> 
> Though I am not sure if it should apply also to this situation.

While I cannot avoid changing directory, using a subshell would be best
to avoid causing the later tests to start in unexpected directories.

> 
> > +	git init &&
> > +	git config core.commitGraph true &&
> > +	git config gc.writeCommitGraph false &&
> 
> All right.
> 
> > +	for i in $(test_seq 3)
> > +	do
> > +		test_commit $i &&
> > +		git branch commits/$i || return 1
> > +	done &&
> > +	git reset --hard commits/1 &&
> > +	for i in $(test_seq 4 5)
> > +	do
> > +		test_commit $i &&
> > +		git branch commits/$i || return 1
> > +	done &&
> > +	git reset --hard commits/2 &&
> > +	for i in $(test_seq 6 10)
> > +	do
> > +		test_commit $i &&
> > +		git branch commits/$i || return 1
> > +	done &&
> > +	git commit-graph write --reachable --split &&
> 
> Is there a reason why we do not check just written commit-graph file
> with `test-tool read-graph >output-layer-1`?

We could check the written commit-graph file at this point but it's same
as existing tests as above.

> 
> > +	git reset --hard commits/2 &&
> > +	git merge commits/4 &&
> 
> Shouldn't we use `test_merge` instead of `git merge`; I am not sure when
> to use one or the other?

`test_merge` is used in 26 places whereas `git merge` is used in over a
thousand places. `test_merge` is just not widely adopted and this lack
of adoption prevents further use.

> 
> > +	git branch merge/1 &&
> > +	git reset --hard commits/4 &&
> > +	git merge commits/6 &&
> > +	git branch merge/2 &&
> 
> It would be nice to have ASCII-art of the history (of the graph of
> revisions) created here for subsequent tests:
> 
>                                         
>            /- 6 <-- 7 <-- 8 <-- 9 <-- 10*
>           /    \-\
>          /        \
>   1 <-- 2 <-- 3*   \--\
>   |      \             \ 
>   |       \-----\       \
>    \             \       \
>     \-- 4*<------ M/1     M/2
>         |\               /  
>         | \-- 5*        /
>         \              /
>          \------------/
> 
>   * - 1st layer  
> 
> Though I am not sure if what I have created is readable; I think a
> better way to draw this graph is possible, for example:
> 
>                /- 3*
>               /
>              /
>   1 <------ 2 <---- 6 <-- 7 <-- 8 <-- 9 <-- 10*
>    \         \       \
>     \         \       \
>      \         \       \
>       \- 4* <-- M/1     \    
>          |\              \
>          | \------------- M/2
>          \
>           \---- 5*
> 
> Edit: as I see the history gets even more complicated, so perhaps
> ASCII-art diagram of the history with layers marked would be too
> complicated, and wouldn't bring much.
> 
> Why do we need such shape of the history in the repository?

We don't need such a complicated shape. Any commit-graph file with 2-3
layers regardless of how commits are related should suffice. Will
simplify.

> 
> > +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
> > +	test-tool read-graph >output &&
> > +	cat >expect <<-EOF &&
> > +	header: 43475048 1 $(test_oid oid_version) 4 1
> > +	num_commits: 2
> > +	chunks: oid_fanout oid_lookup commit_metadata
> > +	EOF
> > +	test_cmp expect output &&
> 
> All right, we check that we have 2 commits, and that there is no GDAT
> chunk.
> 
> > +	git commit-graph verify
> 
> All right, we verify commit-graph as a whole (both layers).
> 
> > +'
> > +
> > +test_expect_success 'does not write generation data chunk if not present on existing tip' '
> 
> Hmmm... I wonder if we can come up with a better name for this test;
> for example should it be "does not write" or "do not write"?

That's better.

> 
> > +	cd "$TRASH_DIRECTORY/mixed" &&
> > +	git reset --hard commits/3 &&
> > +	git merge merge/1 &&
> > +	git merge commits/5 &&
> > +	git merge merge/2 &&
> > +	git branch merge/3 &&
> 
> The commit graph gets complicated, so it would not be easy to visualize
> it with ASCII-art diagram without any crossed lines.  Maybe `git log
> --graph --oneline --all` would help:
> 
> *   (merge/3) Merge branch 'merge/2'
> |\
> | *   (merge/2) Merge branch 'commits/6'
> | |\
> * | \   Merge branch 'commits/5'
> |\ \ \
> | * | | (commits/5) 5
> | |/ /
> * | |   Merge branch 'merge/1'
> |\ \ \
> | * | | (merge/1) Merge branch 'commits/4'
> | |\| |
> | | * | (commits/4) 4
> * | | | (commits/3) 3
> |/ / /
> | | | * (commits/10) 10
> | | | * (commits/9) 9
> | | | * (commits/8) 8
> | | | * (commits/7) 7
> | | |/
> | | * (commits/6) 6
> | |/
> |/|
> * | (commits/2) 2
> |/
> * (commits/1) 1
> 
> 
> > +	git commit-graph write --reachable --split=no-merge &&
> > +	test-tool read-graph >output &&
> > +	cat >expect <<-EOF &&
> > +	header: 43475048 1 $(test_oid oid_version) 4 2
> > +	num_commits: 3
> > +	chunks: oid_fanout oid_lookup commit_metadata
> > +	EOF
> > +	test_cmp expect output &&
> > +	git commit-graph verify
> 
> All right, so here we check that we have layer without GDAT at the top,
> and we request not to merge layers thus new layer will be created, then
> the new layer also does not have GDAT chunk (and has 3 commits).
> 
> Minor nitpick: shouldn't those test be indented?
> 

The tests look indented to me and `git diff HEAD^ --check` gives nothing.

Did you mean the lines enclosed by EOF delimiter?

> > +'
> > +
> > +test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
> > +	cd "$TRASH_DIRECTORY/mixed" &&
> > +	git commit-graph write --reachable --split=replace &&
> > +	test_path_is_file $graphdir/commit-graph-chain &&
> > +	test_line_count = 1 $graphdir/commit-graph-chain &&
> > +	verify_chain_files_exist $graphdir &&
> 
> All right, this checks that we have split commit-graph chain that
> consist of a single layer, and that the commit-graph file for this
> single layer exists.
> 
> > +	graph_read_expect 15 &&
> 
> Shouldn't we use `test-tool read-graph` to check whether generation_data
> chunk is present... ah, sorry, I have realized that after previous
> patches `graph_read_expect 15` implicitly checks the latter, because in
> its' use of `test-tool read-graph` it does expect generation_data chunk.
> 
> So we use `test-tool read-graph` manually to check that generation_data
> chunk is absent, and we use graph_read_expect to check that it is
> present (and in both cases that the number of commits matches).  I
> wonder if it would be possible to simplify that...
>

The problem here is graph_read_expect() as defined in
t5324-split-commit-graph takes two parameters - number of commits and
number of base graphs. If the number of base graphs is not passed to
the function call, it's assumed to be zero. Using a default parameter
is tricky - I can fix it by manually adding a zero to each of 
graph_read_expect() in an additional preparatory patch.

Any other suggestions are welcome too.

> 
> > +	git commit-graph verify
> 
> All right.
> 
> > +'
> > +
> > +test_expect_success 'add one commit, write a tip graph' '
> > +	cd "$TRASH_DIRECTORY/mixed" &&
> > +	test_commit 11 &&
> > +	git branch commits/11 &&
> > +	git commit-graph write --reachable --split &&
> > +	test_path_is_missing $infodir/commit-graph &&
> > +	test_path_is_file $graphdir/commit-graph-chain &&
> > +	ls $graphdir/graph-*.graph >graph-files &&
> > +	test_line_count = 2 graph-files &&
> > +	verify_chain_files_exist $graphdir
> > +'
> 
> What it is meant to test?  That adding single-commit to a 15 commit
> commit-graph file in split mode does not result in layers merging, and
> actually adds a new layer: we check that we have exactly two layers and
> that they are all OK.

This test is meant to check writing to a split graph in "normal"
conditions (i.e. all existing layers have generation data chunk). The
above tests are special cases as they involve merging layers with mixed 
generation number versions.

> 
> We don't check here that the newly created top layer commit-graph does
> have GDAT chunk, as it should be if the top layer (in this case the only
> layer) has GDAT chunk.
> > +
> >  test_done
> 
> One test we are missing is testing that merging layers is done
> correctly, namely that if we are merging layers in split commit-graph
> file, and the layer below the ones we are merging lacks GDAT chunk, then
> the result of the merge should also be without GDAT chunk.  This would
> require at least two GDAT-less layers in a setup.
> 
> I'm not sure how difficult writing such test should be.

It wouldn't be too hard. 

After the last test, I can write some more commits and write split 
commit-graph file without GDAT chunk. Then write some more commits 
and merge layers using `git commit-graph write --max-commits=<nr>`.

Thanks for pointing this out!

> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
