From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 11:57:09 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810141148010.19665@iabervon.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810131546180.19665@iabervon.org> <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 14 17:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpmHy-00018B-2w
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 17:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYJNP5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYJNP5L
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 11:57:11 -0400
Received: from iabervon.org ([66.92.72.58]:52965 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbYJNP5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 11:57:10 -0400
Received: (qmail 11610 invoked by uid 1000); 14 Oct 2008 15:57:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2008 15:57:09 -0000
In-Reply-To: <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98192>

On Tue, 14 Oct 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 13 Oct 2008, Daniel Barkalow wrote:
> 
> > On Mon, 13 Oct 2008, Johannes Schindelin wrote:
> > 
> > > I actually understand now why the tests started failing: the change from 
> > > resolve_ref() to get_branch() as requested by Daniel are at fault: 
> > > get_branch() does not check if the branch has an initial commit.
> > > 
> > > I am actually regretting making this change.  Daniel, do you agree 
> > > that it might be better to change back to resolve_ref(), so that the 
> > > initial complaint (IIRC Han-Wen git pull'ed into a freshly initialized 
> > > repository with that utterly bogus "git pull origin master:master" 
> > > line) is not re-raised?
> > 
> > Is it, in fact, okay to fetch into the current branch if it's "yet to be 
> > born"? I feel like it shouldn't be, since you'll get exactly the same 
> > problem that you would if the branch already existed: the index reflects 
> > the previous state (in this case, it's empty), so git will show that 
> > you've staged removing all of the files, right? So this would make the 
> > check for --update-head-ok more strict than before, but I think the 
> > behavior change is correct.
> 
> I think 
> http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31544 
> is the best link to see what Han-Wen said.  Granted, it was a 
> misunderstanding on his part, but there have been quite a few people with 
> the same misunderstanding.
> 
> So what they did was
> 
> 	$ mkdir just-one-branch
> 	$ cd just-one-branch
> 	$ git init
> 	$ git remote add origin <url>
> 	$ git pull origin master:master
> 
> And this _will_ work correctly.  Except when using get_branch(NULL) 
> instead of the validating resolve_ref().

"git pull origin master:master" invokes "git fetch" with --update-head-ok, 
so it doesn't matter for this case what "git fetch" does without 
--update-head-ok.

The check would block:

$ git fetch origin master:master

but this also would fail to update the working directory and would leave 
the index as if you're removing everything.

	-Daniel
*This .sig left intentionally blank*
