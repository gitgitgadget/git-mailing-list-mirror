From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 14:19:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091418510.4362@racer.site>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
 <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711090225110.4362@racer.site> <7v1wb0xhxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUid-0004Tb-S6
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbXKIOUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758302AbXKIOUH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:20:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:50233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753378AbXKIOUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:20:05 -0500
Received: (qmail invoked by alias); 09 Nov 2007 14:20:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 09 Nov 2007 15:20:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XzpJxzt+XAhnzn4WozgfrwVShjgcMbWd6zrks1U
	kzPZM2t9hCsUr7
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wb0xhxq.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64187>

Hi,

On Thu, 8 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 8 Nov 2007, Junio C Hamano wrote:
> >
> >> I wonder if this is a sensible thing to do, regardless of the issue 
> >> of commit log message that contains anything.
> >> 
> >> The patch replaces git-rebase with git-rebase--interactive.  The only 
> >> difference from the existing "git-rebase -i" is if the command is 
> >> called without "-i" the initial "here is the to-do list. please 
> >> rearrange the lines, modify 'pick' to 'edit' or whatever as 
> >> appropriate" step is done without letting the user edit the list.
> >
> > Hmm.  I don't know, really.  I had the impression that the "git 
> > format-patch | git am" pipeline would be faster.
> 
> Heh, I did not read rebase--interactive carefully enough.
> 
> Unless told to use merge with "rebase -m", rebase replays the change by 
> extracting and applying patches, and speed comparison was about that vs 
> merge based replaying; I thought make_patch was done in order to avoid 
> using cherry-pick (which is based on merge-recursive) and doing patch 
> application with three-way fallback.  Apparently that is not what 
> "interactive" does.
> 
> Perhaps pick_one () could be taught to perform the 3-way fallback dance 
> git-am plays correctly.  The patch I sent to make 
> git-rebase--interactive take over git-rebase would then become quite 
> reasonable, I would think.

I have a different idea: How about changing cherry-pick to try a simple 
patch first?  If that fails, we can always go back to merge-recursive (or 
merge-nu once that is ready).

Ciao,
Dscho
