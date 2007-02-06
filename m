From: Jeff King <peff@peff.net>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 06:00:15 -0500
Message-ID: <20070206110015.GA10231@coredump.intra.peff.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org> <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com> <20070205194508.GD8409@spearce.org> <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com> <20070205225505.GA9222@spearce.org> <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com> <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 12:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEO3p-0005hC-Iv
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 12:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXBFLAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 06:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXBFLAU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 06:00:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3024 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751898AbXBFLAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 06:00:19 -0500
Received: (qmail 30831 invoked from network); 6 Feb 2007 06:00:18 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Feb 2007 06:00:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2007 06:00:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38833>

On Tue, Feb 06, 2007 at 11:45:24AM +0100, Johannes Schindelin wrote:

> > git gc (repack -d of it) is too dangerous in a shared repo: it breaks
> > the repos which depend on the master repository, have sent (by some
> > means) some objects over to the master, and accidentally removed
> > the reference, and were pruned afterwards.
> 
> We no longer call git-prune automatically in git-gc. You have to say 
> "git-gc --prune" to trigger that behaviour.

repack -d can lose objects, too:

# fully packed test repo with 2 commits
mkdir repo && cd repo
git init
touch foo
git add foo
git commit -m foo
echo bar >foo
git commit -a -m bar
git repack -a -d

# remember the latest commit
commit=`git rev-parse HEAD`

# now make it dangling
git reset --hard HEAD^
sleep 1
git reflog expire --expire=0 HEAD refs/heads/master

# now repack
git repack -a -d

# and it's gone
git-show $commit

-Peff
