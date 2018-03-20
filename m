Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950491F404
	for <e@80x24.org>; Tue, 20 Mar 2018 05:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeCTFcY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 01:32:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:35512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750888AbeCTFcW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 01:32:22 -0400
Received: (qmail 692 invoked by uid 109); 20 Mar 2018 05:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 05:32:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29378 invoked by uid 111); 20 Mar 2018 05:33:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 01:33:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 01:32:20 -0400
Date:   Tue, 20 Mar 2018 01:32:20 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
Message-ID: <20180320053220.GB15813@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
 <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 04:55:25PM +0100, Duy Nguyen wrote:

> On Sun, Mar 18, 2018 at 9:18 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
> > +CFLAGS += -Wextra
> 
> Another thing we can add here is -Og instead of standard -O2 (or -O0
> in my build), which is supported since gcc 4.8. clang seems to support
> it too (mapped to -O1 at least for clang5) but I don't know what
> version added that flag.

I don't know, that feels kind of weird to me. I thought DEVELOPER was
supposed to mean "ratchet up the linting, I want to know if I've broken
something".

But tweaking -O is about "I am in an edit-compile-debug cycle".
Sometimes you are and sometimes you aren't, but you'd presumably want to
have extra warnings regardless (especially because some warnings only
trigger under particular optimization settings).

Personally, I default to -O0, but then crank up to -O2 for performance
testing or for my daily-driver builds. But I _always_ have as many
warnings enabled as possible[1].

-Peff

[1] I do have some pretty horrific magic to turn on -Werror when I'm
    visiting a "historical" commit, such as during a bisect.
