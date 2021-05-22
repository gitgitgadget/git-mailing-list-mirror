Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30391C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077296108D
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEVVUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEVVUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:20:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A2C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:19:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c196so15103183oib.9
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lh2+td+FNdHocySSrpCoM2PK8Olh36RUQgSkHhzVi0M=;
        b=nw4jGbpq1CM+9oex72Jx79s9ghzz60IH0mbbzHJSDEtY/ojooIyxmFWNHPhivjiqva
         zRD/fuD1rDaR1ZIP0UgrwT+PHD/KDoV+yzAD7pOrvVqPcmfiCDC/0D3lYbQ9OGffY1hl
         HtT6QX37gfP1XnSWVn6k1uIYtkURQ56yQL2ORO7TZrrSSIEZsIqS42u3at2mcZFgmZck
         xSQ5yKsS3bRQYjxFVpY5hXm50M0bPmjqXKbXAdJDYwMjzSZEDOGQUeOXXh9LkZ8Z++CJ
         +cHYZd5+zwpd6RtAgl7nQzBBWFoRCepBHknbv/urMGmGLdANNX/DE7e9pZTk4kWgf3KG
         rWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lh2+td+FNdHocySSrpCoM2PK8Olh36RUQgSkHhzVi0M=;
        b=kC8/hf65jIg+5kWzMxRv8pV9kZK4h73B6NPhnibroaq8P684TaJQrMx8RsoJrBQRLT
         RqcqxBTL8oHsp99Rpq86kM7eP07sPldduhR6rq8gTqfHMyaBbmfh85Pe5NO5ANPajJSC
         R9zpivvoi1PwUdKc8fPuODTvAaZ2WVG0c+YPn1ZZUanZFl3WUIxZd0gRlrw249+lUo/Z
         CHUgBQWhenNHSTW9/4z/wxspEFEZfCp0s7K5iNvScG9yOVbOejU0YZi5e9yhyoFLCv7c
         XkT3A6jkGkpurTSehe+V4gYTyyQ4VWaD0bTE6vmOlhMlWv5wOiffDrT1Jssw6qxL6I/c
         YHyg==
X-Gm-Message-State: AOAM530weWniJwxTmNJZ8lVjeZZd08Pn6/zY/5hPG8EcyzbHjiEjEhfG
        TXcYyTYtog/gvHVruuqU7ak=
X-Google-Smtp-Source: ABdhPJyKxuB7S/lwDhcn+l+nHay2axR2UoMz118ejr1sUF1jooYY8Qu6/XL+eCyYpK+0ySo5Dx9FQQ==
X-Received: by 2002:a05:6808:3cf:: with SMTP id o15mr6116688oie.77.1621718358958;
        Sat, 22 May 2021 14:19:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v6sm809623oou.14.2021.05.22.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:19:18 -0700 (PDT)
Date:   Sat, 22 May 2021 16:19:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60a97550287b3_857e9208b8@natae.notmuch>
In-Reply-To: <7f0c9ab8-c1ca-171b-8247-6d921702f3bc@iee.email>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <7f0c9ab8-c1ca-171b-8247-6d921702f3bc@iee.email>
Subject: Re: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 21/05/2021 17:53, Alex Henrie wrote:
> > On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >> It's good to not include many initial codes, but I would start with at
> >> least three:
> >>
> >>   OK = 0,
> >>   UNKNOWN = 1,
> >>   NORMAL = 2,
> > If you go that route, could you please pick a word other than "normal"
> > to describe errors that are not entirely unexpected? I'm worried that
> > someone will see "normal" and use it instead of "OK" to indicate
> > success.
> >
> > -Alex
> Typical <== Normal
> 
> Though abnormal and atypical often have different implications ;-)
> P.

Or USUAL.

-- 
Felipe Contreras
