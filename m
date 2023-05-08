Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB67FC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjEHWdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHWdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:33:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9515BB4
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:33:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9d881ad689so6762363276.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683585233; x=1686177233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3i/ELLzFzEwdYXqf1n0U9ddKtT2+bpgAG+Ciw2BkZ1A=;
        b=kJfsOJbo+vBiWWij4omFF8Aq8YY2wNJmNP3hwRha19GtTjSHCmyTtrvGGpiV8dYZvg
         SlsKZAigHY/4i3ppeVUmQ2J9cLSit7c1fhzJGQW6CZhoVFtNVYkd+a7JjNPYkH2yUuwj
         ky/qvAAXeJcQHToJnyThUG9Tf+mSLU2ezh2LCTXutXan0R05euCYldMuji/dGFcsGqWC
         I1u8rBvLg0bHY5oCGZm9zVa4T9rJ8GvC3MCuAmPfUUphzOOFuYar4fU+giKC25cUN68v
         eEBHGpdgRdKJgQTdI0L5GIkIYS8Agw3afdiSWTPcoAMJ+u5/oyApsPrcU6DIBJTXr/HH
         f7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683585233; x=1686177233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i/ELLzFzEwdYXqf1n0U9ddKtT2+bpgAG+Ciw2BkZ1A=;
        b=bZuZ8hz4ttxB3rlBQ1E3/jRJuGhjAzHAe/QO67Qh1PTtFGVXsUnOyr5g4qSZyevMXV
         DFlketGC03Am5pPrLnw442+v45iFGFf+yofApFVirmEDARhWdSFdf/FiQL0udJu3GVXS
         IBxNFr40M+M/VebApJRxPlDfp41zse7U7ro58CJebSbPuYCD8DEmZf52At/XhKu18lLb
         sIxbKySTvyMSvzqbDPwcSH9ZXPNb65zvbTGF/RHcNDdyf6vYJFva+2iQB+j6y6xz+ibW
         66Ab6gx1JoNO72oGia9Cy+zhD8XKiCc1I4QbMTE42xF127mPx2sT5GDLLtJo7PMQHE13
         1Qng==
X-Gm-Message-State: AC+VfDypMCfN8GYkVatzdkFaoJPG76pSV5eZMjsVco8XvoT94D4xD3gK
        mFl7bJnNoJcMvNUihyae3lIJRooZDi0mm9gWmoVxjA==
X-Google-Smtp-Source: ACHHUZ63+xJvFLGBe6UctYxk+HNqTojryDwmIbincUpNFhDdnAIhQyf5zXbKz9RgBkCqKRl1Mv0L5A==
X-Received: by 2002:a25:d51:0:b0:b9e:65ac:c316 with SMTP id 78-20020a250d51000000b00b9e65acc316mr14021420ybn.49.1683585232975;
        Mon, 08 May 2023 15:33:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 130-20020a250888000000b00ba1a0346360sm2658772ybi.13.2023.05.08.15.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:33:52 -0700 (PDT)
Date:   Mon, 8 May 2023 18:33:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 04/15] ref-filter: add ref_filter_clear()
Message-ID: <ZFl4z/WD2j49a8bk@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
 <xmqqr0rq4ful.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0rq4ful.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 03:29:22PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > From: Jeff King <peff@peff.net>
> >
> > We did not bother to clean up at all in branch/tag, and for-each-ref
> > only hit a few elements. So this is probably cleaning up leaks, but I
> > didn't check yet.
> >
> > Note that the reachable_from and unreachable_from lists should be
> > cleaned as they are used. So this is just covering any case where we
> > might bail before running the reachability check.
> > ---
>
> Not signed-off?

Oops. Sorry about that, this should be:

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Taylor Blau <me@ttaylorr.com>

> I wonder if structure assignment "*filter = blank" is easier to see
> but I think we've seen this "_INIT; memcpy()" dance before.

Yeah, this matches how many other _init() functions work (just looking
through the output of `git grep -B3 memcpy | grep -A3 _init`).

Thanks,
Taylor
