Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64C420196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbcGNTp0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:45:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:44876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751160AbcGNTp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:45:26 -0400
Received: (qmail 12357 invoked by uid 102); 14 Jul 2016 19:45:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 15:45:25 -0400
Received: (qmail 7839 invoked by uid 107); 14 Jul 2016 19:45:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 15:45:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 15:45:22 -0400
Date:	Thu, 14 Jul 2016 15:45:22 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160714194522.GA17798@sigill.intra.peff.net>
References: <20160714173920.22001-1-sbeller@google.com>
 <20160714173920.22001-3-sbeller@google.com>
 <xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZgJ_6fxZ19Hx6zd6KoTAd_+oMjb4fj1twY2ZGUHP7wHA@mail.gmail.com>
 <xmqqfurcqbrw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfurcqbrw.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 12:07:15PM -0700, Junio C Hamano wrote:

> > Although as you remarked in another email, this would not pose a problem for
> > the shell variable, so we could also drop it to allow multi line
> > options. will do.
> 
> One thing to note is that I do not think there is a guarantee that
> packet_buf[] is NUL-terminated, and when len == LAGE_PACKET_MAX, you
> do not have room to NUL-terminate it yourself.

packet_read() does NUL-terminate for you. It gets the extra bytes
because it doesn't store the 4-byte size in the output (whereas the
client does not ever send anything over LARGE_PACKET_MAX, _including_
those bytes, so we always have room to store its result in our
LARGE_PACKET_MAX buffer, plus the NUL, with 3 bytes to spare).

-Peff
