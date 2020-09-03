Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F10C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A6820658
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flHRq6ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgICTMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICTMF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 15:12:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589EC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 12:12:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so5077633lja.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j9Cp6ufAl9U8sihuyPhN1xpe/iYDRtPW0tQdQyGr3bI=;
        b=flHRq6ZZp8BU0SQi2/uwPoGs3tmaOSDgw1wczoRP7g6T1UNbcXi3XqCPjZaaRw5iGF
         oCa9F5IAB0D+RDxcZSXkD1BkQHcfFS3ZnBk+ZELSaDO5YxzlLegVfBtlDRBwrQIPgmzh
         HIoRBk5E+WgFjvaA/9BFoIil7TM++r8Uy9QpQCNphmXQJAIOtt78l7tnU6kopACTr1XN
         CCnH95ybqEZLkM9DJBLuK8YwuUwBDTrQaOjnu4FPgsg4m7CXGG/uEd7uEefq7jkiGYJF
         4RVER8ccOMS8rnDfgpkbd+17i9F7nSauWXuja27SQR69WhZBbG05IiEF5zmRE2x9VeTe
         avaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=j9Cp6ufAl9U8sihuyPhN1xpe/iYDRtPW0tQdQyGr3bI=;
        b=ktG2JDcEqKYXceNQobo4WGaT82QCWzgHsn4zvKyCGWWGwXjRUUONirD842IUbqyRzJ
         BVMEFD/nVZeDv681iIgaiStcWN5V8rdirN5xH0HUw883QEKWMRmffHpQaQHR7PtcYX9p
         cYt08zf9xz6EtjZfDoVZRttWoTJh9Ot1PloIArabJ/GolneGsR7NuAnCLDMLEm++f0t7
         RUGMj1a/KKB3EnAYGovGRmcl1qVAn2i5A6jkAYv4H+SQsch/FauJeAi0KzaS9EdivE41
         HCdwNAngt5AcXaOAAkc82jI3mMmVt77TJTtUkcLb1zRBRg7vV6WTwe4ia1cFZq13QQ+6
         iacw==
X-Gm-Message-State: AOAM531HQZ0ABnrceYcJDtWa37pD0tM+PY9nmZQkmOdew8N9JxA8YAOl
        MHSkXNMQt2io9TAsQ636zHBIHDX8ZH3oyA==
X-Google-Smtp-Source: ABdhPJyhF/ow29OYYJMsNWXBsilwLO8T46aU96e0wqMwhrKIXt03PV7Mo2O1eaF1MeSc4Waef+hAQw==
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr2102173ljb.283.1599160322386;
        Thu, 03 Sep 2020 12:12:02 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r7sm768601lfn.84.2020.09.03.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 12:12:01 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 10/11] commit-reach: use corrected commit dates in paint_down_to_common()
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <439adc1718d6cc37f18c1eaeafd605f5c2961733.1597509583.git.gitgitgadget@gmail.com>
        <85imdah50e.fsf@gmail.com> <20200901100828.GA10388@Abhishek-Arch>
Date:   Thu, 03 Sep 2020 21:11:59 +0200
In-Reply-To: <20200901100828.GA10388@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 1 Sep 2020 15:38:28 +0530")
Message-ID: <85pn72ad4w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Sat, Aug 22, 2020 at 09:09:21PM +0200, Jakub Nar=C4=99bski wrote:
>>=20
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>>
>>> With corrected commit dates implemented, we no longer have to rely on
>>> commit date as a heuristic in paint_down_to_common().
>>=20
>> All right, but it would be nice to have some benchmark data: what were
>> performance when using topological levels, what was performance when
>> using commit date heuristics (before this patch), what is performace now
>> when using corrected commit date.

All right, the new proposed commit message has this benchmark data.
Thanks.

>>> t6024-recursive-merge setups a unique repository where all commits have
>>> the same committer date without well-defined merge-base. As this has
>>> already caused problems (as noted in 859fdc0 (commit-graph: define
>>> GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph within the
>>> test script.
>>=20
>> OK?
>
> In hindsight, that is a terrible explanation. Here's what I have revised
> this to:
>
>   With corrected commit dates implemented, we no longer have to rely on
>   commit date as a heuristic in paint_down_to_common().
>
>   While using corrected commit dates Git walks nearly the same number of
>   commits as commit date, the process is slower as for each comparision we
>   have to access the commit-slab (for corrected committer date) instead of
>   accessing struct member (for committer date).
>
>   For example, the command `git merge-base v4.8 v4.9` on the linux
>   repository walks 167468 commits, taking 0.135s for committer date and
>   167496 commits, taking 0.157s for corrected committer date respectively.
>
>   t6404-recursive-merge setups a unique repository where all commits have
>   the same committer date without well-defined merge-base. As this has
>   already caused problems (as noted in 859fdc0 (commit-graph: define
>   GIT_TEST_COMMIT_GRAPH, 2018-08-29)).
>
>   While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
>   date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
>   conflicts' merges commits in the order:
>   - Merge C with B to form a intermediate commit.
>   - Merge the intermediate commit with A.
>
>   With GIT_TEST_COMMIT_GRAPH=3D1, we write a commit-graph and subsequently
>   use the corrected committer date, which changes the order in which
>   commits are merged:
>   - Merge A with B to form a intermediate commit.
>   - Merge the intermediate commit with C.
>
>   While resulting repositories are equivalent, 6404.4 'virtual trees were
>   processed' fails with GIT_TEST_COMMIT_GRAPH=3D1 as we are selecting
>   different merge-bases and thus have different object ids for the
>   intermediate commits.
>
>   As this has already causes problems (as noted in 859fdc0 (commit-graph:
>   define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
>   within t6404-recursive-merge.

Much better.  Thanks a lot.

[...]
>>> diff --git a/commit-graph.c b/commit-graph.c
>>> index c1292f8e08..6411068411 100644
>>> --- a/commit-graph.c
>>> +++ b/commit-graph.c
>>> @@ -703,6 +703,20 @@ int generation_numbers_enabled(struct repository *=
r)
>>>  	return !!first_generation;
>>>  }
>>>
>>> +int corrected_commit_dates_enabled(struct repository *r)
>>> +{
>>> +	struct commit_graph *g;
>>> +	if (!prepare_commit_graph(r))
>>> +		return 0;
>>> +
>>> +	g =3D r->objects->commit_graph;
>>> +
>>> +	if (!g->num_commits)
>>> +		return 0;
>>> +
>>> +	return !!g->chunk_generation_data;
>>> +}
>>=20
>> The previous commit introduced validate_mixed_generation_chain(), which
>> walked whole split commit-graph chain, and set `read_generation_data`
>> field in `struct commit_graph` for all layers in the chain.
>>=20
>> This function examines only the top layer, so it follows the assumption
>> that Git would behave in such way that oly topmost layers in the chai
>> can be GDAT-less.
>>=20
>> Why the difference?  Couldn't validate_mixed_generation_chain() simply
>> call corrected_commit_dates_enabled()?
>
> The previous commit didn't need to walk the whole split commit-graph
> chain.

Errr... but `validate_mixed_generation_chain()` introduced in previous
commit in this patch series *does* walk all the layers of the whole
split commit-graph chain.

	static void validate_mixed_generation_chain(struct repository *r)
	{
		struct commit_graph *g =3D r->objects->commit_graph;
		int read_generation_data =3D 1;
=09
		while (g) {
			if (!g->chunk_generation_data) {
				read_generation_data =3D 0;
				break;
			}
			g =3D g->base_graph;
		}
=09
		g =3D r->objects->commit_graph;
=09
		while (g) {
			g->read_generation_data =3D read_generation_data;
			g =3D g->base_graph;
		}
	}

Moreover it "marks up" the whole chain, actually walking it twice.

You wrote somewhere else (possibly after I wrote this post) that this
was needed to handle `git commit-graph validate`, if I remember it
correctly.

If it is true, then we need both approaches: the less expensive one
(relying on our assumptions) and the more expensive one.  But we need to
better explain both: why we need more expensive one, why we can use the
less expensive onne (how we ensure that the requirements are fulfilled).

>       Because of how we are handling writing in a mixed generation data
> chunk, if a layer has generation data chunk, all layers below it have a
> generation data chunk as well.
>
> So, there are two cases at hand:
>
> - Topmost layer has generation data chunk, so we know all layers below
>   it has generation data chunk and we can read values from it.
> - Topmost layer does not have generation data chunk, so we know we can't
>   read from generation data chunk.
>
> Just checking the topmost layer suffices - modified the previous commit.
>
> Then, this function is more or less the same as
> `g->read_generation_data` that is, if we are reading from generation
> data chunk, we are using corrected commit dates.

All right.  That explains how corrected_commit_dates_enabled() works,
but not why we need also validate_mixed_generation_chain() that sets
g->read_generation_data for every layer in the chain.

>>=20
>>> +
>>>  static void close_commit_graph_one(struct commit_graph *g)
>>>  {
>>>  	if (!g)
>>> diff --git a/commit-reach.c b/commit-reach.c
>>> index 470bc80139..3a1b925274 100644
>>> --- a/commit-reach.c
>>> +++ b/commit-reach.c
>>> @@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struc=
t repository *r,
>>>  	int i;
>>>  	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>>>
>>> -	if (!min_generation)
>>=20
>> This check was added in 091f4cf (commit: don't use generation numbers if
>> not needed, 2018-08-30) by Derrick Stolee, and its commit message
>> includes benchmark results for running 'git merge-base v4.8 v4.9' in
>> Linux kernel repository:
>>=20
>>       v2.18.0: 0.122s    167,468 walked
>>   v2.19.0-rc1: 0.547s    635,579 walked
>>          HEAD: 0.127s
>>=20
>>> +	if (!min_generation && !corrected_commit_dates_enabled(r))
>>>  		queue.compare =3D compare_commits_by_commit_date;
>>=20
>> It would be nice to have similar benchmark for this change... unless of
>> course there is no change in performance, but I think then it needs to
>> be stated explicitly.  I think.
>>=20
>
> Mentioned in the commit message - we walk (nearly) the same number of
> commits but take somewhat longer.

All right, the new proposed commit message has it.

Sidenote: this is outside of the scope of this patch series, but perhaps
we should think about bringing the `generation` field from the
commit-slab back as a member of the `struct commit`; this would need
profiling and benchmarking of the typical workload to get amortized
performance across many git commands.

>>>
>>>  	one->object.flags |=3D PARENT1;
>>> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
>>> index 332cfc53fd..d3def66e7d 100755
>>> --- a/t/t6024-recursive-merge.sh
>>> +++ b/t/t6024-recursive-merge.sh

Note: this might be now t/t6404-recursive-merge.sh -- 6404 ot 6024.

>>> @@ -15,6 +15,8 @@ GIT_COMMITTER_DATE=3D"2006-12-12 23:28:00 +0100"
>>>  export GIT_COMMITTER_DATE
>>>
>>>  test_expect_success 'setup tests' '
>>> +	GIT_TEST_COMMIT_GRAPH=3D0 &&
>>> +	export GIT_TEST_COMMIT_GRAPH &&
>>>  	echo 1 >a1 &&
>>>  	git add a1 &&
>>>  	GIT_AUTHOR_DATE=3D"2006-12-12 23:00:00" git commit -m 1 a1 &&
>>> @@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
>>>  '
>>>
>>>  test_expect_success 'combined merge conflicts' '
>>> -	test_must_fail env GIT_TEST_COMMIT_GRAPH=3D0 git merge -m final G
>>> +	test_must_fail git merge -m final G
>>>  '
>>>
>>>  test_expect_success 'result contains a conflict' '
>>=20
>> OK, so instead of disabling commit-graph for this test, now we disable
>> it for the whole script.
>>=20
>> Maybe this change should be in a separate patch?
>
> With the explanation in commit message, it's clear to see how using
> corrected commit dates leads to an (incorrectly) failing test. Does it
> still make sense to seperate them?

No, I think that the new commit message explains why those changes are
together.

On the other hand it might be a good idea to add a TODO comment to this
test to mark it as fragile (fixing it is certainly out of scope of this
patch series, but better have something to remind us about the issue).
Perhaps:

  # TODO: fragile test, relies on specific resolving of ambiguity

Or something like that.  The original commit that added
GIT_TEST_COMMIT_GRAPH=3D0 (for a single test) explained:

  There is one test in t6024-recursive-merge.sh that relies on the
  merge-base algorithm picking one of two ambiguous merge-bases, and
  the commit-graph feature changes which merge-base is picked.

I'm not sure of we could salvage some of this test as it is now adding
`env GIT_TEST_COMMIT_GRAPH=3D0` in more individual tests instead of
turning it off for the whole test script.  But that is something that we
can do later.

Best,
--=20
Jakub Nar=C4=99bski
