From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Fri, 05 Feb 2010 16:45:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002051634380.1681@xanadu.home>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
 <alpine.LFD.2.00.1002051539080.1681@xanadu.home>
 <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_H+1ty+2KaN+HdDRZzLRwhQ)"
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVzZ-0007ML-Af
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933844Ab0BEVp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:45:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19602 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab0BEVp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:45:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXE000X21RF9T11@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Feb 2010 16:45:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139098>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_H+1ty+2KaN+HdDRZzLRwhQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 5 Feb 2010, Jon Nelson wrote:

> On Fri, Feb 5, 2010 at 2:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 5 Feb 2010, Jon Nelson wrote:
> >
> >> [Using git 1.6.4.2]
> >>
> >> In one repo I have (136G objects directory, fully packed) I'm having
> >> some trouble.
> >> I've run git-gc --prune=now, git repack -Adf, and so on a half-dozen
> >> times and each time I do so it gets bigger, not smaller.
> >
> > Please tell us more.
> 
> I'll tell you whatever I can -- as soon as I know what it is you want.

I want to know what you did and what results you obtained to lead you to 
believe that 'git-gc --prune=now' makes your repository bigger.

> > You need to dig further down in history to find a commit that actually
> > references that blob/tree.  One easy method is to do:
> >
> >        git log --raw --all
> >
> > and within the pager ('less' by default) simply search for "b32c3d8".
> 
> OK. I'm piping "git log --raw --all" to a file this very moment. It'll
> take a while. However, one thing I did not mention is that there
> *should* be a 1:1 correlation between branches and commits. As in,
> every time I did a commit, the commit was on a new branch. 

Ouch.  Why?  I'm curious.

> I'll look into this, as I've fiddled with the repo a bunch of 
> different ways lately. I suspect the answer will be found in the logs.

If the blob you're looking for is not in that log, then it must be 
referenced by one of the reflog entries.  The reflog is a log of all the 
commits your branches, and the HEAD pointer, ever pointed at.  Those 
entries are kept for a certain period (3 months by default).  The HEAD 
reflog will keep a reference of all branches you might have visited, 
even deleted ones.  So another log:

	git log --raw -g HEAD

should ultimately give you the blob reference.


Nicolas

--Boundary_(ID_H+1ty+2KaN+HdDRZzLRwhQ)--
