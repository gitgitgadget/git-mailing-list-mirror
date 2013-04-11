From: Jeff King <peff@peff.net>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Thu, 11 Apr 2013 15:34:34 -0400
Message-ID: <20130411193434.GE3177@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <5165DA13.8010100@gmail.com>
 <20130410214722.GA6215@sigill.intra.peff.net>
 <20130410231919.GA1315@mteis.lan>
 <20130411015613.GA8455@sigill.intra.peff.net>
 <CAAExw5t3rk_R1GB9OMVKjPYEMRQg1gNSUGQtEK71m1Ux01N27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:34:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQNGj-0002KZ-DL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3DKTen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:34:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40861 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab3DKTem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:34:42 -0400
Received: (qmail 18530 invoked by uid 107); 11 Apr 2013 19:36:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 15:36:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 15:34:34 -0400
Content-Disposition: inline
In-Reply-To: <CAAExw5t3rk_R1GB9OMVKjPYEMRQg1gNSUGQtEK71m1Ux01N27w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220920>

On Thu, Apr 11, 2013 at 08:52:56AM +0200, Magnus Therning wrote:

> > The documentation should probably make the use of http.receivepack more
> > clear in this situation.
> 
> I think that'd be good.  The fact that it wasn't until several mails
> into the thread that anyone thought of the http.receivepack setting
> also suggests that its use is a bit un-intuitive (even though it
> probably makes perfect sense and is a good solution).

Yeah, I did not even think of http.receivepack because I have never had
to set it before (it was turned on in the original tests that I built
top of). I have the impression that the anonymous-read/authenticated-write
setup you are using has not been all that commonly used. The example in
the manpage dates back to 2009, but it was only in 2012 that we got a
bug report that the client-side authentication handler has problems with
it.

> > So _if_ you fixed it by setting http.receivepack (which I think is the
> > simplest thing under Apache, since matching the query string there is
> > hard), then you would need a version of git with that fix on the
> > client side to actually have git prompt for the password correctly.
> 
> Ah, so *that* is the fix that has been mentioned (I haven't bothered
> reading it myself), or are there in fact two fixes that have been
> referred to in the thread?

No, there's only the one fix in git itself (not counting improving the
documentation just now). With the Apache config given in the manual,
clients older than git v1.7.11.7 will not properly handle the 401
response they get mid-way through the push process.

But you do not have to worry about that with your configuration, as you
provide the 401 up-front.

> > But your fix under lighttpd is much better, as it asks for the
> > credentials up front (which means the client does not go to any work
> > creating a packfile just to find out that it does not have access).
> 
> Yes, I think it also helps with my particular scenario where new repos
> will be added from time to time.  This way there is no second step,
> after `git init`, that must be remembered.

Yeah, avoiding setting http.receivepack at all is helpful. Though note
that you can also set it in /etc/gitconfig for the whole system at once.

> Thank you very much for taking the time to help me out with this!
> I'll also take a look at the patches you sent, as a dumb simpler user
> I might have something to add, who knows?

You're welcome. I'm glad we got it resolved, and looking over the
documentation patch is appreciated.

-Peff
