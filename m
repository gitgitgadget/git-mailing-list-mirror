From: Jeff King <peff@peff.net>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Tue, 10 May 2011 15:47:38 -0400
Message-ID: <20110510194738.GB14456@sigill.intra.peff.net>
References: <loom.20110505T103708-225@post.gmane.org>
 <20110505093752.GB29595@sigill.intra.peff.net>
 <loom.20110505T114511-660@post.gmane.org>
 <20110505105914.GA464@sigill.intra.peff.net>
 <loom.20110506T034552-210@post.gmane.org>
 <20110506170204.GA16576@sigill.intra.peff.net>
 <loom.20110510T153328-584@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 21:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsuI-0002oY-SA
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab1EJTrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:47:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45560
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab1EJTrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:47:40 -0400
Received: (qmail 25252 invoked by uid 107); 10 May 2011 19:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 15:49:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 15:47:38 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110510T153328-584@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173352>

On Tue, May 10, 2011 at 03:34:26PM +0000, chris wrote:

> I was just taking a queue from the documentation:
> 
> --
> "git push origin master:satellite/master dev:satellite/dev
> 
> Use the source ref that matches master (e.g. refs/heads/master) to update the
> ref that matches satellite/master (most probably refs/remotes/satellite/master)
> in the origin repository, then do the same for dev and satellite/dev."
> --
> 
> Of course the documentation there is meaninging that
> refs/remotes/satellite/master already exists and that there is no conflicting
> refs/heads/satellite/master.

Right. All of our discussion has been on the case where the RHS doesn't
match anything on the remote.

> Probably what I need to do is better understand the "guess work" git-push
> already does before trying to "improve" it.  So, based on this thread and the
> documentation, the following holds true:
> 
>   $ git push origin HEAD:newbranch
> 
> is valid only if HEAD contains a branch ref pointer.  Otherwise, if the LHS of
> the refspec is not a known ref type, the RHS must always be explicit when
> pushing a new ref.  If the LHS is a known ref type, then the same ref type is
> used for the RHS of the refspec - also the RHS becomes optional in such a case
> and the LHS name will be used if the RHS was omitted.

I think the RHS is always optional, isn't it? That is, if I say:

  git push origin foo

then that is always equivalent to

  git push origin foo:foo

which will then push to the matching "foo" on the remote; if it does not
exist, then it will infer the type of "foo" on the remote from the type
of "foo" locally. But I could be mis-remembering, as it's been a while
since I've dug into the refspec code.

Other than that, I think your description above is accurate.

-Peff
