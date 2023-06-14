Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF09EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 00:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjFNA1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFNA1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 20:27:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394F1739
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:27:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso4803462b3a.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702426; x=1689294426;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIkik7XUCZTf3W9HGUnKrlKgKMqXGy6qiinNNoGiwRs=;
        b=OooQ5Ctp3rcc8rb1VYrgLMISS48LDNXooNIbEY2jIORCmI4r8odHBAwFXwHvyeAYjF
         HFJRFzNB2Ato3BnJe7rERdie6PCsemDFQqVHRMuI/yovbvkzFjSEuGVdkxGrh28syze2
         /KTmNyK4CORhmse9M9+tmeNmk8BOA8ZxicKnDgbMGaqrGa2Ldjtq9c24vmUGt8qqIQLj
         SqqNcV6jsrSJkUpBLV1tv5FTBNezjo1qMVgQCNTT5wPGmLIJ2LYY+pfCsZaTYbwQTHgp
         iPQMbA+18VxA/F6yvwxcFdDrJ2Kdv2PP4I2zYInKj8BjCeaAMN8A9IG00u7uafNgaaFt
         QsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702426; x=1689294426;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FIkik7XUCZTf3W9HGUnKrlKgKMqXGy6qiinNNoGiwRs=;
        b=UCCGkOrloq+cZWSFYmMHZ5Byu26+gR4a7j0Hs6LcsoxkJsX52fFgLIXOcUtSlqMLWl
         24MwDN2U38fXOpuVkNGNnKuQNCJKzYoERRHVYusjhvSQFPSw56oZY4Bfbtzr/HPlQMlF
         gfpd6O0sqlHwGLOHgGbGUIzQUZw/A3HLIwNasc2yzPQiR475/ZYEzb5kBgWQ27FUKZSO
         arRvSdhZizy4kCmREVQ4/DHDWtx5DeyHs97qLZ/kSrlvEptnI8xjkekEJI+UVqhrdXrc
         +Hmfjg4kVdQi4SrWFNHH/9okceHbFCxUEXz8B8KiVMpFeQAq1Rcgk6adUA2thuC3+/Il
         Isuw==
X-Gm-Message-State: AC+VfDx8wucegHX/+nZL7+TDleAy78mgwbwQfOjYIZrdDFwt2No7A775
        16JzUm7q7EHEUSCNl3QcYwk=
X-Google-Smtp-Source: ACHHUZ7JlReTyAS7YHsGrSetUab9Z+WZQlJIcygZwG35DiPT/x99v/GNzO8U0QTO+jOfepj+sK/Kew==
X-Received: by 2002:a05:6a20:9592:b0:11d:bc14:85a9 with SMTP id iu18-20020a056a20959200b0011dbc1485a9mr102393pzb.37.1686702425822;
        Tue, 13 Jun 2023 17:27:05 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7824f000000b0063b96574b8bsm9054443pfn.220.2023.06.13.17.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:27:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <8066858bf59386eeec68f0f1e4247eeebb6482f7.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 17:27:05 -0700
In-Reply-To: <8066858bf59386eeec68f0f1e4247eeebb6482f7.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:41:33 -0400")
Message-ID: <xmqq352u3n3a.fsf@gitster.g>
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
>     and the first record that *doesn't* match it (i.e. the location
>     you'd next want to consider when excluding that pattern).
>
>   - Sort the set of excluded regions from the previous step in ascending
>     order of the first location within the `packed-refs` file that
>     matches.
>
>   - Clean up the results from the previous step: discard empty regions,
>     and combine adjacent regions.

Say something like

   The resulting list of regions that would never contain refs that
   are not excluded is called the "jump list".

here, probably.  Otherwise the first reference to "jump list" we see
later feels a bit too abrupt.

> Then when iterating through the `packed-refs` file, if `iter->pos` is
> ever contained in one of the regions from the previous steps, advance
> `iter->pos` past the end of that region, and continue enumeration.
>
> Note that we only perform this optimization when none of the excluded
> pattern(s) have special meta-characters in them. For a pattern like
> "refs/foo[ac]", the excluded regions ("refs/fooa", "refs/fooc", and
> everything underneath them) are not connected. A future implementation
> that handles this case may split the character class (pretending as if
> two patterns were excluded: "refs/fooa", and "refs/fooc").

Makes sense.

> There are a few other gotchas worth considering. First, note that the
> jump list is sorted, so once we jump past a region, we can avoid
> considering it (or any regions preceding it) again. The member
> `jump_pos` is used to track the first next-possible region to jump
> through.
>
> Second, note that the exclusion list is best-effort, since we do not
> handle loose references, and because of the meta-character issue above.

I found this a bit misleading; a natural reading of "exclusion list"
is that the phrase refers to the list of exclude patterns given from
the command line, and users would be upset if the processing of it
is best effort.

I think what you meant to say was that optimization to avoid full
scan using the jump list does not aim for perfection, and entries
that are not skipped using the jump list may still be excluded by
the exclude patterns.

> In repositories with a large number of hidden references, the speed-up

"hidden" -> "excluded".  Your final objective to implement the
feature to exclude refs using patterns and optimize it using the
jump list data may be to implement "hidden references", but that
hasn't be talked about in the above.  All we have been hearing was
that we are optimizing the walk over packed-refs using exclude
patterns.

> can be significant. Tests here are done with a copy of linux.git with a
> reference "refs/pull/N" pointing at every commit, as in:
> ...
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c              |   5 +-
>  refs/packed-backend.c     | 166 ++++++++++++++++++++++++++++++++++++--
>  t/helper/test-ref-store.c |  10 +++
>  t/t1419-exclude-refs.sh   | 101 +++++++++++++++++++++++
>  4 files changed, 274 insertions(+), 8 deletions(-)
>  create mode 100755 t/t1419-exclude-refs.sh

Nice.

> @@ -785,6 +802,13 @@ struct packed_ref_iterator {
>  	/* The end of the part of the buffer that will be iterated over: */
>  	const char *eof;
>  
> +	struct jump_list_entry {
> +		const char *start;
> +		const char *end;
> +	} *jump;
> +	size_t jump_nr, jump_alloc;
> +	size_t jump_pos;
> +
>  	/* Scratch space for current values: */
>  	struct object_id oid, peeled;
>  	struct strbuf refname_buf;
> @@ -802,14 +826,34 @@ struct packed_ref_iterator {
>   */
>  static int next_record(struct packed_ref_iterator *iter)
>  {
> -	const char *p = iter->pos, *eol;
> +	const char *p, *eol;
>  
>  	strbuf_reset(&iter->refname_buf);
>  
> +	/*
> +	 * If iter->pos is contained within a skipped region, jump past
> +	 * it.
> +	 *
> +	 * Note that each skipped region is considered at most once,
> +	 * since they are ordered based on their starting position.
> +	 */
> +	while (iter->jump_pos < iter->jump_nr) {
> +		struct jump_list_entry *curr = &iter->jump[iter->jump_pos];
> +		if (iter->pos < curr->start)
> +			break; /* not to the next jump yet */
> +
> +		iter->jump_pos++;
> +		if (iter->pos < curr->end) {
> +			iter->pos = curr->end;
> +			break;
> +		}
> +	}

Quite straight-forward.

> +static const char *ptr_max(const char *x, const char *y)
> +{
> +	if (x > y)
> +		return x;
> +	return y;
> +}

Hopefully the compiler would inline the function without being told.

These pointers point into the same mmapped region of contiguous
memory that holds the contents of the packed-refs file, so
comparison between them is always defined.  Good.

I wondered if

	return (x > y) ? x : y;

is easier to read, simply because it treats both cases more equally
(in other words, as written, (x>y) appears more "special"), but that
is minor.

> +static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
> +					struct snapshot *snapshot,
> +					const char **excluded_patterns)
> +{
> +	size_t i, j;
> +	const char **pattern;
> +	struct jump_list_entry *last_disjoint;
> +
> +	if (!excluded_patterns)
> +		return;
> +
> +	for (pattern = excluded_patterns; *pattern; pattern++) {
> +		struct jump_list_entry *e;
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

OK.  When we have a "literal" exclude pattern and another "glob"
exclude pattern, we can afford to ignore the "glob" one when
building the jump list and include only the "literal" one, because
the jump list is used only to skip over entries that obviously can
never be in the result, *and* --exclude are additive (i.e. being
on jump list because of the "literal" pattern is a reason enough to
be excluded from the result; matching or not matching the other
patterns does not affect the fate of the ref that got excluded due
to matching the "literal" pattern).

Makes sense.

> +		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
> +
> +		e = &iter->jump[iter->jump_nr++];
> +		e->start = find_reference_location(snapshot, *pattern, 0);
> +		e->end = find_reference_location_end(snapshot, *pattern, 0);
> +	}
> +
> +	if (!iter->jump_nr) {
> +		/*
> +		 * Every entry in exclude_patterns has a meta-character,
> +		 * nothing to do here.
> +		 */
> +		return;
> +	}

OK.

Thanks.
