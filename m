From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git reflog show
Date: Sun, 24 Dec 2006 13:49:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061224061151.GE7443@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 13:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GySnq-000428-Tx
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 13:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWLXMtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 07:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWLXMtz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 07:49:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:46449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751347AbWLXMty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 07:49:54 -0500
Received: (qmail invoked by alias); 24 Dec 2006 12:49:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 24 Dec 2006 13:49:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061224061151.GE7443@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35354>

Hi,

On Sun, 24 Dec 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I wonder if it would make sense to teach the revision walking machinery 
> > about reflogs. A commit could be marked as coming from a reflog entry, and 
> > in that case the parents could be determined by the reflog rather than the 
> > commit itself.
> 
> The revision machinery already knows about reflogs with --reflog,
> used by git-pack-objects via git-repack.  But here its really only
> useful to seed the list of commits to be walked as part of a pack
> generation, to make sure the things referenced by the reflog stay
> around after a repacking.  And it implies --all.

Ah. I think it is a bit misnamed.

Besides, --reflog options of pack-objects, show-branch and general 
revision-walk based programs are independent.

I propose to change the behaviour of "--reflog" in revision.c (which 
should not have a big impact, since it is not even documented yet):

- if --all-reflog is passed, include all reflogs (part of the current 
  behaviour of --reflog), and
- if --reflog is passed, write the reflog messages in addition to the 
  commit lines, and rewrite the parent(s).

> Rewriting the commits in memory to appear to have parents based
> on their order of appearence in the reflog would nicely generate
> a single strand of perls, but it makes it difficult to then access
> the same commit's real parents, doesn't it?  So that may make the
> revision machinary somewhat limited in some applications.

Uhm, we rewrite parents all the time. Just think about "git log Makefile".

> Besides we want the reflog message entry and not the commit message
> when we perform pretty output, etc.  So really we are then talking
> about generating synthetic commit objects for the reflog data.

Yes, but if we have to read the reflog anyway to determine the logical 
(local) parent, we can just as well read the message, and display it, too.

What it buys us is that we do not duplicate efforts here, and we can 
easily visualize the reflog in gitk, too.

Ciao,
Dscho
