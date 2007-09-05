From: Nicolas Pitre <nico@cam.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 14:54:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT01a-00058W-Cx
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbXIESyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbXIESyq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:54:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12962 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbXIESyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:54:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNW000M0SJ4KX60@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Sep 2007 14:54:41 -0400 (EDT)
In-reply-to: <877in50y7p.fsf@hades.wkstn.nix>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57739>

On Wed, 5 Sep 2007, Nix wrote:

> I personally wonder if git-gc shouldn't use a proportional scheme, so
> that only some packs get repacked, maybe the smallest ones (and when
> they grow to the same size as the next largest one, the two get repacked
> into one). This has the singular advantage that you won't have to
> carefully drop .keep files everywhere or have to worry about your git-gc
> of 50K of loose objects suddenly deciding to repack 100Mb of packfiles
> and taking ages.

Not only that.  Currently the "Counting objects" phase when running 
git-gc on the Linux repo takes a significant amount of time, even if 
there is little to repack.

If any kind of automatic repack is implemented, it should be an 
incremental repacking only, not the full thing, i.e. git-repack without 
-a, or git-pack-objects with --unpacked.  The idea is to be the least 
intrusive as possible.  Also, object walking should be limited to 
objects linked to a commit object which is itself unpacked in order to 
cut on the time required to fully enumerate all objects.

This way a semi-packed state will always be preserved and should be good 
enough.  The full repacking should probably be left to manual execution 
of git-gc.


Nicolas
