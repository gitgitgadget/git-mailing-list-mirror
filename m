From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git reflog show
Date: Tue, 26 Dec 2006 17:14:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612261654330.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061224061151.GE7443@spearce.org> <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 17:14:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzEws-00012o-Eo
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 17:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWLZQOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWLZQOJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 11:14:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:41174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932699AbWLZQOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 11:14:08 -0500
Received: (qmail invoked by alias); 26 Dec 2006 16:14:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 26 Dec 2006 17:14:06 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35423>

Hi,

On Mon, 25 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Also I highly doubt visualization based on parents information rewritten 
> >> to match the reflog order is of _any_ use.  By rewriting the parenthood, 
> >> you are losing the topology and your visualization is no better than 
> >> what "tac .git/logs/$ref" would give.
> >
> > Okay, but if they are _not_ rewritten, we can reuse the log machinery to 
> > show the revisions in "upstream..master@{2.hours.ago}", but in the order 
> > they came into the local repository.
> 
> Shawn's code was about showing where the tip of the branch was,
> and I think you are talking about something entirely different,
> which I would address later.

If I read Shawn's mail correctly, it is not only about the tip.

> The most valuable parts of the revision walking code are about ancestry 
> traversal and history simplification with pathspec, neither of which 
> makes much sense to use when "walking" reflog.

Sorry to be a PITA here, but I think that it _would_ make sense. Quite 
often I ask myself "That feature in this file used to work. When and how 
was it changed?" Right now, I use git-log with path simplification, but 
with reflog walking, I could ask in a more specific way!

> But it _also_ makes sense to use reflog when the primary thing we are 
> interested in seeing is not how the tip jumped around, but seeing how 
> the branch acquired commits, which I think is what you are suggesting.  
> What we would want to have is a sort order different from the existing 
> topo or date, which is "reflog order".

I think it should not be a different sort order. As you pointed out 
yourself, a "git reset --hard HEAD^" removes the assumption of the commit 
list being a DAG.

Rather, I think about introducing a "get_parents(revs, commit)" function 
in revision.c, which takes reflog information rather than commit->parents 
if "--walk-reflogs" is passed to setup_revisions().

I hope to have a proof of concept later today.

Ciao,
Dscho
