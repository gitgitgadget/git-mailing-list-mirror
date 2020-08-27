Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F13C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 06:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737722BEA
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8CtVyxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgH0GmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH0GmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 02:42:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE0C061264
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 23:42:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so2727959pfn.5
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XJwwIa4iU2xofQkWHLToZWCk0wDp4gHWeFcUVN0MT9g=;
        b=r8CtVyxgr0+Z2uKWzCC5MZYeeK/8fluAGGryDDdHUfqCZuNMo1u3SoSaNUjLNXNVmF
         UzX22MvP6NP2sL2UDHzHYvyaRLG/MoYw06gLrK0xNqBZjndUt7VT4KMUEzYwKYno73sG
         LroRl4VDKa8jcNgUGkjtCRTg0Yj8PyJ9Nw6NhNkAvia2hSBbI08+vSc3iPE3iHmaJ5os
         QOwFZbN422hWUZo5wSvoig+1PXvUKkuenXhRb6JEolH97D5iubaq5q7qAz1SDm/ieXbu
         pq3P8MrKJYSQhaqMGQVaJ4J1w0q8dCld2fcgIuEP2AkS39zCKypc44PHtQxbJ47b6sbA
         Hs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XJwwIa4iU2xofQkWHLToZWCk0wDp4gHWeFcUVN0MT9g=;
        b=braaIHL/8LRuwi5fpifMMWAA0yj4rPNqTtM3HftiI6G+MAWHCVk7UrUIQ+QhB8+j+b
         t9zlw6IBBUqjbE8nrkWFs4kWWC240XsW/bvdkGCEqPLd+Q+tutpSxlygbVoYHqzbFEk9
         RqB0XbQkP2Z9dfrEqH4hqZ2ER7ZDJ3XOW88HrEI74gb3YFkMJjYnhCG2CbLf7mZ4RQoS
         BH3FYr6mpO3pfUO+Dm0o45YcvKF9pa+SZs24Dru5Sb2fUk5pcYQzSAWx0R1cUINSBEGK
         F3LZW3+9q+Rpnk67RS03fmDaw9DF0oyPXPrk1flgdaV/Zsz9sIPAOcl+/X/K39+ib1DX
         zQPA==
X-Gm-Message-State: AOAM532cRnA1umxAS9IcZt9q9nFdWsCJi3c1HL83qXo+kTyMLe37ttwJ
        YUo8YwwuHKfB64/zdzjszZA=
X-Google-Smtp-Source: ABdhPJzi1fO/b8k5vm1Z6XCUGT7HdMXcFab26YWG2uZjLtgmC+gX8MaZ/A44NAW7Cc2VqFskn0TmcA==
X-Received: by 2002:a62:33c2:: with SMTP id z185mr15141098pfz.242.1598510534039;
        Wed, 26 Aug 2020 23:42:14 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e90:8941:4a7e:15a9:3e69:e2d0])
        by smtp.gmail.com with ESMTPSA id r28sm1367895pfg.158.2020.08.26.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:42:13 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:09:51 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v3 11/11] doc: add corrected commit date info
Message-ID: <20200827063951.GA16268@Abhishek-Arch>
Reply-To: 85y2m6fhkm.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
 <85y2m6fhkm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85y2m6fhkm.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 23, 2020 at 12:20:57AM +0200, Jakub Narębski wrote:
> Hello,
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With generation data chunk and corrected commit dates implemented, let's
> > update the technical documentation for commit-graph.
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> All right.
> 
> > ---
> >  .../technical/commit-graph-format.txt         | 12 ++---
> >  Documentation/technical/commit-graph.txt      | 45 ++++++++++++-------
> >  2 files changed, 36 insertions(+), 21 deletions(-)
> >
> > diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> > index 440541045d..71c43884ec 100644
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
> 
> All right, that was duplicated information.  Now that we need to talk
> about two of them, it would not make sense to duplicate that.
> 
> >
> >  - The root tree OID.
> >
> > @@ -88,6 +84,12 @@ CHUNK DATA:
> 
> Shouldn't we also replace 'generation number' occurences in description
> of the Commit Data (CDAT) chunk with either 'topological level' or
> 'generation number v1'?

Yes, we should.

> 
> >        2 bits of the lowest byte, storing the 33rd and 34th bit of the
> >        commit time.
> >
> > +  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
> 
> It is not exactly 'optional', as it implies that we need to turn it on
> (or that we can turn it off).  It is more 'conditional', as it can be
> not present due to outside influences (mixed-version environment).
> 
> > +    * This list of 4-byte values store corrected commit date offsets for the
> > +      commits, arranged in the same order as commit data chunk.
> 
> I have just realized purely theoretical, but possible, problem with
> storing non-monotinic generation number related values like corrected
> commit date offset in constrained space.  There are problems with
> clamping them.
> 
> Say that somewhere in the ancestry chain there is a commit A with commit
> date far in the future by mistake, for example 2120-08-22; it is
> important for that date to be not able to be represented using uint32_t.
> Say that a later descendant commit B is malformed, and has committer
> date of 0, that is 1970-01-01. This means that the corrected commit date
> for B must be larger than 2120-08-22 - which for this commit means that
> corrected commit date offset do not fit in 32 bits, and must be clamped
> (replaced) with GENERATION_NUMBER_V2_OFFSET_MAX.
> 
> Say that we have commit C that is child of B, and it has correct commit
> date.  Because of mistake in commit A, it has corrected commit date of
> more than 2120-08-22 (corrected commit date degenerated into topological
> level plus constant).
> 
> Now C can reach B, and B can reach A.  However, if we recover corrected
> commit date of B out of its date=0 and offset=GENERATION_NUMBER_V2_OFFSET_MAX
> we get a number that is smaller than correct corrected commit date.  We
> will have
> 
>    gen(A) > date(B) + offset(B) < gen(C)
> 
> Which breaks reachability condition guarantee.
> 
> If instead we use GENERATION_NUMBER_V2_MAX for commits with clamped
> corrected commit date, that is offset=GENERATION_NUMBER_V2_OFFSET_MAX,
> we would get
> 
>   gen(A) < GENERATION_NUMBER_V2_MAX > gen(C)
> 
> And again reachability condition is broken.
> 
> This is a very contrived but possible example.  This shouldn't happen,
> but ufortunately it can happen.
> 

Yes, that's very unfortunate. 

Here's a much simpler example:

A commit P has an reasonable commit date (i.e. after release of Git to
present) D and has a child commit C with committer date 0. Now, the 
corrected commiter date of C would D + 1 and the offset would be same too,
as the committer date is zero. This overflows as reasonable dates are of
the order 2 ^ 34.

> 
> The question is how to deal with this issue.  Ignore it as unlikely?
> Switch to storing corrected commit date, which is monotonic, so if there
> is commit with GENERATION_NUMBER_V2_MAX, then subsequent descendant
> commits will also have GENERATION_NUMBER_V2_MAX -- and pay with up to 7%
> larger commit-graph file?
> 

To be honest, I would prefer storing corrected committer dates over
storing offsets.

While it is 7% of the size of commit-graph file, it is also *only* around
~3.5 MB for a repository of the size of linux kernel (and IIRC
correctly, the Windows repo has ~2M commits, it amounts to ~8 MB).

Minimizing space and memory requirements are a top priority, but
shouldn't making sure our program is correct and efficient to be a
greater priority?

I would love to hear your and Dr. Stolee's opinions on this.

> > +    * This list can be later modified to store future generation number related
> > +      data.
> 
> How can it be later modified?  There is no header, no version number.
> How would we add another generation number data?
> 

We could modify the graph version in future. Here's how I think it would
work:

Graph Version 1, No GDAT -> Topological level
Graph Version 2, GDAT    -> Corrected committer dates
Graph Version 3, GDAT    -> Generation number v3

and so on.

Of course, we do not have to update generation number definition for
each graph version.

However, my statement could still be wrong for things that we do not
foresee (similar to how we missed the hard die on different graph version),
so I am removing the statement.

> > +
> >    Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> >        This list of 4-byte values store the second through nth parents for
> >        all octopus merges. The second parent value in the commit data stores
> > diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> > index 808fa30b99..f27145328c 100644
> > --- a/Documentation/technical/commit-graph.txt
> > +++ b/Documentation/technical/commit-graph.txt
> > @@ -38,14 +38,27 @@ A consumer may load the following info for a commit from the graph:
> >
> >  Values 1-4 satisfy the requirements of parse_commit_gently().
> >
> > -Define the "generation number" of a commit recursively as follows:
> > +There are two definitions of generation number:
> > +1. Corrected committer dates
> > +2. Topological levels
> 
> Should we add versioning info, that is:
> 
>   +1. Corrected committer dates  (generation number v2)
>   +2. Topological levels  (generation number v1)
> 

Yes, added.

> > +
> > +Define "corrected committer date" of a commit recursively as follows:
> > +
> > +  * A commit with no parents (a root commit) has corrected committer date
> > +    equal to its committer date.
> > +
> > +  * A commit with at least one parent has corrected committer date equal to
> > +    the maximum of its commiter date and one more than the largest corrected
> > +    committer date among its parents.
> > +
> > +Define the "topological level" of a commit recursively as follows:
> >
> >   * A commit with no parents (a root commit) has generation number one.
> 
> Shouldn't this be
> 
>     * A commit with no parents (a root commit) has topological level of one.
> 

Thanks, fixed!

> >
> > - * A commit with at least one parent has generation number one more than
> > -   the largest generation number among its parents.
> > + * A commit with at least one parent has topological level one more than
> > +   the largest topological level among its parents.
> >
> > -Equivalently, the generation number of a commit A is one more than the
> > +Equivalently, the topological level of a commit A is one more than the
> >  length of a longest path from A to a root commit. The recursive definition
> >  is easier to use for computation and observing the following property:
> 
> We should probably explicitly state that the property state applies to
> both versions of generation number, not only to topological level.
> 
> >
> > @@ -67,17 +80,12 @@ numbers, the general heuristic is the following:
> >      If A and B are commits with commit time X and Y, respectively, and
> >      X < Y, then A _probably_ cannot reach B.
> >
> > -This heuristic is currently used whenever the computation is allowed to
> > -violate topological relationships due to clock skew (such as "git log"
> > -with default order), but is not used when the topological order is
> > -required (such as merge base calculations, "git log --graph").
> > -
> 
> To be overly pedantic, this heuristic is still used, but now in much
> more rare case.  In addition to what is stated above, at least one layer
> in the split commit-graph chain must have been generated by "Old" Git,
> for the date heuristic to be used.
> 
> But that might be unnecessary level of detail.
> 
> >  In practice, we expect some commits to be created recently and not stored
> >  in the commit graph. We can treat these commits as having "infinite"
> >  generation number and walk until reaching commits with known generation
> >  number.
> >
> > -We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
> > +We use the macro GENERATION_NUMBER_INFINITY to mark commits not
> 
> All right.
> 
> >  in the commit-graph file. If a commit-graph file was written by a version
> >  of Git that did not compute generation numbers, then those commits will
> >  have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
> > @@ -93,12 +101,11 @@ fully-computed generation numbers. Using strict inequality may result in
> >  walking a few extra commits, but the simplicity in dealing with commits
> >  with generation number *_INFINITY or *_ZERO is valuable.
> >
> > -We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
> > -generation numbers are computed to be at least this value. We limit at
> > -this value since it is the largest value that can be stored in the
> > -commit-graph file using the 30 bits available to generation numbers. This
> > -presents another case where a commit can have generation number equal to
> > -that of a parent.
> > +We use the macro GENERATION_NUMBER_MAX for commits whose generation numbers
> > +are computed to be at least this value. We limit at this value since it is
> > +the largest value that can be stored in the commit-graph file using the
> > +available to generation numbers. This presents another case where a
> > +commit can have generation number equal to that of a parent.
> 
> All right, though it could have been done without re-wrapping, so that
> only first line would be marked as changed.
> 
> As I wrote, there is theoretical problem with this for offsets.
> 
> >
> >  Design Details
> >  --------------
> > @@ -267,6 +274,12 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
> >  number of commits) could be extracted into config settings for full
> >  flexibility.
> >
> > +We also merge commit-graph chains when we try to write a commit graph with
> > +two different generation number definitions as they cannot be compared directly.
> > +We overwrite the existing chain and create a commit-graph with the newer or more
> > +efficient defintion. For example, overwriting topological levels commit graph
> > +chain to create a corrected commit dates commit graph chain.
> > +
> 
> This is more complicated than that.
> 
> I think we should explicitly state that Git ensures that in split
> commit-graph chain, if there are layers without the GDAT chunk (that
> force Git to use topological levels for generation numbers), then they
> are top layers.  So if there is commit-graph file created by "Old" Git,
> then when addig new layer it would also be GDAT-less.
> 
> Now how to write this...

Thinking about this, I feel creating a new section called "Handling
Mixed Generation Number Chains" made more sense:

  ## Handling Mixed Generation Number Chains

  With the introduction of generation number v2 and generation data chunk,
  the following scenario is possible:

  1. "New" Git writes a commit-graph with a GDAT chunk.
  2. "Old" Git writes a split commit-graph on top without a GDAT chunk.

  The commits in the lower layer will be interpreted as having very large
  generation values (commit date plus offset) compared to the generation
  numbers in the top layer (toplogical level). This violates the
  expectation that the generation of a parent is strictly smaller than the
  generation of a child. In such cases, we revert to using topological
  levels for all layers to maintain backwards compatability.

  When writing a new layer in split commit-graph, we write a GDAT chunk
  only if the topmost layer has a GDAT chunk. This guarantees that if a
  lyer has GDAT chunk, all lower layers must have a GDAT chunk as well.

  Rewriting layers follows similar approach: if the topmost layer below
  set of layers being rewriteen (in the split commit-graph chain) exists,
  and it does not contain GDAT chunk, then the result of rewrite does not
  have GDAT chunks either.

> 
> >  ## Deleting graph-{hash} files
> >
> >  After a new tip file is written, some `graph-{hash}` files may no longer
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
