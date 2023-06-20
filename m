Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7C2EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFTMFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjFTMF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F045710F3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:05:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38dec65ab50so3389378b6e.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687262721; x=1689854721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjrCTCb+eovc7UnEBqgnLeLF8QBu82sFc8I5l+8bLLA=;
        b=m3Ikycan64blJzC6s26dL76q9DaxOZrJQhhXWFfs5ZEQvPE0zpTiGPzZ5/QNY2iS04
         atwAKiTAdp2rgNf+hDMqT3eVaClVu/giwDg7pggLtmKcKMNL8GosODZjqA5GdvN8Aih7
         tCmAy7hrTvqnB+b/EwUcXKys6i9QHH4+mIS1+Af4xpxwt3xIIFDoXpy+L9J3Bas2sarc
         LLExon2snKfqjcH7yRQK0SZAMr8NHAKuuK6dd6759+LisykxM5dW+hBrB4foWalSp5Vs
         0PatLqnHHM5qltogJbQ10do6b8qjcHT+hI5m6K/8g/PgtDs3sHwbWJ0BiRDVdZhUkdP6
         f5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262721; x=1689854721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjrCTCb+eovc7UnEBqgnLeLF8QBu82sFc8I5l+8bLLA=;
        b=LBXRy0W/endPdKMZOaXfV0Xo8NlqgSHyInrF9JFRYdE+7h1bdR8FGIyYhvToaG5AC6
         drM39LdhIkYiD5qbSBXfmpi8AygmWmaeEUm8pmYxLWUv7T8BpeQOu8+f7SeuaRlbbGgz
         S8kSKvsbcoHOgQ8AlJ4gQnyBv5u4JXJEu6lg6kS479sqVFiOkc43Db4FcZrGhC87boew
         SH3bEjK0k6okpyc3kTmLcnpKzoz5cCqrbYuxvWPl/5EClcGLaOx+YqcUmBu2GeQ5ZOmG
         aFWk+QG8LdwtIae0fRb0DmxspoTTC0oOxVy8IXjDAckD/0X4MbYttdUFdFjlTdZt4jnX
         VULA==
X-Gm-Message-State: AC+VfDz+OEW+Ut5YXvMLsi2DvvsC7ae5lQAgb+SbpJSBU48IJSlNm1ca
        yx2lvJ4sMNAC1+LA5+oV3ocUjQUMYuxSepcI5Q4t7oj0
X-Google-Smtp-Source: ACHHUZ63Sya2uGvGZywJI2e4mMwYt+YHlozX7fb5kot+obDh78DQYOKRqApY46mci7b2vLe/hOTDMA==
X-Received: by 2002:a05:6808:302c:b0:39a:a4ab:22f2 with SMTP id ay44-20020a056808302c00b0039aa4ab22f2mr14665029oib.56.1687262720895;
        Tue, 20 Jun 2023 05:05:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s2-20020a0dd002000000b00545a08184fdsm439949ywd.141.2023.06.20.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:05:20 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:05:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <ZJGV/bYDN9Dn4V8S@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
 <8066858bf59386eeec68f0f1e4247eeebb6482f7.1686134440.git.me@ttaylorr.com>
 <xmqq352u3n3a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq352u3n3a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 05:27:05PM -0700, Junio C Hamano wrote:
> >   - Clean up the results from the previous step: discard empty regions,
> >     and combine adjacent regions.
>
> Say something like
>
>    The resulting list of regions that would never contain refs that
>    are not excluded is called the "jump list".
>
> here, probably.  Otherwise the first reference to "jump list" we see
> later feels a bit too abrupt.

Good suggestion. I phrased it slightly differently in the version that
I'll send shortly, but the spirit is the same.

> > There are a few other gotchas worth considering. First, note that the
> > jump list is sorted, so once we jump past a region, we can avoid
> > considering it (or any regions preceding it) again. The member
> > `jump_pos` is used to track the first next-possible region to jump
> > through.
> >
> > Second, note that the exclusion list is best-effort, since we do not
> > handle loose references, and because of the meta-character issue above.
>
> I found this a bit misleading; a natural reading of "exclusion list"
> is that the phrase refers to the list of exclude patterns given from
> the command line, and users would be upset if the processing of it
> is best effort.
>
> I think what you meant to say was that optimization to avoid full
> scan using the jump list does not aim for perfection, and entries
> that are not skipped using the jump list may still be excluded by
> the exclude patterns.

Yep, exactly. I think this was from an earlier version from before this
was called "jump lists", and I missed it when find-and-replacing
through the patch messages. Thanks for spotting.

> > In repositories with a large number of hidden references, the speed-up
>
> "hidden" -> "excluded".  Your final objective to implement the
> feature to exclude refs using patterns and optimize it using the
> jump list data may be to implement "hidden references", but that
> hasn't be talked about in the above.  All we have been hearing was
> that we are optimizing the walk over packed-refs using exclude
> patterns.

Yep, thanks.

> > +static const char *ptr_max(const char *x, const char *y)
> > +{
> > +	if (x > y)
> > +		return x;
> > +	return y;
> > +}
>
> Hopefully the compiler would inline the function without being told.
>
> These pointers point into the same mmapped region of contiguous
> memory that holds the contents of the packed-refs file, so
> comparison between them is always defined.  Good.
>
> I wondered if
>
> 	return (x > y) ? x : y;
>
> is easier to read, simply because it treats both cases more equally
> (in other words, as written, (x>y) appears more "special"), but that
> is minor.

Yeah, I think that any reasonable compiler would almost certainly inline
this, especially at higher optimization levels. But I agree with your
suggestion nonetheless, thanks.

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
> OK.  When we have a "literal" exclude pattern and another "glob"
> exclude pattern, we can afford to ignore the "glob" one when
> building the jump list and include only the "literal" one, because
> the jump list is used only to skip over entries that obviously can
> never be in the result, *and* --exclude are additive (i.e. being
> on jump list because of the "literal" pattern is a reason enough to
> be excluded from the result; matching or not matching the other
> patterns does not affect the fate of the ref that got excluded due
> to matching the "literal" pattern).
>
> Makes sense.

Exactly.

Thanks,
Taylor
