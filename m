From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf_getwholeline: NUL-terminate getdelim buffer on
 error
Date: Sat, 5 Mar 2016 14:36:41 -0500
Message-ID: <20160305193640.GA20701@sigill.intra.peff.net>
References: <20160305184330.GA7534@sigill.intra.peff.net>
 <xmqqziucu3d7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:36:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acI0O-0006nY-0W
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbcCETgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:36:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:55281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750732AbcCETgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 14:36:43 -0500
Received: (qmail 5340 invoked by uid 102); 5 Mar 2016 19:36:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 14:36:43 -0500
Received: (qmail 11569 invoked by uid 107); 5 Mar 2016 19:36:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 14:36:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 14:36:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqziucu3d7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288325>

On Sat, Mar 05, 2016 at 11:33:08AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Not a big rush for 2.8.0-rc, as the bug is in v2.5.0, and I doubt
> > there's an easy trigger besides fast-import. But it might be harmless
> > enough to squeeze in.
> 
> Was it found by a real-world debugging session, or by a code
> inspection?  I'd be really impressed if it were the latter ;-)

Sorry to disappoint, but it was the former. :)

I found (and am fixing) a _different_ bug with:

  {
	echo "tag foo"
	echo "from HEAD:./bar"
  } | git fast-import

and I wondered if fast-import would take:

  echo "tag foo from HEAD:./bar"

on one line.  The answer is no, btw, but it also tickles this bug (it is
expecting "from ..." on the next line, and handles EOF by detecting the
empty string).

-Peff
