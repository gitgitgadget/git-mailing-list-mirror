From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix
	fetch_local for .git/HEAD
Date: Thu, 10 Nov 2005 19:14:35 -0500
Message-ID: <1131668075.3987.5.camel@dv>
References: <1124832796.23795.9.camel@dv>
	 <200511110026.18324.Josef.Weidendorfer@gmx.de>
	 <20051110234029.GE30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 01:16:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMZ3-0005ej-BG
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVKKAOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVKKAOl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:14:41 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:37016 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932272AbVKKAOl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 19:14:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaMYx-000734-UI
	for git@vger.kernel.org; Thu, 10 Nov 2005 19:14:40 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaMYt-00012f-JO; Thu, 10 Nov 2005 19:14:35 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110234029.GE30496@pasky.or.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11543>

On Fri, 2005-11-11 at 00:40 +0100, Petr Baudis wrote: 
> Dear diary, on Fri, Nov 11, 2005 at 12:26:18AM CET, I got a letter
> where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > Why would anybody want to fetch the current upstream HEAD at cg-pull
> > time? If you do this, and you have no control on the upstream
> > repository, "origin" will jump randomly around after cg-pull, depending
> > on the current HEAD of the origin repository.
> 
> In public repositories, you usually set the HEAD once and it stays
> there, or when you switch it, you are really careful about it.

Correct.  But if it's a concern, I think we could make some
improvements.  Following approaches could be tried (starting from top,
using following steps as a fallback):

1) Use recorded branch, i.e. the branch name that was used in cg-clone.

2) Check a file specifying the default branch for cloning (let's call it
e.g. .git/default_export).  Record branch name.

3) If cg-switch is implemented, another file would be likely used to
specify the default branch for local operations
(e.g. .git/default_branch).  Use it.  Record branch name.

4) If .git/HEAD can be recognized as link (we may need to eliminate
symlinks for that to work over remote transport), use the branch it
points to.  Record branch name.

5) If .git/HEAD cannot be recognized as link, use it as the branch to
clone.  Don't record the branch name.  (I'm not sure if we really want
that - it's good to know what branch we are using).

6) Use "master" branch.  Record branch name.

-- 
Regards,
Pavel Roskin
