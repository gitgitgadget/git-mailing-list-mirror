Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225691F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCRJUE (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:20:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751031AbeCRJUE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:20:04 -0400
Received: (qmail 2783 invoked by uid 109); 18 Mar 2018 09:20:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 18 Mar 2018 09:20:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10487 invoked by uid 111); 18 Mar 2018 09:20:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 18 Mar 2018 05:20:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2018 05:20:01 -0400
Date:   Sun, 18 Mar 2018 05:20:01 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
Message-ID: <20180318092001.GA29208@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
 <20180318090607.GA26226@flurp.local>
 <CACsJy8BGZV1hHKNzDaFkt=9zfhzv+GR1JUN-fOcQRk_2+tctZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8BGZV1hHKNzDaFkt=9zfhzv+GR1JUN-fOcQRk_2+tctZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 10:17:41AM +0100, Duy Nguyen wrote:

> On Sun, Mar 18, 2018 at 10:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sun, Mar 18, 2018 at 09:18:34AM +0100, Nguyễn Thái Ngọc Duy wrote:
> >> The set of extra warnings we enable when DEVELOPER has to be
> >> conservative because we can't assume any compiler version the
> >> developer may use. Detect the compiler version so we know when it's
> >> safe to enable -Wextra and maybe more.
> >>
> >> Helped-by: Jeff King <peff@peff.net>
> >> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> ---
> >> diff --git a/detect-compiler b/detect-compiler
> >> --- /dev/null
> >> +++ b/detect-compiler
> >> @@ -0,0 +1,50 @@
> >> +get_version_line() {
> >> +     "$CC" -v 2>&1 | grep ' version '
> >> +}
> >
> > On MacOS, "cc -v" output is:
> >
> > --- >8 ---
> > Apple LLVM version 9.0.0 (clang-900.0.39.2)
> > Target: x86_64-apple-darwin16.7.0
> > Thread model: posix
> > InstalledDir: ...
> > --- >8 ---
> 
> Does it still build ok for you with your changes squashed in? I think
> the check for clang4/gcc6 and setting -Wextra in config.mak.dev may
> backfire because clang9 probably has a lot more warnings enabled and
> some of them we don't want and cause compile error...

I don't think we can predict that going forward, though. We'd have to
wait for people to use the new compiler and then send a patch disabling
whatever causes a problem (or better yet, fixing the code if
appropriate).

This framework can only help us write those patches; I don't think it
can save us from having to do them in the first place.

-Peff
