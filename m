From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 11/11] Improve merge performance by avoiding in-index merges.
Date: Thu, 28 Dec 2006 03:24:41 -0500
Message-ID: <20061228082441.GB18029@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org> <20061228073534.GK17867@spearce.org> <7vejqkxx1s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 09:24:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzqZG-0005pT-6h
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWL1IYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWL1IYq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:24:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46786 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965AbWL1IYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:24:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzqYi-00018j-2W; Thu, 28 Dec 2006 03:24:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 96AAA20FB65; Thu, 28 Dec 2006 03:24:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejqkxx1s.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35539>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > For a really trivial merge which can be handled entirely by
> > `read-tree -m -u`, skipping the read-tree and just going directly
> > into merge-recursive saves on average 50 ms on my PowerPC G4 system.
> > May sound odd, but it does appear to be true.
> 
> This sounds awfully attractive yet disruptive.  Should be cooked
> in 'next' for at least two weeks, maybe even longer to verify
> that performance figure holds for everybody.

I agree.  I have been thinking about doing this for a while but
just never sat down and did it until night.  To get it in 1.5.0 I
probably should have done this back in early Decmember.  Whoops,
bad timing on my part.  ;-)
 
> Also I think you need to make sure running merge-recursive
> upfront offers the same safety as the code you are removing then
> running it, as I vaguely recall its checking for local changes
> were slightly looser.

>From what I can tell, merge-recursive and read-tree -m are running
exactly the same code.  So aside from the fact that I bypassed the
update-index --refresh by accident, I don't think they will have
different outcomes.

-- 
Shawn.
