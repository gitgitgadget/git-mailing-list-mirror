From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:58:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151448120.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <20090115133808.GA10045@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSkt-0001m5-Kl
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804AbZAON6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbZAON6F
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:58:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:47930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752652AbZAON6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:58:02 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:58:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 15 Jan 2009 14:58:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fZ1lZ52uf9+pBHFEUHqAu8L7Lk8GOcVlGtgZXG4
	NnFdtEMmNVZeIG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090115133808.GA10045@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105811>

Hi,

On Thu, 15 Jan 2009, Stephan Beyer wrote:

> Hmm, you are rebasing onto master which is merged into the branch you 
> want to rebase. So, I think the correct output should be the same like 
> git rebase without -p, ie
> 
> * 1337bee... (refs/heads/work) b4
> * deadbee... b3
> * badbeef... b2
> * fa1afe1... b1
> * 0153c27... (refs/heads/master) a4
> * 74f4387... a3
> * b37ae36... a2
> * ed1e1bc... a1
> 
> This is because master is already merged into work and a preserved
> merge will see that everything is already merged in.

I guess the problem is that the list shown in the editor says 'noop'.  
This does not happen without -p, so something is borked in the commit 
listing with -p.

Which is no wonder: the code after line 652 in git-rebase--interactive.sh 
that handles -p is utterly incomprehensible.

Remember: there is code that is so simple that it has no obvious flaws, 
and there is code that is so complicated that it has no obvious flaws.

IMO (and I said so much back then), it was the biggest mistake of the 
whole patch series that it was so intrusive and changed everything.  It's 
not like I did not warn anybody.

The point is: you could _easily_ handle -p with _almost the same_ 
rev-list command; you'd just have to make sure that --no-merges is 
skipped.

And then you only have to make sure that the current commit is the 
(possibly rewritten version of the) first parent of the next commit to 
pick.

Ciao,
Dscho
