From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sat, 25 Jun 2005 00:40:06 -0400
Message-ID: <42BCE026.8050405@pobox.com>
References: <20050624.212009.92584730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 06:35:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm2O2-00066e-6t
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 06:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbVFYElx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 00:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbVFYElw
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 00:41:52 -0400
Received: from mail.dvmed.net ([216.237.124.58]:57030 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263334AbVFYEkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2005 00:40:09 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dm2Se-0007HD-IY; Sat, 25 Jun 2005 04:40:08 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050624.212009.92584730.davem@davemloft.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David S. Miller wrote:
> To get a clean history to push to Linus, I typically blow
> away my trees and make fresh ones to stick patches into
> which I want to merge.
> 
> That mostly works fine here on my local systems, but I know this
> brings the master.org mirroring system to it's knees.  So what is the
> generally condoned way to do stuff like this in a more friendly way?
> 
> Should I:
> 
> 1) Do a git pull from Linus's tree once he takes my changes, then
>    ask GIT to prune the tree?  How do I do that and how does it work?

> It takes sometimes an hour for my tree updates on master.kernel.org
> to propagate to rsync.kernel.org so I can ask Linus to pull.
> That's crazy.

Unfortunately you cannot fix this by changing your actions.  This is the 
cumulative effect of all the git kernel trees on kernel.org.  It now 
takes over an hour for my non-git changes to propagate from master to 
the mirrors, as well.

This is all due to the rsync sweeps, which have to scan metric tons of 
inodes and dentries.  Orders of magnitude over the pre-git days.

ftpadmin@kernel.org folks are supposedly working on an inotify-based 
system, and an improved rsync application.  No ETA or details.

As an aside, cold-cache, git really punishes my disks.  Ted T'so noted 
that it really drains laptop batteries, too.


> 2) Should I use .git/object/ database symlinking?
> 
>    Are there any scripts out there which do this automatically?
>    Something as simple to run as "git-pull-script" and it takes
>    care of using links when possible on a local filesystem.

On both kernel.org and locally, I use 'cp -al' to duplicate the initial 
.git/objects directory, and then rsync (->kernel.org) or git-pull-script 
(<-kernel.org) to update it after that.

That definitely helps.

Maybe somebody needs to script a relink cron job for kernel.org?

	Jeff


