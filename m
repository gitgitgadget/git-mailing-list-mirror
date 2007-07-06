From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 14:56:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707061440050.14638@iabervon.org>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
 <Pine.LNX.4.64.0707052320090.14638@iabervon.org> <Pine.LNX.4.64.0707061340350.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 20:56:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6sya-0000MH-EX
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 20:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbXGFS4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757548AbXGFS4D
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 14:56:03 -0400
Received: from iabervon.org ([66.92.72.58]:2755 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757502AbXGFS4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 14:56:01 -0400
Received: (qmail 6599 invoked by uid 1000); 6 Jul 2007 18:56:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jul 2007 18:56:00 -0000
In-Reply-To: <Pine.LNX.4.64.0707061340350.4093@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51781>

On Fri, 6 Jul 2007, Johannes Schindelin wrote:

> Hi,
> 
> Related, but not identical, is the problem illustrated in 
> http://thread.gmane.org/gmane.comp.version-control.git/49888
> 
> IMHO there is a bug. IIUC git push first looks for common ref names on the 
> local and remote side (yes, refs/remotes are excluded since v1.5.3-rc0~9, 
> but the underlying problem is still there). Then it pushes them. But here, 
> something seems to have gone wrong: refs/remotes/origin/HEAD is a symref. 
> And the corresponding ref is updated. Should git-push not just _not_ 
> update symrefs?

I believe this actually have nothing to do with git-push; it's actually 
git-receive-pack and maybe git-send-pack. Probably git-receive-pack 
shouldn't list symrefs at all, or should somehow report them as links so 
that they can be compared as links. The only refs that git-push itself 
updates are tracking refs on the local side for refs on the remote side 
which were updated. In the report, the reporter had (obviously) not 
configured any local tracking refs for the remote's tracking refs.

Now, if there are symref heads on the remote (maybe somebody wants to have 
a "dominus" branch which is a symref to "master" for people who only speak 
Latin), and this was in tracking refs as a symref as well, and the user 
pushed to both (with the remote side somehow identifying that the same 
change is being made to both names, and that's okay), then the tracking 
refs would need this same logic as well. But that requires an 
unimplemented and unrequested feature, with fixes in a number of other 
places first, before it's even possible to have git-push need to worry 
about it.

	-Daniel
*This .sig left intentionally blank*
