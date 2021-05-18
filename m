Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC1CC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E366113C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhERNWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhERNWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:22:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312CC061756
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:21:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c196so1546548oib.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3u/L9ENQPYvvO+UBnsQEn8fZpm1rD5NgXKz8QRd3YKw=;
        b=ZEBa/TJCcJFiJns/RCb+nPpEUIWYSKWPVS/r4UOGKFr40/Mzwjg9P7q4GExxOnwwUW
         ywoWaiFGv+L1b9Qj1iagGQrwNvBD8oFq9DYVhDRtYwjn4CX595gv5qwvIuN0WZPow9Cf
         UNj4q6D5FkX0wk3ff+2yigxVD0QYAYMOq2x94+zNlqDO+7vvM86uCDRZgBjUXIOvxwbF
         quHLiF4KpFoscA2/Ut1upqXLJMwZKKuV1EI9ykzEvd1Fb5SfTTc/Cmzo2jeyp0/Q/xLX
         ndorL4I7VYtdeyIkqPgBfdoYvlR+kVq+zOXJCkOwVSJrajjN3p8ZB/U4kA9ENDTuj/YV
         I5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3u/L9ENQPYvvO+UBnsQEn8fZpm1rD5NgXKz8QRd3YKw=;
        b=bcuTgx1jgwfWp/sCZ6f5fS7FCleDoXWcz0wYcz1nw4IWThaHS2uBJOKa+5hfcx4YLF
         xMhLMtuo0ALD3l41oNXPiAy22ZNMi85aVG2drl8FkIGuWQCGNSHdalNxCX1oKtz/fzkl
         LWra8yUXQ8yYAGlV4zDLtp+VTonC/i7e9MMpLwhqdFYS7SUuRZhFUhZcB8u9esH4Eo8G
         P+x28LIHgOFpmovsNJloTZibWUY6NNHleyamk9DFhfEJdCmCDr+deWui+P1tKMczjf7f
         Orihzp/OUa9pVkhkxKx4UkVw7HsTR5Tt4O/HRtbGSkKLurfmtPoxVJO1q3mYcjqCHu2a
         fhVw==
X-Gm-Message-State: AOAM533Td0992tm8kjVVuXq2ZDAis3OgpLuckyF/JIufIY+Bpq6OiQ8p
        8W8RW7/CxxKIPFc8U7/QBsI=
X-Google-Smtp-Source: ABdhPJyCf4NGCs7xNm8Ik4d84DyRbY3M7pDonY+b8TyQf1HGEbHdn5BOD9JBZdZRUGaO5lEM2rwuwg==
X-Received: by 2002:aca:f008:: with SMTP id o8mr3963575oih.106.1621344087804;
        Tue, 18 May 2021 06:21:27 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t69sm43156oif.28.2021.05.18.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 06:21:27 -0700 (PDT)
Date:   Tue, 18 May 2021 08:21:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Message-ID: <60a3bf5624cbc_15198720876@natae.notmuch>
In-Reply-To: <YKNptH9DL6pe18Dk@coredump.intra.peff.net>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <xmqqlf8d6ty5.fsf@gitster.g>
 <60a2f1c4cab0d_13c3702083a@natae.notmuch>
 <xmqqim3g4ys5.fsf@gitster.g>
 <60a3422b9556c_14d1bc2082f@natae.notmuch>
 <YKNptH9DL6pe18Dk@coredump.intra.peff.net>
Subject: Re: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 17, 2021 at 11:27:23PM -0500, Felipe Contreras wrote:
> 
> > > So in short, the color.pager is about "is the pager capable of
> > > colors?"
> > 
> > That's not the case.
> > 
> > Even the documentation says so:
> > 
> >   color.pager::
> >     A boolean to enable/disable colored output when the pager is in
> >     use (default is true).
> 
> I think that documentation misses the reason you'd want to use it.
> Likewise, the commit message introducing it (aa086eb813d) sucks,

Well, it was 2006. Many of the best practices of today were not followed
back then.

> but the
> motivation (from [0]) was:
> 
>   When I use a pager that escapes the escape character or highlights the
>   content itself the output of git diff without the pager should have
>   colors but not with the pager.  For example using git diff with a
>   pathspec is quite short most of the time.  For git diff I have to
>   enable paging manually and run git diff | $PAGER usually but git log
>   uses the pager automatically and should not use colors with it.

This is aligned with what I said: the uswer wants to disable colors when
using a pager.

Yes, in this instance it's because the pager doesn't support colors, but
that's not always necessarily so. A person with sight problems may use
less (perfectly capable of colors), but yet not want to exercise that
capability.

It's still a preference.

> For a more concrete example, my pager _does_ understand colors, and I
> would not want to set pager.color to "false" (because then "git log",
> etc, would not show me any colors). But I don't like the man colors you
> are suggesting.

You can change them in your environment.

> I want to be able to turn them off by setting "color.man" or similar
> to false, not by disabling color for everything that is paged.

Sure, for that particular case it does make sense. I'll add that.

> So color.pager being true is _necessary_ for showing colors in paged
> outputs, but by itself is not sufficient. We have other per-context
> color options (color.diff, color.branch, and so on).
> 
> And so likewise, we would want to avoid turning on colors if the user
> has set color.pager=false. Usually this is done automatically because
> want_color() checks, which knows if we are using the pager or not. But
> if we are going to call out to "man" which will invoke another pager,
> that caller would have to check pager_use_color themselves (it's yet
> another question of whether "the pager can handle color" applies equally
> to the pager that Git will run versus the one that man will run).

Yes, but we still need to check pager_use_color.

Except... Maybe a user has GIT_PAGER set to a colorless pager, and
MANPAGER to something fancier, in which case color.pager should be
ignored. But that's probably a corner-case nobody is ever going to hit.

Anyway, I've sent an update version with color.man.

-- 
Felipe Contreras
