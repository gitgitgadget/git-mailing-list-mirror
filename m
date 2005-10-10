From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Mon, 10 Oct 2005 11:48:42 -0500
Message-ID: <1128962922.9069.11.camel@cashmere.sps.mot.com>
References: <20051005214447.GF15593@reactrix.com>
	 <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	 <20051007000041.GH15593@reactrix.com>
	 <Pine.LNX.4.63.0510071149550.23242@iabervon.org>
	 <7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
	 <20051007172206.GK15593@reactrix.com>
	 <7vachl42tt.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0510071808071.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Nick Hengeveld <nickh@reactrix.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 18:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP0pn-0004ow-In
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 18:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVJJQtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVJJQtB
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 12:49:01 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:63105 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750920AbVJJQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 12:49:00 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j9AGxVex001598;
	Mon, 10 Oct 2005 09:59:31 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j9AGt4sO003818;
	Mon, 10 Oct 2005 11:55:05 -0500 (CDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510071808071.23242@iabervon.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9897>

On Fri, 2005-10-07 at 17:39, Daniel Barkalow wrote:

> 
> I believe that the situation is the one you describe in your previous 
> message: we determine we need to fetch A and B; we ask for A; we ask for 
> B; we find A isn't available alone, but is available in a pack; we get the 
> pack; we find we now have B (in the pack); the request for B (which would 
> probably fail) is left dangling.
> 
> The only actual problem I can see is if this happens with a whole bunch of 
> objects at the beginning of a big download, and all but one of your 
> connections are left in this state while you download all of the loose 
> objects over the one connection that got the pack.
> 
> I don't know if this is a problem for the new http code, but it could be 
> an issue in general if a transport method allocates resources in 
> prefetch().

So, this sounds like a classic resource scheduling problem
with various solutions encoded in many compiler schedulers.

Doesn't this sort of scheduling problem get solved by a
two-stage request pipeline model?  In particular, you only
"semi-request A" and "semi-request B" into a queue.  When
all of the sub-parts (that are needed) of some pack P have
been requested you issue the one request for the common
pack P holding all the sub-parts.  Then all the sub-parts
are can be retired from the queue.

Or am I just now finally catching up? :-)

Thanks,
jdl
