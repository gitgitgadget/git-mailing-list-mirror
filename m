From: Jeff King <peff@peff.net>
Subject: Re: teach git diff -v/--invert-match?
Date: Fri, 22 Aug 2008 17:42:08 -0400
Message-ID: <20080822214208.GA4498@coredump.intra.peff.net>
References: <48AED264.60600@visi.com> <20080822193947.GA31322@coredump.intra.peff.net> <48AF2FBB.2080401@visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Ericson <bme@visi.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWePc-00011Z-Jg
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbYHVVmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYHVVmM
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:42:12 -0400
Received: from peff.net ([208.65.91.99]:1350 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361AbYHVVmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:42:11 -0400
Received: (qmail 25981 invoked by uid 111); 22 Aug 2008 21:42:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 17:42:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 17:42:08 -0400
Content-Disposition: inline
In-Reply-To: <48AF2FBB.2080401@visi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93378>

On Fri, Aug 22, 2008 at 04:29:31PM -0500, Brian Ericson wrote:

> I was just working on a reply to my own email as I realized it was
> only  dumb-luck that converted 1200 noisy changes into a couple of
> dozen.  "-S" matches only  the string itself, not the line the string
> resides on.  So, -Sxyz will match if  "xyz" itself was added or
> deleted in the diff (if "xyz" is on a line that's changed but  did not
> itself change, it won't match).  Funny that I actually knew this -- I
> use it to look for System.out.println additions among other things.

Yes (though I couldn't have told you that without experimenting -- I
always assumed it checked whole lines).

> Interestingly, if I wanted to know if an import changed (on top of
> knowing if imports were added or deleted), eg: -import foo; +import
> bar;

That is a bit harder, and AFAIK not possible with -S. You could always
post process the log output. E.g.,:

  git log -p | perl -ne '
    BEGIN { $/ = "commit " }
    chomp; print if /^\+import /
  '

which lets you get quite fancy with the matching.

> The current behavior seems to work well to answer questions like "has
> somebody added a System.out.println",

The usual question (for me, anyway) is "when did X get introduced?" when
looking for a token.

-Peff
