From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 14:29:00 -0400
Message-ID: <20160414182900.GD22068@sigill.intra.peff.net>
References: <20160414180709.28968-1-gitster@pobox.com>
 <20160414180709.28968-2-gitster@pobox.com>
 <20160414182102.GB22068@sigill.intra.peff.net>
 <xmqq1t68gi92.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqm0s-0008Mo-LI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbcDNS3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:29:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:49574 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754703AbcDNS3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:29:04 -0400
Received: (qmail 15315 invoked by uid 102); 14 Apr 2016 18:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:29:02 -0400
Received: (qmail 1431 invoked by uid 107); 14 Apr 2016 18:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:29:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 14:29:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1t68gi92.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291553>

On Thu, Apr 14, 2016 at 11:25:29AM -0700, Junio C Hamano wrote:

> > You need this "buffer_begin" because we move the "buffer" pointer
> > forward as we parse. But perhaps whole-buffer checks should simply go at
> > the top (next to verify_headers) before we start advancing the pointer.
> > To me, that makes the function's flow more natural.
> 
> That was my second iteration.  I didn't want the function return
> with warning without checking more serious errors that may be in the
> object.

Ah, I didn't consider that. In general I'm not sure the distinction
between "warning" and "error" is all that important, or has been applied
all that consistently. transfer.fsckObjects will barf on either.

But I do agree in general that we should be checking as many things as
we can. And that we are already wrong to return an error immediately
when verify_headers() complains. We should be accumulating problems in
an error code and progressing as far as possible. I think fsck_tree() is
a good example of how to do this.

-Peff
