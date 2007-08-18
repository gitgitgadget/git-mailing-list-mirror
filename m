From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Sat, 18 Aug 2007 02:09:13 -0700
Message-ID: <20070818090913.GA13936@soma>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx> <20070816082110.GB16849@muzzle> <7vir7eh7mc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 11:09:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMKJQ-0005tD-D5
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 11:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbXHRJJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 05:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbXHRJJQ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 05:09:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44123 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXHRJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 05:09:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1368B2DC08D;
	Sat, 18 Aug 2007 02:09:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vir7eh7mc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56103>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio:
> > Would you object to having git-merge spew a big fat warning
> > and/or outright refuse to let git-merge run on git-svn repositories?
> 
> Actually I do.  A major, if not primary, selling point of
> git-svn has been that svn cannot do merges but if you import to
> git you can, and I've had an impression that Sam's git-svn intro
> alludes to this capability as well.

Wow.  My primary reasons for git-svn are completely different: speed and
offline usability; and merging was not so much a concern for me.

I've grown to prefer the patch + rebase model of keeping history linear
in my work.  This is different than from when I first picked up git:
went overboard on merging just to see what kind of interesting graphs I
could create in gitk :)

So I didn't always prefer the recommended way git-svn works now.  In the
beginning there was the "git-svn commit" command, which has now been
named "set-tree".  I haven't used set-tree in ages, but I think it still
supports preserving history of a git <-> git merging after commiting to
SVN.  The problem with set-tree was that it would either:

a) make history ugly (with duplicate commits) for git users, as history
   never gets rewritten when using set-tree.

or

b) hide history from SVN users.

> If I understand you correctly, your position is that the svn
> side has the authoritative history when using git-svn, and we
> should refuse to do anything on the git side that the resulting
> history in svn cannot represent.  I know and respect that you
> have thought about the issues involved long enough before that
> declaration of defeat, but at the same time, I would really hope
> that we can come up with a workable compromise to allow merge
> tracking on the git side.

Yes.  From what I gather, developers only use git-svn because they don't
have enough swing within their group to replace SVN.  I don't think
encouraging git-svn users to isolate themselves with their own history
and propagating less-useful history to the non-SVN users in a project is
a good thing.

> It probably does not even have to interoperate with people who
> do their own merge tracking using svk.  Perhaps something as
> simple and ugly as recording the parent commit object names on
> the git side as a trailer to the commit log message we push back
> to svn would allow people who interact with the same svn
> repository from their own git-svn managed git repository to
> interoperate with each other?

Of course, git-svn has gotten a lot more users than I expected it
would, so maybe I'll implement it and see where it takes us.

This could just be as simple as using the code for set-tree and instead
using it to create revprops in SVN.  I'd probably be inventing a fourth
method of doing merge-tracking in SVN, though...

-- 
Eric Wong
