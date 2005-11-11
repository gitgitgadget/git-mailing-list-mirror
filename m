From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 23:40:07 +0100
Message-ID: <200511112340.07794.Josef.Weidendorfer@gmx.de>
References: <200511111313.27273.lan@ac-sw.com> <200511111713.58018.lan@ac-sw.com> <20051111212953.GX30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 23:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eahav-0005aE-Rd
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 23:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKKWlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 17:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVKKWkO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 17:40:14 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54497 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751286AbVKKWkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 17:40:12 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 0C066198A
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 23:40:11 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051111212953.GX30496@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11641>

On Friday 11 November 2005 22:29, Petr Baudis wrote:
> Dear diary, on Fri, Nov 11, 2005 at 12:13:57PM CET, I got a letter
> where Alexander Litvinov <lan@ac-sw.com> said that...
>
> Aha. So it isn't so much about modules, but more about nested checkouts,
> described in Cogito's TODO as:
> 
> * Subprojects
> ...

Interesting. So these would be multiple git repositories, which are
more or less loosely coupled via same head and tag names?

Instead of putting multiple git repositories in subdirectories,
these possibly could be combined into one .git/ with different index
files, and simultaneously checked out files. This way, the
partitioning of files does not have to follow directory boundaries
(similar to the "todo" branch of git itself).

We would need a configuration for the partitioning.
E.g. a .git/projects

 gitk: gitk
 todo: TODO TODO-docu
 docu: Documentation/*
 git: *

(perhaps with path remapping between checkout files and paths in the
git tree objects of every subproject, to be flexible)

You would have multiple indexes: .git/index.gitk, .git/index.todo...
.git/HEAD would have to hold multiple references for the currently
checked out subprojects:

 gitk: refs/gitk/heads/master
 git: refs/git/heads/master

On commiting, the subproject partitions are checked seperatly for
changes, and commits objects are done for each subproject.
Fetching/merging is done on each subproject of its own.

You probably want to have multi-head tags covering all subprojects.

And for a more tight coupling of subprojects, you probably even want
to have multihead commits every time a commit is done in one subproject,
which leads to branches tracking the versioning of all subprojects,
i.e. multihead heads ;-)
I think that even subprojects of subprojects fall out naturally.

I am quite sure this can be done in a fully compatible way to Git-1:
with Git-1, you have only one subproject, the empty one.
It should be possible to combine multiple Git-1 repositories to a
repository with multiple subprojects, where each subproject was its
own project with Git-1.

Josef
