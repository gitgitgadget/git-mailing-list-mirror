Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1CFC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 23:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjEIXky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 19:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIXkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 19:40:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB92690
        for <git@vger.kernel.org>; Tue,  9 May 2023 16:40:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso7074794b3a.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683675651; x=1686267651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15bm2G289wycZ7LH0S4NwYEoIcB7jJxLHWERDKU6jaI=;
        b=MpKUHvSuBiRl8u4JeS6uTFgENdhlIkBY0tSUQTLjXvx9BM+hFOCppbxzRy3zXH+hVd
         90/E+kSa+iSTWCanMituyI2zLFTcNZPR7s9WVfuSw05IoopYc2fOSgZ4hqcDtOVN58hY
         nzvUhc63VWQ7K/yrBAMtcuhTD2BvEUAbzYcxEDJ6bbgbgC/19p5iDMZtfg2CDxG32VK3
         7NuBZI6RxqOKSAa81i4VJDNQaxF5GCQNYfQ0ZEGd1dneprWwt+GFkRzcT2TOYMW9Ikcs
         IEa8mRaC8EyYSR1wsMniP2Pui+roSLvXTvVDJi7Ovm3WDLTszbMW6mJ3uzgxkDwUSO37
         Po5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683675651; x=1686267651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15bm2G289wycZ7LH0S4NwYEoIcB7jJxLHWERDKU6jaI=;
        b=PFGYeeJ8DA+iVH/AW8Fv4ziMe81vYFhvxQdFlsKJetz44vXUnvGxOS+JIaxcIDwiWw
         +tIZGkAxg1FGtunbqKDeunNBrGFuwZ2rX0RPXIRiNcayyEMUHd1Wqt+MuN8a0wdvX7hg
         1xNFg4e/rRTf4DBozciyLl90yhp1W3eoBxzDq4XG5m9z5KiKpvsmTa+X8EJBN+FE1kNp
         sxKKOHx2xgKTjw+h1MTnt5LUhdfI9fR4b7aaIqrE/Q8Im59zZBtfnjLjoZkji+ZrANZd
         kVe1A/3J1BubzZobNrqb4pSRsVW3oL1Y4wpIXsDVhyw8yn42Knalhhgi8UlWUsuJAb/b
         vbhw==
X-Gm-Message-State: AC+VfDybAlZYzfHmN8tJxJr0MgAO62+OayCE8+Mpgrgrg7G//TrwFcUu
        AwkGyh+9RoLXgMhjb1y1MInr/WnR2vM=
X-Google-Smtp-Source: ACHHUZ5v7li4GPCDPxxPLi1Q4ReHIa2bCGjEiWfN8iAu64vHslPVIfKYKMQuhC0mCVhSE0CK5b9t4Q==
X-Received: by 2002:a05:6a00:234f:b0:643:59cd:6cad with SMTP id j15-20020a056a00234f00b0064359cd6cadmr19149925pfj.24.1683675650887;
        Tue, 09 May 2023 16:40:50 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j16-20020aa78010000000b00643910fe7d5sm2328310pfi.76.2023.05.09.16.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 16:40:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
References: <cover.1683581621.git.me@ttaylorr.com>
        <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
Date:   Tue, 09 May 2023 16:40:50 -0700
In-Reply-To: <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 8 May 2023 18:00:08 -0400")
Message-ID: <xmqqh6slt6nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When iterating through the `packed-refs` file in order to answer a query
> like:
>
>     $ git for-each-ref --exclude=refs/__hidden__
>
> it would be useful to avoid walking over all of the entries in
> `refs/__hidden__/*` when possible, since we know that the ref-filter
> code is going to throw them away anyways.
>
> In certain circumstances, doing so is possible. The algorithm for doing
> so is as follows:
>
>   - For each excluded pattern, find the first record that matches it,
>     and the first pattern that *doesn't* match it (i.e. the location
>     you'd next want to consider when excluding that pattern).

Do we find "record" and then "pattern", or is the latter a misspelt
"record"?  I will assume it is the latter while reading the rest.
Is the latter "the record that does not match the pattern, whose
record number is the smallest but yet larger than the first record
that matches the pattern?"  That is we assume that the refs in the
packed refs file are sorted and can be partitioned into three by
each pattern: (1) refs before the first matching record---they do
not match the pattern. (2) refs at or after the first matching
record that match.  (3) refs after (2) that do not match.

I am not sure if that would work.  What if the pattern were refs/tags/[ad-z]*
and there are packed tags refs/tags/{a,b,c,d,e}?  The pattern would partition
the refs into [a](matches), [b,c](does not match), [d,e](matches).

Perhaps I am grossly misunderstanding what the above explanation
says.

>   - Sort the patterns by their starting location within the
>     `packed-refs` file.

So the idea is that the patterns are sorted by the first record they
match, and after sorting these patterns, refs that are between the
beginning of the list of refs and the first record associated with
the first pattern will not match _any_ pattern in that list?

>   - Construct a skip list of regions by combining adjacent and
>     overlapping regions from the previous step.

"skip list of regions" -> "list of regions to skip", I guess.

>   - When iterating through the `packed-refs` file, if `iter->pos` is
>     ever contained in one of the regions from the previous steps,
>     advance `iter->pos` past the end of that region, and continue
>     enumeration.
>
> Note that this optimization is only possible when none of the excluded
> pattern(s) have special meta-characters in them.

Ah, so this is called "patterns" but it deals with literal patterns
without globs?  Then I'll stop worrying about the refs/tags/[ad-z]
counter-example.

> To see why this is the
> case, consider the exclusion pattern "refs/foo[a]". In general, in order
> to find the location of the first record that matches this pattern, we
> could only consider up to the first meta-character, "refs/foo". But this
> doesn't work, since the excluded region we'd come up with would include
> "refs/foobar", even though it is not excluded.

OK.

> Using the skip list is fairly straightforward (see the changes to
> `refs/packed-backend.c::next_record()`), but constructing the list is
> not. To ensure that the construction is correct, add a new suite of
> tests in t1419 covering various corner cases (overlapping regions,
> partially overlapping regions, adjacent regions, etc.).

Sounds good.  Does this actually use the skip list data structure,
or do they happen to share the same two words in their names, but
otherwise have nothing common with each other?  If the latter, we
may want to revise the explanation, data type names, and variable
names, to avoid confusion, as Chris pointed out earlier.

> +static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
> +					struct snapshot *snapshot,
> +					const char **excluded_patterns)
> +{
> +	size_t i, j;
> +	const char **pattern;
> +
> +	if (!excluded_patterns)
> +		return;
> +
> +	for (pattern = excluded_patterns; *pattern; pattern++) {
> +		struct skip_list_entry *e;
> +
> +		/*
> +		 * We can't feed any excludes with globs in them to the
> +		 * refs machinery.  It only understands prefix matching.
> +		 * We likewise can't even feed the string leading up to
> +		 * the first meta-character, as something like "foo[a]"
> +		 * should not exclude "foobar" (but the prefix "foo"
> +		 * would match that and mark it for exclusion).
> +		 */
> +		if (has_glob_special(*pattern))
> +			continue;

Hmph.  I would have expected that a set of patterns with any one
pattern with glob would invalidate the whole skip optimization, but
it is nice if we can salvage such a set and still optimize, if only
for literal patterns.  Interesting.

Ah, that is because we are dealing with ranges that cannot possibly
match.  With the mention of "first record that matches" etc. in the
earlier descriptoin, I somehow misled myself that we are dealing
with ranges that have interesting records.  So, a pattern with glob
does not contribute any range to be skipped, but that is OK.

> +		ALLOC_GROW(iter->skip, iter->skip_nr + 1, iter->skip_alloc);
> +
> +		e = &iter->skip[iter->skip_nr++];
> +		e->start = find_reference_location(snapshot, *pattern, 0);
> +		e->end = find_reference_location_end(snapshot, *pattern, 0);

So, iter->skip[] array has one range per pattern at most, but some
patterns may not contribute any range to the list.

> +	}
> +
> +	if (!iter->skip_nr) {
> +		/*
> +		 * Every entry in exclude_patterns has a meta-character,
> +		 * nothing to do here.
> +		 */
> +		return;
> +	}
> +
> +	QSORT(iter->skip, iter->skip_nr, skip_list_entry_cmp);
> +
> +	/*
> +	 * As an optimization, merge adjacent entries in the skip list
> +	 * to jump forwards as far as possible when entering a skipped
> +	 * region.
> +	 *
> +	 * For example, if we have two skipped regions:
> +	 *
> +	 *	[[A, B], [B, C]]

I am confused.  The first pattern may never match records in [A..B]
range, and the second pattern may never match records in [B..C]
range, but what does it mean to combine these two ranges?

> +	 * we want to combine that into a single entry jumping from A to
> +	 * C.
> +	 */
> +	for (i = 1, j = 1; i < iter->skip_nr; i++) {
> +		struct skip_list_entry *ours = &iter->skip[i];
> +		struct skip_list_entry *prev = &iter->skip[i - 1];


> +		if (ours->start == ours->end) {
> +			/* ignore empty regions (no matching entries) */
> +			continue;
> +		} else if (prev->end >= ours->start) {
> +			/* overlapping regions extend the previous one */
> +			prev->end = ptr_max(prev->end, ours->end);
> +		} else {
> +			/* otherwise, insert a new region */
> +			iter->skip[j++] = *ours;
> +		}

None of the {braces} seem needed, but OK.  

> +	}
> +
> +	iter->skip_nr = j;
> +	iter->skip_pos = 0;
> +}
