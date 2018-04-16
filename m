Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE881F404
	for <e@80x24.org>; Mon, 16 Apr 2018 01:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDPBoH (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 21:44:07 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34712 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDPBoG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 21:44:06 -0400
Received: by mail-wr0-f179.google.com with SMTP id d19so21487550wre.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+OsG3lYW5S1B2Lt2fooUmwKjNng0Mhr6nAxA9P2UAMw=;
        b=fLXhl4ZKYfClTev+9hnmSrhmT1vNtP051eykmI1H/dKKYfJDkMVIaGXHw6WuIGkLMI
         ipbdga9x1yNbg0+k3emjn5A7xKQdGiaeMKdgUR1Be1M4osELm+9KWEkVqwj1mLv4QNng
         mnM9Uq4tSl37q88KR55OC92NORWJy7jDWUUyo6zXGgk69UQ27U8GLzt3ZNOGu5EBgL3h
         B8SPcqB0dk7GnSEl7ObVhO+DroP6o6P2qTGtZEWUofK0WqMu8TQygsL/Stvn6mkwfBeM
         F/NwBFpNu2XongtphIAK3DLWNWeLsV2ojThslEjYT0ywOy8VAI5+m7Ph8dUW+t3IVcYy
         MPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+OsG3lYW5S1B2Lt2fooUmwKjNng0Mhr6nAxA9P2UAMw=;
        b=mv4yCXFMS8QIfR8paBTeQXlj5JBj8OWS/h6AW80uI+0AZX7L7ZedRg2RCryFrVT0nL
         mhBMfGz4pD8ADE5Y8Orf7vEL5fRb/6WE6k1ey1kgvdA5HvwcAXpTnvN+5bxxCMq7gmXC
         IhptxUOt/PZmIjf06IlW3RnrSvLxSV6rwZkB5OR/H6SYTwixBm5ymAGcSVeJWcXTW3Mv
         oW5ejH7WvODvlRnozrtYsVqjfBNzM/qXxxMOAiN1WhdPTXmBTVlhClQzOv7DXMbDx/0j
         fma6Ndw+KdiNkcKf20Ohk9rJHHSWlX8KlcrHiGZi62gGxKQzuwftOvLiaayZ//03dtoa
         jAIw==
X-Gm-Message-State: ALQs6tBwSza2pBP3ytkAKTdh9r9rPcANk/qpVImJFOm4Ztoibpc4ZERR
        tRwrjPEnYLxSMSYxBIpSDDw=
X-Google-Smtp-Source: AIpwx48dFVhS4fLirDogZ/MsAXPLLp56Tf+EswKAr3vVQ1QK7ARDNicZOX9rE4UJ1+7alQCro2bY2g==
X-Received: by 10.223.144.35 with SMTP id h32mr1862748wrh.167.1523843044642;
        Sun, 15 Apr 2018 18:44:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 64sm7359396wmb.2.2018.04.15.18.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 18:44:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
        <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
        <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
        <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
        <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
        <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
        <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
Date:   Mon, 16 Apr 2018 10:44:03 +0900
In-Reply-To: <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 13 Apr 2018 10:14:26 -0700")
Message-ID: <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> How about we take a completely different approach? Instead of relying
> on fragile (but clever) tests, why not rely on stupid brute force?
>
> Yeah, yeah, it's bad to be stupid, but sometimes simple and stupid
> really does work.
>
> See the attached patch. It gets rid of all the subtle "has this been
> renamed" tests entirely, and just _always_ does that final
> update_file().

I think Elijah's corrected was_tracked() also does not care "has
this been renamed".

One thing that makes me curious is what happens (and what we want to
happen) when such a "we already have the changes the side branch
tries to bring in" path has local (i.e. not yet in the index)
changes.  For a dirty file that trivially merges (e.g. a path we
modified since our histories forked, while the other side didn't do
anything, has local changes in the working tree), we try hard to
make the merge succeed while keeping the local changes, and we
should be able to do the same in this case, too.  

Your illustration patch that reads from the working tree to compare
with the contents we are about to write out of course won't cope
with this case ;-).  If we do things in the index like the approach
to fix was_tracked(), I suspect that we would just say "as long as
the index and the HEAD matches, i.e. we are keeping the pathas it is
found in HEAD as the merge result, we do not touch the working tree"
and leave such a local modification alone.

