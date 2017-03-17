Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34B420951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdCQWjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:39:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46247 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdCQWjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:39:40 -0400
Received: (qmail 4265 invoked by uid 109); 17 Mar 2017 22:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 22:37:45 +0000
Received: (qmail 7480 invoked by uid 111); 17 Mar 2017 22:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 18:37:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 18:37:41 -0400
Date:   Fri, 17 Mar 2017 18:37:41 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317223741.qwfh2zw37y3jbeev@sigill.intra.peff.net>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
 <20170317184701.GB110341@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317184701.GB110341@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 11:47:01AM -0700, Brandon Williams wrote:

> While taking a look at this bug I discovered that the test suite doesn't
> pass 100% of the test when compiled with the NO_PTHREADS option. The
> following tests seem to be failing:
> 
> t1060-object-corruption.sh                       (Wstat: 256 Tests: 13 Failed: 3)
>   Failed tests:  7-9
>   Non-zero exit status: 1
> t5306-pack-nobase.sh                             (Wstat: 256 Tests: 4 Failed: 1)
>   Failed test:  4
>   Non-zero exit status: 1
> t5504-fetch-receive-strict.sh                    (Wstat: 256 Tests: 12 Failed: 2)
>   Failed tests:  4-5
>   Non-zero exit status: 1
> t5530-upload-pack-error.sh                       (Wstat: 256 Tests: 10 Failed: 1)
>   Failed test:  10
>   Non-zero exit status: 1
> 
> I didn't take a close look at it but this would seem to indicate that we
> don't worry to much about systems without pthreads support.  Just food
> for thought.

Hmm. We used to. What version did you test? Everything passes for me at
0281e487f^ (after that it fails to build). So AFAICT v2.12.0 is the
first release which does not work with NO_PTHREADS.

-Peff
