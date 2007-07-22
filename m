From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: executing git from a non git directory
Date: Sun, 22 Jul 2007 03:07:34 -0400
Message-ID: <20070722070734.GU32566@spearce.org>
References: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Aljord <patcito@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICVXc-0007aY-16
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbXGVHHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbXGVHHk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:07:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40606 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbXGVHHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:07:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICVXT-0006Dz-TH; Sun, 22 Jul 2007 03:07:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 79ED820FBAE; Sun, 22 Jul 2007 03:07:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53225>

Patrick Aljord <patcito@gmail.com> wrote:
> I would like to check it from another direcory, I tried the following 
> command:
> 
> $ git --git-dir=/path/to/my_git_dir status
> 
> and
> 
> $ GIT_DIR='/path/to/my_git_dir' && git status

These are actually the same two commands.  The --git-dir option
just means "set GIT_DIR before calling the real command".

However, there are two problems here...
 
> but in both cases I get this error:
> fatal: Not a git repository: '/path/to/my_git_dir'

Right.  That's problem number 1.  /path/to/my_git_dir is probably
not actually your Git repository.  The git repository is actually in
".git", so you really need to use:

  $ git --git-dir=/path/to/my_git_dir/.git status

However, problem number 2 is that status requires a working
directory.  Setting GIT_DIR explicitly like this tells git that
you don't have a working directory present.  So status won't work.

> yet when I do "$ cd /path/to/my_git_dir && git status" I do get the results.

That's what you have to do if you want to run git-status.  Or use
a subshell as that won't change your current working directory:

  $ (cd /path/to/my_git_dir && git status)

-- 
Shawn.
