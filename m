From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Tue, 6 May 2014 23:02:54 -0400
Message-ID: <20140507030254.GC20726@sigill.intra.peff.net>
References: <20140505212938.GA16715@sigill.intra.peff.net>
 <20140506151441.GA25768@sigill.intra.peff.net>
 <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 05:03:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whs9A-0008QR-0T
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 05:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaEGDC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 23:02:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:46411 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751552AbaEGDC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 23:02:56 -0400
Received: (qmail 31563 invoked by uid 102); 7 May 2014 03:02:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 22:02:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 23:02:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248280>

On Tue, May 06, 2014 at 03:29:37PM -0700, Junio C Hamano wrote:

> > We can work around this by encapsulating the constant return
> > value in a static inline function, as gcc specifically
> > avoids complaining about unused function returns unless the
> > function has been specifically marked with the
> > warn_unused_result attribute.
> 
> That's kind of W*A*T magic, and I generally try to avoid magic, as
> long as it solves your "can we make both -O2 with new compilers and
> -O3 happy?" I wouldn't complain ;-)

I agree it's rather magical, but I think it's something we can count on.
Certainly turning on warn_unused_result for every function would be a
catastrophe for most code bases, and I don't expect gcc to do it. It's
possible it would eventually grow smart to say "eh, I inlined this and
realized that you don't use the return value", but I think that would be
similarly a bad idea.

And it does work with -O2 and -O3 with both gcc-4.9 and clang in my
tests.

-Peff
