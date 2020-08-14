Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B2BC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAEC20866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHNMkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:40:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:58998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHNMkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:40:12 -0400
Received: (qmail 31796 invoked by uid 109); 14 Aug 2020 12:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 12:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24801 invoked by uid 111); 14 Aug 2020 12:40:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 08:40:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 08:40:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200814124011.GA4104592@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
 <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
 <20200804192053.GA1400936@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
 <20200812141958.GA32453@coredump.intra.peff.net>
 <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
 <20200812160653.GA42443@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 02:08:28PM +0200, Johannes Schindelin wrote:

> On Wed, 12 Aug 2020, Jeff King wrote:
> 
> > From my perspective as somebody who does not work on Windows, I wonder
> > how much value there is in running vsbuild _and_ Windows CI for average
> > developers. I have certainly gotten information from these jobs (e.g.,
> > when introducing a portability problem, or missing a refactoring spot in
> > Windows-only code). But I don't think I've ever gotten information from
> > vsbuild that wasn't also in the regular windows build.
> 
> There have not been a _ton_ of these instances, but there have been a
> couple:

Thanks, that was exactly the kind of data I was interested in.

> I cannot find any more instances, so yes, I agree that the
> `vs-build`/`vs-test` jobs might not be _all_ that necessary. So maybe we
> should do something like this?

Let's leave it be for now. The topics I had to adjust due to cmake were
ones that I'd had sitting around for a while. So while I hit problems
immediately, now that the queue is drained it's not clear to me how
often it will come up in practice.

> -- snipsnap --
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 30425404eb3..2549fff8edd 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -122,7 +122,7 @@ jobs:
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    vs-build:
>      needs: ci-config
> -    if: needs.ci-config.outputs.enabled == 'yes'
> +    if: (github.repository == 'git/git' || github.repository == 'gitgitgadget/git') && needs.ci-config.outputs.enabled == 'yes'

If we do go this route, I'd consider defaulting it to on and just
letting people disable it through needs.ci-config.outputs.vsbuild or
similar.

-Peff
