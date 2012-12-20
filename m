From: Jeff King <peff@peff.net>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 09:55:19 -0500
Message-ID: <20121220145519.GB27211@sigill.intra.peff.net>
References: <20121217010538.GC3673@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 15:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlhX9-0006xj-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 15:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab2LTOzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:55:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2LTOzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:55:21 -0500
Received: (qmail 9509 invoked by uid 107); 20 Dec 2012 14:56:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 09:56:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 09:55:19 -0500
Content-Disposition: inline
In-Reply-To: <20121217010538.GC3673@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211892>

On Mon, Dec 17, 2012 at 01:05:38AM +0000, Adam Spiers wrote:

> t/t9902-completion.sh is currently failing for me because I happen to
> have a custom shell-script called git-check-email in ~/bin, which is
> on my $PATH.  This is different to a similar-looking case reported
> recently, which was due to an unclean working tree:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/208085
> 
> It's not unthinkable that in the future other tests could break for
> similar reasons.  Therefore it would be good to sanitize $PATH in the
> test framework so that it cannot destabilize tests, although I am
> struggling to think of a good way of doing this.  Naively stripping
> directories under $HOME would not protect against git "plugins" such
> as the above being installed into places like /usr/bin.  Thoughts?

I've run into this, too. I think sanitizing $PATH is the wrong approach.
The real problem is that the test is overly picky. Right now it is
failing because you happen to have "check-email" in your $PATH, but it
will also need to be adjusted when a true "check-email" command is added
to git.

I can think of two other options:

  1. Make the test input more specific (e.g., looking for "checkou").
     This doesn't eliminate the problem, but makes it less likely
     to occur.

  2. Loosen the test to look for the presence of "checkout", but not
     fail when other items are present. Bonus points if it makes sure
     that everything returned starts with "check".

I think (2) is the ideal solution in terms of behavior, but writing it
may be more of a pain.

-Peff
