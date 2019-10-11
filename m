Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78751F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 07:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfJKHuH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 03:50:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39065 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJKHuG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 03:50:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so7822512edt.6
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R08k/gpGiQiuHl8UnL5JsuVJlmpYlj7JQvby9dC7L7o=;
        b=jMA23a6MMU7qgQG/W/zz8DmHRIhESvLnI4g/ZzYy6P0+1OPl0Bugcyw9Gm+5/oFJvp
         c8CsGUMpcAZU2/8Izl4Brt4Ply21lM1mJrLNgBl+NhgHB2oqoPiMuZ6iVlCQviUcxbLn
         8v0M4GtdfAjigyoUd8+tOJjlKTXZKX0n7083xv2KcyzEgjCFCYSOUpeEfx15hzRVqx1E
         VaNe4lhaFnww9V12ib/3ZAMRNx3skYrlLBoneC0VhUOYmNPYo5fkuhQexAwnZEcRND6q
         UkkY0vN+/z1mM/mbO3F9rFBbsVM659t6lYy83N1WGGV8qqKVGwndzijxg3lUgd1k4Q19
         EqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R08k/gpGiQiuHl8UnL5JsuVJlmpYlj7JQvby9dC7L7o=;
        b=H44BMg6cDKO79vfSzD5XUTDcoehI3uHR8Ng+M/ian4VMocK/iQQ/6UzPKtfuA2rWHu
         8S3F6N3x3ECrmENhFySwAN2EdOH1m93s7TiUXW3DkFg5UOZJFHWzvIBZL9GcmXr5PTVg
         H3ifW8ZAB/FbvN9LVq1vGo1hMqBCjv+OfjIgUGGuy/Bx7RG5ny3BE8RNfd8Dj+zv7W6G
         WojNcO8aeQ30FqDl1Cdf7AYCBSk876toIOvpMkWTEL3hbRT7vrM4kOwLRSprTHbX9r4x
         4dp5VMiIojKk/TjokZzE8Psde2wc6Nxvjq6mR3zJIkFpqZaY5YGXPK7ntk4N2nXwFvHm
         Idiw==
X-Gm-Message-State: APjAAAU7GdjVinLjGIpMVMCxpfrTzigbSwue+AKjDrj/vIZubgiJ3bve
        7ewA+qLm0tiOSEHzhMpEfv7fVvdGmQA/Bxm/YUHpIC+2
X-Google-Smtp-Source: APXvYqxB5/ZyU+ygtZStt9kDjTSlLPEl4fIaijXvb2wzsPtM6eieXJJEkuBkfZIroq/6Tyc0fQdU60DpWEilv2VJPrc=
X-Received: by 2002:a05:6402:2c5:: with SMTP id b5mr12397921edx.45.1570780204623;
 Fri, 11 Oct 2019 00:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130226.7449-5-chriscool@tuxfamily.org> <20191010234040.168894-1-jonathantanmy@google.com>
In-Reply-To: <20191010234040.168894-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 11 Oct 2019 09:49:53 +0200
Message-ID: <CAP8UFD0-NHCj6KcbdMG3bCwWp=wUdoYugLggsbnpvr1d6-P4yg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] ewah/bitmap: always allocate 2 more words
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 1:40 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > In a following patch we will allocate a variable number
> > of words in some bitmaps. When iterating over the words we
> > will need a mark to tell us when to stop iterating. Let's
> > always allocate 2 more words, that will always contain 0,
> > as that mark.
>
> [snip]
>
> >       if (block >= self->word_alloc) {
> >               size_t old_size = self->word_alloc;
> > -             self->word_alloc = block * 2;
> > +             self->word_alloc = (block + 1) * 2;
> >               REALLOC_ARRAY(self->words, self->word_alloc);
> >               memset(self->words + old_size, 0x0,
> >                       (self->word_alloc - old_size) * sizeof(eword_t));
>
> This patch set was mentioned as needing more thorough review in "What's
> Cooking" [1], so I thought I'd give it a try.

Thanks!

> As Peff said [2], the
> justification in the commit message looks incorrect. He suggests that it
> is most likely because "block" might be 0 (which is possible because a
> previous patch eliminated the minimum of 32), which makes sense to me.

Ok I will try to come up with a better justification, though Peff said
that he would took another look at this series and I'd rather wait
until he has done that.

> In any case, the next patch does not use 0 as a sentinel mark. Iteration
> stops when word_alloc is reached anyway, and since this is a regular
> bitmap, 0 is a valid word and cannot be used as a sentinel. (Maybe 0 is
> a valid word in a compressed EWAH bitmap too...not sure about that.)

Yeah I misread this. Hopefully Peff can shed some light on this.

> I think this should be squashed with patch 3, adding to that commit
> message "since word_alloc might be 0, we need to change the growth
> function". (Or just make the minimum word_alloc be 1 or 32 or something
> positive, if that's possible.)

Yeah, thank you for the suggestion. I still wonder why 2 is added
instead of just 1 though.
