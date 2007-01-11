From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 03:00:36 -0500
Message-ID: <20070111080035.GA28222@spearce.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4urd-0000mK-If
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbXAKIAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbXAKIAn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:00:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35319 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965330AbXAKIAm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:00:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4ura-0007kV-1M; Thu, 11 Jan 2007 03:00:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 407A420FBAE; Thu, 11 Jan 2007 03:00:36 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701102241230.4964@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36552>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 10 Jan 2007, Junio C Hamano wrote:
> > * sp/describe (Wed Jan 10 06:39:47 2007 -0500) 1 commit
> >  - Chose better tag names in git-describe after merges.
> > 
> > Slowing it down by 4x is very unfortunate.  I think there is a
> > better way to walk the ancestry than doing one at a time to
> > count the commits, but I did not have enough time to look at
> > this today.
> 
> However git-describe is certainly not a frequent and speed critical 
> operation, and 
> even if it cannot be sped up then waiting 300 ms more won't really 
> affect one's workflow that badly.

My thoughts exactly.  I spent a few hours trying to determine
an algorithm that produced the right answer and did not require
generating the revlist between the tag and the requested commit
for every possibly matching tag.  I did not come up with one.
If someone else does it would obviously be a welcome replacement
to my own patch.  :-)

There is almost no additional penalty for a simple strand of pearls
with the tag placed along that strand; only one possible tag will be
found.  But my code does an unnecessary revision list in this case.

Where we really get hit is the large number of possible tags.  The
master branch is turning up 14 tags, some dating back to v1.4.1-rc1.
I do try to abort the revision list as soon as one of those tags
cannot give me a better selection than the one I have currently,
but I still had to generate a revision list to reach that point.

-- 
Shawn.
