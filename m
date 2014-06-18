From: Jeff King <peff@peff.net>
Subject: Re: [puzzled and solved] "shortlog" not quite understanding all
 "log" options
Date: Wed, 18 Jun 2014 04:08:48 -0400
Message-ID: <20140618080848.GB11027@sigill.intra.peff.net>
References: <xmqqzjhz83rk.fsf@gitster.dls.corp.google.com>
 <20140530201652.GC5513@sigill.intra.peff.net>
 <xmqqwqd36j9d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 10:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAvU-0001GO-Is
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 10:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604AbaFRIIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 04:08:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:46609 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932108AbaFRIIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 04:08:50 -0400
Received: (qmail 26744 invoked by uid 102); 18 Jun 2014 08:08:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 03:08:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 04:08:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqd36j9d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251975>

On Fri, May 30, 2014 at 02:37:02PM -0700, Junio C Hamano wrote:

> > I am slightly puzzled why parse_revision_opt does not just call
> > handle_revision_pseudo_opt. According to f6aca0dc4, it is because
> > pseudo-options need to be acted on in-order, as they affect things like
> > subsequent "--not" options, etc. But if we are using parse_options_step,
> > shouldn't we be handling the options in order?
> >
> > I am sure I am just missing something obvious, so do not trouble
> > yourself if you do not know the answer offhand.
> 
> Sorry, I don't know ;-)

Hopefully I am not wasting your time by responding to an old thread, but
I figured this out and wanted to post it for posterity.

The answer is that it is not about handling _options_ in order, but that
we need to handle pseudo-options in order with non-options, like:

  foo --not bar

Stepping through the options with parseopt will just cover dashed
options, but we handle non-option arguments later. So we have to handle
the pseudo-arguments like "--not" at the same later time.

So there's nothing interesting to clean up or fix here.

-Peff
