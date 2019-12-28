Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2BC2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7376F20409
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDUC+neR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfL1Myi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 07:54:38 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:39629 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfL1Myh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 07:54:37 -0500
Received: by mail-pj1-f44.google.com with SMTP id t101so6127321pjb.4
        for <git@vger.kernel.org>; Sat, 28 Dec 2019 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrXLsqWV7FheknKcwPAf05hj/QZB/ZPs+S/bMLjoyok=;
        b=bDUC+neRrAFuad/DdESRvNKevt+JZiju4coZwvK9JSky6wJz/SCgxjExnPZeb0NpOr
         aIr0dkM1OcbDSv7B6AfOFiEJWrU9lCspa9NvnXHV1F347k7FKhqEHtt22F9cZwhVXb2e
         PM4PaXPEK1xfdV815G3G2Ffoxr7mAdpSMSFksUNZ7tTqFSumzySXuVXaMA7/Z6JtXBDP
         oS4a9OAJhmiDYA/Uw8hDPwjTAdrUJdgJxUd5xFrZ0B9GjuZilK/mdod0P1oAwdrqc8MU
         9CIfwgCe7obbxFOrFSUaNulvtiu/w5JB8vZNqBLq3W9WY9nPvzF8cpr4kMMF1AVjQsgN
         9qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrXLsqWV7FheknKcwPAf05hj/QZB/ZPs+S/bMLjoyok=;
        b=jUmDdpqMx93afFYjnBClkzQl6QXsoHhll+UYu+47TL7TT33frFX9qf6fS5zBrxwJuh
         gV9I0heP7USI+8zK81az63uVJuyZg2N79OLnsSPS1AJFSD9O3PX15MvFeecZ5Kv29JT3
         yPrHRIE9TL3BTjK7jyyO2fVupxddHJd8RyhrIkghQanoY6gAOtknOcSbNwgcCIv4hc4/
         vipKxTDyVMqoMYlA/VsFws07u3y1mDptMcbNp2nlBGtJfnATurPaz4sTGHxLyCacKmUq
         HUeu0V1zPzLg2rbn7uCFvIAkkmnmzmIoJ5DPnVhMcl+jhw+gMijNVYAlBMcbKTADK4WN
         jaWw==
X-Gm-Message-State: APjAAAXgzZwkS/z+TcD/AkcuN9H8SKKffo90/Vau4n8GNdcUrSoxCbHd
        YCMC+Cm9IdOCl9FT4+THUxhYqQ2j
X-Google-Smtp-Source: APXvYqwKbpLokUfvUNMqjjBbvs5MoXPVT5mJgPvoUgnOKThKVUSMexJAXC4T3vdAxIiAtH5X/d0kOw==
X-Received: by 2002:a17:90b:344f:: with SMTP id lj15mr33832178pjb.0.1577537676911;
        Sat, 28 Dec 2019 04:54:36 -0800 (PST)
Received: from localhost ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id m71sm17499042pje.0.2019.12.28.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 04:54:36 -0800 (PST)
Date:   Sat, 28 Dec 2019 19:54:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
Message-ID: <20191228125433.GC24268@danh.dev>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
 <20191226143527.GA24268@danh.dev>
 <xmqq4kxnm0w6.fsf@gitster-ct.c.googlers.com>
 <20191227113858.GB24268@danh.dev>
 <xmqq36d5jtck.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36d5jtck.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-12-27 14:28:59-0800, Junio C Hamano <gitster@pobox.com> wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> > Some of my projects requires ASCII-only user.name,
> > instead of doing the right thing
> >
> > 	git config user.name <simplified-name>
> >
> > I decided to set it globally instead.
> > I rarely need to type in my native language,
> > hence I don't have the IME software start with Xorg.
> 
> Hmph, but back in v2.20 days, you did have IME?

Back in the days, I had my IME started on logging in,
then to save some tiny time on starting up,
I turned it off.
> 
> In any case, if I were in such a situation to need my name spelled
> differently depending on the project I work on, I would probably use
> 
> 	$ git config --global user.name <simplified-name>
> 	$ cd <repository of git>
> 	$ git config user.name <name-with-accents>
> 
> or the other way around (depends on which projects your focus is on).

Yes, that's the the right way to do, but I didn't pick that way.
I'm going through my ~/src and fixing it.

Thanks,

-- 
Danh
