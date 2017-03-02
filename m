Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353101F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750787AbdCBTNn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:13:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:37367 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdCBTNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:13:42 -0500
Received: (qmail 30112 invoked by uid 109); 2 Mar 2017 19:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 19:12:04 +0000
Received: (qmail 20711 invoked by uid 111); 2 Mar 2017 19:12:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 14:12:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 14:12:01 -0500
Date:   Thu, 2 Mar 2017 14:12:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org, mac@mcrowe.com
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170302191201.nhhucl44dwmcqkb4@sigill.intra.peff.net>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
 <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net>
 <xmqqmvd3d0ru.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvd3d0ru.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 09:52:21AM -0800, Junio C Hamano wrote:

> >> +		 * and is_binary check being that we want to avoid
> >> +		 * opening the file and inspecting the contents, this
> >> +		 * is probably fine.
> >> +		 */
> >>  		if ((flags & CHECK_BINARY) &&
> >>  		    s->size > big_file_threshold && s->is_binary == -1) {
> >>  			s->is_binary = 1;
> >
> > I'm trying to think how this "not strictly correct" could bite us. 
> 
> Note that the comment is just documenting what I learned and thought
> while working on an unrelated thing that happened to be sitting next
> to it.

Yeah, sorry, this is obviously not a blocker to your patch. I'm just
wondering if there is more work needed.

> To be quite honest, I do not think this code should cater to LFS or
> any other conversion hack.  They all install their own diff driver
> and they can tell diff_filespec_is_binary() if the thing is binary
> or not without falling back to this heuristics codepath.

Yeah, you're right, I was just being silly. Whatever configured the
filter already has an opportunity to give us this knowledge in a better
way, and we should rely on that.

-Peff
