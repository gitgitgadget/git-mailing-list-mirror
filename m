From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
 commits
Date: Sat, 22 Mar 2008 02:33:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803220231020.4124@racer.site>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1812418688-1206149611=:4124"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcscc-0002px-OX
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbYCVBda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYCVBda
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:33:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:55778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752798AbYCVBd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:33:29 -0400
Received: (qmail invoked by alias); 22 Mar 2008 01:33:27 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp009) with SMTP; 22 Mar 2008 02:33:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ubcYbMgQugX3vkN936cQxn2kHR0zh7AvFwsOHhU
	Z1ZbUc8/v0kIID
X-X-Sender: gene099@racer.site
In-Reply-To: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77789>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1812418688-1206149611=:4124
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 22 Mar 2008, Jörg Sommer wrote:

> The current version of git-rebase--interactive shows the user the 
> commits coming from a merge.
> 
> M---A---B
>  \       \
>   o---o---+---o branch
> 
> Rebasing branch on M with preserve merges gives the commits A and B. But 
> if you mark them for editing or remove them the rebase fails. You must 
> keep them as they are. It's useless to bother the user with these 
> commits and might lead to mistakes.

I don't understand.  Rebasing with "rebase --onto <something else> M" 
_should_ show A and B.

Besides, I think that this would break exactly that case:

> @@ -523,7 +525,7 @@ do
>  		SHORTONTO=$(git rev-parse --short $ONTO)
>  		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
>  			--abbrev=7 --reverse --left-right --cherry-pick \
> -			$UPSTREAM...$HEAD | \
> +			--first-parent $UPSTREAM...$HEAD | \

If I am not mistaken, you now mark A and B to be _not_ in the list of 
commits all of a sudden, even if A and B _are_ reachable from "branch", 
but not from "M".

So I think this is exactly one of the cases which made me unsure if your 
expectation was always right.

IOW I think this is _very_ easy to get wrong, and needs careful thought.

Ciao,
Dscho

--8323584-1812418688-1206149611=:4124--
