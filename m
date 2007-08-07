From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Tue, 7 Aug 2007 22:55:44 +0200
Message-ID: <20070807205543.GB27703@xp.machine.xx>
References: <46B8BA03.1030809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Kleine <matthias_kleine@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 22:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIW78-0006wb-SV
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 22:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXHGUzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 16:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935739AbXHGUzu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 16:55:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:55207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935221AbXHGUzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 16:55:46 -0400
Received: (qmail invoked by alias); 07 Aug 2007 20:55:43 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp023) with SMTP; 07 Aug 2007 22:55:43 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18UzAg/uu8UfM3GVHUleYJyzIgWC3bPV/oHmTV6n2
	giM0CTIi/2CfDV
Mail-Followup-To: Matthias Kleine <matthias_kleine@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46B8BA03.1030809@gmx.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55274>

On Tue, Aug 07, 2007 at 08:29:23PM +0200, Matthias Kleine wrote:
> Hi there,
>
> when running "git-svn dcommit" git-svn tries to find the svn-URL of the 
> current branch int git by looking for the most recent git log-entry 
> corresponding to a commit in svn (see working_head_info in git-svn).  In 
> case a merge just happended this might be the URL of another branch. Would 
> using "log --first-parent" instead of a plain "log" take care of this 
> problem or would it have other undesirable consequences?
>

I had this situation, too.


			a = svn branch 'a'
	m		b = svn branch 'b' (in my case, it was trunk)
      /   \		m = a merge of branch 'a' and 'b', not yet commited to svn
     a     b

So trying to dcommit m, git svn can't figure out on which branch, as 'a'
and 'b' are both reachable. I had to use a graft file to lose one of the
parents, which let git-svn commit to SVN.

So for a short fix to get the work done, you could create a graft file
where you fake m to only have one parent.

On the longer run, I would make sense to have an option to explicitly
specify on which SVN branch 'git-svn dcommit' should operate.

-Peter
