From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: File was not found in commit
Date: Sun, 11 Jan 2009 21:14:09 -0800
Message-ID: <20090112051409.GB14992@dcvr.yhbt.net>
References: <49678705.4040506@mog.se> <20090111215526.GA15533@atjola.homenet> <496A890C.8080208@mog.se> <20090112023211.GA21462@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Morgan Christiansson <git@mog.se>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMF9D-0004OU-Ah
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZALFOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbZALFOL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:14:11 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60341 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbZALFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:14:10 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06871FE52;
	Mon, 12 Jan 2009 05:14:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090112023211.GA21462@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105291>

Eric Wong <normalperson@yhbt.net> wrote:
> Morgan Christiansson <git@mog.se> wrote:
> > The "Ignoring path" message appears to be coming from git which is  
> > refusing to commit the .git directory. Which leads to git-svn being  
> > unaware of the files being ignored and giving an error when it can't  
> > find them.
> 
> > I'm personally fine with these files being ignored by git, but git-svn  
> > needs to be aware that they are not added to the repository.
> 
> Hi Morgan,
> Can you try the following rough patch and see it it fixes things
> for you?  Thanks!

Actually, I think this patch is broken (my quickly put together test
case was insufficient)...

> From 559f4b673592f364e9773f2ba65caf09b138521b Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Sun, 11 Jan 2009 18:23:38 -0800
> Subject: [PATCH/RFC] git-svn: avoid importing nested repos
> 
> Some SVN repositories contain .git repositories within them
> (hopefully accidentally checked in).  Since git refuses to
> check in ".git" repositories, this can be a problem when
> fetching updates from SVN.
> 
> This seems to repull the entire blob from SVN everytime a user
> changes something inside the ".git" directory on the SVN side,
> but hopefully this will be a rare case and the SVN users will
> correct the error quickly.
> 
> The test could probably be expanded to be more thorough...
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
