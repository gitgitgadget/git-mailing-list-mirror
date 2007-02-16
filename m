From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected transfer
Date: Thu, 15 Feb 2007 23:41:58 -0500
Message-ID: <20070216044158.GB28894@spearce.org>
References: <11715851974102-git-send-email-mdl123@verizon.net> <11715851972838-git-send-email-mdl123@verizon.net> <7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 05:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHuvB-0001r1-Vp
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 05:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423171AbXBPEmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 23:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423170AbXBPEmF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 23:42:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43920 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423171AbXBPEmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 23:42:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHuuq-00045o-8u; Thu, 15 Feb 2007 23:41:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0ADF620FBAE; Thu, 15 Feb 2007 23:41:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39886>

Junio C Hamano <junkio@cox.net> wrote:
> Mark Levedahl <mdl123@verizon.net> writes:
> > +# we do things a slow way if max-age or min-age are given
> > +fast=
> > +[ "${fullrevargs##*--max-age}" == "$fullrevargs" ] && \
> > +[ "${fullrevargs##*--min-age}" == "$fullrevargs" ] && fast=1
> 
> Style.
> 
> Our scripts tend to spell the test command "test" and equality test
> operator as single '='.

Using "test" is a style thing, but using "=" rather than "==" is
a portability issue.  "==" is accepted by bash as a synonym for
"=", but its not valid elsewhere.

I've made my fair share of patches with "==" in them, only to have
someone else have a problem on their system and then submit a fix to
change them to "=".  Just say no to "==" in Git shell scripts.  ;-)
 
> > +	# get immediate parents of each commit to include
> > +	parents=
> > +	for c in $commits ; do
> > +		parents="$parents $(git-rev-list --parents $c | head -1 | cut -b42-)"
> > +	done
> 
> Nicely done, but you seemed to have used "head -n 1" elsewhere,
> which is more portable.

What about:

	parents="$parents $(git-rev-list --max-count=1 --parents $c | cut -b42-)"

?

I just used that trick recently.  Oh yea it was in git-gui's
GIT-VERSION-GEN script.  Though I did not know about using cut
like that...
 
-- 
Shawn.
