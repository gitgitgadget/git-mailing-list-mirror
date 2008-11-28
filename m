From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 28 Nov 2008 12:47:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de> <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 12:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L61he-0000xb-41
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 12:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYK1Lit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 06:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYK1Lit
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 06:38:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751740AbYK1Lis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 06:38:48 -0500
Received: (qmail invoked by alias); 28 Nov 2008 11:38:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 28 Nov 2008 12:38:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZhoMWXXnZIgQvponKUl0FVbPgVKKSuFpGOrAPKM
	KOC9qOKYmwQDQy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101871>

Hi,

On Thu, 27 Nov 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I have a strong suspicion that the narrow stuff will make the worktree 
> > mess pale in comparison.
> >
> > Note that I do not have time to review this myself (which is not 
> > helped at all by it being no longer a trivial single patch, but a full 
> > 10 patches!), but I really have a bad feeling about this.  IMO it is 
> > substantially under-reviewed.
> 
> Well, "a bad feeling" is not a convincing enough argument either, is it? 
> What kind of bad interaction are you fearing?

I just remember the worktree stuff well enough.  I had a bad gut feeling 
when it was proposed, and I had a bad impression of the (IMO way too 
intrusive) patch series implementing it.  It was pretty buggy and affected 
Git in serious ways (in order to accomodate worktree, we broke operations 
in bare repositories at least once, for example).

(So no, "bad feeling" is not convincing, but it is basically a primitive 
pattern matching in experiences that have not been fully analyzed, but 
that turned out to be bad enough.)

I tried to fix it, but did not a very good job at it.  In the meantime, I 
think I know why: there is no elegant way to implement this that is 
performant at the same time.  (Just think of having git_dir be relative: 
this is a necessity for the performance, but ugly to implement in the 
presence of worktree where it may _need_ to be absolute).

To me, the narrow patch series has all the looks of becoming the same type 
of nightmare:

- it is intrusive,

- it consists of a substantial number of patches (making bugs the opposite 
  of shallow),

- it is heavily under-reviewed,

- it _needs_ a lot of changes to be accomodated, affecting common code 
  paths, having all the potential to break existing workflows, and

- there is as little interest in the feature from core Git developers as 
  with worktree, literally guaranteeing that it will not, or only very 
  slowly, and probably badly, get fixed if it breaks.

And the worst part: I think that as with worktree, there has not been 
enough of kicking forth and back ideas how to design the beast, so I fully 
expect a subtle breakage that would require a redesign (which will be 
painful, with existing users of the feature).

Maybe I am crying "wolf", but I _do_ want to caution against risking too 
much, too fast, with that feature.

In other words, unless there is more interest in that feature, enough to 
generate a well-understood design before a good implementation, I'd rather 
see this patch series dropped.

Ciao,
Dscho
