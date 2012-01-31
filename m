From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 16:47:40 -0500
Message-ID: <20120131214740.GA2465@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsLYK-0003aP-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 22:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab2AaVro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 16:47:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51190
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab2AaVrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 16:47:43 -0500
Received: (qmail 2323 invoked by uid 107); 31 Jan 2012 21:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 16:54:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 16:47:40 -0500
Content-Disposition: inline
In-Reply-To: <20120131214047.GA13547@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189474>

On Tue, Jan 31, 2012 at 03:40:47PM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > No, it does not match. While the sequence I outlined above makes the
> > most sense to me, it does not match what setup_git_directory does, which
> > prefers "foo/.git" to using "foo" as a bare repo. I think being
> > consistent between all of the lookup points makes sense. The patch took
> > the least-invasive approach and aligned clone and enter_repo with
> > setup_git_directory.
> >
> > However, we could also tweak setup_git_directory to prefer bare repos
> > over ".git" to keep things consistent. While it makes me feel good from
> > a theoretical standpoint (because the rules above seem simple and
> > intuitive to me), I'm not sure it's a good idea in practice.
> 
> Wait, don't these two functions serve two completely different purposes?

Yes, but I would expect the lookup to be the same.

> One is the implementation of (A):
> 
> 	cd foo
> 	git rev-parse --git-dir
> 
> The other implements (B):
> 
> 	git ls-remote foo

Right. But would you expect:

  git ls-remote foo

to behave the same as:

  cd foo
  git ls-remote .

and would you furthermore expect that to behave the same as:

  cd foo
  git rev-parse --git-dir

?

Maybe I am crazy, but I see all of them as ways of specifying "I am
interested in repository foo", and any lookup magic should be the same
in all cases.

> If "foo" is actually a bare repository that moonlights as a worktree for
> a non-bare repository, then:
> 
>  1) Whoever set up these directories is completely insane[*].  Maybe we
>     should emit a warning.

Yes, I think we are dealing with an insane corner case.

>  2) As a naive user, I would expect (A) to give a different result
>     from (B).

Why?

-Peff
