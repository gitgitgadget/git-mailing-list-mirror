From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 17:45:57 -0500
Message-ID: <20151102224556.GA16387@sigill.intra.peff.net>
References: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
 <20151102201831.GA10722@sigill.intra.peff.net>
 <87mvuwcbql.fsf@igel.home>
 <20151102221027.GA13996@sigill.intra.peff.net>
 <1446504084.4131.33.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:46:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNrZ-0003fW-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbKBWqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:46:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:51721 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751275AbbKBWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:46:00 -0500
Received: (qmail 21091 invoked by uid 102); 2 Nov 2015 22:45:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 16:45:59 -0600
Received: (qmail 18531 invoked by uid 107); 2 Nov 2015 22:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 17:46:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 17:45:57 -0500
Content-Disposition: inline
In-Reply-To: <1446504084.4131.33.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280733>

On Mon, Nov 02, 2015 at 05:41:24PM -0500, David Turner wrote:

> > Let's switch to using off_t, which should hold any file size
> > our system is capable of storing. We need to use ftello() to
> > get the off_t. This is in POSIX and hopefully available
> > everywhere; if not, we should be able to wrap it by falling
> > back to ftell(), which would presumably return "-1" on such
> > a large file (and we would simply skip resuming in that case).
> 
> It would skip resuming, but would still maybe write to the end of the
> existing file, right?  So I think we would need to seek to the beginning
> of the file in that case.

Oh, you're right. That's no worse than the current behavior, but it's
definitely not ideal. I'd leave that for a follow-on patch that actually
implements such an ftello wrapper.

-Peff
