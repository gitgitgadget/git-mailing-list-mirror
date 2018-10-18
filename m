Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89661F453
	for <e@80x24.org>; Thu, 18 Oct 2018 03:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJRLjn (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 07:39:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37123 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 07:39:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so4224852wmt.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CGIqkfklHtFntDlGOWyfWN7nEON4vMLgBAZj2PlsDbs=;
        b=g3ZiLWsqvJ5egNtqHz3VmofBlZX0w1Qegc9cxHPlcJq4Wxwjs0mhgnpdHBKzeO22Lg
         2N4Y8JnAuyoFjrEx2Vuz1GyIMyq8ANqzK6+yBf/sGm5LCHjWwM45q1KCZOfvg3kyBM7m
         vdNklsUsQZ+L7dbiJuH1Lq8gF1v6rnA9Wox9T2q2Xp8GH+QzvnoakVLNbyDABBIqvpRc
         K2m4gxXRkXGnEUpEm7DpcpAqWmxuiMXUayULWXqiDvmuQQ9Xj7LKNH7sTJLCx9GZwJaO
         +TT3bjvlREGz5BnyrA3qmXH6tdx/Wh61p1J4Iv23/jLDHdXtey1QqscbPR8yZJat/DOu
         NM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CGIqkfklHtFntDlGOWyfWN7nEON4vMLgBAZj2PlsDbs=;
        b=A81Ak1amOhsMHnhnZheC5ddgSTOwVV0kIKbEmUeBIICEPCxRQN6MT7kET+aivFes+J
         is8E2lArMNQnv9bLnFJdscmj08NOnlJnv9bp6ytG+hHuuPjgAFjFPG3RrMWyg3dB1q31
         i7Bx0ThoDlnLbvOm5YOl9PPzgc638+oN8VkDnqe+plY00Njf8j4q2PXwOpnlGapcmQsc
         2besCj0YG2++40Vp8cXVGER/LR8YKqBe3ffOkeuoHz9e1eMOujuknYc7At98hQnnDm/N
         BvoxMV8JswQLH+GBWN/13WuC2Ydq4zlHB9B42TBYHZhAbyabcNCtuCcCdU/ROZET8LpE
         YjRw==
X-Gm-Message-State: ABuFfoiitFBs51V1RLr7zPq65f7roytuUOfUmqG/yrQLb1paf/lnQz3S
        g1tMzA2TsUUPaR2XXm9dh1I=
X-Google-Smtp-Source: ACcGV60EIm2oi3QX9VXfhZodOiEh+ZP/lp0djMsv/AsacgyC5TaGbvtGNbcbf4yKshuzGnsE0pkU5A==
X-Received: by 2002:a1c:b402:: with SMTP id d2-v6mr5506011wmf.37.1539834050117;
        Wed, 17 Oct 2018 20:40:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t18-v6sm6770672wrm.26.2018.10.17.20.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 20:40:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset when --quiet
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181017164021.15204-2-peartben@gmail.com>
        <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
        <20181017182255.GC28326@sigill.intra.peff.net>
Date:   Thu, 18 Oct 2018 12:40:48 +0900
In-Reply-To: <20181017182255.GC28326@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 17 Oct 2018 14:22:56 -0400")
Message-ID: <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Whereas for the new config variable, you'd probably set it not because
> you want it quiet all the time, but because you want to get some time
> savings. So there it does make sense to me to explain.
>
> Other than that, this seems like an obvious and easy win. It does feel a
> little hacky (you're really losing something in the output, and ideally
> we'd just be able to give that answer quickly), but this may be OK as a
> hack in the interim.

After "git reset --quiet -- this/area/" with this change, any
operation you'd do next that needs to learn if working tree files
are different from what is recorded in the index outside that area
will have to spend more cycles, because the refresh done by "reset"
is now limited to the area.  So if your final goal is "make 'reset'
as fast as possible", this is an obvious and easy win.  For other
goals, i.e. "make the overall experience of using Git feel faster",
it is not so obvious to me, though.

If we somehow know that it is much less important in your setup that
the cached stat bits in the index is kept up to date (e.g. perhaps
you are more heavily relying on fsmonitor and are happy with it),
then I suspect that we could even skip the refreshing altogether and
gain more performance, without sacrificing the "overall experience
of using Git" at all, which would be even better.

> The sad thing is just that it's user-facing, so we have to respect it
> forever. I almost wonder if there should be a global core.optimizeMessages
> or something that tries to tradeoff less information for speed in all
> commands, but makes no promises about which. Then a user with a big repo
> who sets it once will get the benefit as more areas are identified (I
> think "status" already has a similar case with ahead/behind)? And vice
> versa, as some messages get faster to produce, they can be dropped from
> that option.
>
> I dunno. Maybe that is a stupid idea, and people really do want to
> control it on a per-message basis.
>
> -Peff
