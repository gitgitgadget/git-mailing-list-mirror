From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 05:16:53 -0500
Message-ID: <20070111101653.GC28309@spearce.org>
References: <200701110941.22024.andyparkins@gmail.com> <20070111095046.GA28309@spearce.org> <Pine.LNX.4.63.0701111057110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 11:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wzV-0001AJ-Qt
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbXAKKQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbXAKKQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:16:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38113 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965341AbXAKKQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:16:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4wzS-0005sj-SQ; Thu, 11 Jan 2007 05:16:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 58D1820FBAE; Thu, 11 Jan 2007 05:16:54 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701111057110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36575>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 11 Jan 2007, Shawn O. Pearce wrote:
> 
> > That said I don't really care about this problem that much. The problem 
> > that I care about is its far too easy to convert the lineendings in a 
> > file (e.g. CRLF->LF, LF->CRLF).  This causes the entire file to differ, 
> > making merges very difficult.  I really should just fix it (in the one 
> > place where it matters to me) by modifying the pre-commit hook to look 
> > for such a case and abort.
> 
> Why not just introduce a config variable, and do the conversion in-flight?

That's a lot of work and goes very much against the Git mindset that
we never alter content, just store it as-is.  If Linus sees this
thread I'm suspecting he will jump in and point out that altering
content transparently like this just wrong.  I think he's stated
something like that in the past.  :-)

All I want is to make the user realize what they have done.  "Hey
dummy, you just changed the entire file and the only difference I see
for most lines is simply the addition/removal of a CR.  You shouldn't
do that!".  The pre-commit hook is the perfect place for that.

It should be pretty easy to do.  For every line in the diff stuff
it into a perl hash after removing any trailing CR.  If both an
add and a delete for the exact same line of text appear in the diff
(with the only difference being the CR on the end) and the number
of such lines number is at least 50% of the modified lines in the
file, something's amiss.  Smack the user and tell them to fix the
file.
 
> Or, alternatively, do the merge ignoring white space? (Of course, this is 
> somewhat pointless when merging whitespace fixes...)

Lets not go down that road.  That's just asking for trouble.
And it sounds like a lot of work from what you pointed out in
another message.

-- 
Shawn.
