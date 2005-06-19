From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sat, 18 Jun 2005 23:38:22 -0400
Message-ID: <20050619033821.GB24982@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org> <2cfc403205061817181e4d6d5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 19 05:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjqYQ-0005xu-8c
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 05:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVFSDi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 23:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVFSDi1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 23:38:27 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:15310 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261682AbVFSDiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 23:38:23 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1Djqda-0006aU-00
	for <git@vger.kernel.org>; Sat, 18 Jun 2005 23:38:22 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cfc403205061817181e4d6d5e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 19, 2005 at 10:18:45AM +1000, Jon Seymour wrote:
> On 6/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > Ok, I just added a feature to "git-rev-list" that I hereby nominate to be
> > the coolest feature ever, namely the "--bisect" flag, which basically
> > tries to split the list of revisions in two, and prints out just the "most
> > middle" commit.
> > 
> 
> Perhaps in answering this question, you can help me understand the
> intended behaviour of your bisection algorithm a little better. The
> question is this: for your purposes, given a rev-list output, why not
> simply use the literal middle element of the outputed list?

A was known good, parallel development for commits B and C, finally
merged into D. A bug got introduced in B, which we discover by the time
we have a checked out copy of D.

     .--- B ---.
    /           \
   A             D
    \           /
     `--- C ---'

git-rev-list E ^A shows this as BCD. Pick the halfway point C, and this
one checks out ok. So at this point we would decide that the bug got
introduced by the C->D change.

My guess is that Linus's bisect algorithm considers the branches, so
once C is cleared as good, we get a rev-list that looks like BD, and as
such can still find the exact bad commit B.

Jan
