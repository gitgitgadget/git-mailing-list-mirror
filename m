From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bus Error- git merge
Date: Fri, 30 Jan 2009 19:57:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301950100.3586@pacific.mpi-cbg.de>
References: <C5A883D0.E243%bmoran@onehub.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1285767731-1233341836=:3586"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brian Moran <bmoran@onehub.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 19:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSyZH-0002h5-0O
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 19:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZA3S4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 13:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZA3S4x
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 13:56:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:49969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751957AbZA3S4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 13:56:52 -0500
Received: (qmail invoked by alias); 30 Jan 2009 18:56:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 30 Jan 2009 19:56:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jxsVqeaFj3t1XhgFGbPUJQYLKnFs3xoaoo0H1f6
	YKOafeYpEmuimB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <C5A883D0.E243%bmoran@onehub.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107863>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1285767731-1233341836=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 30 Jan 2009, Brian Moran wrote:

> I am getting a bus error on a git merge, including the more recent versions.
> Following the instructions from a bug August, I got the latest sources,
> compiled them up, and executed the merge in the debugger to repro. Here¹s
> what I found:

Is it possible that your branch has submodules?

> gdb ../git-1.6.1.2/git-merge
> GNU gdb 6.3.50-20050815 (Apple version gdb-768) (Tue Oct  2 04:07:49 UTC
> 2007)
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i386-apple-darwin"...Reading symbols for shared
> libraries ........ done
> 
> (gdb) set args -v v1-ftp-support
> (gdb) run
> Starting program: /Users/bmo/Documents/repo/git-1.6.1.2/git-merge -v
> v1-ftp-support
> Reading symbols for shared libraries +++++++. done
> 
> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_PROTECTION_FAILURE at address: 0x00000004
> 0x000863c3 in sha_eq (a=0x4 <Address 0x4 out of bounds>, b=0x7bf004 "<some
> random chars>") at cache.h:575
> 575        return memcmp(sha1, sha2, 20);
> 
> (gdb) backtrace
> #0  0x000863c3 in sha_eq (a=0x4 <Address 0x4 out of bounds>, b=0x7bf004
> "<some random chars>") at cache.h:575
> #1  0x00086dc6 in merge_trees (o=0xbfffedd4, head=0x7bf020, merge=0x7bf000,
> common=0x0, result=0xbfffed28) at merge-recursive.c:1164

common=0x0, that's the issue.

> #2  0x00088960 in merge_recursive (o=0xbfffedd4, h1=0x4f4060, h2=0x4f4000,
> ca=0x53cc20, result=0xbfffee2c) at merge-recursive.c:1294

However, here I read in my version of merge-recursive.c that "common" is 
the tree of merged_common_ancestor, which is either set to 
"pop_commit(&ca)", i.e. to one of the common ancestors, or to a virtual 
commit, that must have a tree.

So it would be good if you could debug this further, letting me know where 
the merged_common_ancestor came from, and why it does not have a tree.

Thanks,
Dscho
--8323328-1285767731-1233341836=:3586--
