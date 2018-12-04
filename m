Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6CA211B4
	for <e@80x24.org>; Tue,  4 Dec 2018 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDGeF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 01:34:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:58194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725983AbeLDGeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 01:34:05 -0500
Received: (qmail 27338 invoked by uid 109); 4 Dec 2018 06:34:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Dec 2018 06:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17499 invoked by uid 111); 4 Dec 2018 06:33:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 01:33:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 01:34:03 -0500
Date:   Tue, 4 Dec 2018 01:34:03 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/lib-git-daemon: fix signal checking
Message-ID: <20181204063402.GA10178@sigill.intra.peff.net>
References: <20181126200337.32462-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126200337.32462-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 09:03:37PM +0100, SZEDER Gábor wrote:

> Test scripts checking 'git daemon' stop the daemon with a TERM signal,
> and the 'stop_git_daemon' helper checks the daemon's exit status to
> make sure that it indeed died because of that signal.
> 
> This check is bogus since 03c39b3458 (t/lib-git-daemon: use
> test_match_signal, 2016-06-24), for two reasons:
> 
>   - Right after killing 'git daemon', 'stop_git_daemon' saves its exit
>     status in a variable, but since 03c39b3458 the condition checking
>     the exit status looks at '$?', which at this point is not the exit
>     status of 'git daemon', but that of the variable assignment, i.e.
>     it's always 0.
> 
>   - The unexpected exit status should abort the whole test script with
>     'error', but it doesn't, because 03c39b3458 forgot to negate
>     'test_match_signal's exit status in the condition.
> 
> This patch fixes both issues.

Oof. Who says two wrongs don't make a right? :)

Thanks for catching this, and the patch looks obviously correct.

I peeked at the other test_match_signal conversions from that era, and
they all look sane.

-Peff
