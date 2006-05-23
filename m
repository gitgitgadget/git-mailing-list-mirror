From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Git 1.3.2 on Solaris
Date: Mon, 22 May 2006 21:51:15 -0700
Message-ID: <8157.1148359875@lotus.CS.Berkeley.EDU>
References: <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com>
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 06:51:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiOrh-0003NA-Dt
	for gcvg-git@gmane.org; Tue, 23 May 2006 06:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWEWEvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 00:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWEWEvR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 00:51:17 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:43958 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750897AbWEWEvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 00:51:17 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k4N4pFgH008161;
	Mon, 22 May 2006 21:51:15 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k4N4pFpA008160;
	Mon, 22 May 2006 21:51:15 -0700 (PDT)
To: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
In-reply-to: <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20564>

And "Stefan Pfetzing" writes:
 -   printf ("access: %d\n", access("/etc/motd", X_OK));
[...]
 - will return 0 on solaris - when run as root, even though /etc/motd
 - is not executeable.

This is explicitly allowed by the SUS, even for non-root:
  http://www.opengroup.org/onlinepubs/000095399/functions/access.html
For non-root, some ACL systems could allow you to execute
the file even if there are no execute bits.  What a joy
ACLs are.  Or NFS uid mappings could play tricks on you,
or...  And as you've noticed, this kills [ -x ].  (Failing
to run the hooks in receive-pack.c is noisy but not fatal.
It's the shell scripts that stop.)

I think you're stuck.  To disable the hooks for all possible
users, OSes, file systems, etc., you need to remove them.

Or just don't run as root, and hope that the OS isn't 
completely insane.

BTW, ERR_RUN_COMMAND_EXEC is never returned.  Any failure
to exec will produce an exit code of 128 from die.  This
will be an issue when commit becomes a built-in, right?

Jason
