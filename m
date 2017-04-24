Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2627E207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 01:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163944AbdDXBnp (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 21:43:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38785 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163891AbdDXBno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 21:43:44 -0400
Received: (qmail 21548 invoked by uid 109); 24 Apr 2017 01:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 01:43:43 +0000
Received: (qmail 2879 invoked by uid 111); 24 Apr 2017 01:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Apr 2017 21:44:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Apr 2017 21:43:40 -0400
Date:   Sun, 23 Apr 2017 21:43:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
Message-ID: <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
 <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
 <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 05:14:54PM -0700, Junio C Hamano wrote:

> OK.  I am wondering why we do not do 
> 
> 	rm -fr "$TRASH_DIRECTORY"
> 
> and do this instead:
> 
> 	cd "$(dirname "$remove_trash")" &&
> 	rm -rf "$(basename "$remove_trash")"
> 
> in the original.  It feels somewhat unnatural.

I assumed the "cd" was there because some systems may be unhappy
removing a directory which is our current working directory. That might
just be superstition, though.

The use of "basename" in the second does seem superfluous, since the
trash directory should be the full path (I suspect it wasn't in the
early days, though).

> So perhaps we can simplify and make it more robust by doing this?
> [...]
> +		if test -z "$debug"
> +		then
> +			test -d "$TRASH_DIRECTORY" ||
> +			error "Tests passed but trash directory already removed before test cleanup; aborting"
> +
> +			rm -fr "$TRASH_DIRECTORY" ||
> +			error "Tests passed but test cleanup failed; aborting"
> +		fi

That looks fine, assuming the answer to the "is the cwd important"
question is "no".

-Peff
