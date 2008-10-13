From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 16:05:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810131546180.19665@iabervon.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 22:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpThB-0000s8-5k
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 22:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbYJMUF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 16:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYJMUF5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 16:05:57 -0400
Received: from iabervon.org ([66.92.72.58]:38112 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797AbYJMUFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 16:05:52 -0400
Received: (qmail 9752 invoked by uid 1000); 13 Oct 2008 20:05:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2008 20:05:50 -0000
In-Reply-To: <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98142>

On Mon, 13 Oct 2008, Johannes Schindelin wrote:

> I actually understand now why the tests started failing: the change from 
> resolve_ref() to get_branch() as requested by Daniel are at fault: 
> get_branch() does not check if the branch has an initial commit.
> 
> I am actually regretting making this change.  Daniel, do you agree that it 
> might be better to change back to resolve_ref(), so that the initial 
> complaint (IIRC Han-Wen git pull'ed into a freshly initialized repository 
> with that utterly bogus "git pull origin master:master" line) is not 
> re-raised?

Is it, in fact, okay to fetch into the current branch if it's "yet to be 
born"? I feel like it shouldn't be, since you'll get exactly the same 
problem that you would if the branch already existed: the index reflects 
the previous state (in this case, it's empty), so git will show that 
you've staged removing all of the files, right? So this would make the 
check for --update-head-ok more strict than before, but I think the 
behavior change is correct.

	-Daniel
*This .sig left intentionally blank*
