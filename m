Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447BC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 03:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454A0611CE
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 03:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFWDpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWDpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 23:45:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A82C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 20:43:02 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f10so1643853iok.6
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t3FC4o25SN6L+tAzKoFAT9yPUaa3GlYr3MrkRQuw0Gg=;
        b=h39CjiARFJqJErZYmJEXU2Wv1LNRmrRrfJsfHdM6es8qjvICPYb5dowDj7Y2aRcdtn
         bZK7gR4DaCmrhg1+Qeb3Vgg2kqd60ieCIbEgn9c67rzdAs7pSWMwS7A/OkAfqLgYrjQl
         0B9GIUnjNO/OeQQyhnhmB7d/Bc/Zyva7h6+87xbXSG2mkFpoCiPfF0uk47vmsBitzn98
         fJhipIjYovm2SNqMlHohrw9jt12vq0k7Cm/vdgJlEz8vP0Dcevzb2YHA4SSfEoyNawMM
         PYfWkPfpZhTBt2wDyz2RBT8DKGpeJ5Oo+qqAlmJg/RzMDOmvaVPDsYdecXW8l5GIgVXt
         iNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3FC4o25SN6L+tAzKoFAT9yPUaa3GlYr3MrkRQuw0Gg=;
        b=orhXycN+QCbhlo19vEmQoQkFHcCwH172oQk5Kfuz2XY26h0N9L8Ai2KFxsd2CyiEZ7
         DclkZqgMoIMa6uJp1jyv8qdQkBlps+byCw7+pCGRiKGtNOGD3rTz8kHNx9/W/SpO6JVB
         viCMxJfQqgeY1k88gsFoyAvGTD4E+jVHp2CwFU2QQIHHjVJwK5kq/3e9RYaQoa4wbPZl
         pjLqReomd8tZ9T/J0XFZ6uI0w//wvAiRQy05kmpXqOnEvBOZKO03PJuwV80qpmVDsJ8p
         xUsXWzOZUNzvBxfsIoprNcNdG2BM8/07tGVg9bv1bm3zetJGMMq/j+hbBZ9KeTgNIYKt
         iYuA==
X-Gm-Message-State: AOAM533DctKEHnYGQkRMGBfZ9kXwSYTMuZB+dUmUKl1w4k2aB66ZwCY6
        NIg8KGM9qsxItfiYudQTLJdZBg==
X-Google-Smtp-Source: ABdhPJyGyB0OlofRXR3FU4nqHotiUqK4PUJGGoeVM6P/HqUEzLZsVS5aNTuaoHDLv7IT+TBhH0au4Q==
X-Received: by 2002:a5d:83ce:: with SMTP id u14mr5454204ior.45.1624419781585;
        Tue, 22 Jun 2021 20:43:01 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id b15sm9080181iln.17.2021.06.22.20.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:43:01 -0700 (PDT)
Date:   Tue, 22 Jun 2021 23:42:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
Message-ID: <YNKtvj4z2dwSUvOS@nand.local>
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <871r8w3sxu.fsf@evledraar.gmail.com>
 <YNKiv2Ar77xAxixz@nand.local>
 <CAPx1Gve_KqzQHanDDTSJ_2QywzNybq-J3wkG8xBC_DUhwVB5Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1Gve_KqzQHanDDTSJ_2QywzNybq-J3wkG8xBC_DUhwVB5Fg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 08:29:35PM -0700, Chris Torek wrote:
> On Tue, Jun 22, 2021 at 7:56 PM Taylor Blau <me@ttaylorr.com> wrote:
> >... I was going to comment on the fact that "(*p_progress)->total" could
> > be written simply as "*p_progress->total", but I'm (a) not sure that I
> > actually prefer the latter to the former, and (b) I find that kind of
> > style comment generally useless.
>
> Also, it can't. :-) The binding order is wrong; *p_progress->total binds as
> *(p_progress->total), and `p_progress` has to be followed first, so this
> just doesn't work.

Ack, serves me right for starting a discussion based on operator
precedence. Yes, you're right, I was mistaken and forgot that -> binds
with highest precedence in C (above *, which is why this doesn't work).

In any case, my confusion is probably a good reason to avoid this
entirely by manipulating a variable which stores *p_progress.

Thanks,
Taylor
