Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC3C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E926922249
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmafLxR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgKMJ7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 04:59:18 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1946EC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:59:18 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id o24so9952705ljj.6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8yTOCJRBaSWydtX5UmAx2BRfsS5nR0p/fGo6ldShmXE=;
        b=GmafLxR3yyAWrTeYbRTDjNWLIZZVF2XRJyzy63eQkmQvVPyiTQBs+Jzl5LsMIuuRKj
         w8dqIfh29lwb1UE/qD0UiuOB8asaxpmNO7hg68OYsv9oteoGv14au/ZdqkshEy/7TLcv
         X6uoTWxuiLwQH9XJUcaiQ4fTAIizO2rghXN44DU2ImIKMzG9Lf8zRV9fhy8kVHHaVehS
         HszKW2n8iedC6qFWoN7SwMBNizGncapQiWVtBD+8gQEpRrThUL6VyrWN6PgljK17ny98
         na3RqSGBOCUydkeZRadamcmjAHnCmqlb001vXzNHyVMK+CGJP28+1SnZcR+mLuaIoaIk
         FBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8yTOCJRBaSWydtX5UmAx2BRfsS5nR0p/fGo6ldShmXE=;
        b=CFjj0EDaolLWMM3zCJH7HYA05GuLciMqQKlxE/hOndE3qJ53SkDFrrQIIEPCqbs9rY
         c4MDLDshaLGI2zi4MmvuZuVFLBvcA8ooPAAjznxRolpobZz3+m0BusxHZzTjCaB1FMH3
         u2/3l9OvbPdmIV71flJ2f1uX/PYA34zupR+4ExDNP3G8jdCIRqZjAjMumIBNvJ2mOloq
         eDHocpLKsxpRzuyi/DkSlmBIai6MTfaa/wr0AqNwSjUDDai74Nv0xvalFldiDpnRuZ+V
         gycaJgLG0iSOojHEDSG0rF1xEWUsI5nrCltDVC0cEuaL5Bka+jPfXjQV5+9ZIN4tuMng
         iOdA==
X-Gm-Message-State: AOAM532czktMPL2x1JMRl9S0xtUccac4aX1XNJ4ifKARvpnsw3aCQLMv
        ktZItZ5zTcdeFkcgbeymRps=
X-Google-Smtp-Source: ABdhPJw8uNb2dsfpApdVuCx91B2pRJrTIEHPbIH/FZu5PlntCnyGDPKqxpPGCLJc50iGtwce2Y86/g==
X-Received: by 2002:a05:651c:134f:: with SMTP id j15mr741590ljb.469.1605261554952;
        Fri, 13 Nov 2020 01:59:14 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d1sm1506935lfs.216.2020.11.13.01.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 01:59:13 -0800 (PST)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 08/10] commit-graph: use generation v2 only if entire chain does
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <8ec119edc66814ad4d63908c79437a7f9dd3c08c.1602079786.git.gitgitgadget@gmail.com>
        <85zh41sxow.fsf@gmail.com> <20201112100133.GA2691@Abhishek-Arch>
Date:   Fri, 13 Nov 2020 10:59:13 +0100
In-Reply-To: <20201112100133.GA2691@Abhishek-Arch> (Abhishek Kumar's message
        of "Thu, 12 Nov 2020 15:31:33 +0530")
Message-ID: <85ft5dinm6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Sun, Nov 01, 2020 at 01:55:11AM +0100, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
[...]
>>> It is difficult to expose this issue in a test. Since we _start_ with
>>> artificially low generation numbers, any commit walk that prioritizes
>>> generation numbers will walk all of the commits with high generation
>>> number before walking the commits with low generation number. In all the
>>> cases I tried, the commit-graph layers themselves "protect" any
>>> incorrect behavior since none of the commits in the lower layer can
>>> reach the commits in the upper layer.
>>=20
>> I don't quite understand the issue here. Unless none of the following
>> query commands short-circuit and all walk the commit graph regardless of
>> what generation numbers tell them, they should give different results
>> with and without the commit graph, if we take two commits one from lower
>> layer of split commit graph with GDAT, and one commit from the higher
>> layer without GDAT, one lower reachable from the other higher.
>>=20
>> We have the following query commands that we can check:
>>   $ git merge-base --is-ancestor <lower> <higher>
>>   $ git merge-base --independent <lower> <higher>
>>=20=20=20
>>   $ git tag --contains <tag-to-lower>
>>   $ git tag --merged <tag-to-higher>
>>   $ git branch --contains <branch-to-lower>
>>   $ git branch --merged <branch-to-higher>
>>=20
>> The second set of queries require for those commits to be tagged, or
>> have branch pointing at them, respectively.
>>=20
>> Also, shouldn't `git commit-graph verify` fail with split commit graph
>> where the top layer is created with GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1?
>>=20
>> Let's assume that we have the following history, with newer commits
>> shown on top like in `git log --graph --oneline --all`:
>>=20
>>           topological     corrected         generation
>>           level           commit date       number^*
>>=20
>>       d    3                                3
>>       |
>>    c  |    3                                3
>>    |  |                                                 without GDAT
>>  ..|..|.....[layer.boundary]........................................
>>    |  |                                                    with GDAT
>>    |  b    2              1112912113        1112912113
>>    |  |
>>    a  |    2              1112912053        1112912053
>>    | /
>>    |/
>>    r       1              1112911993        1112911993
>>=20
>> *) each layer inspected individually.
>>=20
>> With such history, we can for example reach 'a' from 'c', thus
>> `git merge-base --is-ancestor a b` should return true value, but
>> without this commit gen(a) > gen(c), instead of gen(a) <=3D gen(c);
>> I use here weaker reachability condition, but the one that works
>> also for commits outside the commit-graph (and those for which
>> generation numbers overflows).
>>=20
>
> The original explanation was given by Dr. Stolee and he might not have
> thought exhaustively about the issue.
>
> In any case, your explanation and the history make sense to me. I will
> try to add test and report back to the mailing list if something goes
> wrong.
>
> Thank you for clarifying in such detail.

I don't think you need to add any new test.  It should be enough to check
that the first test introduced in this patch, namely 'setup repo for
mixed generation commit-graph-chain', fails without the change in this
patch -- as I think it does.  This is because `git commit-graph verify`
should fail with mixed-version split commit-graph with GDAT-less layer
on top without this change.

Reporting this (possibly as from one sentence to one paragraph in the
commit message) would be enough, in my opinion.

[...]
>> NOTE that this means that GIT_TEST_COMMIT_GRAPH_NO_GDAT prevents from
>> writing GDAT chunk with generation data v2 unless we are merging layers,
>> or replacing all of them with a single layer: then it is _ignored_.
>>=20
>> Should we clarify this fact in the description of GIT_TEST_COMMIT_GRAPH_=
NO_GDAT
>> in t/README?  Currently it reads:
>>=20
>>   GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D<boolean>, when true, forces the
>>   commit-graph to be written without generation data chunk.
>
> I think it's better to *not* write generation data chunk if
> GIT_TEST_COMMIT_GRAPH_NO_GDAT is set even though all GDAT-less layers
> are merged, that is:
>
>   if (!ctx->write_generation_data &&
>       g->chunk_generation_data &&
>      !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
>     ctx->write_generation_data =3D 1;
>
> With this change, we would have a method to force-write commit-graph
> without generation data chunk regardless of the shape of split
> commit-graph files.

While it would be more consistent to always behave like the old Git with
GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1, it is in my opinion not necessary.

The only thing we need to test the mixed-version commit-graph chain is
the ability to add new layer on top without GDAT.  It does not matter if
this layer is created from new commits or a result of partial or full
merge of layers.

So the alternative to extending what GIT_TEST_COMMIT_GRAPH_NO_GDAT does
that you propose here would be simply improving the description of t in
t/README, e.g.

     GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D<boolean>, when true, forces the
     commit-graph, or new layer in split commit-graph chain, to be written
     without generation data chunk.  It does not affect merging of layers.

For me either solution is fine.

[...]
>>> diff --git a/commit-graph.h b/commit-graph.h
>>> index 19a02001fd..ad52130883 100644
>>> --- a/commit-graph.h
>>> +++ b/commit-graph.h
>>> @@ -64,6 +64,7 @@ struct commit_graph {
>>>  	struct object_directory *odb;
>>>=20=20
>>>  	uint32_t num_commits_in_base;
>>> +	unsigned int read_generation_data;
>>>  	struct commit_graph *base_graph;
>>=20
>> All right, this new field is here to propagate to each layer the
>> information whether we can read from the generation number v2 data
>> chunk.
>>=20
>> Though I am not sure whether this field should be added here, and
>> whether it should be `unsigned int` (we don't have to be that careful
>> about saving space for this type).
>
> I cannot think of a more appropriate struct than `struct commit_graph`.=20
> Any particular suggestions?

After thinking about it a bit more, I think it is fine to have it here
in `struct commit_graph`, it is better than using a global variable
(which would make code non-reentrant; not that we use multiple threads
for reading multiple layers of the commit graph, but we might want to in
the future).

[...]
>>> +	cd "$TRASH_DIRECTORY/mixed" &&
>>=20
>> The t/README says:
>>=20
>>    - Don't chdir around in tests.  It is not sufficient to chdir to
>>      somewhere and then chdir back to the original location later in
>>      the test, as any intermediate step can fail and abort the test,
>>      causing the next test to start in an unexpected directory.  Do so
>>      inside a subshell if necessary.
>>=20
>> Though I am not sure if it should apply also to this situation.
>
> While I cannot avoid changing directory, using a subshell would be best
> to avoid causing the later tests to start in unexpected directories.

This would allow for easier skipping of tests, and failed tests would
not propagate the error (because of subsequent tests after a failed one
starting in unexpected directory).

[...]
>>> +	for i in $(test_seq 3)
>>> +	do
>>> +		test_commit $i &&
>>> +		git branch commits/$i || return 1
>>> +	done &&
>>> +	git reset --hard commits/1 &&
>>> +	for i in $(test_seq 4 5)
>>> +	do
>>> +		test_commit $i &&
>>> +		git branch commits/$i || return 1
>>> +	done &&
>>> +	git reset --hard commits/2 &&
>>> +	for i in $(test_seq 6 10)
>>> +	do
>>> +		test_commit $i &&
>>> +		git branch commits/$i || return 1
>>> +	done &&
>>> +	git commit-graph write --reachable --split &&
>>=20
>> Is there a reason why we do not check just written commit-graph file
>> with `test-tool read-graph >output-layer-1`?
>
> We could check the written commit-graph file at this point but it's same
> as existing tests as above.

All right, thanks for an explanation.

>>=20
>>> +	git reset --hard commits/2 &&
>>> +	git merge commits/4 &&
>>=20
>> Shouldn't we use `test_merge` instead of `git merge`; I am not sure when
>> to use one or the other?
>
> `test_merge` is used in 26 places whereas `git merge` is used in over a
> thousand places. `test_merge` is just not widely adopted and this lack
> of adoption prevents further use.

All right then.

>>> +	git branch merge/1 &&
>>> +	git reset --hard commits/4 &&
>>> +	git merge commits/6 &&
>>> +	git branch merge/2 &&
>>=20
>> It would be nice to have ASCII-art of the history (of the graph of
>> revisions) created here for subsequent tests:
>>=20
>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>            /- 6 <-- 7 <-- 8 <-- 9 <-- 10*
>>           /    \-\
>>          /        \
>>   1 <-- 2 <-- 3*   \--\
>>   |      \             \=20
>>   |       \-----\       \
>>    \             \       \
>>     \-- 4*<------ M/1     M/2
>>         |\               /=20=20
>>         | \-- 5*        /
>>         \              /
>>          \------------/
>>=20
>>   * - 1st layer=20=20
>>=20
>> Though I am not sure if what I have created is readable; I think a
>> better way to draw this graph is possible, for example:
>>=20
>>                /- 3*
>>               /
>>              /
>>   1 <------ 2 <---- 6 <-- 7 <-- 8 <-- 9 <-- 10*
>>    \         \       \
>>     \         \       \
>>      \         \       \
>>       \- 4* <-- M/1     \=20=20=20=20
>>          |\              \
>>          | \------------- M/2
>>          \
>>           \---- 5*
>>=20
>> Edit: as I see the history gets even more complicated, so perhaps
>> ASCII-art diagram of the history with layers marked would be too
>> complicated, and wouldn't bring much.
>>=20
>> Why do we need such shape of the history in the repository?
>
> We don't need such a complicated shape. Any commit-graph file with 2-3
> layers regardless of how commits are related should suffice. Will
> simplify.

If you are unsire if we need this shape of history to properly test all
corner cases of the algorithm, or whether simple history would be
enough, you can simply compare code coverage.  Git Makefile ha the
'coverage' target (which requires 'gcov' tool).

NOTE: if it is possible to run 'make coverage' for you, it can be used
to check if there are any parts of the new code that are not tested.

[...]
>>> +	git commit-graph write --reachable --split=3Dno-merge &&
>>> +	test-tool read-graph >output &&
>>> +	cat >expect <<-EOF &&
>>> +	header: 43475048 1 $(test_oid oid_version) 4 2
>>> +	num_commits: 3
>>> +	chunks: oid_fanout oid_lookup commit_metadata
>>> +	EOF
>>> +	test_cmp expect output &&
>>> +	git commit-graph verify
>>=20
>> All right, so here we check that we have layer without GDAT at the top,
>> and we request not to merge layers thus new layer will be created, then
>> the new layer also does not have GDAT chunk (and has 3 commits).
>>=20
>> Minor nitpick: shouldn't those test be indented?
>>=20
>
> The tests look indented to me and `git diff HEAD^ --check` gives nothing.
>
> Did you mean the lines enclosed by EOF delimiter?

I'm sorry, that was my mistake -- tabs are used for indent, and the
tabstop (in my newsreader) when being quoted made it look like it was
not indented.

[...]
>>> +test_expect_success 'writes generation data chunk when commit-graph ch=
ain is replaced' '
>>> +	cd "$TRASH_DIRECTORY/mixed" &&
>>> +	git commit-graph write --reachable --split=3Dreplace &&
>>> +	test_path_is_file $graphdir/commit-graph-chain &&
>>> +	test_line_count =3D 1 $graphdir/commit-graph-chain &&
>>> +	verify_chain_files_exist $graphdir &&
>>=20
>> All right, this checks that we have split commit-graph chain that
>> consist of a single layer, and that the commit-graph file for this
>> single layer exists.
>>=20
>>> +	graph_read_expect 15 &&
>>=20
>> Shouldn't we use `test-tool read-graph` to check whether generation_data
>> chunk is present... ah, sorry, I have realized that after previous
>> patches `graph_read_expect 15` implicitly checks the latter, because in
>> its' use of `test-tool read-graph` it does expect generation_data chunk.
>>=20
>> So we use `test-tool read-graph` manually to check that generation_data
>> chunk is absent, and we use graph_read_expect to check that it is
>> present (and in both cases that the number of commits matches).  I
>> wonder if it would be possible to simplify that...

What I wanted to say that it might be better to have a second variant of
graph_read_expect() for GDAT-less layers -- but this might be
unnecessary complication.

> The problem here is graph_read_expect() as defined in
> t5324-split-commit-graph takes two parameters - number of commits and
> number of base graphs. If the number of base graphs is not passed to
> the function call, it's assumed to be zero. Using a default parameter
> is tricky - I can fix it by manually adding a zero to each of=20
> graph_read_expect() in an additional preparatory patch.

All right, thanks for an explanation.  I should have examined
graph_read_expect() in more detail.

> Any other suggestions are welcome too.

[...]
>>> +test_expect_success 'add one commit, write a tip graph' '
>>> +	cd "$TRASH_DIRECTORY/mixed" &&
>>> +	test_commit 11 &&
>>> +	git branch commits/11 &&
>>> +	git commit-graph write --reachable --split &&
>>> +	test_path_is_missing $infodir/commit-graph &&
>>> +	test_path_is_file $graphdir/commit-graph-chain &&
>>> +	ls $graphdir/graph-*.graph >graph-files &&
>>> +	test_line_count =3D 2 graph-files &&
>>> +	verify_chain_files_exist $graphdir
>>> +'
>>=20
>> What it is meant to test?  That adding single-commit to a 15 commit
>> commit-graph file in split mode does not result in layers merging, and
>> actually adds a new layer: we check that we have exactly two layers and
>> that they are all OK.
>
> This test is meant to check writing to a split graph in "normal"
> conditions (i.e. all existing layers have generation data chunk). The
> above tests are special cases as they involve merging layers with mixed=20
> generation number versions.

All right.

>>=20
>> We don't check here that the newly created top layer commit-graph does
>> have GDAT chunk, as it should be if the top layer (in this case the only
>> layer) has GDAT chunk.
>>> +
>>>  test_done
>>=20
>> One test we are missing is testing that merging layers is done
>> correctly, namely that if we are merging layers in split commit-graph
>> file, and the layer below the ones we are merging lacks GDAT chunk, then
>> the result of the merge should also be without GDAT chunk.  This would
>> require at least two GDAT-less layers in a setup.
>>=20
>> I'm not sure how difficult writing such test should be.
>
> It wouldn't be too hard.=20
>
> After the last test, I can write some more commits and write split=20
> commit-graph file without GDAT chunk. Then write some more commits=20
> and merge layers using `git commit-graph write --max-commits=3D<nr>`.
>
> Thanks for pointing this out!

Good.

Best,
--=20
Jakub Nar=C4=99bski
