Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC43C001B3
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGCRiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCRiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:38:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2EE5D
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:38:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5768a7e3adbso67673727b3.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688405894; x=1690997894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+PAVwdRpCyCaojhb56Iz7LDqfUDQcSZIU3tcMBSmAw=;
        b=0zWoiTYKDeNZ+fovixamwcB6PzaCTgWlc9d8zoWBXm7dBbJwIy33qyCqb8rih3tA5a
         7RbWpdKLsQHQGd0JvblIVobSHA8hdA2PtYd7icjBnK9WkWFreM55x5oRwmZ9Rw7YC98U
         5EWxJ2RgAj9UpFaVQp5OuXkXq5dkqoygTMLYiX3s8mWIGqmBxSQzVbzcFZwySil2kxqP
         h4y7DpOPPS3aSeg2FtbuW51JBXKxf96pJBF3zc4CxvCOCm7v7qiixM0Ath7uIvVYnhT7
         80+hpmtF5SxesmoLP2tiKIWsSFy7BPMlAZXpCJYpMyUGYiZgK+nAnuy4Sezi/c0eG5mE
         gLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688405894; x=1690997894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+PAVwdRpCyCaojhb56Iz7LDqfUDQcSZIU3tcMBSmAw=;
        b=IsBVLrj9BKVRqQYF5928SFdqk5LuSy6NNWpmCNrl9kWYBPnaTkzyUUGjWKAi3H5FVf
         0s0gu52PfWSqT4gF20KU8/hG0/tmHt+6WVXtUSuvwZOU/5euEVCrSa3MpBcsNSexF2dC
         BWjrVn23VnILwxx0cVUQcDBv9UhUARfSNCCUFsWOdwnGIBA4aIWfMhy2XkAecQyWh+rr
         1SwTkLVWR27quSi4phjvMtHmZEgNXY8qWj59XesNstWWZAjjTBQKYzyMVej10cezkHdh
         cTOBMaahWw0vbi8wMBuFLabD6NmhZNo7uXM3XsK75iNPhNFFE9Paf38CllSxlS6Ter40
         G0zw==
X-Gm-Message-State: ABy/qLZzZOmSayLBb8uMZnayD05sagvMNvsvBMd5cR0cNR0t3jsSdVLU
        oiCVsUICYvpndDFaKB8OVbd74LL/un5Ab69zan1vhQ==
X-Google-Smtp-Source: APBJJlFg9nK0dvh1lrXDklyb6wvzC3O4DfSkH39gOq0519XaYtkBpF6ngSya/LTKLhpBO9zjv+b0rA==
X-Received: by 2002:a0d:d510:0:b0:56d:18fb:62a1 with SMTP id x16-20020a0dd510000000b0056d18fb62a1mr9355981ywd.15.1688405894406;
        Mon, 03 Jul 2023 10:38:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l189-20020a0dfbc6000000b0055a931afe48sm5169842ywf.8.2023.07.03.10.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:38:13 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:38:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <ZKMHhUVQ3EckJFIE@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <386ed468fa7157e90f2f7324199a68974a7860cc.1687270849.git.me@ttaylorr.com>
 <20230703055627.GF3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703055627.GF3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:56:27AM -0400, Jeff King wrote:
> On Tue, Jun 20, 2023 at 10:21:42AM -0400, Taylor Blau wrote:
>
> > Second, note that the jump list is best-effort, since we do not handle
> > loose references, and because of the meta-character issue above. The
> > jump list may not skip past all references which won't appear in the
> > results, but will never skip over a reference which does appear in the
> > result set.
>
> I wonder if we should be advertising this in a docstring comment above
> the relevant function. The problem may be that there are several such
> functions. I just think that it's a gotcha that may affect somebody who
> wants to call the function, and they're not going to think to dig up
> this commit message.

Good idea, thanks.

> >     $ hyperfine \
> >       'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"' \
> >       'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"'
> >     Benchmark 1: git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"
> >       Time (mean ± σ):     802.7 ms ±   2.1 ms    [User: 691.6 ms, System: 147.0 ms]
> >       Range (min … max):   800.0 ms … 807.7 ms    10 runs
> >
> >     Benchmark 2: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
> >       Time (mean ± σ):       4.7 ms ±   0.3 ms    [User: 0.7 ms, System: 4.0 ms]
> >       Range (min … max):     4.3 ms …   6.7 ms    422 runs
> >
> >     Summary
> >       'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' ran
> >       172.03 ± 9.60 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'
>
> This measurement is cheating a little, I think, because the earlier
> patch to implement --exclude sped that up from ~800ms to ~100ms (because
> we avoid writing and all of the ref-filter malloc slowness for the
> excluded entries). So the better comparison is between two invocations
> with "--exclude", but before/after this patch. You should still see a
> 20x speedup (100ms down to 5).

I agree. I included a build from the previous commit in this benchmark.
As expected, it's around ~100ms, but at least it gives readers a clearer
picture of how performance changes as a result of this patch.
(

> > @@ -802,14 +826,34 @@ struct packed_ref_iterator {
> >   */
> >  static int next_record(struct packed_ref_iterator *iter)
> >  {
> > -	const char *p = iter->pos, *eol;
> > +	const char *p, *eol;
> >
> >  	strbuf_reset(&iter->refname_buf);
> >
> > +	/*
> > +	 * If iter->pos is contained within a skipped region, jump past
> > +	 * it.
> > +	 *
> > +	 * Note that each skipped region is considered at most once,
> > +	 * since they are ordered based on their starting position.
> > +	 */
> > +	while (iter->jump_cur < iter->jump_nr) {
> > +		struct jump_list_entry *curr = &iter->jump[iter->jump_cur];
> > +		if (iter->pos < curr->start)
> > +			break; /* not to the next jump yet */
> > +
> > +		iter->jump_cur++;
> > +		if (iter->pos < curr->end) {
> > +			iter->pos = curr->end;
> > +			break;
> > +		}
> > +	}
>
> It took me a minute to convince myself that this second "break" was
> right. If we get to it, we know that iter->pos (the current record we
> are looking at) is in the current jump region. So it makes sense to
> advance to curr->end. But might we hit another jump region immediately?
>
> I guess not, because earlier we would have coalesced the jump regions.
> So either there is a non-excluded entry there _or_ we would have
> coalesced the later region into a single larger region. So breaking is
> the right thing to do.

Exactly. I added a short comment to this effect to hopefully avoid any
confusion here.

> > +	for (pattern = excluded_patterns; *pattern; pattern++) {
> > +		struct jump_list_entry *e;
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
> OK, and here's where we could split "foo[ac]" into "fooa" and "foob" if
> we wanted. But I think it is a very good idea to leave that out of this
> initial patch. :)

Oh, definitely ;-).

> > +	/*
> > +	 * As an optimization, merge adjacent entries in the jump list
> > +	 * to jump forwards as far as possible when entering a skipped
> > +	 * region.
> > +	 *
> > +	 * For example, if we have two skipped regions:
> > +	 *
> > +	 *	[[A, B], [B, C]]
> > +	 *
> > +	 * we want to combine that into a single entry jumping from A to
> > +	 * C.
> > +	 */
> > +	last_disjoint = iter->jump;
> > +
> > +	for (i = 1, j = 1; i < iter->jump_nr; i++) {
> > +		struct jump_list_entry *ours = &iter->jump[i];
> > +
> > +		if (ours->start == ours->end) {
> > +			/* ignore empty regions (no matching entries) */
> > +			continue;
>
> Dropping empty regions makes sense, but our iteration starts at "1"
> (because the rest of the checks are inherently looking at last_disjoint
> before deciding if each region is worth keeping). So we'd fail to throw
> away iter->jump[0] if it is empty, I think.
>
> That could be fixed here by iterating from 0 and checking for a NULL
> last_disjoint, but maybe it would be easier to avoid allocating at all
> in the earlier loop, when we find that start == end?

Yeah, I agree with this. I think Patrick made a similar suggestion in an
earlier response, and I decided not to take it since it makes the patch
more verbose.

But I think that avoiding the empty region special case is worth it.
Thanks, both :-).

Thanks,
Taylor
