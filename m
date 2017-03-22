Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D8920323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdCVVkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:40:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:49704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdCVVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:40:20 -0400
Received: (qmail 27873 invoked by uid 109); 22 Mar 2017 21:39:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:39:58 +0000
Received: (qmail 31982 invoked by uid 111); 22 Mar 2017 21:40:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 17:40:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:39:53 -0400
Date:   Wed, 22 Mar 2017 17:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 2/3] t7406: fix here-doc syntax errors
Message-ID: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-3-gitster@pobox.com>
 <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net>
 <CAGZ79kafNKwfLhE1nXyt5mc5-D-kdxRxDP9pV7gc3btvjiHV7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kafNKwfLhE1nXyt5mc5-D-kdxRxDP9pV7gc3btvjiHV7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 02:32:22PM -0700, Stefan Beller wrote:

> > But the submodule path seems wrong, too. I'm not sure if
> > the expectation is wrong, or if there's a bug. +cc Stefan
> 
> Yes the actual output is wrong, too.
> But that is not because Git is wrong, but the test suite is.
> 
>     test_must_fail git -C super submodule update >../actual &&
> 
> contains 2 errors:
> 
> * we are interested in stderr, so make it 2>
> * the -C switch doesn't apply to redirection. (obviously!)
>   So if you have run the test suite in a normal setup, you may have
>   a file "t/actual" which is empty. This is scary as it managed to break
>   out of the test suite and overwrote a potential file in your git.git.

Oh yeah, I didn't even look at the test itself, but I see I now have
t/actual in my repository. Yikes. That didn't happen before because it
simply sucked the entire command into the here document.

> I'll send a patch on top of the one under discussion momentarily.

I'd prefer if they come in a single patch so that we don't break bisect.

-Peff
