From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Thu, 5 Jun 2008 23:39:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806052304300.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4O9p-0000y4-Q2
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 00:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYFEWlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 18:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbYFEWlR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 18:41:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:38035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753169AbYFEWlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 18:41:16 -0400
Received: (qmail invoked by alias); 05 Jun 2008 22:41:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 06 Jun 2008 00:41:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TV25lcYiTczbGN5Ed9Likh1CYTFi6iAFs2hlm15
	DAFSlp9tP+1tW5
X-X-Sender: gene099@racer
In-Reply-To: <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83989>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Sometimes, the easiest way to fix up a patch is to edit it directly, 
> > even adding or deleting lines.  Now, many people are not as divine as 
> > certain benevolent dictators as to update the hunk headers correctly 
> > at the first try.
> >
> > So teach the tool to do it for us.
> 
> Two comments and a half.
> 
>  * Latest POSIX draft talks about unified context and allows an empty line
>    to represent an empty common context line.  GNU diff already emits such
>    a diff.  fixup_counts() should take this into account.

As you pointed out, I wanted to support only add -e.  But that should not 
be an issue at all.  I think a "case ' ': case '\n':" should be enough, 
right?

>  * I'd sleep better at night if 'Probably "diff ..."' part were written 
>    in a bit more robust way.

How about stopping on "@@" and end of file only, and complaining 
otherwise?

>  * (minor) There is an established term for this operation: recountdiff, 
>    so --recount might be a better name.  fixup_counts() also is better 
>    called recount_diff() if we go this route.

Fine!

> If you are too narrowly focused to only support "git add -e", the first 
> issue does not matter, because we always emit "SP LF" for such a common 
> context.  The reason why I care about the first two points is because we 
> may want to teach git-am about this new option as well in 1.6.0.

Point taken.

> And the robustness issue I worry about the second point also applies to 
> a line that is "^-- $", especially if we were to make this available to 
> git-am.  Perhaps when the line begins with a '-', the logic could be 
> extra careful to detect the case where the line looks like the e-mail 
> signature separator and check one line beyond it to see if it does not 
> look anything like part of a diff (in which case you stop, without 
> considering the line you are currently looking at, "^-- $", a deletion 
> of "^- $", as part of the preimage context).

Is this really an issue?  fixup_counts() is only called after a hunk 
header was read, and that should be well after any "^-- $".

> As to code structure, we might want to make the later parameters to 
> apply_patch() an integer, of OR'ed flag values, or even a pointer to a 
> structure that holds options.

Right.

Will fix up and resubmit.

Ciao,
Dscho
