From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Fri, 16 Feb 2007 02:45:03 -0500
Message-ID: <20070216074503.GH28894@spearce.org>
References: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org> <11716079211954-git-send-email-mdl123@verizon.net> <20070216064852.GF28894@spearce.org> <7v4ppma788.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 08:45:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxmY-0007uG-4D
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbXBPHpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbXBPHpM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:45:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48000 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXBPHpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:45:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHxmD-0005z7-Kh; Fri, 16 Feb 2007 02:45:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 024E520FBAE; Fri, 16 Feb 2007 02:45:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v4ppma788.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39898>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Mark Levedahl <mdl123@verizon.net> wrote:
> >> +        # update only if non-fastforward
> >> +        local=$(git-rev-parse --verify "$ref^0" 2>/dev/null)
> >> ...
> >> +        git-update-ref -m "git-unbundle update" $ref $sha1
> >
> > What about passing $local as the final argument to update-ref,
> > so that the ref won't be modified if someone changed it while
> > an unbundle was running?  Sure its mostly a manual operation,
> > but imagine running it on a bare repository while someone else
> > is pushing into it...
> 
> The script already has $local at that point, so adding it to
> update-ref is a no-cost change to make things safer.  I think it
> makes sense.

Actually that's only if --force was not given.  If --force was
given, rev-parse wasn't run, so local is not populated.  So maybe
its not trivial.
 
> But I have to wonder...  While someone else is _pushing_ into
> it?  Why are _you_ sneakernetting, then?

People do weird things.  I agree, its probably unlikely to ever
happen.  But give a user a length of rope, they will find a way to
hang themselves...

I can see someone trying to use an update hook with bundle/unbundle
to move stuff from one repository to another, despite the fact that
are better ways to do that.  Better that we fail when an update
might lose changes.

-- 
Shawn.
