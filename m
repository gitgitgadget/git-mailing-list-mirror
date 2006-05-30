From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Tue, 30 May 2006 02:37:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605300207130.6713@iabervon.org>
References: <11489641631558-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 08:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkxpn-0002R0-Fm
	for gcvg-git@gmane.org; Tue, 30 May 2006 08:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWE3Gfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 02:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWE3Gfy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 02:35:54 -0400
Received: from iabervon.org ([66.92.72.58]:5640 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932163AbWE3Gfx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 02:35:53 -0400
Received: (qmail 9834 invoked by uid 1000); 30 May 2006 02:37:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 May 2006 02:37:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21018>

On Mon, 29 May 2006, Linus Torvalds wrote:

> Some long-running (in git terms) git programs will look up the pack-files 
> when they start, and if you repack after that, they won't see the new 
> pack-file, but they _will_ notice that the unpacked files are no longer 
> there, and will be very unhappy indeed.

We should be able to fix this, right? If an object isn't found in packs or 
unpacked, look for new packs; if there are any, look for the object in 
them; if it's not there, then give up. The only tricky thing is making it 
possible to scan through the available packs without installing any that 
are already installed. I think the failure case is only a critical path in 
the history-walking fetch code, which should probably disable this (or 
defer it to after trying to download the object).

	-Daniel
*This .sig left intentionally blank*
