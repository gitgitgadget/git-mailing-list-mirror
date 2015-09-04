From: Jeff King <peff@peff.net>
Subject: Re: git grep broken in Fedora 21 update?
Date: Fri, 4 Sep 2015 10:03:45 -0400
Message-ID: <20150904140345.GA28675@sigill.intra.peff.net>
References: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXraq-0001IH-C1
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 16:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687AbbIDODs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 10:03:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:54963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755832AbbIDODs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 10:03:48 -0400
Received: (qmail 21274 invoked by uid 102); 4 Sep 2015 14:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 09:03:47 -0500
Received: (qmail 21798 invoked by uid 107); 4 Sep 2015 14:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 10:03:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 10:03:45 -0400
Content-Disposition: inline
In-Reply-To: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277310>

On Fri, Sep 04, 2015 at 12:04:38AM +0000, Rustad, Mark D wrote:

> You can see that git grep missed the line in ixgbe_x550.c that had two hits on the string.
> 
> This was with git 2.1.0 in Fedora 21. I use git grep a lot and never
> noticed a problem before. I just updated my Fedora 21 system
> yesterday, so I have to figure that has something to do with it. I
> checked and git didn't get updated, so I figure it must be a library
> that is really broken.
> 
> I see in my update log that pcre was updated to:
> 
> pcre.x86_64 0:8.35-12.fc21
> pcre-devel.x86_64 0:8.35-12.fc21
> 
> Yet the grep command is unaffected.

I don't think "git grep" should be using pcre unless you specified "-P"
on the command line (which might be an interesting experiment, to see if
it improves the result).

It shouldn't be affected by your working tree state. "git grep" without
arguments searches the working tree, just like grep. It might omit a
file that is not tracked, but given that the missing line is from a file
which _does_ have other results, that's clearly not the problem.

Is it possible that git _is_ producing the hit, but it is getting eaten
by the pager or something like that? Does "git --no-pager grep
enter_lplu" produce the same results?

I don't think there have been any git bugs in this area for quite a
while. In your position I'd try building from source to see if a freshly
built version has the same problem.

-Peff
