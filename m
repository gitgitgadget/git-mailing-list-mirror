From: Jeff King <peff@peff.net>
Subject: Re: Disabling credential helper?
Date: Tue, 2 Dec 2014 20:36:07 -0500
Message-ID: <20141203013607.GA30037@peff.net>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
 <20141203012148.GB29427@peff.net>
 <20141203012950.GC6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:36:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvyrW-0007JK-Nt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 02:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbaLCBgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 20:36:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:47548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaLCBgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 20:36:10 -0500
Received: (qmail 9012 invoked by uid 102); 3 Dec 2014 01:36:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 19:36:10 -0600
Received: (qmail 20950 invoked by uid 107); 3 Dec 2014 01:36:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 20:36:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 20:36:07 -0500
Content-Disposition: inline
In-Reply-To: <20141203012950.GC6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260613>

On Tue, Dec 02, 2014 at 05:29:50PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Tue, Dec 02, 2014 at 04:59:53PM -0800, Jonathan Nieder wrote:
> 
> >> As long as you have no credential helpers configured, your GIT_ASKPASS
> >> based approach should work fine.
> >
> > Yeah, it's fine (as is GIT_ASKPASS=true). You could also provide a
> > credential helper that gives you an empty username and password. But in
> > both cases, I think that git will then feed the empty password to the
> > server again, resulting in an extra useless round-trip. You probably
> > instead want to say "stop now, git, there is nothing else to be done".
> >
> > We could teach the credential-helper code to do that (e.g., a helper
> > returns "stop=true" and we respect that). But I think you can do it
> > reasonably well today by making the input process fail.
> 
> How can my scripts defend against a credential helper that I didn't
> set up that e.g. pops up a GUI window to ask for a password?

Maybe I am misunderstanding the original situation, but I did not think
that was the problem. I thought the situation was one where the
environment was controlled, but Git still would not do what was wanted
(if you did have such a renegade helper, setting GIT_ASKPASS certainly
would not help, as it is the fallback).

But to answer your question: you can't currently. I would be happy to
have a config syntax that means "reset this multi-value config option
list to nothing", but it does not yet exist. It would be useful for more
than just credential-helper config.

-Peff
