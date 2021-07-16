Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C3EC6377E
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349B5613C0
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhGPV2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhGPV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:28:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FAC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:25:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h9so12538658oih.4
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FuVHRzQveHsjr1Gv6c4rmAoI5BoYroTqQskR0LZ5gf4=;
        b=DCJtDRc7BrcwTz1b3KRxGC+XIeNKh7viwrjPoWEw4h4yqTcAgniMt23YkO39MVsadb
         ZY0RqeRm5DkCSJHSYmm4QCbrG/QfPo7wxMl50FIReC0NQAhGxihzx0kgxK87rCJfBZLS
         RAfCZp3h7xEMY5OIVMA/TgNTury7JqsJi8DAzjrxeKe7ydoa8mAzoNniroB61VQ04Pyx
         ypbaqW+guCPVA6YIhb8TnDwkmwBEanJXIvBhQuqUyhVkuNE5ZdNyCJNyOSsCQ+Mub5yq
         RJPjLyf9VXZybbB7XcMKOqWbFh/TUzaHaXuZqsuazWk0DU4w905TmzuVI1IB2TSDoQeQ
         SrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FuVHRzQveHsjr1Gv6c4rmAoI5BoYroTqQskR0LZ5gf4=;
        b=Tn5vKlt71z2aoGQh5pyMPuUsHqg9dgMyfLYcCMlZjNO3jTPLTvgiGx/8fuap/63LZu
         IXt4M35XGSycZmURFTcw6XmxdtjRSYEtgKZx/IUyb2myCwvW/YRLh7YpVevJFpboeSVA
         X7/WqhMy3Q+0aWp8JXn6SHlr5wpxQpN+zHZn99FXMfd8fkhHk5fJDlDyx3Zi5QVbpv+t
         v051YTww5YWNVXMq5xn3tu0KUlCZdZQZYn2DL7fsFETWvc1tVSbwD/anL8k6v0nHCwLh
         Ps4uepRNhvRLIJCrlgnuHzipQE/RKbTf5ZH2YpOBUoBdQyIhQOx91xVeH46aFssVD1DQ
         pNRw==
X-Gm-Message-State: AOAM533cWGKNcc8z14S4rvYtL7IzmgVaBVZy8bxAH71pJ+9JFPZAU1qh
        8Km+SubV+ByIlPFAZ0uOwGk=
X-Google-Smtp-Source: ABdhPJxs9uAN1zRFteMndPpE5PESqj0jfCJJtfN+xkQ6h8mWWNSZYwxw4hBPpM20mZhRi5oOuG8lug==
X-Received: by 2002:a05:6808:2d2:: with SMTP id a18mr13960747oid.106.1626470732328;
        Fri, 16 Jul 2021 14:25:32 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y19sm2307618oia.22.2021.07.16.14.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:25:31 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:25:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60f1f94a83f1e_14cb20828@natae.notmuch>
In-Reply-To: <YPBmv7x3zUbuQ2uy@nand.local>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com>
 <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
 <YPBmv7x3zUbuQ2uy@nand.local>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Thu, Jul 15, 2021 at 12:35:30PM -0400, Eric Sunshine wrote:
> > On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:

> > > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > > @@ -541,6 +541,49 @@ Writing Documentation:
> > > +      A contributor asks their upstream to pull from them.
> > > +
> > > +    Note that this sounds ungrammatical and unnatural to those who
> > > +    learned English as a second language in some parts of the world.
> >
> > It also sounds ungrammatical and unnatural to this native English speaker.
> 
> Apologies if this suggestion has been made earlier in the thread, but
> this article
> 
>     https://apastyle.apa.org/style-grammar-guidelines/grammar/singular-they
> 
> document from the APA's style guide helps convince me that this is
> grammatical.

That's the opinion of one organization (biased in my opinion). Other
organizations disagree:

https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they

-- 
Felipe Contreras
