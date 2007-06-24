From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Mon, 25 Jun 2007 00:20:39 +0200
Message-ID: <20070624222039.GB2374@steel.home>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home> <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de> <20070624093017.GC2467@steel.home> <EA80EB51-97F9-4C5F-BEF7-C8C1BF39B8D2@zib.de> <20070624183552.GA2374@steel.home> <6382A127-7A81-4ADE-B2C1-1FCCBE9EA239@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aRo-0003FO-SR
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXFXWUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXFXWUn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:20:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:28775 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXFXWUn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:20:43 -0400
Received: from tigra.home (Fa9d0.f.strato-dslnet.de [195.4.169.208])
	by post.webmailer.de (fruni mo16) (RZmta 7.5)
	with ESMTP id L015f7j5OM3I33 ; Mon, 25 Jun 2007 00:20:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9DE83277BD;
	Mon, 25 Jun 2007 00:20:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 01AD2C164; Mon, 25 Jun 2007 00:20:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6382A127-7A81-4ADE-B2C1-1FCCBE9EA239@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrHA+4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50829>

Steffen Prohaska, Sun, Jun 24, 2007 22:54:21 +0200:
> I don't see how I can avoid tree diffs. As I pointed out earlier I need
> to mix the tree of the base commit of the newly built branch with
> files that were changed in the series of commits that I'm transplanting.

Hmm...

> Just taking the whole tree from the commits I'm transplanting is  
> _wrong_.
> I need to only take files that were touched by a commit. The tree of
> the tip of the resulting branch can be quite different from the tree
> of the tip of the original branch.

I see.

> >As to perfomance: read-tree doesn't actually _read_ the blobs to
> >populate index, just the trees. And diff-tree has do do the same, but
> >also _compare_ two trees recursively: more work, more memory needed.
> 
> I'm still pretty convinced that I need tree diffs (not file diffs!).

"git-read-tree --reset" does an in-index merge (just discards unmerged
entries), so it still is better then git-diff-tree. But remove that
unlink, so that the previuos tree is not discarded and do a
"git-read-tree $onto" before starting the loop.

> Anyway, the script worked for me and I still think it may be useful for
> fixing broken repositories resulting from a wrong cvsimport. I would
> probably improve many details if someone else considered my work useful.
> But up to now it seems as if I failed to explain, why the script would
> be needed in the first place.
> 
> However, the best way would be to fix git-cvsimport to handle branches
> correctly independently of the time of the first commit to a branch;
> and avoid insane, broken repositories altogether.

You still better make it work properly wrt deleted files.
And you have to be careful not to hit a real content conflict.
