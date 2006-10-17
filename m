From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 13:00:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 19:01:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZsIl-0002rh-5x
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWJQRAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWJQRAL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 13:00:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22748 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751333AbWJQRAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 13:00:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A006QCHW99FV4@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 13:00:09 -0400 (EDT)
In-reply-to: <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29094>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Mon, 16 Oct 2006, Junio C Hamano wrote:
> >
> >> I'm still a bit under the weather and do not have enough
> >> concentration to dig into the problem tonight, but I noticed
> >> that something in "next", most likely the delta-base-offset
> >> patchset, broke git-index-pack:
> >> 
> >> $ X=ec0c3491753e115e1775256f6b7bd1bce4dea7cd
> >> $ wget http://www.kernel.org/pub/scm/git/git.git/objects/pack/pack-$X.pack
> >> $ ~/git-master/bin/git-index-pack pack-$X.pack
> >> ec0c3491753e115e1775256f6b7bd1bce4dea7cd
> >> $ git-index-pack pack-$X.pack
> >> fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has unresolved deltas
> >
> > Using the tip of the "next" branch (git version 1.4.2.4.gf9fe) I just 
> > cannot reproduce this problem at all.  I always get a good index and 
> > ec0c3491753e115e1775256f6b7bd1bce4dea7cd back.
> 
> Hmph.  I just got exactly the same breakage; could this be
> another 64-bit breakage?  My breakage was on x86-64.

I've been suspecting that since then as well.  I indeed tested on i386.
But reviewing the code I just can't find any obvious spot where 64-bit 
would be an issue, especially since your pack does not have any 
OFS_DELTA objects.

Could you instrument the code at the end of 
index-pack.c:parse_pack_objects() to display how many deltas were 
actually resolved and how many were not?  IOW is it a case of all or 
nothing, or is there an isolated case of corruption lurking somewhere?


Nicolas
