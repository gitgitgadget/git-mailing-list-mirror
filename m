From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710150039120.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 01:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhD9r-0000jP-Ih
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 01:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761171AbXJNXp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 19:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760346AbXJNXpz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 19:45:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:43385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753574AbXJNXpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 19:45:52 -0400
Received: (qmail invoked by alias); 14 Oct 2007 23:45:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 15 Oct 2007 01:45:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m/AcGZUKmtLbTqFW3NmO7eoLDnuWnuJXXuy0Wj+
	F/BLxBBYt6d8TO
X-X-Sender: gene099@racer.site
In-Reply-To: <u7ilpjp3x.fsf@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60928>

Hi,

On Mon, 15 Oct 2007, Eli Zaretskii wrote:

> Alex Riesen said:
> 
> > - no proper VFS
> 
> I'm not sure what you are talking about.  What VFS do you use on 
> GNU/Linux that cannot work on Windows, and why do you use it?

The problem is that on Windows, you cannot keep a file open and delete it 
at the same time.  This is an issue in Windows' equivalent of VFS.

A neat trick to work with temporary files without permission issues is to 
open the file and delete it right after that.  This does not work on 
Windows.

> > - no proper filename semantics (case-insensitivity and stupid rules for
> >   allowed characters in filenames, like ":" in filenames in
> >   cross-platform projects)
> 
> There's a flag on Windows to open files case-sensitively, if you need
> that.

The problem is not so much opening, but determining if an existing file 
and a file in the index have the same name.

For example, "README" in the index, but "readme" in the working directory, 
will be handled as "deleted/untracked" by the current machinery.  IOW git 
will not know that what it gets from readdir() as "readme" really is the 
same file as "README" in the index.

> > - no acceptable level of performance in filesystem and VFS (readdir,
> >   stat, open and read/write are annoyingly slow)
> 
> With what libraries?  Native `stat' and `readdir' are quite fast. 
> Perhaps you mean the ported glibc (libgw32c), where `readdir' is indeed 
> painfully slow, but then you don't need to use it.

No, native.

Once you experienced the performance of git on Linux, then rebooted into 
Windows on the same box, you will grow a beard while waiting for trivial 
operations.

Sure, git kicks ass on Windows, but only as compared to other programs _on 
Windows_.

> > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
> >   can be not the same, depending on what current "drive" is)
> 
> So what? on Unix "a/b/c" can be not the same.  Both cases are simply not 
> complete file names, that's all.  No one said there must be a single 
> root for all volumes, it's the Posix jingoism creeping in again.

I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So depending 
on which drive you are, you mean one or the other.  Just comparing the 
paths is not enough.

> > - no real "mmap" (which kills perfomance and complicates code)
> 
> You only need mmap because you are accustomed to use it on GNU/Linux.

Yes.  And we rely on the performance very much.

Hth,
Dscho
