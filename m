From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 11:07:01 -0500
Message-ID: <20070227160701.GD3230@spearce.org>
References: <11725197603476-git-send-email-nico@cam.org> <1172519760216-git-send-email-nico@cam.org> <11725197613482-git-send-email-nico@cam.org> <11725197622423-git-send-email-nico@cam.org> <11725197633144-git-send-email-nico@cam.org> <11725197632516-git-send-email-nico@cam.org> <7vejobhor2.fsf@assigned-by-dhcp.cox.net> <20070227150126.GA3230@spearce.org> <alpine.LRH.0.82.0702271029060.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9BC-0000mq-T1
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933483AbXB0Unh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933806AbXB0Unh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:43:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbXB0Unf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:43:35 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 15:43:33 EST
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HM4qv-0003Uj-M8; Tue, 27 Feb 2007 11:06:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC11D20FBAE; Tue, 27 Feb 2007 11:07:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0702271029060.29426@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40796>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 27 Feb 2007, Shawn O. Pearce wrote:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> > > I am wondering if "enum object_type" and signed comparison here
> > > are compatible.  sha1_object_info() is of type "int" so that is
> > > clearly signed, but are we safe assuming this would not result
> > > in "type is unsigned and condition is always false"?
> > 
> > See my recent patch; I actually rewrote those hunks to use OBJ_BAD
> > rather than < 0, as this cleans things up for my packv4.

Hmm... I appear to now be banned from posting to the git mailing list
and I am also no longer recieving email from the mailing list.  Argh!
 
> I'd prefer if < 0 remained though.  That way we can use negative values 
> for any kind of error status.  And for kernel hackers this is a pretty 
> common idiom.  And it uses less line realestate.
> 
> Actually OBJ_BAD could be assigned the value -1 and OBJ_MAX used to 
> verify the object number is within range.  That would unify things and 
> make the code a bit more logical.

I guess I could do that; my unify_type() function just needs to add
a new conditional to see if the input is < 0 and if so return it
unchanged.  I was trying to avoid that extra condition as it appears
twice in the critical path of the object sorting in pack-objects.

-- 
Shawn.
