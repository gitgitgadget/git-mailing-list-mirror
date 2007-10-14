From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 18:51:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141843480.25221@racer.site>
References: <20071014143628.GA22568@atjola.homenet> <20071014163702.GA2776@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7cv-00067O-Tr
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759867AbXJNRvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759852AbXJNRvP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:51:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:55587 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759367AbXJNRvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:51:12 -0400
Received: (qmail invoked by alias); 14 Oct 2007 17:51:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 14 Oct 2007 19:51:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/cJZCxfy/4JhZbw8UJ6EtAENb9R3/rlvLZOAS51
	k2KttFvLCbqNh/
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014163702.GA2776@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60883>

Hi,

On Sun, 14 Oct 2007, Alex Riesen wrote:

> Bj?rn Steinbrink, Sun, Oct 14, 2007 16:36:28 +0200:
> > 
> > git blame just decided to crash on me, when I tried to use it while 
> > resolving a merge conflict. Interesting is probably, that it crashes 
> > when given the filename of a file that is not _directly_ affected by 
> > the merge, but contains code that originates from a file that caused 
> > conlicts.
> > 
> > Error message is: fatal: internal error: ce_mode is 0
> 
> It is not crashing. It is just not handling unexpected situation 
> properly:
> 
>     $ testcase.sh
>     ...
>     Switched to branch "foo"
>     CONFLICT (delete/modify): file1 deleted in HEAD and modified in master. Version master of file1 left in tree.
>     Automatic merge failed; fix conflicts and then commit the result.
>     fatal: internal error: ce_mode is 0
>     $ git ls-files --cached --stage
>     100644 72139f38953679bd19b3a7938c479d73c1aa7b59 1       file1
>     100644 3181f904ce3f9364b08524edd262a7a2ac766c9c 3       file1
>     100644 24e1ea80d6dcc497f60597b2a6d7cf65ecaa958a 0       file2
> 
> See? There is an unresolved merge.

I _think_ that what blame does here is correct.  It wants to handle the 
rename case, and because of the conflicts, it cannot determine the 
renames.

The proper thing to do now would be

	git blame HEAD file2

since you want to exclude the working tree from the blaming.

I agree that the error message is not really helping here, though.  Since 
we are not really libified, I do not see an easy way to help here, either, 
short of git-blame checking for unmerged entries.

Ciao,
Dscho
