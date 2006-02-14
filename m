From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: git 1.2 works on Solaris, AIX [was Re: [PATCH 1/3] Call extended-semantics commands through variables.]
Date: Mon, 13 Feb 2006 21:12:41 -0800
Message-ID: <12579.1139893961@lotus.CS.Berkeley.EDU>
References: <7v64nllbdj.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 06:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8sVu-0000dO-LA
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 06:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWBNFNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 00:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWBNFM6
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 00:12:58 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:11428 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1030414AbWBNFMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 00:12:44 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1E5CgxZ012581;
	Mon, 13 Feb 2006 21:12:42 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1E5CgWF012580;
	Mon, 13 Feb 2006 21:12:42 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v64nllbdj.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16112>

The AIX machines I work on are back, and it looks like my 
patches are unnecessary, at least for my use.  It'd be cute 
to allow builders to point at GNU tools, but not terribly 
useful.  The File::Find patch to git-archimport.perl might 
be nice, but it functions as-is.

To have diff and merge on my path with this AIX platform, I have 
to pull *all* the GNU tools into my path.  (NERSC uses modules.)  
I suspect that is a rather common setup, so it's not worth the 
serious surgery to redirect diff and merge.  diff is used in C 
and shell, and merge is in shell, Perl, and Python sources.

And pkgsrc on Solaris appears happy using GNU's cpio (under
archivers/gcpio) rather than its default, plain one.  I hadn't 
realized I could replace it easily.

So with the GNU tools in the path and a properly built Python, 
the mainline code works on Solaris 8 and AIX.

For posterity: Any problems with git-merge-recursive.py on AIX
likely are a yucky Python/AIX problem.  The sha has 'sem_trywait: 
Permission denied\n' prepended to it a few times.  You need to 
rebuild Python with HAVE_BROKEN_POSIX_SEMAPHORES:
  https://sourceforge.net/tracker/?func=detail&atid=105470&aid=1106262&group_id=5470

If anyone really wants to point at particular tools but not 
require them in the user's path, the simplest way would be to 
link the correct tools (or wrappers) into the GIT_EXEC_PATH 
and prepend that to the PATH *everywhere*.  But it's not worth 
the effort until someone really needs it.

Jason
