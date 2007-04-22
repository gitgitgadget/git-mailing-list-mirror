From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Teach cat-file a --quiet option
Date: Sun, 22 Apr 2007 04:11:06 -0400
Message-ID: <20070422081106.GI17480@spearce.org>
References: <20070422011447.GC2910@spearce.org> <7virboq1tx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 10:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfXAJ-0008Ja-R4
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 10:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965528AbXDVILO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965525AbXDVILO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 04:11:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43052 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965536AbXDVILL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 04:11:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfXA3-0003s4-Dv; Sun, 22 Apr 2007 04:11:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2749320FBAE; Sun, 22 Apr 2007 04:11:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7virboq1tx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45226>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Sometimes when you get the content of a file in a script you don't
> > want an error message for missing files; instead its OK to treat
> > a missing file the same as one whose content was empty.
...
> I am not sure if I agree with this logic.  How is this different
> from discarding stderr to /dev/null?
 
Its not any different.  But it means I can do:

	open(I,'-|','git','cat-file','--quiet','blob',"HEAD:users/$who");

and not worry about redirection to silence the case of when $who
is not in the users subtree of HEAD.  Sure, I could redirect that,
but then that's something more like:

	if (open(I,'-|')) {
		open STDERR, ">/dev/null";
		exec 'git','cat-file','--quiet','blob',"HEAD:users/$who";
		exit 1;
	}

and uh, why, that's really annoying.  And my Perl is rusty enough
that I'm not even sure I did that right, I'd have to go look it
up danngit.  And didn't we just add a --quiet to git-diff?  This is
different, but not that much different..

What's also annoying is cat-file today prints an error with -e if
you use the "branch:path" syntax, but not if you supply the 40 byte
hex SHA-1 of the blob in question.  Again, you have to redirect
the one syntax, but not the other, even for just a simple -e.
Which makes -e slightly less useful.  So I also fixed that...

Anyway... if you really don't like it, drop it, I'll just have to
go digging through the Perl manual...  ;-)

-- 
Shawn.
