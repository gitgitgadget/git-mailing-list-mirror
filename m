Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E867C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 02:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjEJCan (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 22:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 22:30:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40165E72
        for <git@vger.kernel.org>; Tue,  9 May 2023 19:30:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba1815e12efso5776088276.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683685837; x=1686277837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW7VMjFcTnsyZYUqgd2VmiTAhuavbqsyC+VprDXUhTQ=;
        b=NRbxtItazE3IVvq/hCTLcnOB/DI4M8BRfDjuXtOu4GKDp3tKyL2ZPAIC2zJ3WNvxRt
         a9+phGOvmoPT8SoikyFLbLvx19EyoP6dBV7XGLua4FEI/F8R3dUiRjz3ZPtOMJx7RLqq
         yWFishg/hf3LeRe/8u+pLBGsW+odtv0kpD5KrsYRekSx5IBesumMTEnQASqvzdiMyKB3
         ZOpEhAWVJA38MTKczDgjV51lbMbSYfwSnaRfSOzJJOPeiJZkuMGR04fidv4FU2NdNAKL
         NORWfOCcuI1QF6pUEEUBK8WtrcGx4uwCUe8/+Sl4miQ9dKQmFsTlEF4eJqcZ35d/jzqW
         0xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685837; x=1686277837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW7VMjFcTnsyZYUqgd2VmiTAhuavbqsyC+VprDXUhTQ=;
        b=Bj7vQdYKeBZp55cLKyTXmJUHsfV0a0G41cJRhjfC2JOShw6i7iH21TGplndnAzFQ4z
         n6tdjti6JD2v8+0cZFEhGJQKjGFO3LDEKdpHbFdXVWuwq2GJDmR+WeANI/HALDpxVwtU
         dy+xLVDoIiKlM6hNkligXOSJeHExWNx5y/1Mdu3fzobabGx7+juy/nSVdbU/0VezW4eE
         YQWJ3AQy1CZsDfQL9g8baOIHMclCk7hEu97MmIr0sPtZZT6YObHO04TnJDE/75k0aifI
         Fi6uyDg2iCCSmjfOO5REhK1Rx88aUjQpCdf3FuI4XNpV7e07VC6/lUtcqP1Tu2WJ23uW
         B1Tg==
X-Gm-Message-State: AC+VfDxtoP7l9q67fsxxVrfnRvBS0nvk1V3JzQea+AfH6YpG52DCVu1W
        GiEKn7dSjtDrOILJowcbVylw2A==
X-Google-Smtp-Source: ACHHUZ6tDAaPFkwJr5CjejoP6mEaW3BZ49psBMmqD4TgbKbyLva0yghBjewhsq3VmzAJ7eXGXb5cmg==
X-Received: by 2002:a25:50d3:0:b0:ba6:1b1f:5d3f with SMTP id e202-20020a2550d3000000b00ba61b1f5d3fmr2819167ybb.51.1683685837342;
        Tue, 09 May 2023 19:30:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j128-20020a255586000000b00b923b2935d9sm3445979ybb.20.2023.05.09.19.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 19:30:36 -0700 (PDT)
Date:   Tue, 9 May 2023 22:30:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFsBy6BacQNJ6LCo@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
 <xmqqh6slt6nx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6slt6nx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 04:40:50PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When iterating through the `packed-refs` file in order to answer a query
> > like:
> >
> >     $ git for-each-ref --exclude=refs/__hidden__
> >
> > it would be useful to avoid walking over all of the entries in
> > `refs/__hidden__/*` when possible, since we know that the ref-filter
> > code is going to throw them away anyways.
> >
> > In certain circumstances, doing so is possible. The algorithm for doing
> > so is as follows:
> >
> >   - For each excluded pattern, find the first record that matches it,
> >     and the first pattern that *doesn't* match it (i.e. the location
> >     you'd next want to consider when excluding that pattern).
>
> Do we find "record" and then "pattern", or is the latter a misspelt
> "record"?  I will assume it is the latter while reading the rest.
> Is the latter "the record that does not match the pattern, whose
> record number is the smallest but yet larger than the first record
> that matches the pattern?"  That is we assume that the refs in the
> packed refs file are sorted and can be partitioned into three by
> each pattern: (1) refs before the first matching record---they do
> not match the pattern. (2) refs at or after the first matching
> record that match.  (3) refs after (2) that do not match.
>
> I am not sure if that would work.  What if the pattern were refs/tags/[ad-z]*
> and there are packed tags refs/tags/{a,b,c,d,e}?  The pattern would partition
> the refs into [a](matches), [b,c](does not match), [d,e](matches).
>
> Perhaps I am grossly misunderstanding what the above explanation
> says.

Sorry, you're right to assume the latter. This should read "..., find
the record that matches it, and the first record that *doesn't* match."

In the example you give, we would ignore that whole pattern and
enumerate everything (including entries that match 'refs/tags/[ad-z]*'),
and the caller is expected to discard them.

> >   - Sort the patterns by their starting location within the
> >     `packed-refs` file.
>
> So the idea is that the patterns are sorted by the first record they
> match, and after sorting these patterns, refs that are between the
> beginning of the list of refs and the first record associated with
> the first pattern will not match _any_ pattern in that list?

My patch could use some clarification here, since it is much easier to
treat the patterns as unsorted, and then sort the beginning of the range
that they match.

> >   - Construct a skip list of regions by combining adjacent and
> >     overlapping regions from the previous step.
>
> "skip list of regions" -> "list of regions to skip", I guess.

Thanks, will update.

> > Using the skip list is fairly straightforward (see the changes to
> > `refs/packed-backend.c::next_record()`), but constructing the list is
> > not. To ensure that the construction is correct, add a new suite of
> > tests in t1419 covering various corner cases (overlapping regions,
> > partially overlapping regions, adjacent regions, etc.).
>
> Sounds good.  Does this actually use the skip list data structure,
> or do they happen to share the same two words in their names, but
> otherwise have nothing common with each other?  If the latter, we
> may want to revise the explanation, data type names, and variable
> names, to avoid confusion, as Chris pointed out earlier.

They have nothing to do with each other ;-). I made a note in this patch
in the revised version I'll send in the next day or two to note the
distinction. But I'm fine with renaming the whole concept to "jump list"
or something like that if you prefer.

> > +	for (pattern = excluded_patterns; *pattern; pattern++) {
> > +		struct skip_list_entry *e;
> > +
> > +		/*
> > +		 * We can't feed any excludes with globs in them to the
> > +		 * refs machinery.  It only understands prefix matching.
> > +		 * We likewise can't even feed the string leading up to
> > +		 * the first meta-character, as something like "foo[a]"
> > +		 * should not exclude "foobar" (but the prefix "foo"
> > +		 * would match that and mark it for exclusion).
> > +		 */
> > +		if (has_glob_special(*pattern))
> > +			continue;
>
> Hmph.  I would have expected that a set of patterns with any one
> pattern with glob would invalidate the whole skip optimization, but
> it is nice if we can salvage such a set and still optimize, if only
> for literal patterns.  Interesting.
>
> Ah, that is because we are dealing with ranges that cannot possibly
> match.  With the mention of "first record that matches" etc. in the
> earlier descriptoin, I somehow misled myself that we are dealing
> with ranges that have interesting records.  So, a pattern with glob
> does not contribute any range to be skipped, but that is OK.

Exactly right. This is all "best effort" anyway, since there are some
patterns that we cannot construct a skip list entry for in the general
case. So it's fine if we enumerate some references that match one or
more of the excluded patterns, because the caller is expected to drop
those results themselves.

> > +	/*
> > +	 * As an optimization, merge adjacent entries in the skip list
> > +	 * to jump forwards as far as possible when entering a skipped
> > +	 * region.
> > +	 *
> > +	 * For example, if we have two skipped regions:
> > +	 *
> > +	 *	[[A, B], [B, C]]
>
> I am confused.  The first pattern may never match records in [A..B]
> range, and the second pattern may never match records in [B..C]
> range, but what does it mean to combine these two ranges?

The patterns would match all records in their respective regions, but
since they are excluded we want to jump over those references instead of
iterating (and then discarding them later).

So if we have a jump from A->B, and another from B->C, it would be fine
to perform two jumps to get from A to C. But we can detect this case by
combining adjacent/overlapping regions.

> > +		if (ours->start == ours->end) {
> > +			/* ignore empty regions (no matching entries) */
> > +			continue;
> > +		} else if (prev->end >= ours->start) {
> > +			/* overlapping regions extend the previous one */
> > +			prev->end = ptr_max(prev->end, ours->end);
> > +		} else {
> > +			/* otherwise, insert a new region */
> > +			iter->skip[j++] = *ours;
> > +		}
>
> None of the {braces} seem needed, but OK.

Yeah. I added the braces here intentionally to match the
CodingGuidelines, which state that this case is an exception.

Thanks,
Taylor
