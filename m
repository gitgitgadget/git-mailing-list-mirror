From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 10:19:44 +0100
Message-ID: <tnxmzobutsf.fsf@arm.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 11:21:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dwz92-0003q8-1G
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 11:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGYJU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 05:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVGYJU5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 05:20:57 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:58315 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261160AbVGYJUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 05:20:55 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6P9JZs4006648;
	Mon, 25 Jul 2005 10:19:35 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA20054;
	Mon, 25 Jul 2005 10:20:16 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 25 Jul 2005 10:20:15 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 24 Jul 2005 15:49:33 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 25 Jul 2005 09:20:15.0915 (UTC) FILETIME=[1176CFB0:01C590FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
>  * When --exclude-per-directory=<name> is specified, upon
>    entering a directory that has such a file, its contents are
>    appended at the end of the current "list of patterns".  They
>    are popped off when leaving the directory.
[...]
> A pattern specified on the command line with --exclude or read
> from the file specified with --exclude-from is relative to the
> top of the directory tree.  A pattern read from a file specified
> by --exclude-per-directory is relative to the directory that the
> pattern file appears in.

I think it would make more sense for the exclude-per-directory
patterns to be local to that directory only, without recursively
preserving them for subdirectories. One would, in general, put the
common exclude patterns like *.o *~ etc. in the global file
(.git/exclude). The patterns local to a directory only (take the
vmlinux file for example), one would write it in the .gitignore file
but this should be used for subdirectories.

> An exclude pattern is of the following format:
[...]

That's fine. Actually, the Porcelain would care much about it since it
gets the information already filtered by git.

>     $ cat Documentation/.gitignore
>     # ignore generated html files,
>     # except foo.html which is maintained by hand
>     !foo.html
>     *.html

Wouldn't it be clearer to have the general rules first (*.html),
overridden by the more specific ones (!foo.html)? Just my opinion, I
don't know what others think.

-- 
Catalin
