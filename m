Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A611C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjECVma (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECVm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:42:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D64C13
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:42:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55c939fb24dso11905507b3.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683150147; x=1685742147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuSbcxU+wykCtGCjLMRfpcbbaXx9M6397YmloQioGu8=;
        b=AbAPXrNq9uVE8JmVpHn/mOCjNmzDydq6zDvIyuelkBmf2SzLKIYt8FLIahkJmszgRP
         XF0x6w7FMDGzYepu1FA+7+dWmXRkj5s5YeBYy89qipQ75+DGiEBedwMKG6XVYYubSzki
         1OdK1Cg65/0N10ZpB5v6e1AXVzNyHfiM1zbVSzF1pFxIlZUde+Qkjt0tGlE9SBh56Pbn
         s/eC224kcYFkoRR/byRHgZZ2nDzpm9LIViuxDh6ngxT6JyoG1COqEDwss6bw9Phm65C+
         AWjifGWVFYiG+UtpKISfD9e2EEiWOZT6LsDZohYyle1yWV2bn2cUbL/bjQQRqUOPlug0
         z8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150147; x=1685742147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuSbcxU+wykCtGCjLMRfpcbbaXx9M6397YmloQioGu8=;
        b=Oyew5U/sl5s6kIu2DMlneD6YMRol4EO2wDeLUN8jubvM/59C1GRSJBkRC+j8+SMUBg
         w74DdIyWI0RDlzI+YnK1LpGoL0xaZH4/v2w1r/6H9FpW6PxK84OL6IMIlcjC0x8NqHc/
         +F0cuiainIPLiZM+xfW8wcN9o9b7M3zEuiyuR+FLksNNF8p/v8bqy2/a9nqZ5hIV2T5w
         lB/pp64uKHpq9ib0V9tZ0YIcCVmzzAAqzbgs2REYzgX6GwOYPhYLpS9StYeexYSfBVXN
         xuUNGmaWWYihrCFFFxFcBZ0sfkCi6CiF9cL2+7gyymcWWBXK9d/zE0moOWgTShVHz/oS
         jPrw==
X-Gm-Message-State: AC+VfDwDRxel/L+MN9Zm3tJMPvbETYozEbQoQq+h3oQspHmac+/m9+Rr
        qw/jgkr5BXam34usjIhD8fSLWu3nDEe8eiiNgDX6zQ==
X-Google-Smtp-Source: ACHHUZ5pd4hdL9lv0/Q30ND0rFUMI2GjZHQvz24Vl7mxpriQRWRQzEXkKJumLRb651FiVJGiarp0kg==
X-Received: by 2002:a25:c005:0:b0:b92:182a:c99b with SMTP id c5-20020a25c005000000b00b92182ac99bmr18243137ybf.23.1683150147032;
        Wed, 03 May 2023 14:42:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p71-20020a0de64a000000b00552e1d1ac1esm8979453ywe.13.2023.05.03.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:42:26 -0700 (PDT)
Date:   Wed, 3 May 2023 17:42:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <ZFLVQdjXoEmGImml@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
 <xmqqh6t3ztee.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6t3ztee.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 11:52:25AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   3. Fall back to the ordinary object traversal if either (a) there are
> >      no haves, (b) none of the haves are in the bitmapped pack or MIDX,
> >      or (c) there are no wants.
>
> Tangents.  If there are no haves, wouldn't the answer by definition
> everything that are reachable from all wants?  Is there a reason why
> a bitmapped walk cannot fulfill such a request?  If there are no
> wants, wouldn't the answer by definition an empty set?  Again, I am
> not sure what the ordinary object traversal is expected to do in
> such a case.

Oops, (a) is just wrong. The old code is:

    /*
     * if we have a HAVES list, but none of those haves is contained
     * in the packfile that has a bitmap, we don't have anything to
     * optimize here
     */
    if (haves && !in_bitmapped_pack(bitmap_git, haves))
      goto cleanup;

which is itself an iffy optimization that I have toyed with the idea of
getting rid of over the years, since I am skeptical that it is doing
much even in the classic bitmap traversal.

But we only do that in_bitmapped_pack() if there are haves to begin
with, so (a) from my commit message is incorrect. Sorry about that.

> > And is more-or-less equivalent to using the *old* algorithm with this
> > invocation:
> >
> >     $ git rev-list --objects --boundary $WANTS --not $HAVES |
>
> It is especially confusing because the "--boundary" (at least as I
> originally had invented it), i.e. a commit that is smudged with
> UNINTERESTING bit, whose parent we did not bother to dig further to
> paint with the same UNINTERESTING bit, is not something we start our
> computation with; it is something we learn _after_ completing the
> history traversing.  So I am utterly confused X-<.

Hmm. This is from code that Peff and I wrote together a long time ago.
My recollection is that we only care about the UNINTERESTING commits
between the tips and boundary (as you described it), but no further, and
that we could discover that set during limit_list() alone.

But maybe not? I honestly cannot remember. Perhaps Peff does?

Thanks,
Taylor
