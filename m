From: tony.luck@intel.com
Subject: cache status after git pull
Date: Thu, 25 Aug 2005 09:08:33 -0700
Message-ID: <200508251608.j7PG8XGq016882@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 18:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8KHO-00068t-9E
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 18:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHYQIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 12:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHYQIf
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 12:08:35 -0400
Received: from fmr23.intel.com ([143.183.121.15]:23211 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932241AbVHYQIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 12:08:34 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7PG8Xv9010678
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 16:08:33 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7PGB34e009758
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 16:11:03 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7PG8X6D016883
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 09:08:33 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7PG8XGq016882;
	Thu, 25 Aug 2005 09:08:33 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7751>

>* When the branch head pointed by $GIT_DIR/HEAD changes while
> the index file and working tree are looking the other way
> (e.g. somebody pushed into your repository, or you ran "git
> fetch" to update the ref your working tree is on), "git
> checkout" without -f gets confused.  Figure out a good way to
> handle this.

Aha ... is this the problem that caught me out last week (when
I ended up with 10 extra files attached to one of my commits)? At
the time the blame was placed on a failed merge not being backed
out correctly.  But I only had the failed merge because "get checkout"
had failed to switch branches (and not provided an exit code to
stop my script from trying the merge).

Here's what I did this morning.

1) Updated my "linus" branch:

  $ git checkout linus && git pull linus

This appeared to work just fine ... except that when I
check the status of my tree I see:

  $ git status
  #
  # Updated but not checked in:
  #   (will commit)
  #
  #       modified: arch/ia64/pci/pci.c
  #       modified: arch/ppc64/kernel/setup.c
  #       modified: arch/sparc64/kernel/pci.c
  #       modified: arch/x86_64/defconfig
  #       modified: drivers/block/cfq-iosched.c
  #       modified: include/asm-m68k/page.h
  #       modified: kernel/cpuset.c
  #
  #
  # On branch refs/heads/linus
  
Which looks like a set of landmines just waiting for me to
step on them!

Today these didn't bite me.  "git checkout release" worked
and switched to my release branch (and git status went back
to saying "nothing to commit").  But in the past I think
this is the situation that has caused "git checkout" to fail
with the "fatal: Entry 'blah' would be overwritten by merge. Cannot merge."

-Tony
