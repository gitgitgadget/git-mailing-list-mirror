From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] git-merge-cache -q doesn't complain about failing merge program
Date: Fri, 29 Jul 2005 19:11:21 -0700
Message-ID: <7vack582ly.fsf@assigned-by-dhcp.cox.net>
References: <20050729085819.GL24895@pasky.ji.cz>
	<20050729125338.GB21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 04:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dygsq-0001ki-Jy
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVG3CPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVG3CNx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1192 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262924AbVG3CLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021111.MGIU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:11 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> git-merge-cache reporting failed merge program is undesirable for
> Cogito, since it emits its own more appropriate error message in that
> case. However, I want to show other possible git-merge-cache error
> messages. So -q will just silence this particular error.

That description makes it sound more like it is a Cogito
specific hack, which other Porcelains may not benefit from,
meaning they may want to suppress some other errors but this
patch does not give that possibility.

I do not mind about the above too much, but I'll sit on this one
for now just in case if anybody comes up with a different patch
to give a bit cleaner solution.

I wonder how many die()'s we have in our C code.  It _might_ be
cleaner to say (the first parameter being exit(2) parameter):

    die("unable to execute '%s'", pgm);
    die_with(47, "merge program failed");

and have the calling Porcelain, if it wants to, supress error
messages by redirecting 2>/dev/null, and say whatever it wants
to say based on $?.
