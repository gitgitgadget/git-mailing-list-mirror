From: chris <jugg@hotmail.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Tue, 10 May 2011 15:34:26 +0000 (UTC)
Message-ID: <loom.20110510T153328-584@post.gmane.org>
References: <loom.20110505T103708-225@post.gmane.org> <20110505093752.GB29595@sigill.intra.peff.net> <loom.20110505T114511-660@post.gmane.org> <20110505105914.GA464@sigill.intra.peff.net> <loom.20110506T034552-210@post.gmane.org> <20110506170204.GA16576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 17:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJoxa-0003mA-RB
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 17:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab1EJPet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 11:34:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:41143 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494Ab1EJPes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 11:34:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QJoxL-0003cw-MA
	for git@vger.kernel.org; Tue, 10 May 2011 17:34:40 +0200
Received: from 118-170-14-123.dynamic.hinet.net ([118.170.14.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2011 17:34:39 +0200
Received: from jugg by 118-170-14-123.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2011 17:34:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 118.170.14.123 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.17) Gecko/20110420 Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173339>

Jeff King <peff <at> peff.net> writes:
> 
> On Fri, May 06, 2011 at 02:16:03AM +0000, chris wrote:
> 
> > Personally, I would prefer that git-push work on branches by default[1], 
> > providing shortcuts for pushing tag[2] refs and remote branch[3] refs, 
> > while all other ref types must be called out explicitly.  Creating new refs 
> > isn't destructive, so it seems these could be supported without concern.
> > 
> > 1. $ git push origin SHA1:branch1
> >   => $ git push origin SHA1:refs/heads/branch1
> > 
> > 2. $ git push origin tag SHA1:tagname
> >   => $ git push origin SHA1:refs/tags/tagname
> > 
> > 3. $ git push origin SHA1:upstream/branch2
> >   => $ git push origin SHA1:refs/remotes/upstream/branch2
> 
> In (3), how do you differentiate between the branch
> "refs/heads/upstream/branch2" and the remote tracking branch
> "refs/remotes/upstream/branches"?

I was just taking a queue from the documentation:

--
"git push origin master:satellite/master dev:satellite/dev

Use the source ref that matches master (e.g. refs/heads/master) to update the
ref that matches satellite/master (most probably refs/remotes/satellite/master)
in the origin repository, then do the same for dev and satellite/dev."
--

Of course the documentation there is meaninging that
refs/remotes/satellite/master already exists and that there is no conflicting
refs/heads/satellite/master.

Probably what I need to do is better understand the "guess work" git-push
already does before trying to "improve" it.  So, based on this thread and the
documentation, the following holds true:

  $ git push origin HEAD:newbranch

is valid only if HEAD contains a branch ref pointer.  Otherwise, if the LHS of
the refspec is not a known ref type, the RHS must always be explicit when
pushing a new ref.  If the LHS is a known ref type, then the same ref type is
used for the RHS of the refspec - also the RHS becomes optional in such a case
and the LHS name will be used if the RHS was omitted.

If that is a correct summary (something missing?), then as is, there is little
point in anything but explicit specification of the RHS of the refspec when
pushing a new ref.

And given that "$ git push remote tag <refspec>" syntax seems to be outdated, I
don't see any benefit to my proposed set of shortcuts for pushing new refs.

So, thanks Peff for the informative responses, they helped bring my
understanding up a notch.

chris
