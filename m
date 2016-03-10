From: Jeff King <peff@peff.net>
Subject: Re: Bug: git branch -D can be used to delete branch which is
 currently checked out - Part 2
Date: Thu, 10 Mar 2016 17:41:58 -0500
Message-ID: <20160310224158.GA2772@sigill.intra.peff.net>
References: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com>
 <alpine.DEB.2.20.1603101313220.4690@virtualbox>
 <9EFA8642-FA02-4ADB-B37B-530E611C9C1F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Marcus Kida <marcus.kida@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:42:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9HU-0003fe-36
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbcCJWmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:42:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:58111 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755009AbcCJWmC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:42:02 -0500
Received: (qmail 8092 invoked by uid 102); 10 Mar 2016 22:42:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 17:42:01 -0500
Received: (qmail 30561 invoked by uid 107); 10 Mar 2016 22:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 17:42:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2016 17:41:58 -0500
Content-Disposition: inline
In-Reply-To: <9EFA8642-FA02-4ADB-B37B-530E611C9C1F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288655>

On Fri, Mar 11, 2016 at 05:30:00AM +1100, Marcus Kida wrote:

> thank you for the feedback.
> I will fix this, test it and send a patch.

Unfortunately, I think this issue is a little more complicated.

There's some prior discussion in

  http://thread.gmane.org/gmane.comp.version-control.git/284022

and

  http://thread.gmane.org/gmane.comp.version-control.git/276456/focus=276506

The latter, in particular, shows a case where this approach will do the
wrong thing. The fundamental issue is that refs are potentially stored
in _two_ places: the filesystem, and the packed-refs file. And the
latter is always case-sensitive, while the former sometimes is and
sometimes isn't. But because the storage all happens behind the scenes,
the user has no way of reliably disambiguating (e.g., does "foo" refer
to your checked-out "FOO", or are you intentionally trying to delete an
extraneous "FOO" that ended up in the packed-refs file?).

-Peff
