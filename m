From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 16:10:35 -0500
Message-ID: <20110302211035.GC20400@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
 <20110302180722.GA20287@sigill.intra.peff.net>
 <AANLkTi=m_WTohMfJZxTqObRT3rhhtxo=QfnDJCHO=U0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PutJy-0001cn-QK
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab1CBVKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:10:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab1CBVKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:10:38 -0500
Received: (qmail 20422 invoked by uid 111); 2 Mar 2011 21:10:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:10:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:10:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=m_WTohMfJZxTqObRT3rhhtxo=QfnDJCHO=U0K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168342>

On Wed, Mar 02, 2011 at 07:39:20PM +0100, Piotr Krukowiecki wrote:

> I'd expect this to be something like union. Currently I can only think about
> following case:
> 
> Some files were changed in branch1, some in branch2, some in both.
> Show me how the files are changed. For example:
>   file1 changed in branch1 in commit1
>   file2 changed in branch2 in commit2
>   file3 changed in branch1 in commit3 and in branch2 in commit4
> 
> If file was not changed since branch creation then don't show it (optionally).

I think we are getting into something different here, because you are
caring not just about the commit in some traversal that touched a file,
but for each source, which commits got us there and potentially multiple
such commits, one per source for each file.

And that's a bit more expensive to compute, and the answers are not
always unambiguous. For example, let's say branch1 and branch2 fork from
some merge-base M. In the parent of M, file "foo" was changed. We
traverse from branch1 and branch2, not seeing anything interesting for
"foo". We hit M, and then finally see that its parent touched "foo".

What do we output? Both branches have equal claim to the commit.

I think you could figure out semantics that make sense if you spent
enough time on it. But I also think it is making the relatively simple
problem of blame-tree a lot more complex.

-Peff
