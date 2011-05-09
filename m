From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 07:10:19 -0400
Message-ID: <20110509111019.GD9060@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <D0FA0C3F-8DA8-4607-A0A6-F9AFAB3EC3CE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: David Lee <davidomundo@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 13:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJOM5-0000cl-VN
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1EILKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 07:10:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33460
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab1EILKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 07:10:20 -0400
Received: (qmail 7762 invoked by uid 107); 9 May 2011 11:12:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 07:12:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 07:10:19 -0400
Content-Disposition: inline
In-Reply-To: <D0FA0C3F-8DA8-4607-A0A6-F9AFAB3EC3CE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173220>

On Mon, May 09, 2011 at 01:34:22AM -0700, David Lee wrote:

> >  4. Decentralized, you're a developer that publishes work via git. You
> >     call the upstream maintainer "origin", so fetches are convenient
> >     (and git does this for you at clone, after all). But pushing, even
> >     though you probably always push to the same central, does not have
> >     a convenient shorthand.
> 
> By "push to the same central", I assume you mean "push to the same mirror of origin".

Yeah, sorry, that was supposed to be "central spot", but I think you got
the meaning.

> I think github is making option 4 the dominant use case. In fact, in
> our workplace we have a similar workflow set up, where we pull from a
> central origin, but push to individual mirrors from where commits are
> reviewed, tested, and merged unto origin.

Yeah, I think we will see more of that as decentralized workflows (and
the tools that support them) mature.

With respect to supporting an alternate default push destination, I'm
not sure what is the best change to make. If "origin" were simply the
default, I would say we should have a push.defaultRemote config that
lets you specify something else.

But it's not that simple. If you are on branch "foo", and you have
"branch.foo.remote" set in your config, then the value of that config
option becomes the default remote. Which makes some sense for pulling
(and there is the associated branch.*.merge config), but of course
pushing may not match.

But now we have precedence questions. If I have config like:

  [push]
    defaultRemote = my-mirror

  [branch "foo"]
    remote = origin
    merge = refs/heads/master

which remote should be the default for "git push"? Obviously if I'm not
on "foo", it should be my-mirror. But if I am, should push.defaultRemote
take precedence? Should there also be a branch.*.pushRemote config that
takes precedence over branch.*.remote?

I have to admit that I have never found the branch.*.remote config to be
useful for any of my workflows, so I am not really sure how people use
it.

-Peff
