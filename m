From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 17:05:10 -0500
Message-ID: <20120131220510.GA3253@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsLpJ-0002wc-12
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab2AaWFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:05:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51208
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab2AaWFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 17:05:12 -0500
Received: (qmail 2569 invoked by uid 107); 31 Jan 2012 22:12:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 17:12:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 17:05:10 -0500
Content-Disposition: inline
In-Reply-To: <20120131215501.GF13252@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189476>

On Tue, Jan 31, 2012 at 03:55:01PM -0600, Jonathan Nieder wrote:

> >>  2) As a naive user, I would expect (A) to give a different result
> >>     from (B).
> >
> > Why?
> 
> Normally git commands expect me to be in (possibly a deeply nested
> subdirectory) of the worktree.  The typical case is a non-bare
> repository.  I have been taught that it walks to the toplevel and
> finds a ".git" directory.
> 
> By contrast, the path passed to git transport commands like "git fetch
> otherhost:/foo/bar/baz.git" is a path to the git repository metadata.
> I am not allowed to pass a path to a subdirectory, for example.

True. But I consider that to make the walk-backwards-from-pwd case
simply a superset. That is, in (A) we are walking backwards and trying
to apply the lookup rule from (B) individually to each directory we
consider (though even that is not entirely true, as we don't look for
parallel "$PWD.git" directories in the walk).

I'll admit I don't care that much, though. This is extremely unlikely to
come up. The real issue is fixing the fact that we prefer "foo.git" to
"foo", even when the user told us "foo". I am content to leave the rest
of it as-is, which is what my original patch did.

-Peff
