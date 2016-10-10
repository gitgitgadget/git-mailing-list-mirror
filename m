Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E896120989
	for <e@80x24.org>; Mon, 10 Oct 2016 23:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbcJJXnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 19:43:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752279AbcJJXnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 19:43:42 -0400
Received: (qmail 26776 invoked by uid 109); 10 Oct 2016 23:43:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 23:43:41 +0000
Received: (qmail 3723 invoked by uid 111); 10 Oct 2016 23:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 19:44:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 19:43:39 -0400
Date:   Mon, 10 Oct 2016 19:43:39 -0400
From:   Jeff King <peff@peff.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161010234339.2oyc7kplz2zzjfwh@sigill.intra.peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <577f6873-c320-7aa6-b42f-475f2afb9b92@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <577f6873-c320-7aa6-b42f-475f2afb9b92@lwfinger.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 06:35:01PM -0500, Larry Finger wrote:

> > Ah, it is Mail::Address. It gets this case right, but if I uninstall it,
> > then the cc becomes:
> > 
> >   Cc: Stable <stable@vger.kernel.org[4.8+]>
> > 
> > that you saw, which is broken. Older versions of git, even without
> > Mail::Address, got this right. The breakage bisects to b1c8a11
> > (send-email: allow multiple emails using --cc, --to and --bcc,
> > 2015-06-30) from v2.6.0, but I didn't dig deeper into the cause.
> 
> I did not have Mail::Address installed, but adding it did not help.

Weird. On my system:

  $ git send-email -1 --to=peff@peff.net --dry-run | grep ^Cc
  Cc: Stable <stable@vger.kernel.org[4.8+]>

  $ sudo apt-get install libmailtools-perl
  ... apt-get cruft ...

  $ git send-email -1 --to=peff@peff.net --dry-run | grep ^Cc
  Cc: "Stable [4.8+]" <stable@vger.kernel.org>

I wonder if the version matters (mine is 2.13-1, packaged by Debian).

> I solved my immediate problem by moving the [4.8+] between Stable and the
> starting <. The result is spaced funny, but at least the info is there.

If you can change the format, I suspect:

  Cc: "Stable: [v4.8+]" <stable@vger.kernel.org>

will probably yield the most consistent results.

-Peff
