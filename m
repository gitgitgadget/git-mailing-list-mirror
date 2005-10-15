From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: getting rid of extra directories
Date: Sat, 15 Oct 2005 12:27:20 -0700
Message-ID: <20051015192720.GA11364@tumblerings.org>
References: <20051015174103.GA2609@tumblerings.org> <7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 21:29:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQrh4-0001oh-57
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVJOT1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJOT1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 15:27:24 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:40098 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751204AbVJOT1X
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 15:27:23 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.52)
	id 1EQrge-000409-UU; Sat, 15 Oct 2005 12:27:20 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10139>

On Sat, Oct 15, 2005 at 11:00:52AM -0700, Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > I've been using the latest Cogito. When I seek back and forth in a git repo,
> > directories I've created tend to persist backward in time, cluttering up
> > earlier versions.
> >
> > By the discussions on this list, I'm pretty sure there's a way to stop this,
> > but I don't know clearly what it is, and I'm worried about trying things
> > that might corrupt my repository. Could someone spell it out for me please?
> 
> I do not know exactly what Cogito "seek back and forth" does,

It means to "cg-seek" back to an earlier state of the repo, and forward to a
more recent state of the repo. "seeking back and forth" means doing a lot of
"cg-seek" commands. Sorry that wasn't clear.

> but updating to git-core "master" branch may help.

I already use that branch.

Here's some commands that reproduce the problem:

$ mkdir tmpproj
$ cd tmpproj
$ cg-init

give the initial commit message and save

$ ls > a
$ cg-add a
$ cg-commit

give the commit message and save

$ cg-tag nodirs
$ mkdir d
$ mv a d/a
$ cg-rm a
$ cg-add d/a
$ cg-commit

give the commit message and save

$ cg-seek nodirs

now I would expect to see the original directory, with no 'd' subdirectory, and
just the 'a' file sitting there.

$ ls -F
a  d/
$

See the problem? The 'd' directory did not exist in this version of the
repository, but it's there anyway.

Be well,
Zack



> 
> Specifically, this commit intends to remove empty directory from
> the working tree, where previously checked out tree object had
> files/directories inside while newly checked out tree does not.
> 
>     commit 340e4f88c083b0692e6554b1c2c27fd43c7cc8d3
>     Author: Junio C Hamano <junkio@cox.net>
>     Date:   Mon Oct 10 17:34:08 2005 -0700
> 
>         Remove empty directories after read-tree -u.
> 
>         This fixes everybody's favorite gripe that switching branch
>         with 'git checkout' leaves empty directories.
> 
>         Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
