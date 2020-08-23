Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD2C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74411206B5
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 15:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWbDH+94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHWP1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHWP1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 11:27:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC93C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 08:27:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v9so6877035ljk.6
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=glmxlPwpOTssFUuL1TepOeSUVTMWvK6pIy0tZwZZmDs=;
        b=sWbDH+944/ZnsIK2Jy+CKL3DesdVnvQrqsGfw+szjcK1POC5KJOQTkQr6VnJntFCpH
         noAwY9fJ3+xzJTd0z2/b6tpjId+UExmBFuqyOmdFZGE37NdBfoepPDxcg0QzWj+kPYAa
         GzaGjryeV4BH2eiwNJGGC+ZkE6LJN7qYeiEhOamGy57GbQ+7x0BJ/PXU/UTrVqxNeP2C
         NDgPyWMRHlHqaaIAW5EL86JkDSqwZbv/HzTg9QLRqJjlIi3n9CqWHjGUzkIBnEPdnZcm
         XxrIGKVIwSEOS59Y4AK4PS390BykZBMgMgnybgwRkrai1WZLL5hkIKMm2ddzY2zSaQ+c
         nfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=glmxlPwpOTssFUuL1TepOeSUVTMWvK6pIy0tZwZZmDs=;
        b=iFB92O8N58p/BgWiTOXkIMlFh4TzSzO6x6fjGUGWHiW/5MFg9jyo/+WCTmevbppd+o
         GZPaYe9o/dsvObh2sz1+5wJ8pHKhCw7h1SWiwI3JVEZM/VNN4VstGW852NXQJ/8TUuix
         VdkfpN9Zbvyah+3fSEMU3Q6+z4BFPJrMBF4oDjd/EpYy1nthRrAQzhctrEcUfC4TkHvm
         H5wB27YNFkmiGVYLdT6pFspscDGX6gqU/WHMp7byDW3caCsIB+KE1nCWQwtJH+oQJd+/
         9K+A7YhAQYAxbr7m2bgySm9okvUww/E4l28Bdt9goo7YTG/oSjQfuun018BSRAlvtSjX
         JwWA==
X-Gm-Message-State: AOAM532gfBb1b0eFbIAP6/IGK29nwso2CSrnyTgOE9RUmjdXB64SFbLY
        5bWhpER8a8pwNtHFxeXYAoA=
X-Google-Smtp-Source: ABdhPJx/Pm5eWUNmiSHFjxwvxAra1kw0UwqdTGFMpYeNHLQIHX5Y3L3z7YNy6q52ywdQ7C3bH3JC1A==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr773791ljj.105.1598196469000;
        Sun, 23 Aug 2020 08:27:49 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 72sm1657218lfh.97.2020.08.23.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 08:27:47 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <85zh6uxh7l.fsf@gmail.com>
Date:   Sun, 23 Aug 2020 17:27:46 +0200
In-Reply-To: <85zh6uxh7l.fsf@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\=22\?\=
 \=\?utf-8\?Q\?'s\?\= message of "Mon,
        17 Aug 2020 02:13:18 +0200")
Message-ID: <85blj1e619.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here is a summary of my comments and thoughts after carefully reviewing
all patches in the series.

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
[...]
>> The Corrected Commit Date is defined as:
>>
>> For a commit C, let its corrected commit date be the maximum of the comm=
it
>> date of C and the corrected commit dates of its parents.
>
> Actually it needs to be "corrected commit dates of its parents plus 1"
> to fulfill the reachability condition for a generation number for a
> commit:
>
>       A can reach B   =3D>  gen(A) < gen(B)
>
> Of course it can be computed in simpler way, because
>
>   max_P (gen(P) + 1)  =3D=3D  max_P (gen(P)) + 1

I see that it is defined correctly in the documentation, which is more
important than cover letter (which would not be stored in the repository
for memory, even in the commit message for the merge).

[...]
> However I think the cover letter should also describe what should happen
> in a mixed version environment (for example new Git on command line,
> copy of old Git used by GUI client), and in particular what should
> happen in a mixed-chain case - both for reading and for writing the
> commit-graph file.
>
> For *writing*: because old Git would create commit-graph layers without
> the GDAT chunk, to simplify the behavior and make easy to reason about
> commit-graph data (the situation should be not that common, and
> transient -- it should get more rare as the time goes), we want the
> following behavior from new Git:
>
> - If top layer contains the GDAT chunk, or we are rewriting commit-graph
>   file (--split=3Dreplace), or we are merging layers and there are no
>   layers without GDAT chunk below set of layers that are merged, then
>
>      write commit-graph file or commit-graph layer with GDAT chunk,

Actually we can simplify handling of merging layers, while still
retaining the property that in mixed-version chain all GDAT-full layers
are before / below GDAT-less layers.

Namely, if merging layers, and at least one layer being merged doesn't
have GDAT chunk, then the result of merge wouldn't have either.

We can always switch to slightly more complicated behavior proposed
above in quoted part later, perhaps as a followup commit.

>
>   otherwise
>
>      write commit-graph layer without GDAT chunk.
>
>   This means that there are commit-graph layers without GDAT chunk if
>   and only if the top layer is also without GDAT chunk.

This might be not necessary if Git would always check the whole chain of
split commit-graph layers for presence of GDAT-less layers.

But I still think it is a good idea to avoid having GDAT-less "holes".

>
> For *reading* we want to use generation number v2 (corrected commit
> date) if possible, and fall back to generation number v1 (topological
> levels).
>
> - If the top layer contains the GDAT chunk (or maybe even if the topmost
>   layer that involves all commits in question, not necessarily the top
>   layer in the full commit-graph chain), then use generation number v2
>
>   - commit_graph_data->generation stores corrected commit date,
>     computed as sum of committer date (from CDAT) and offset (from GDAT)

Or stored directly in GDAT, at the cost of increasing the file size by
at most 7% (if I have done my math correctly).

See also the issue with clamping offsets (GENERATION_NUMBER_V2_OFFSET_MAX).

>
>   - A can reach B   =3D>  gen(A) < gen(B)
>
>   - there is no need for committer date heuristics, and no need for
>     limiting use of generation number to where there is a cutoff (to not
>     hamper performance).
>
> - If there are layers without GDAT chunks, which thanks to the write
>   behavior means simply top layer without GDAT chunk, we need to turn
>   off use of generation numbers or fall back to using topological levels
>
>   - commit_graph_data->generation stores topological levels,
>     taken from CDAT chunk (30-bits)
>
>   - A can reach B   =3D>  gen(A) < gen(B)
>
>   - we probably want to keep tie-breaking of sorting by generation
>     number via committer date, and limit use of generation number as
>     opposed to using committer date heuristics (with slop) to not make
>     performance worse.

And this is being done in this patch series.  Good!

The thing I was worrying about turned out to be non-issue, as the
comparison function in question is used only when writing, and in this
case we have corrected commit date computer - though perhaps not being
written (as far as I understand it, but I might be mistaken).

[...]
>>
>> Abhishek Kumar (11):
>>   commit-graph: fix regression when computing bloom filter

No problems, maybe just expanding a commit message and/or adding a comment.

>>   revision: parse parent in indegree_walk_step()

Looks good to me.

>>   commit-graph: consolidate fill_commit_graph_info

I think this commit could be split into three:
- fix to the 'generate tar with future mtime' test
  as it is a hidden bug (when using commit-graph)
- simplify implementation of fill_commit_in_graph()
  by using fill_commit_graph_info()
- move loading date into fill_commit_graph_info()
  that uncovers the issue with 'generate tar with future mtime'

On the other hand because they are inter-related, those changes might be
kept in a single commit.

In commit message greater care needs to be taken with
fill_commit_graph_info() and fill_commit_in_graph(), when to use one and
when to use the other. For example it is fill_commit_graph_info() that
changes its behavior, and it is fill_commit_in_graph() that is getting
simplified.

>>   commit-graph: consolidate compare_commits_by_gen

Looks good to me, though it might be good idea to add comments about the
sorting order (inside comment) to appropriate header files.

>>   commit-graph: return 64-bit generation number

This conversion misses one place, though it would be changed to use
topological levels slab in next patch.

This patch also unnecessary introduces GENERATION_NUMBER_V1_INFINITY.
There is no need for it: `generation` field can always simply use
GENERATION_NUMBER_INFINITY for commits not in commit-graph.

>>   commit-graph: add a slab to store topological levels

This is the patch that needs GENERATION_NUMBER_V1_INFINITY (or
TOPOLOGICAL_LEVEL_INFINITY), not the previous patch.

Detailed analysis uncovered hidden bug in the code of
compute_generation_numbers() that works only because of historical
reasons (that topological levels in Git start from 1, not from 0). The
problem is that the 'level' / 'generation' variable for commits not in
graph, and therefore ones that needs to have its generation number
computed, is 0 (default value on commit slab) and not
GENERATION_NUMBER*_INFINITY as it should.

This issue is present since moving commit graph info data to
commit-slab.  We can simply document it and ignore (it works, if by
accident), or try to fix it.

We need to handle GENERATION_NUMBER*_MAX clamping carefully
in the future patches.

I think also that this patch needs a bit more detailed commit message.

>>   commit-graph: implement corrected commit date

Looks good, though verify_commit_graph() now verifies *a* generation
number used, be it v1 (topological level) or v2 (corrected commit date),
so the variable rename is unnecessary.  We verify that they fulfill the
reachability condition promise, that is gen(parent) <=3D gen(commit),
(the '=3D' is to include GENERATION_NUMBER*_MAX case), as it is what is
used to speed up graph traversal.

We probably want to verify both topological level values in CDAT, and if
they exist also corrected commit date values in GDAT.  But that might be
left for the future commit.

>>   commit-graph: implement generation data chunk

To save up to 6-7% on commit-graph file size we store 32-bits corrected
commit date offsets, instead of storing 64-bits corrected commit date.

However, as far as I understand it, using non-monotonic values for
on-disk storage with limited field size, like 32-bits corrected
commit date offset, leads to problems with GENERATION_NUMBER*_MAX.
Namely, as I have written in detail in my reply to patch 11/11 in this
series, there is no way to fulfill the reachability condition promise if
we have to store offset which true value do not fit in 32-bits reserved
for it.

This is extremly unlikely to happen in practice, but we need to be able
to handle it somehow.  We can store 64-bit corrected commit date, which
has graph-monotonic values, and the problem goes away in theory and in
practice (we would never have values that do not fit).  We can keep
storing 32-bit offsets, and simply do not use GDAT chunk if there is
offset value that do not fit.

All this of course, provided that I am not wrong about this issue...

>>   commit-graph: use generation v2 only if entire chain does

The commit message do not say anything about the *writing* side.

However, if we want to keep the requirement that GDAT-less layers in the
split commit-graph chain must all be above any GDAT-containing layers,
we need to consider how we want layer merging to behave.  We could
either opt for using GDAT whenever possible, or similify code and skip
using GDAT if we are unsure.

The first approach would mean that if the topmost layer below set of
layers being rewritten (in the split commit-graph chain) exists, and it
does not contain GDAT chunk, then and only then the result of rewrite
should not have GDAT chunk either.

The second approach is, I think, simpler: if any of layers that is being
rewritten is GDAT-less (we need to check only the top layer, though),
and we are not running full rewrite ('--split=3Dreplace'), then the result
of rewrite should not have GDAT chunk either.  We can switch to the
first algorithm in later commit.

Whether we choose one or the other, we need test that doing layer
merging do not break GDAT-inness requirement stated above.


Also, we can probably test that we are not using v1 and v2 at the same
time with tests involving --is-ancestor, or --contains / --merged.

>>   commit-reach: use corrected commit dates in paint_down_to_common()

I think this commit could be split into two:
- disable commit graph for entire t6024-recursive-merge test
- use corrected commit dates in paint_down_to_common()

On the other hand because they are inter-related, those changes might be
better kept in a single commit.

It would be nice to have some benchmark data, or at least stating that
performance does not change (within the error bounds), using for example
'git merge-base v4.8 v4.9' in Linux kernel repository.

>>   doc: add corrected commit date info

Looks good, there are a few places where 'generation number' (referring
to the v1 version) should have been replaced with 'topological level'.

I am also unsure how the GDAT chunk can be "later modified to store
future generation number related data.".  I'd like to have an example,
or for this statement to be removed (if it turns out to not be true, not
without introducing yet another chunk type).

>>  18 files changed, 396 insertions(+), 185 deletions(-)

Thanks for all your work.

Best regards,
--
Jakub Nar=C4=99bski
