Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D4C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjEJXK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjEJXK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:10:26 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56DAD3
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:10:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a5a830238so73588217b3.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683760224; x=1686352224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEeDDHeheXM0AkW8YU0wCa2LzqPSxE27IlcA3D8etyc=;
        b=Ki23hOJhIwLIiwUrbSMP8BsRCpezTVinsXo9HiG66jwkskMcflQJWxLUpV5lhjxjvi
         fHx8wyJuTxi89xW/5eGQrmulTIgvuZ5+1tJ4fwzbkJsxgT/kpkEeLqepy2wD5b1gBH1B
         iaIaIkPPAPrtR+L8t1Vsb41udEFjovbfWOSb2Jin5lRlL1GNqrlaPEl6CYuPvk0Cf6O1
         OX0A6WQvGnFpK//JU3lNrxrkEqp4WUX8YlPgpXUtx03Lo8tdUAgK+uevaxVL7N2MYiTB
         Q1V7JDYhnda++Dv39u41nj8XGtclCU92KwXf3W/Er0QVfsElk7njq2jEeM2L1TZ8hGSx
         ec+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683760224; x=1686352224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEeDDHeheXM0AkW8YU0wCa2LzqPSxE27IlcA3D8etyc=;
        b=jmRDuptplgGnMnHagH8nOxqyXkixoyax5+EA3H8/AcmpmeaTdaY0ik1Vgx4A03byLb
         p5W1u7dKadrGuVth1eo3w5tf6aha61ngizZPx0Ft7eDTGDDD9DTcIiKU4bsc9sCVGqVa
         GKIjTsEGRTYmydZmzToqJXfGl78esq7Q8vlWWdPXyDZ0AWvg1Ni6cs8Gtam+NNcPAs14
         JPPMl6sSphcdyUYgR8zY1ppCJ9L8dd/Tu23WPrVJgScWzixNrNSKl53IIEACYBFfsdcc
         LIGjOgohMGvQ3k95cYHxKaqq0vSr3CZTZAmwgi2J++w5bcniGoEoxuM2cdy/xnSJHDo5
         Mvrw==
X-Gm-Message-State: AC+VfDyiEfjkSDhKymkZGPTDQhicUtvovpo+6/UjRFdXX3RBvhr4kZ8C
        QUZb8RkRCYKhDvrUgibrrE1PQA==
X-Google-Smtp-Source: ACHHUZ7F0uUZecUMyXHJwU0HJ2IQDgBa+hNR+mhPS+0i3/XHVQg/WJFlBJVRGkDrpnP/bPLB8ZJWxA==
X-Received: by 2002:a81:6cc6:0:b0:55a:3c8e:da37 with SMTP id h189-20020a816cc6000000b0055a3c8eda37mr21596248ywc.1.1683760223813;
        Wed, 10 May 2023 16:10:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u204-20020a8184d5000000b00559d3586ab9sm4455568ywf.10.2023.05.10.16.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:10:23 -0700 (PDT)
Date:   Wed, 10 May 2023 19:10:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <ZFwkXtkAau4MNtKv@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com>
 <xmqqmt2b23ut.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt2b23ut.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 03:55:54PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is another small reroll of my series to implement a boundary-based
> > bitmap traversal algorithm that I worked on towards the end of 2021 with
> > Peff.
> >
> > The algorithm is the same as in the last round, though I cleaned up a
> > few things throughout thanks to another very helpful review from Stolee.
> >
> > One significant change from last time is that the new algorithm is
> > opt-in behind feature.experimental, giving users a way to try out the
> > new implementation while still being able to switch back to the
> > known-good traversal in case anything goes wrong.
>
> It seems that the comments the topic received on the previous round
> have all been addressed adequately?  Does everybody feel comfortable
> merging this topic to 'next'?

Thanks. I agree and think that this is ready to merge down. Even though
it is changing the traversal algorithm, it should be relatively safe to
merge since the new behavior is hidden behind an opt-in configuration
option.

Thanks,
Taylor
