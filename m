From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] chronoversion: chronological archiving script with
 temporary commits
Date: Tue, 13 Mar 2007 16:49:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703131648440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e1dab3980703130526t4b573f18h793a065d54c9369@mail.gmail.com>
 <20070313154511.GA18890@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Tweed <david.tweed@gmail.com>, git@vger.kernel.org,
	jonsmirl@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9Ft-000800-JC
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 16:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbXCMPth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXCMPth
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 11:49:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:36435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752189AbXCMPtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 11:49:36 -0400
Received: (qmail invoked by alias); 13 Mar 2007 15:49:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 13 Mar 2007 16:49:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/IL09xeE/CATaA+304eJh8RtokhZMTDRay4ydzx
	noddpUmdMZsraa
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070313154511.GA18890@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42124>

Hi,

On Tue, 13 Mar 2007, Shawn O. Pearce wrote:

> David Tweed <david.tweed@gmail.com> wrote:
> > A question for those who understand things: I stash the last written
> > _tree_'s hash in a tag and then when a new "commit's" directory tree
> > is written starts look to see if it's the same SHA value. If it is I
> > know I can avoid the commit. At the moment I'm using
> > 
> >    if os.path.exists(lastTreeFile) and
> > tree==open(lastTreeFile,"r").read()[:40]:
> > 
> > to be safe just in case a user, eg, goes mad and manually deletes that
> > record. Clearly this is going to hit trouble if git ever decides to
> > put this tag into a packed refs file.
> > Is there any neat way of using builtin stuff like git-rev-parse to ask
> > if a ref has a given SHA1 value and return an easily parsed yes/no
> > answer?
> 
> The common idiom if you want to compare trees to see if you
> need to make a commit is:
> 
> 	oldc=`git rev-parse $tagname^{commit}`
> 	oldt=`git rev-parse $oldc^{tree}`
> 	newt`git write-tree`

	new=`git write-tree`

> 	if [ X$oldt = X$newt ]; then
> 		: nothing to save
> 	else
> 		newc=`git commit-tree $newt -p $oldc`
> 		git update-ref $tagname $newc $oldc
> 	fi
> 
> Yes, a little ugly.  But its safe; if another program were to
> alter the value of $tagname (e.g. "git branch -f", "git tag -f")
> while your script is running the update-ref in the else will fail,
> letting you know that $tagname changed in the process.

Ciao,
Dscho
