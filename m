From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 22:23:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610172209070.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
 <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
 <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 04:23:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga15j-0001nz-CD
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 04:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWJRCXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 22:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJRCXc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 22:23:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34104 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751153AbWJRCXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 22:23:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7B00IH47Z65G20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 22:23:30 -0400 (EDT)
In-reply-to: <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29180>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> The part you pointed out to me about "accidental collision"
> still bothers me somewhat.

I'll try to clear them away.

> Right now we do not produce ref-delta and ofs-delta in the same
> stream, 

It is fully supported nevertheless.

> but if somebody did so then it would mean a disaster to have an 
> accidental collision of an 8-byte offset value plus 12-byte traiing 
> NUL and another base object whose object name happens to match that 
> pattern.

Not really.  The only effect that would have on the sorted list of 
delta entries -- such sorting used to bring all deltas with the same 
base object contigously -- is that those deltas might not be perfectly 
contigous wrt their base object.  This is why there is a test to skip 
deltas if they happen not to be of the expected type.

> I am actually Ok if we say the code assumes one stream has only
> ref-delta or ofs-delta and never both.

I'm perfectly OK with both types completely randomized.

> But then I suspect the first pass of parse_pack_objects() should
> make sure that assumption holds true for the pack being
> inspected and barf if it is not.

This is an unnecessary restriction though.

> Also the second pass do not have to run two find_delta_childs() calls 
> per delta object because by that time we know which kind would never 
> appear in the packfile.

True, but the flexibility is worth having I think.  It makes the thing 
more robust instead of less.

> By the way can we call that find_delta_children() pretty please?

I have no problem with that.


Nicolas
