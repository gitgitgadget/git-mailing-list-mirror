From: Nicolas Pitre <nico@cam.org>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 21:47:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903242124470.26337@xanadu.home>
References: <49C7FAB3.7080301@brainfood.com> <20090324210427.GC30959@zoy.org>
 <49C95453.9080503@brainfood.com>
 <alpine.LFD.2.00.0903242025110.26337@xanadu.home>
 <49C9818A.9040507@brainfood.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Hocevar <sam@zoy.org>, git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 02:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIFA-0006O5-PT
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 02:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZCYBrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbZCYBrm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 21:47:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56352 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZCYBrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 21:47:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH1002TSGZACIR0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 21:47:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49C9818A.9040507@brainfood.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114535>

On Tue, 24 Mar 2009, Adam Heath wrote:

> Nicolas Pitre wrote:
> > On Tue, 24 Mar 2009, Adam Heath wrote:
> > 
> >> Sam Hocevar wrote:
> >>>    In your particular case, I would suggest setting pack.packSizeLimit
> >>> to something lower. This would reduce the time spent generating a new
> >>> pack file if the problem were to happen again.
> >> Yeah, saw that one, but *after* I had this problem.  The default, if
> >> not set, is unlimited, which in this case, is definately *not* what we
> >> want.
> > 
> > In your particular case, if the problem is actually what I think it is, 
> > the pack.packSizeLimit wouldn't have made any difference.  This setting 
> > affects local repacking only and has no effect what so ever on the push 
> > operation.
> 
> Ooh.  Care to enlighten those of us not blessed with git internal
> knowledge?

See my previous email for a likely explanation about your issue.

As to the pack.packSizeLimit setting: it is used when repacking only in 
order to avoid big packs on systems that might have issues dealing with 
large files.  During a repack, if the currently produced pack is about 
to get over that limit, then the pack is closed and a new one is 
started.  You therefore end up with many packs.

The transfer protocol used during a fetch or a push uses the pack format 
streamed over the network, but only one pack can be transferred that 
way.  Maybe the reception of a pack during a network transfer should be 
split according to pack.packSizeLimit as well, but this is currently not 
implemented at all. No one complained about that either, so I'm guessing 
that 
splitting a large pack, if needed, by using 'git repack' after a 
clone/fetch is good enough.

Personally, I don't think actively splitting packs into smaller ones is 
that useful, unless you wish to archive them on a file system which 
cannot handle files larger than 2GB or the like.

> On another note, anyone have a goat I can buy, for the sacrifice?

Beware the wrath of Git...


Nicolas
