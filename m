From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 15:13:32 -0700
Message-ID: <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
	<7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
	<20050517213752.GO7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed May 18 00:23:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYAQz-0000mx-23
	for gcvg-git@gmane.org; Wed, 18 May 2005 00:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVEQWRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVEQWQG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 18:16:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16382 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261874AbVEQWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 18:13:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517221331.XPNC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 18:13:31 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> But that won't work good enough for me. E.g. when committing in a
PB> subdirectory, I want to commit only changes made in the subdirectory,
PB> etc.

Assuming that you have something that lets you commit selected
files when you are at the top level (say cg-commit), and further
assuming that today it only works from the toplevel, that is:

    $ pwd
    /usr/src/linux
    $ cg-commit fs/ext?/Makefile

works today, what I am saying is:

    $ pwd
    /usr/src/linux/fs
    $ git-run-with-user-path cg-commit -- ext?/Makefile

would work.

Usually the command like cg-commit would take non-path
parameters, so if this works today:

    $ pwd
    /usr/src/linux
    $ cg-commit -m 'Changed Makefile' fs/ext?/Makefile

then:

    $ pwd
    /usr/src/linux/fs
    $ git-run-with-user-path cg-commit -m 'Changed Makefile' -- ext?/Makefile

would work.

Once you have a core that works well but only at the top
directory level, then you can make a thin wrapper using
git-run-with-user-path to make that work equally well with the
filesystem path from subdirectories.  And the core-ish thing
that only works at the top directory level does not need to
worry about finding .git/ anymore, which is the whole point of
what this helper is giving you.



BTW, I am wondering if your choice of cg-commit as an example
(as opposed to something else like diff or add) is a flamebait
or just an innocent random example ;-)?

