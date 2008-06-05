From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 6 Jun 2008 00:36:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806060030160.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <7v4p87zcv6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4P2p-0006xK-Kz
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYFEXiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYFEXiF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:38:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:41666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753268AbYFEXiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:38:03 -0400
Received: (qmail invoked by alias); 05 Jun 2008 23:38:01 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 06 Jun 2008 01:38:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1aDZITPX1fCHJFrBbcG+K4UjGoECT354zECzJw0
	wb6SOJZxxiY9Zh
X-X-Sender: gene099@racer
In-Reply-To: <7v4p87zcv6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84001>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> And the robustness issue I worry about the second point also applies to 
> >> a line that is "^-- $", especially if we were to make this available to 
> >> git-am.  Perhaps when the line begins with a '-', the logic could be 
> >> extra careful to detect the case where the line looks like the e-mail 
> >> signature separator and check one line beyond it to see if it does not 
> >> look anything like part of a diff (in which case you stop, without 
> >> considering the line you are currently looking at, "^-- $", a deletion 
> >> of "^- $", as part of the preimage context).
> >
> > Is this really an issue?  fixup_counts() is only called after a hunk 
> > header was read, and that should be well after any "^-- $".
> 
> Are you talking about "^-- $" or "^---$"?  Yes we are way past the 
> three-dash separator at this point, but e-mail signature separator 
> happens at the very end after the patch.

Oh yes, I was thinking about the "^---$".

> You read a hunk header line "@@ -l,m +n,o @@", and start counting the 
> diff text because you do not trust m and o.  When you read the last hunk 
> in a patch e-mail, you may hit a e-mail signature separator, like what 
> is given by format-patch output at the end.  Mistaking that as an extra 
> preimage context to remove "^- $" is what I was worried about.
> 
> -- 
> I worry, therefore I am...

Nice signature...

I could check for garbage after a line that consists of exactly "^-- $" 
with something like this (on top of 1/2):

@@ -0,0 +0,0 @@
 	default:
-		return -1;
+		return len != 4 && memcmp(line - len, "-- \n", len);
 	}

Hmm?

However, this will not work if anybody has a signature starting with 
"@@ ", "+", " ", "-" or "diff "...

Ciao,
Dscho

-- 
Won't dorry, he bappy
