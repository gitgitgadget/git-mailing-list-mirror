From: Stephen Rothwell <git@ozlabs.org>
Subject: Re: bug in git-fsck-cache?
Date: Thu, 1 Sep 2005 12:02:26 +1000
Message-ID: <20050901120226.54547107.git@ozlabs.org>
References: <20050831161529.327a7957.git@ozlabs.org>
	<7v4q959857.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 04:03:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAePc-0001cc-Jt
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 04:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVIACCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 22:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVIACCS
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 22:02:18 -0400
Received: from ozlabs.org ([203.10.76.45]:56729 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965022AbVIACCS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 22:02:18 -0400
Received: from oak (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBD5E681E0;
	Thu,  1 Sep 2005 12:02:16 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q959857.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7987>

On Wed, 31 Aug 2005 13:13:56 -0700 Junio C Hamano <junkio@cox.net> wrote:
>
> Stephen Rothwell <git@ozlabs.org> writes:
> 
> > The commit c594adad5653491813959277fb87a2fef54c4e05 is shown as
> > "connected" (in Linus' tree, not one of my patches) by gitk, so I am happy
> > that git prune did not get rid of it, but why does fsck-cache report it as
> > dangling?
> 
> Hmph.  You ran fsck-cache by hand without --full (i.e. you told
> it not to worry about objects already in packs); 'git prune'
> runs it with '--full' to do the full connectivity analysis.  I
> think that's where the difference comes from.

ok, with '--full' nothing gets reported as dangling.  That commit is not
in a pack, but is in an object directory referenced through
objects/info/alternates.

> Is that commit reachable from any of the refs hanging under your
> $GIT_DIR/refs/?  For example, do you have the Linus tip of the
> master branch in $GIT_DIR/refs/heads/origin?

yes, master == origin and that commit is reachable from master according
to gitk.

> If an object is already in a pack and later became unreachable
> from any of your refs, there is no way to remove that object
> from the pack, so dangling commits in a pack will be left
> dangling even after 'git prune'.

It is still reachable as fsck-cache --full shows (I guess).

Cheers,
Stephen Rothwell
