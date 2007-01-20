From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port - initial work uploaded
Date: Fri, 19 Jan 2007 22:31:49 -0500
Message-ID: <20070120033149.GB11200@spearce.org>
References: <200701192148.20206.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 04:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H86xQ-0006z0-EK
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 04:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbXATDby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 22:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXATDby
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 22:31:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892AbXATDbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 22:31:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H86x9-0008GA-WF; Fri, 19 Jan 2007 22:31:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2ADBF20FBAE; Fri, 19 Jan 2007 22:31:50 -0500 (EST)
To: Johannes Sixt <johannes.sixt@telecom.at>
Content-Disposition: inline
In-Reply-To: <200701192148.20206.johannes.sixt@telecom.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37256>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> I've been working on a MinGW port for some time now. I've pushed out what I 
> have so far to a git.git fork at repo.or.cz. For details on how and what to 
> clone, please look at the top of

Can I make a few suggestions?

Base your branch on Junio's 'master', not 'next'.  This looks like
its going to be a fairly long-running topic with a large number
of commits.  It will be easier to convince Junio to pull the topic
in if its based solely on 'master' than if its based on 'next'.

I made the mistake of building my git-fast-import topic on top of
'next' back in Aug. 2006.  Its still going and has not yet merged
into git.git.  I finally went through the pain of rebasing it onto
'master' to make the merge easier for Junio post 1.5.0.  Of course
gfi is also less intrusive than this topic will be.


The other is maybe try to avoid:

	#ifndef __MINGW32__
	...
	#endif

instead try to use something like:

	git-compat-util:
	#ifdef __MINGW32__
	#define is_mingw32 1
	#else
	#define is_mingw32 0
	#endif

	everywhere else:
	if (is_mingw32) {
	}

This way the code within the block can be syntax checked, etc. on
non-MinGW platforms but will be removed by the compiler on those
non-MinGW systems.  I just went through trying to do a #ifndef thing
for Windows (1510fea7 in git.git, aka the NO_FAST_WORKING_DIRECTORY
flag) and Junio rightly rejected my first attempt which used #ifndef,
and instead used something like the above.
 
-- 
Shawn.
