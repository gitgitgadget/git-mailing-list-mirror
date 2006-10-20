From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 23:36:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610192324420.1971@xanadu.home>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu>
 <20061020002048.GC7162@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0610192058130.1971@xanadu.home>
 <20061020022723.GE7162@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 05:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GalBJ-0000Nx-9Q
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 05:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946156AbWJTDgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 23:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946149AbWJTDgV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 23:36:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45036 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1946156AbWJTDgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 23:36:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7F00A2B0OJKV60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Oct 2006 23:36:19 -0400 (EDT)
In-reply-to: <20061020022723.GE7162@delft.aura.cs.cmu.edu>
X-X-Sender: nico@xanadu.home
To: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29406>

On Thu, 19 Oct 2006, Jan Harkes wrote:

> If we see a complete object it will remain complete. If we find a delta,
> and we have the base in the current repository it will be expanded to a
> complete object.
> When we get a delta that doesn't have a base in the
> current repository it will remain unresolved and is written out as a
> delta.

But the point of the whole exercice is actually to avoid unresolved 
deltas.  And you know if you have unresolved deltas only when the whole 
pack has been processed.

If the base object is not in the repository but it is in the pack 
_after_ the delta that needs it, you won't have resolved it.  If this is 
a thin pack with missing base objects for whatever reason you're 
screwed.

If the delta has its base object in both the repository _and_ in the 
pack but after the delta then you will have expanded the delta 
needlessly.

So your solution is suboptimal.

The optimal solution really consists of appending missing base objects 
to a thin pack in order to make it complete, or error out if those 
cannot be found.


Nicolas
