Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12153C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKDMon (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDMom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:44:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3D6258
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:44:41 -0700 (PDT)
Received: (qmail 18638 invoked by uid 109); 4 Nov 2022 12:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 12:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29400 invoked by uid 111); 4 Nov 2022 12:44:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 08:44:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 08:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <Y2UJNzA1n498pThw@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
 <20221104123722.GA6942@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104123722.GA6942@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 01:37:22PM +0100, SZEDER Gábor wrote:

> This bogus state didn't last long, however, because in the same patch
> series 06f5608c14 (bisect--helper: `bisect_start` shell function
> partially in C, 2019-01-02) the C reimplementation of bisect_start()
> started calling the bisect_write() C function, this time with the
> right 'nolog' function parameter.  From then on there was no need for
> the '--no-log' option in 'bisect--helper'.  Eventually all bisect
> subcommands were ported to C as 'bisect--helper' command modes, each
> calling the bisect_write() C function instead, but when the
> '--bisect-write' command mode was removed in 68efed8c8a
> (bisect--helper: retire `--bisect-write` subcommand, 2021-02-03) it
> forgot to remove that '--no-log' option.

Yeah, but I don't think "--log" or "--no-log" is really the bug, is it?

The same thing happens if my command is "echo --bisect-run". Obviously
that's less likely, but the bug is still that we are parsing random
options out of the supposedly opaque command.

-Peff
