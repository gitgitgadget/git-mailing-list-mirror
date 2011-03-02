From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 16:41:42 -0500
Message-ID: <20110302214142.GH20400@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
 <20110302180722.GA20287@sigill.intra.peff.net>
 <AANLkTi=m_WTohMfJZxTqObRT3rhhtxo=QfnDJCHO=U0K@mail.gmail.com>
 <20110302211035.GC20400@sigill.intra.peff.net>
 <AANLkTi=hqVcGw16q6uJBO5kPjKtsa=ujtQxg4FRj_+i6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Putnr-0004AT-2e
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab1CBVlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:41:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab1CBVlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:41:44 -0500
Received: (qmail 20777 invoked by uid 111); 2 Mar 2011 21:41:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:41:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:41:42 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=hqVcGw16q6uJBO5kPjKtsa=ujtQxg4FRj_+i6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168351>

On Wed, Mar 02, 2011 at 10:24:29PM +0100, Piotr Krukowiecki wrote:

> So it's like this?
> 
> B1
> |
> M - B2
> |
> P <- changes foo

Yes.

> > What do we output? Both branches have equal claim to the commit.
> 
> That's easy. In "show only differences" we don't show anything,
> because on both branches last-change-commit of "foo" is the same.
> In "show all" last-change-commit is P so show it (with message like
> "changed in common root" or whatever).

Ah, that is totally not the output I would have expected. But now I
understand a little better what you are talking about. In the former
case, you are interested in a blame traversal going to the merge-base of
branch1 and branch2, and you are interested in the source. So I think
you could do it with something like:

  git blame-tree dir --left-right branch1...branch2

though of course the current output doesn't actually notice things like
left-right markings from the revision traversal machinery.

And then there is also the question of representing greater than two
branches. If "foo" blames to a commit that is in branch1 and branch2,
but not branch3, what should be output? Presumably you would want it
enumerated as "branch1 and branch2 touched it in commit X, branch three
touched it in commit Y". But I'm not sure how well git's revision
machinery tracks more than two sources.

> I think this is simple, but maybe I don't understand some git
> internals that make it hard.

I think it is possible, and probably would build on top of the work I am
doing. But I am going to try to get the basics right first, and then we
can see about building other stuff on top.

-Peff
