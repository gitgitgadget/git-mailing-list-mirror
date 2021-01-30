Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D785C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E664D9D
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhA3FbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 00:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhA3F3m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 00:29:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89870C061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 21:28:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a20so6867925pjs.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 21:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=thdhSUDayo3fHnlTbTRwAOKGbREBIB1CaQuIBmLpL/s=;
        b=vS+vyeH6WhjkPE2eMHJt1/s3ktXzaa0QOhReUXQaAdxoOmmxdTo9MuyXVDIgp1jdxW
         VxZTbcTyIg61hgD1ikbMFVKRg1LXDig0Hs7j0EdNtQK1GURkUQEM03mkXD365KJ8pWGj
         tq0xO3Rg+Y//7KATsf7D3gia/l59w825JsJNriBBXdc9GpdLJtbmQud551A0Fb1TnNqL
         eTjBZSeHmaFmxax3hnUqJUGGitZbcYP8glmGnPgvJ18Tn5a3T32FUyY+cZH04c0z2vMA
         YSRjis2QIxr++aKVGWoepEuM0Y2qWNk5ykR6/tLw7oXt9XgvARK2g+FrvR2yg/x0lMVG
         wStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=thdhSUDayo3fHnlTbTRwAOKGbREBIB1CaQuIBmLpL/s=;
        b=gAmvSvSHpoyG6bb5MZjuEv7UT/LJI4z1jno2QOGS5bVAINQz0DMet+D0kUF354OQYk
         Nrod+N3jFWgkgtcigAPkQ/a7m62Q/XcrmbBfrYxqMeorZQ18nNtUEWFRolDilGuScXPJ
         /ALQgdA2Cy1Tdj8MLPOgIbRTZtdj8eF8kiUxgZv1B88xvP2QemcMFVhMBAt9ungkMF/g
         7tR9Xsc4+Xk+lMksTC4iQ1BNVnAUXibUxs7G5m9vpopfsezeeV1j5SD+FHrrDkKQGPsk
         fMtSIR8rN7BGeo48s4daZiJsU1xukQqAjk2RKHlS3wAO2QeaU9VKAnmaGRNB7OF37LJB
         iGpw==
X-Gm-Message-State: AOAM531fmuQxXLPNFh42I5cscWhlHUnPwqg2UZzOuVLmzklzvaWeQlG4
        2AIKiMXEwJcCTNnsFChZ8+0GM4CdryY=
X-Google-Smtp-Source: ABdhPJylvCPVz0rCKTOK6Hdrz8uSoMp+2TAS9Acnmuy81meQtfMW2WO9pXrFwxWSeLKRze4HOVSrAg==
X-Received: by 2002:a17:902:8f86:b029:df:fbf0:f725 with SMTP id z6-20020a1709028f86b02900dffbf0f725mr7734901plo.68.1611984527745;
        Fri, 29 Jan 2021 21:28:47 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:b1c:63e4:f338:f685:ad14:c51a])
        by smtp.gmail.com with ESMTPSA id t2sm11561184pga.45.2021.01.29.21.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 21:28:47 -0800 (PST)
Date:   Sat, 30 Jan 2021 10:59:05 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylorr.com,
        stolee@gmail.com
Subject: Re: [PATCH v6 11/11] doc: add corrected commit date info
Message-ID: <YBTuoTsrnbzLtX0j@Abhishek-Arch>
Reply-To: 20210127000454.GA1440011@szeder.dev
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <e571f03d8bd0b2def8e16df68f6cc53ffcf02082.1610820679.git.gitgitgadget@gmail.com>
 <20210127000454.GA1440011@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127000454.GA1440011@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 01:04:54AM +0100, SZEDER Gábor wrote:
> On Sat, Jan 16, 2021 at 06:11:18PM +0000, Abhishek Kumar via GitGitGadget wrote:
> > With generation data chunk and corrected commit dates implemented, let's
> > update the technical documentation for commit-graph.
> 
> This patch should come much earlier in this series, before patch 07/11
> (commit-graph: implement corrected commit date), or perhaps even
> earlier.  That way if someone were to investigate an issue in this
> series and checks out one of its commits, then the specification and
> the will be right there under 'Documentation/technical/'.
> 
> Furthermore, a patch introducing a new chunk format is the right place
> to justify the introduction of said new chunk.  What problems does a
> chunk of corrected commit dates solve?  Why does it solve them?  Why
> do we need corrected commit dates instead of simple commit dates?
> What alternatives were considered [1]?  Any other design considerations
> worth mentioning for the benefit of future readers?
> 
> None of the patches' log messages properly explain these, and while
> much of these is indeed explained in the cover letter, the cover
> letter will not be part of the history.  Requiring to look up mailing
> list archives for the justification puts unnecessary burden on other
> developers who might get interested in this feature in the future.
> 
> You might want to take
> https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com/
> as an inspiration.
> 

Alright, the suggestion makes a lot of sense and the patch introducing
documentation is the perfect place to justify the introduction of new
chunk format.

> 
> [1] Please remember the following snippet from SubmittingPatches:
>     "Try to make sure your explanation can be understood without
>     external resources. Instead of giving a URL to a mailing list
>     archive, summarize the relevant points of the discussion."
> 
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  .../technical/commit-graph-format.txt         | 28 +++++--
> >  Documentation/technical/commit-graph.txt      | 77 +++++++++++++++----
> >  2 files changed, 86 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> > index b3b58880b92..b6658eff188 100644
> > --- a/Documentation/technical/commit-graph-format.txt
> > +++ b/Documentation/technical/commit-graph-format.txt
> > @@ -4,11 +4,7 @@ Git commit graph format
> >  The Git commit graph stores a list of commit OIDs and some associated
> >  metadata, including:
> >  
> > -- The generation number of the commit. Commits with no parents have
> > -  generation number 1; commits with parents have generation number
> > -  one more than the maximum generation number of its parents. We
> > -  reserve zero as special, and can be used to mark a generation
> > -  number invalid or as "not computed".
> > +- The generation number of the commit.
> >  
> >  - The root tree OID.
> >  
> > @@ -86,13 +82,33 @@ CHUNK DATA:
> >        position. If there are more than two parents, the second value
> >        has its most-significant bit on and the other bits store an array
> >        position into the Extra Edge List chunk.
> > -    * The next 8 bytes store the generation number of the commit and
> > +    * The next 8 bytes store the topological level (generation number v1)
> > +      of the commit and
> >        the commit time in seconds since EPOCH. The generation number
> >        uses the higher 30 bits of the first 4 bytes, while the commit
> >        time uses the 32 bits of the second 4 bytes, along with the lowest
> >        2 bits of the lowest byte, storing the 33rd and 34th bit of the
> >        commit time.
> >  
> > +  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
> > +    * This list of 4-byte values store corrected commit date offsets for the
> > +      commits, arranged in the same order as commit data chunk.
> > +    * If the corrected commit date offset cannot be stored within 31 bits,
> > +      the value has its most-significant bit on and the other bits store
> > +      the position of corrected commit date into the Generation Data Overflow
> > +      chunk.
> > +    * Generation Data chunk is present only when commit-graph file is written
> > +      by compatible versions of Git and in case of split commit-graph chains,
> > +      the topmost layer also has Generation Data chunk.
> > +
> > +  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
> > +    * This list of 8-byte values stores the corrected commit date offsets
> > +      for commits with corrected commit date offsets that cannot be
> > +      stored within 31 bits.
> > +    * Generation Data Overflow chunk is present only when Generation Data
> > +      chunk is present and atleast one corrected commit date offset cannot
> > +      be stored within 31 bits.
> > +
> >    Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> >        This list of 4-byte values store the second through nth parents for
> >        all octopus merges. The second parent value in the commit data stores
> > diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> > index f14a7659aa8..f05e7bda1a9 100644
> > --- a/Documentation/technical/commit-graph.txt
> > +++ b/Documentation/technical/commit-graph.txt
> > @@ -38,14 +38,31 @@ A consumer may load the following info for a commit from the graph:
> >  
> >  Values 1-4 satisfy the requirements of parse_commit_gently().
> >  
> > -Define the "generation number" of a commit recursively as follows:
> > +There are two definitions of generation number:
> > +1. Corrected committer dates (generation number v2)
> > +2. Topological levels (generation nummber v1)
> >  
> > - * A commit with no parents (a root commit) has generation number one.
> > +Define "corrected committer date" of a commit recursively as follows:
> >  
> > - * A commit with at least one parent has generation number one more than
> > -   the largest generation number among its parents.
> > + * A commit with no parents (a root commit) has corrected committer date
> > +    equal to its committer date.
> >  
> > -Equivalently, the generation number of a commit A is one more than the
> > + * A commit with at least one parent has corrected committer date equal to
> > +    the maximum of its commiter date and one more than the largest corrected
> > +    committer date among its parents.
> > +
> > + * As a special case, a root commit with timestamp zero has corrected commit
> > +    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
> > +    (that is, an uncomputed corrected commit date).
> > +
> > +Define the "topological level" of a commit recursively as follows:
> > +
> > + * A commit with no parents (a root commit) has topological level of one.
> > +
> > + * A commit with at least one parent has topological level one more than
> > +   the largest topological level among its parents.
> > +
> > +Equivalently, the topological level of a commit A is one more than the
> >  length of a longest path from A to a root commit. The recursive definition
> >  is easier to use for computation and observing the following property:
> >  
> > @@ -60,6 +77,9 @@ is easier to use for computation and observing the following property:
> >      generation numbers, then we always expand the boundary commit with highest
> >      generation number and can easily detect the stopping condition.
> >  
> > +The property applies to both versions of generation number, that is both
> > +corrected committer dates and topological levels.
> > +
> >  This property can be used to significantly reduce the time it takes to
> >  walk commits and determine topological relationships. Without generation
> >  numbers, the general heuristic is the following:
> > @@ -67,7 +87,9 @@ numbers, the general heuristic is the following:
> >      If A and B are commits with commit time X and Y, respectively, and
> >      X < Y, then A _probably_ cannot reach B.
> >  
> > -This heuristic is currently used whenever the computation is allowed to
> > +In absence of corrected commit dates (for example, old versions of Git or
> > +mixed generation graph chains),
> > +this heuristic is currently used whenever the computation is allowed to
> >  violate topological relationships due to clock skew (such as "git log"
> >  with default order), but is not used when the topological order is
> >  required (such as merge base calculations, "git log --graph").
> > @@ -77,7 +99,7 @@ in the commit graph. We can treat these commits as having "infinite"
> >  generation number and walk until reaching commits with known generation
> >  number.
> >  
> > -We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
> > +We use the macro GENERATION_NUMBER_INFINITY to mark commits not
> >  in the commit-graph file. If a commit-graph file was written by a version
> >  of Git that did not compute generation numbers, then those commits will
> >  have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
> > @@ -93,12 +115,12 @@ fully-computed generation numbers. Using strict inequality may result in
> >  walking a few extra commits, but the simplicity in dealing with commits
> >  with generation number *_INFINITY or *_ZERO is valuable.
> >  
> > -We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
> > -generation numbers are computed to be at least this value. We limit at
> > -this value since it is the largest value that can be stored in the
> > -commit-graph file using the 30 bits available to generation numbers. This
> > -presents another case where a commit can have generation number equal to
> > -that of a parent.
> > +We use the macro GENERATION_NUMBER_V1_MAX = 0x3FFFFFFF for commits whose
> > +topological levels (generation number v1) are computed to be at least
> > +this value. We limit at this value since it is the largest value that
> > +can be stored in the commit-graph file using the 30 bits available
> > +to topological levels. This presents another case where a commit can
> > +have generation number equal to that of a parent.
> >  
> >  Design Details
> >  --------------
> > @@ -267,6 +289,35 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
> >  number of commits) could be extracted into config settings for full
> >  flexibility.
> >  
> > +## Handling Mixed Generation Number Chains
> > +
> > +With the introduction of generation number v2 and generation data chunk, the
> > +following scenario is possible:
> > +
> > +1. "New" Git writes a commit-graph with the corrected commit dates.
> > +2. "Old" Git writes a split commit-graph on top without corrected commit dates.
> > +
> > +A naive approach of using the newest available generation number from
> > +each layer would lead to violated expectations: the lower layer would
> > +use corrected commit dates which are much larger than the topological
> > +levels of the higher layer. For this reason, Git inspects the topmost
> > +layer to see if the layer is missing corrected commit dates. In such a case
> > +Git only uses topological level for generation numbers.
> > +
> > +When writing a new layer in split commit-graph, we write corrected commit
> > +dates if the topmost layer has corrected commit dates written. This
> > +guarantees that if a layer has corrected commit dates, all lower layers
> > +must have corrected commit dates as well.
> > +
> > +When merging layers, we do not consider whether the merged layers had corrected
> > +commit dates. Instead, the new layer will have corrected commit dates if the
> > +layer below the new layer has corrected commit dates.
> > +
> > +While writing or merging layers, if the new layer is the only layer, it will
> > +have corrected commit dates when written by compatible versions of Git. Thus,
> > +rewriting split commit-graph as a single file (`--split=replace`) creates a
> > +single layer with corrected commit dates.
> > +
> >  ## Deleting graph-{hash} files
> >  
> >  After a new tip file is written, some `graph-{hash}` files may no longer
> > -- 
> > gitgitgadget

Thanks
- Abhishek
