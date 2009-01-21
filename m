From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to keeping track of cherry-pick?
Date: Wed, 21 Jan 2009 13:04:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211258080.3586@pacific.mpi-cbg.de>
References: <497663E4.4000302@telenor.com> <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org> <4976E059.6000404@telenor.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-724487211-1232539473=:3586"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Knut_Olav_B=F8hmer?= <knut-olav.bohmer@telenor.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 13:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPbqC-00017Q-6D
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 13:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729AbZAUME2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 07:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757444AbZAUME1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 07:04:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:59226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756947AbZAUME1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 07:04:27 -0500
Received: (qmail invoked by alias); 21 Jan 2009 12:04:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 21 Jan 2009 13:04:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QVvwcfJIQ/o1ikfhEYfjzmbp+J2kqiwwrbdPtZj
	cSWYfdfsCDLdFE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4976E059.6000404@telenor.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106598>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-724487211-1232539473=:3586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 21 Jan 2009, Knut Olav Bøhmer wrote:

> Junio C Hamano wrote:
> > Knut Olav Bøhmer <knut-olav.bohmer@telenor.com> writes:
> > 
> >> svnmerge.py can give us a list of revisions available for merging. The
> >> result is similar to "git log --chery-pick master..dev" The difference
> >> is that svnmerge.py operates on revision-numbers, and --chery-pick looks
> >> at the diffs. The result of that is that when we get a conflict when a
> >> patch is cherry-picked, it will still show up as "available" when I run
> >> "git log --cherry-pick master..dev"
> > 
> > I think you are looking at it a wrong way.
> > 
> > Because subversion (at least the older one) does not keep track of merges,
> > you had to track cherry-picks.  But cherry-pick is not how you usually do
> > things in git.  You keep many topic branches with different doneness, and
> > you merge well-cooked ones to the more stable integration branch while
> > leaving others still cooking.  So what you want to know is not cherry-pick
> > status, but merge status.
> 
> 
> I was afraid I would get this answer. I know that you change your
> workflow when you migrate to git, but I was looking for a way to resolve
> the situation we are in, due to our old vcs.

You could accomodate your workflow by having the newly introduced commit 
notes provide a mapping of which commits reflect which patch, in a way 
introducing equality classes of patches (thereby having the original SHA-1 
of the commit as kind of a "patch id").

But believe me, you would regret it.

If you are working on different topics, and want to apply only some of 
them, you really want to have different topic branches (it is even 
relatively easy to create them using "git checkout -b <new-topic> 
<miscellaneous-branch> && git rebase -i master" and then deleting the 
commits not referring to a certain subject).

The problem with having a single branch is that patches which are 
independent, can touch the same parts of the code, and are hard to manage 
independently.  If you had them in topic branches, merging them 
individually, you could at least use the rerere mechanism to resolve merge 
conflicts for such overlapping topics.

I speak of experience: my current workflow is exactly what you described, 
and I feel the pain.  That's why I said you would regret it, because I 
sure do.

Ciao,
Dscho

--8323328-724487211-1232539473=:3586--
