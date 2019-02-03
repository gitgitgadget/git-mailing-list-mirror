Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102571F453
	for <e@80x24.org>; Sun,  3 Feb 2019 11:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBCLBj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 3 Feb 2019 06:01:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34711 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfBCLBj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 06:01:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so2683778qtj.1
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 03:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UettPFJPQbJO9Eq9YKxc0yiHoZ3FK2hG8ybVXOyNXiI=;
        b=lTM+WGhbHoDDkESGtp3epBq7BLbVtcxpeGk8t1xWmmZp4xa/sv8LMbqT7yrehnfthp
         Fs5MABGdox4blTktfXJsp5Uk6fo+5Bn2ANZ2+rEpusijO0H3gArcffYlQYRDPwyyV+fh
         32nVF/m9idlq3beYLKMvjxO4WXhyJjnSeW04GxzmR5vIr+iBTFoL1m9MUEmkoS8p0hmX
         Xrho2u/ItllhQXVt2k4tMpqWxXgX6MpPkLJWf7MZ1fB4x1XYosCG8zlfyh0j5HU4hRX/
         +XN8jIDaWYwXU+MJ59w82yDh+mDAiVqEjVqZ5peB43+ZMPlLUfAf3+tfkoD0GznDqKAC
         ESPw==
X-Gm-Message-State: AJcUukf/Yk360CHiv9dUmmbWcdJP/IHOb/Y/1lr18KMPAq3TbAlaAnHm
        t6XRTTVnuMdHIa/QtSa1DnB5axeRd6RxUbpTSAw=
X-Google-Smtp-Source: ALg8bN4hvc+6oiDCdLXx7S63EiKQoV+IafXxPenkz2wzilCi0cDW6LyyXH45we4gcY5QOcOtT0UF6bE/H8I0j3qOhLc=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr45101006qth.335.1549191698269;
 Sun, 03 Feb 2019 03:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20190203083545.5877-1-martin.agren@gmail.com> <CAPig+cRN_Jw_vj5=RWZJWp-Wn6-=Vd9oZKQieMWJ02TjAHWwWg@mail.gmail.com>
 <CAPig+cQYuwMmyw8_p863BeSU5RP-xdB=HFMa7EM4G3YALQj3_g@mail.gmail.com> <CAN0heSohuL=TBOLR+Q9=zrGhZrrjSgfvA=VeT-aA0gr57onAsg@mail.gmail.com>
In-Reply-To: <CAN0heSohuL=TBOLR+Q9=zrGhZrrjSgfvA=VeT-aA0gr57onAsg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Feb 2019 06:01:27 -0500
Message-ID: <CAPig+cT32oi5HLe7tokghrCmaiECwAXxON8U7DrpMYb3GCSNyQ@mail.gmail.com>
Subject: Re: [PATCH] doc-diff: don't `cd_to_toplevel` before calling `usage`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 3, 2019 at 5:37 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Sun, 3 Feb 2019 at 10:12, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sun, Feb 3, 2019 at 4:08 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > I wonder if a more fruitful, longer-term fix which would save us from
> > > having to worry about this in the future, would be to make
> > > git-sh-setup.sh remember the original $0 before cd_to_toplevel() and
> > > then employ the original value when usage() re-execs with the -h
> > > option. That would also avoid the slightly ugly repeated
> > > cd_to_top_level() and 'tmp' assignment in this patch.
> >
> > By "original $0", I meant a path which would be suitable for
> > re-exec'ing (which wouldn't be the literal original $0). Sorry for the
> > confusion.
>
> Ok, so I am not too eager to try and tackle this with fallback
> strategies and what-not. What would you say if I punted on this? I could
> add something like this to the commit message:
>
>   A more general fix would be to teach git-sh-setup to save away the
>   absolute path for $0 and then use that, instead. I'm not aware of any
>   portable way of doing that, see, e.g., d2addc3b96 ("t7800: readlink
>   may not be available", 2016-05-31), so let's just fix this user
>   instead.
>
> What do you think? Thanks for your comments.

Punting and extending the commit message like that sounds reasonable.
