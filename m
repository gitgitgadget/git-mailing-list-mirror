From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/7] Use 'printf %s $x' notation in t5401
Date: Wed, 30 Jan 2008 22:41:56 -0500
Message-ID: <20080131034156.GV24004@spearce.org>
References: <20080130062156.GA15838@spearce.org> <7vlk67izoa.fsf@gitster.siamese.dyndns.org> <20080130064845.GR24004@spearce.org> <7vbq72hjzo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 04:42:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKQJu-000697-UJ
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 04:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbYAaDmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 22:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbYAaDmB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 22:42:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46673 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbYAaDmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 22:42:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JKQJ8-0008US-Ni; Wed, 30 Jan 2008 22:41:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A350020FBAE; Wed, 30 Jan 2008 22:41:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbq72hjzo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72098>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> 	printf '%s\n' "$@"
> >
> > Eh.  Since all we care is that the argument count is 0 we probably
> > should be looking at $# and calling it a day.
> 
> I'll apply as-is, but once you break the code that calls
> pre-receive hook in such a way that it sends unexpected
> arguments, you'd thank me for suggesting to print the arguments
> separately while debugging the problem with the test script.

Well, I don't really think it matters.  I doubt we'll break that
code that invokes the pre-receive or post-receive hooks.  And as
those hooks are defined to never take arguments if we did suddenly
start passing arguments we want the test to break.  When tests break
sometimes its not obvious why they have broken.

Case in point, the "remote: " prefixing caused by the sideband
demultiplexer really confused me for about 15 minutes.  I could
not figure out why the last test in this script was failing.
Until I pulled my head out of the sand and looked at the "actual"
file and saw those prefixes.  At which point it was very obvious.

:)

We haven't touched that script in almost a year.  I poked at it only
to fix a stupid error from my printf implementation, and because of
the new "remote:" prefix.  Which since it is a change in behavior may
cause problems for anyone who is trying to screen-scrape the stderr
of git-push.  Gawd I hope nobody's scripts are that convoluted.

-- 
Shawn.
