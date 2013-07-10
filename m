From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for
 status_printf
Date: Wed, 10 Jul 2013 01:28:59 -0400
Message-ID: <20130710052859.GA5339@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
 <20130710002328.GC19423@sigill.intra.peff.net>
 <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 07:29:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwmxi-0004BU-3r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 07:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3GJF3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 01:29:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:45293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab3GJF3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 01:29:05 -0400
Received: (qmail 7688 invoked by uid 102); 10 Jul 2013 05:30:20 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 00:30:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 01:28:59 -0400
Content-Disposition: inline
In-Reply-To: <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230024>

On Tue, Jul 09, 2013 at 10:26:04PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > These functions could benefit from the added compile-time
> > safety of having the compiler check printf arguments.
> >
> > Unfortunately, we also sometimes pass an empty format string,
> > which will cause false positives with -Wformat-zero-length.
> > In this case, that warning is wrong because our function is
> > not a no-op with an empty format: it may be printing
> > colorized output along with a trailing newline.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I'm torn on this one. It really does provide us with more compile-time
> > safety checks, but it's annoying that "-Wall -Werror" will no longer
> > work out of the box.
> 
> Yeah, that is a show-stopper for me X-<.

You can "fix" it with -Wno-zero-format-length, so the hassle is not
huge. But I am also inclined to just drop this one. We have lived
without the extra safety for a long time, and list review does tend to
catch such problems in practice.

-Peff
