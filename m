Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B68C56201
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 05:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A6620756
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 05:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow+NbfTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKVFbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 00:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgKVFbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 00:31:19 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27656C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 21:31:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q34so11138317pgb.11
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 21:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qwxamJv6cGygL0MI4fFQkjmkHRR0HrCgQ6VgG9U7sqE=;
        b=Ow+NbfThDKd0ikVAQnyF8zmKRconBKHZ24p1lFYcy6S3/+7XBOOqXFNG1irzOJK4LC
         OgDOh8mUxwaRIwbXuIPOlel0huqnAMS//AuDtmh69rJhAdrD3l3u7gnC6lTkiQjZr3hQ
         UDTd/mNJ1ZukdtdcAqh/48B50+NQvbNWxveXC5mFYSQg9OpbD3QvZT3xhKI00dYAr94b
         GJXG2iNs13TURUHNEOv74AaqlTN0wxv2fFH+GKRLmTvsZk6kQtK4XgskUAP253wkX+qW
         YSQigko/66zeEN+CQn+KvBte1OYqxHXIY1BFnLMyuwGhwCVnfGhNEhR4ffV0feI04a1I
         XFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=qwxamJv6cGygL0MI4fFQkjmkHRR0HrCgQ6VgG9U7sqE=;
        b=khFKnLIDsbUlkEjm+wm8ZInFCKJzamLB5v4DiU42exYiCvm8/rOag0ZQFNLG9cE5WH
         HllkSaXYpLZN0WKecfTpd7nUAb88yDqKK8bEzg0HpAJ+GcO8FhzRwS8YpGUlWgdgLTCB
         u4fv/Q4xhx1NxnSoFB163+7Ebm8V9qBcNpmGbFR2Ks6j3v82DFdt19CWhOP0ON4xYSI1
         DPfQC5IcuIFVUs6H+OnJbeCAcuU8fQP0BbgB3ttVR35GjpXXesvpLOtDHrQS4CYXtMpD
         e5f6hOEHeAL9VIBaRHoTdEFANrtRATyUgPl4FTVKLF9mdsrPGncNwFm95TDFGhPFrmcQ
         Jfsw==
X-Gm-Message-State: AOAM5331jq4hfoaXhdYA7kwTilN5zrFn38AMiazIJxeaCNwyAV1S58ln
        /IixcE2C6CNq/LG7Q5ewUgo6FNLZw7ITNA==
X-Google-Smtp-Source: ABdhPJwaGg3tUrkuOtt9lp2GRidKZ3jZCj3rke62CQIoT7TNalA5T1/kogYsxFPCSA4uqnhSEAxHzQ==
X-Received: by 2002:a62:7b08:0:b029:197:d32a:3f52 with SMTP id w8-20020a627b080000b0290197d32a3f52mr10830283pfc.13.1606023077775;
        Sat, 21 Nov 2020 21:31:17 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:4e1b:7df9:8c64:9dfe:9e83:35c8])
        by smtp.gmail.com with ESMTPSA id v3sm8171761pfn.215.2020.11.21.21.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 21:31:17 -0800 (PST)
Date:   Sun, 22 Nov 2020 11:01:40 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 00/10] [GSoC] Implement Corrected Commit Date
Message-ID: <X7n3rxnGthonwElD@Abhishek-Arch>
Reply-To: 85tuu4lmlu.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <85tuu4lmlu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85tuu4lmlu.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 12:37:49AM +0100, Jakub Narębski wrote:
> Hi Abhishek,
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > This patch series implements the corrected commit date offsets as generation
> > number v2, along with other pre-requisites.
> 
> Thanks a lot for continued working on this patch series.

Thank you so much for the careful review of the series.

> 
> >
> > Git uses topological levels in the commit-graph file for commit-graph
> > traversal operations like git log --graph. Unfortunately, using topological
> > levels can result in a worse performance than without them when compared
> > with committer date as a heuristics. For example, git merge-base v4.8 v4.9 
> > on the Linux repository walks 635,579 commits using topological levels and
> > walks 167,468 using committer date.
> 
> Very minor nitpick: it would make it easier to read if the commands
> themself would be put inside single quotes or backticks, e.g. `git log
> --graph` and `git merge-base v4.8 v4.9`.

That's unexpected - I wrote the commands within single quotes in the pull
request. Since backticks are rendered as "code-tags" on Github, let me 
try single quotes.

> 
> I wonder if it is worth mentioning (probably not) that this performance
> hit was the reason why since 091f4cf3 `git merge-base` uses committer
> date heuristics unless there is a cutoff and using topological levels
> (generation date v1) is expected to give better performance.
> 

I think that's useful context for someone wondering whether we continue
to take the performance hit with topological levels or have abandoned
topological levels or chosen some another alternative altogether.

> >
> > Thus, the need for generation number v2 was born. New generation number
> > needed to provide good performance, increment updates, and backward
> > compatibility. Due to an unfortunate problem 1
> 
> Minor issue: this looks a bit strange; is there an error in formatting
> this part?

Yes. The plaintext in pull request description reads as follows:

  Thus, the need for generation number v2 was born. New generation number
  needed to provide good performance, increment updates, and backward
  compatibility. Due to an unfortunate problem [1], we also needed a way
  to distinguish between the old and new generation number without
  incrementing graph version.

  [1]: https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

I have been reviewing other pull request descriptions to match their
style (and hope the cover letter renders correctly) and Dr. Stolee in
his patch series to "add --literal value" option to configuration has
written:
  
  As reported [1], 'git maintenance unregister' fails when a repository
  is located in a directory with regex glob characters.

  [1] https://lore.kernel.org/git/2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com/T/#mb96fa4187a0d6aeda097cd95804a8aafc0273022

(Note the lack of colon after [1])

> 
> > [https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/], we also
> > needed a way to distinguish between the old and new generation number
> > without incrementing graph version.
> >
> > Various candidates were examined (https://github.com/derrickstolee/gen-test, 
> > https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> > number v2, Corrected Commit Date with Mononotically Increasing Offsets 
> > performed much worse than committer date (506,577 vs. 167,468 commits walked
> > for git merge-base v4.8 v4.9) and was dropped.
> >
> > Using Generation Data chunk (GDAT) relieves the requirement of backward
> > compatibility as we would continue to store topological levels in Commit
> > Data (CDAT) chunk.
> 
> Nice writeup about the history of generation number v2, much appreciated.
> 
> >                    Thus, Corrected Commit Date was chosen as generation
> > number v2. The Corrected Commit Date is defined as:
> 
> Minor nitpick: it would be probably better to use "is defined as
> follows." instead of "is defined as:".
> 
> >
> > For a commit C, let its corrected commit date be the maximum of the commit
> > date of C and the corrected commit dates of its parents plus 1. Then 
> > corrected commit date offset is the difference between corrected commit date
> > of C and commit date of C. As a special case, a root commit with timestamp
> > zero has corrected commit date of 1 to be able distinguish it from
> > GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit date).
> 
> Very minor nitpick: s/with timestamp/with *the* timestamp/, and
> s/to be able distinguish/to be able *to* distinguish/ (without the '*'
> used to mark the additions).
> 
> >
> > We will introduce an additional commit-graph chunk, Generation Data chunk,
> 
> Or "Generation DATa chunk", if we want to emphasize where its name came
> from, or even "Generation DATa (GDAT) chunk". But it is fine as it is
> now, though it would be good idea to write "Generation Data (GDAT)
> chunk" to explicitly state its name / shortcut.
> 
> > and store corrected commit date offsets in GDAT chunk while storing
> > topological levels in CDAT chunk. The old versions of Git would ignore GDAT
> > chunk, using topological levels from CDAT chunk. In contrast, new versions
> > of Git would use corrected commit dates, falling back to topological level
> > if the generation data chunk is absent in the commit-graph file.
> 
> Nice writeup of handling the backward compatibility.
> 
> >
> > While storing corrected commit date offsets saves us 4 bytes per commit (as
> > compared with storing corrected commit dates directly), it's possible for
> > the offset to overflow the space allocated. To handle such cases, we
> > introduce a new chunk, Generation Data Overflow (GDOV) that stores the
> > corrected commit date. For overflowing offsets, we set MSB and store the
> > position into the GDOV chunk, in a mechanism similar to the Extra Edges list
> > chunk.
> 
> Very minor suggestion: perhaps it would be better to use "it's however
> possible".
> 
> Very minor suggestion: "it's possible for the offset to overflow" could
> be simplified to just "the offset can overflow"... though the simplified
> version loses a bit of hint that the overflow should be very rare in
> real repositories.
> 
> But it is just fine as it is now; I am not a native English speaker to
> judge which version is better.
> 

I think it is better to indicate the rareness of overflows.

> >
> > For mixed generation number environment (for example new Git on the command
> > line, old Git used by GUI client), we can encounter a mixed-chain
> > commit-graph (a commit-graph chain where some of split commit-graph files
> > have GDAT chunk and others do not). As backward compatibility is one of the
> > goals, we can define the following behavior:
> >
> > While reading a mixed-chain commit-graph version, we fall back on
> > topological levels as corrected commit dates and topological levels cannot
> > be compared directly.
> >
> > While writing on top of a split commit-graph, we check if the tip of the
> > chain has a GDAT chunk. If it does, we append to the chain, writing GDAT
> > chunk. Thus, we guarantee if the topmost split commit-graph file has a GDAT
> > chunk, rest of the chain does too.
> >
> > If the topmost split commit-graph file does not have a GDAT chunk (meaning
> > it has been appended by the old Git), we write without GDAT chunk. We do
> > write a GDAT chunk when the existing chain does not have GDAT chunk - when
> > we are writing to the commit-graph chain with the 'replace' strategy.
> 
> I think the last paragraph can be simplified (or added to) by explicitly
> stating the goal:
> 
>   When adding new layer to the split commit-graph file, and when merging
>   some or all layers (replacing them in the latter case), the new layer
>   will have GDAT chunk if and only if in the final result there would be
>   no layer without GDAT chunk just below it.
> 

Thanks, that is much clearer to understand.

> ...
> 
> After careful review of those 10 patches it looks like the series is
> close to being ready, requiring only small changes to progress.
> 

Thank you for writing this handy reference for changes.

> > Abhishek Kumar (10):
> >   commit-graph: fix regression when computing Bloom filters
> 
>     All good, beside possible improvement to the commit message.
>     Thanks to Taylor Blau for discovering possible reason for strange
>     no change in performance.
> 
> >   revision: parse parent in indegree_walk_step()
> 
>     Looks good.
> 
> >   commit-graph: consolidate fill_commit_graph_info
> 
>     Needs to fix now duplicated test names (minor change).
>     Proposed possible improvement to the commit message.
> 
> >   commit-graph: return 64-bit generation number
> 
>     Needs fixing due to mismerge: there should be no switch from
>     using GENERATION_NUMBER_ZERO to using GENERATION_NUMBER_INFINITY.
>     Possible minor improvement to the commit message.
> 
> >   commit-graph: add a slab to store topological levels
> 
>     Possible minor improvement to the commit message.
>     
>     There is also not very important issue, but something that would be
>     nice to explain, namely that checks for GENERATION_NUMBER_INFINITY 
>     can never be true, as topo_level_slab_at() returns 0 for commits
>     outside the commit-graph, not GENERATION_NUMBER_INFINITY.  It works
>     but it is not obvious why.
> 
> >   commit-graph: implement corrected commit date
> 
>     The change to commit-graph verification needs fixing, and we need to
>     decide how verifying generation numbers should work.  Perhaps a test
>     for handling topological level of GENERATION_NUMBER_V1_MAX could be
>     added (though this might be left for ater).
> 
>     The changes to `git commit-graph verify` code could be put into
>     separate patch, either before or after this one.
> 
> >   commit-graph: implement generation data chunk
> 
>     Proposed possible improvement to the commit message.
>     The commit message does not explain why given shape of history is
>     needed to test handling corrected commit date offset overflow.
> 
>     Proposed minor corrections to the coding style.
> 
>     Instead of looping again through all commits when handling overflow
>     in corrected commit date offsets, while there should be at most a
>     few commits needing it, why not save those commits on list and loop
>     only through those commits?  Though this _possible_ performance
>     improvement could be left to the followup...

Since the improvement can be applied to both 
`write_graph_chunk_generation_data_overflow()` and 
`write_graph_chunk_extra_edges()`, I am planning to cover this in a
followup.

> 
>     test_commit_with_date() could be instead implemented via adding
>     `--date <date>` option to test_commit() in test-lib-functions.sh.
> 
>     Also, to reduce "noise" in this patch, the rename of
>     run_three_modes() to run_all_modes() and test_three_modes() to
>     test_all_modes() could have been done in a separate preparatory
>     patch. It would be pure refactoring patch, without introducing any
>     new functionality.  But it is not something that is necessary.
> 
> >   commit-graph: use generation v2 only if entire chain does
> 
>     Proposed possible improvement to the commit message.
>     Proposed minor corrections to the coding style (also in tests).
> 
>     There is a question whether merging layers or replacing them should
>     honor GIT_TEST_COMMIT_GRAPH_NO_GDAT.
> 
>     Tests possibly could be made more strict, and check more things
>     explicitly. One test we are missing is testing that merging layers
>     is done correctly, namely that if we are merging layers in split
>     commit-graph file, and the layer below the ones we are merging lacks
>     GDAT chunk, then the result of the merge should also be without GDAT
>     chunk -- but that might be left for later.
> 
> >   commit-reach: use corrected commit dates in paint_down_to_common()
> 
>     This patch consist of two slightly interleaved changes, which
>     possibly could be separated: change to paint_down_to_common() and
>     change to t6404-recursive-merge test.
> 
>     In the commit message for the paint_down_to_common() we should
>     explicitly mention 091f4cf3, which this one partially reverts.
> 
>     Possible accidental change, question about function naming.
> 
> >   doc: add corrected commit date info
> 
>     Needs further improvements to the documentation, like adding
>     "[Optional]" to chunk description, and leftover switching from
>     "generation numbers" to "topological levels" in one place.
> 
> ...
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
