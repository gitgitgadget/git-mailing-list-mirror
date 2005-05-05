From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 04 May 2005 23:25:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505042311550.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
 <200505041156.19499.mason@suse.com>
 <Pine.LNX.4.61.0505041202270.22203@cag.csail.mit.edu>
 <200505041344.51637.mason@suse.com>
 <Pine.LNX.4.58.0505041501220.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Mason <mason@suse.com>,
	"C. Scott Ananian" <cscott@cscott.net>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 05:21:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTWvF-0004Li-GV
	for gcvg-git@gmane.org; Thu, 05 May 2005 05:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVEED1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 23:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVEED1a
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 23:27:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56267 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261882AbVEED10
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 23:27:26 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFZ00KQPYTTDT@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 May 2005 23:25:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0505041501220.2328@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 4 May 2005, Linus Torvalds wrote:

> I'll happily take the patch and just not use the delta packing myself (at 
> least until I trust it). But before I take the patch I want to make sure 
> that people agree on it, and that it's been tested well enough that it 
> won't cause people to corrupt their repositories.

To that effect I'm adding knowledge of delta objects to fsck-cache, to 
verify lists of deltas are all reachable and that they all expand to the 
expected data.  This way it would be a good test to completely deltafy a 
whole repository, run fsck-cache to ensure everything is fine, and 
undeltafy it all to see if things are still sane.

> For example, I do _not_ want to be in the situation SVN is in, where if
> you corrupt your SVN database, you're totally screwed. There's a real
> advantage to not having fancy data structures or complicated consistency
> rules.

With deltas it is still a bit more risky by design since many objects 
end up depending on a single one.  You loose that top object and it's 
all the delta chain that's gone.  But having the choice to use them or 
not is what makes the whole system flexible and suited to anyone's 
balance between robustness vs disk space.  Converting back and forth is 
certainly not a problem with the git model.

And if you deltafy things such that the objects in your head tree are 
always top of delta chain then you're not badly affected if some 
intermediate delta objects are corrupted since they are part of old 
trees only.


Nicolas
