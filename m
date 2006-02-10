From: Dave Jones <davej@redhat.com>
Subject: Re: git-apply segfault.
Date: Fri, 10 Feb 2006 14:41:27 -0500
Message-ID: <20060210194127.GM22611@redhat.com>
References: <20060210183745.GI22611@redhat.com> <Pine.LNX.4.64.0602101120440.19172@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 20:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7e9M-00040i-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 20:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWBJTln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 14:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBJTln
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 14:41:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56744 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751321AbWBJTlm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 14:41:42 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1AJfX9u017131;
	Fri, 10 Feb 2006 14:41:34 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1AJfS111016;
	Fri, 10 Feb 2006 14:41:28 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k1AJfS6J029439;
	Fri, 10 Feb 2006 14:41:28 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id k1AJfRe8031273;
	Fri, 10 Feb 2006 14:41:27 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1AJfRUZ031272;
	Fri, 10 Feb 2006 14:41:27 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602101120440.19172@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15878>

On Fri, Feb 10, 2006 at 11:22:46AM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Fri, 10 Feb 2006, Dave Jones wrote:
 > >
 > > (gdb) bt
 > > #0  0x0000003287f73474 in memset () from /lib64/libc.so.6
 > > #1  0x0000003287f6c92a in calloc () from /lib64/libc.so.6
 > > #2  0x0000000000407399 in read_cache () at read-cache.c:537
 > 
 > Ouch. Looks like malloc heap corruption.

Indeed. Self-inflicted in this case.

 > > git on hera is 1.1.6-1
 > Can you try running "valgrind" on it? That should show what corrupts the 
 > heap.

Actually it's a glibc bug (fixed last September, but not backported to older releases).
Jakub is working on an FC4 update.

(It also only hits you if you're a loony and have something like
 export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))
 in your ~/.bashrc)

		Dave
