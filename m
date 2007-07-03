From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-stash to "apply --index"
Date: Tue, 3 Jul 2007 12:17:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031212570.4071@racer.site>
References: <Pine.LNX.4.64.0707021213350.4438@racer.site>
 <7vodiut8c3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:17:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5gNm-0006Rh-TN
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbXGCLRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbXGCLRM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:17:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:45644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755403AbXGCLRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:17:11 -0400
Received: (qmail invoked by alias); 03 Jul 2007 11:17:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 03 Jul 2007 13:17:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1992LY0DeZ9jCg7ONZGgRREyAR13IY1sdK59TKZCW
	YFNmkPexSVSIXe
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodiut8c3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51474>

Hi,

On Mon, 2 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	I am not quite sure if this should not be the default, with
> > 	--skip-index to turn it off if the trivial index merge fails,
> > 	and the user might be interested only in the working directory
> > 	changes anyway.
> >
> > 	Comments?
> 
> There is a bit of impedance mismatch between a rename-aware
> three-way merge (aka merge-recursive) used to update the working
> tree and a patch that updates the index.  The "rename-aware"
> thing can be fixed by doing the diff with -M, though.

Ah yes, I did not think about renames. But like you said, adding -M to the 
diff should help that.

> It might be easier to explain (1) not have --index option, but attempt 
> to do this always, and (2) even if the index cannot be updated, keep 
> going, without worrying about losing the difference between I and W, 
> probably with a message to the end user.

Okay, in this case I propose to make this the default, with an option 
"--skip-index" to only try re-apply the changes to the working directory.

> Suppose you are the user who gets "perhaps you would want to run without 
> --index?" hint.  What can you do?  Run without --index, or forget about 
> unstashing.  But the latter does not sound like an option.  So it feels 
> to me that --index is an unnecessary option.

It is very much like the choice you have with "git checkout" vs "git 
checkout -f". Either you change your index accordingly, or you say "I 
don't care about the index. What changes I had there, I will reconstruct 
myself."

> The potential confusion problem I mentioned in two of my earlier 
> messages due to the program doing one thing sometimes and another thing 
> some other times still applies, though.

Yes, that's why I would suggest not going ahead when the index could not 
be easily merged. Rather give the user enough information to decide.

Of course, this means that in complicated cases, the user mustn't run and 
hide when she hears "index!", but I guess that complicated cases always 
need you to know your tools better than easy problems.

Ciao,
Dscho
