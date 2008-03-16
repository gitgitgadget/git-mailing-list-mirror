From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 16:00:32 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaz2h-0002cJ-R8
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 21:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYCPUAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbYCPUAf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 16:00:35 -0400
Received: from iabervon.org ([66.92.72.58]:37393 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYCPUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 16:00:35 -0400
Received: (qmail 4658 invoked by uid 1000); 16 Mar 2008 20:00:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 20:00:32 -0000
In-Reply-To: <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77378>

On Sun, 16 Mar 2008, Linus Torvalds wrote:

> In commit 34110cd4e394e3f92c01a4709689b384c34645d8 ("Make 'unpack_trees()' 
> have a separate source and destination index") I introduced a really 
> stupid bug in that it would always add merged entries with the CE_UPDATE 
> flag set. That caused us to always re-write the file, even when it was 
> already up-to-date in the source index.
> 
> Not only is that really stupid from a performance angle, but more 
> importantly it's actively wrong: if we have dirty state in the tree when 
> we merge, overwriting it with the result of the merge will incorrectly 
> overwrite that dirty state.
> 
> This trivially fixes the problem - simply don't set the CE_UPDATE flag 
> when the merge result matches the old state.

While you're at it, you should at least fix the comment. I actually think 
it would be better to have update start out 0 and be set to CE_UPDATE 
after verify_uptodate() and verify_absent(), since those checks are what 
verifies that using CE_UPDATE is okay.

	-Daniel
*This .sig left intentionally blank*
