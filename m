Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79B52021E
	for <e@80x24.org>; Mon, 31 Oct 2016 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945414AbcJaSF2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 14:05:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:36568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945400AbcJaSF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 14:05:27 -0400
Received: (qmail 14717 invoked by uid 109); 31 Oct 2016 18:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 18:05:26 +0000
Received: (qmail 20309 invoked by uid 111); 31 Oct 2016 18:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 14:05:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Oct 2016 14:05:24 -0400
Date:   Mon, 31 Oct 2016 14:05:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161031180524.ss37h4njdl3on53m@sigill.intra.peff.net>
References: <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
 <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610281306320.3264@virtualbox>
 <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
 <20161031135601.7immbp44wn7uksvs@sigill.intra.peff.net>
 <xmqqwpgotncb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpgotncb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 10:55:32AM -0700, Junio C Hamano wrote:

> > So I guess it's possible that it produces a noticeable effect in some
> > cases, but I'm still somewhat doubtful. And actually repacking your
> > repository had a greater effect in every case I measured (in addition to
> > providing other speedups).
> 
> Let's keep doubting.  I prefer one-step-at-a-time approach to
> things anyway, and what I plan in the near term are:
> 
>  * use the "open() with O_NOATIME|O_CLOEXEC, gradually losing the
>    bits during fallback" approach in the ls/git-open-cloexec topic,
>    in order to help ls/filter-process topic be part of the upcoming
>    release;
> 
>  * simplify the logic to the "open(2) with O_CLOEXEC, set O_NOATIME
>    with fcntl(2)" in jc/git-open-cloexec~1 after 2.11 ships;
> 
>  * cook "drop the latter half of setting O_NOATIME" which is at the
>    tip of jc/git-open-cloexec in 'next', and while Linus is looking
>    the other way ^W^W^W^W^W^W^W after people had chance to complain
>    with numbers, merge it to a future release iff it still looked OK
>    to drop O_NOATIME thing.

Great, that sounds like a good way to proceed (and if the final step
never happens, no big deal).

-Peff
