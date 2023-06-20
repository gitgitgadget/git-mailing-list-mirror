Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF24DEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjFTMPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTMPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:15:12 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2953B7
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:15:11 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7918b56b1e1so709164241.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687263311; x=1689855311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofItEz0JbN8bjYSxtWhebdbJg9lx+gQ5kQG5f41w2Oc=;
        b=osW2X5CtahPXutGVntkJOchfUXLyw710NKcTqONmH6cfrw7XzC+U515HhmlKUSKGD2
         dx6Z68gt+Oesf2X/IRH63O55ph2mL2HTalt6HpVP9qQLc3jQY/hIy8zy2FrBdoHR588/
         o953bii9Q3pHJ4zj7iilQC4oSjaYB+4L+csrfpmN7rm4nLY9gMFSRFWj3yb5ZkP9pO5I
         2dapCuwoPNSpCXZ0xadp868ypRr1GcmqIIXUnT/Ud6oswHB47CUmGJpWaq8AyMmq/axq
         rjoM8jgt1mcXgUuzon4Qo314/WXjoj2mRuvCyPcLj0eEhPn+72iEbUKWb9RB7lV+83CJ
         j4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263311; x=1689855311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofItEz0JbN8bjYSxtWhebdbJg9lx+gQ5kQG5f41w2Oc=;
        b=V9YYli2RSqleqYjmcMrl4pOSKoxiYF+H10QVwVG7dYO8GHGRbEBGTw3RqfyWD+Xdqv
         CVK+GvagTGkvxkaJfTrSHAgBfUZgGYT4UX6WDoIE1Cx99bAOKZ3vN14EhbO/VSXTMkGp
         p55FlfVd5MyAD5KguPMjrF2f5iZunaMcZLJzL6uUgMjVcQ16An68zu0YUk10bygzoi+5
         ddryXhkdv1kc8+2vBbDGW+GHX9L+qRiyD5dXMcICzA3z9lx2DW1Kz1oq1SjClhwMPkgj
         ICW7xcDn84hHCg5DSaWjM4h3QhlSTsBQ/IlNTTYCyDiESH0GKz06GfLnWGAB3bxZBnO6
         b5PQ==
X-Gm-Message-State: AC+VfDwSgtobyIM/m2/XlxiHDVq2Dcr6yvZ+CBCLVcNL3MuA8wN7w5ZX
        S/7m2uYfbJO5pYdRlwW3Y3V4rw==
X-Google-Smtp-Source: ACHHUZ4JvvafisBRV501qQChfKn1YLNo3XHei1uDS3wLX+jqDo/asTAfOr7szjbPS5LXjErgybpXVA==
X-Received: by 2002:a67:e941:0:b0:440:c269:86d8 with SMTP id p1-20020a67e941000000b00440c26986d8mr1173268vso.6.1687263310797;
        Tue, 20 Jun 2023 05:15:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020a250103000000b00bf4d24fd976sm341462ybb.10.2023.06.20.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:15:10 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:15:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <ZJGYS7D3fusfcou3@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <8c78f49a8def4148c92cdd7efe4daa63fb47f641.1684178576.git.me@ttaylorr.com>
 <ZH7ZpB8eMBZN8q63@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH7ZpB8eMBZN8q63@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2023 at 09:00:52AM +0200, Patrick Steinhardt wrote:
> > @@ -785,6 +802,13 @@ struct packed_ref_iterator {
> >  	/* The end of the part of the buffer that will be iterated over: */
> >  	const char *eof;
> >
> > +	struct jump_list_entry {
> > +		const char *start;
> > +		const char *end;
> > +	} *jump;
> > +	size_t jump_nr, jump_alloc;
> > +	size_t jump_pos;
> >
> Nit: I had some trouble with `jump_pos` given that it sounds so similar
> to `iter->pos`, and thus you tend to think that they both apply to the
> position in the packed-refs file. `jump_curr` or `jump_idx` might help
> to avoid this confusion.

Very fair, thanks for observing. I went with "jump_cur" (as a shorthand
for "cursor").

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
> > +
> > +		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
> > +
> > +		e = &iter->jump[iter->jump_nr++];
> > +		e->start = find_reference_location(snapshot, *pattern, 0);
> > +		e->end = find_reference_location_end(snapshot, *pattern, 0);
>
> Nit: we could detect the non-matching case here already, which would
> allow us to skip an allocation. It's probably pre-mature optimization
> though, so please feel free to ignore.

Probably so, this allocation is so lightweight in comparison to all of
the other things that for-each-ref does throughout its execution that I
think it's probably negligible to shave off a few allocations.

> > +	}
> > +
> > +	if (!iter->jump_nr) {
> > +		/*
> > +		 * Every entry in exclude_patterns has a meta-character,
> > +		 * nothing to do here.
> > +		 */
> > +		return;
> > +	}
> > +
> > +	QSORT(iter->jump, iter->jump_nr, jump_list_entry_cmp);
> > +
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
>
> Nit: if we initialized `j = 0`, then `last_disjoint` would always be
> equal to `iter->jump[j]`. We could then declare the variable inside of
> the loop to make it a bit easier to understand.

Sure, though we would then need to assign `iter->jump_nr = j + 1`, which
I think adds more confusion than inlining the variable is worth.

Thanks,
Taylor
