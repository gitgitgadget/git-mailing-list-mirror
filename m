Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69E81F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdLSQpf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 11:45:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:43236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751122AbdLSQpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:45:34 -0500
Received: (qmail 15489 invoked by uid 109); 19 Dec 2017 16:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Dec 2017 16:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3900 invoked by uid 111); 19 Dec 2017 16:46:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 19 Dec 2017 11:46:00 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec 2017 11:45:32 -0500
Date:   Tue, 19 Dec 2017 11:45:32 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
Message-ID: <20171219164532.GA6745@sigill.intra.peff.net>
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
 <20171219162528.GA5804@sigill.intra.peff.net>
 <xmqqlghywuct.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlghywuct.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 08:33:22AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is a build-time knob. When you build git, try:
> >
> >   make PERL_PATH='/usr/bin/env perl'
> >
> > (If you don't build your own git, then you might raise the issue with
> > whomever packages your binary).
> 
> I somehow thought ANYTHING_PATH was meant to point at the exact path
> (as opposed to ANYTHING_COMMAND which is a command line), so it is
> within our rights to do
> 
>     test -x "$GIT_EXEC_PATH" || die "Your Git installation is broken"
> 
> but your suggestion above makes such a sanity check impossible.

Hmm, you're right. Though it looks like it is only the test scripts
which actually use this feature. It would be nice if we supported this.
Unfortunately it's hard to make both of these work:

  make PERL_PATH='/usr/bin/env perl'

  make PERL_PATH='/path with spaces/perl'

We must protect the spaces in the latter case and treat it as a single
unit, but would not want to in the former.

In the meantime, pointing to the actual build-time perl is a workaround
(but obviously not if it's being done by a third-party packager who has
no idea where your perl is).

-Peff
