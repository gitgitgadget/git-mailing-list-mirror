From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [GITK] use "git <command>" instead of "git-<command>"
Date: Wed, 25 Jan 2006 01:52:51 -0800
Message-ID: <7v3bjcws5o.fsf@assigned-by-dhcp.cox.net>
References: <20060125075635.GB2768@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 10:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1hL1-00059Q-He
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWAYJwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 04:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWAYJwx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 04:52:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41859 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbWAYJww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 04:52:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125095156.YKTF3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 04:51:56 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15125>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Otherwise gitk is not able to work with installations using a gitexecdir
> different from bindir.

For something like gitk that lives for some time and spawns git
number of times, it is considered a good practice to:

 (1) Run "git --exec-path" at the beginning, to learn
     GIT_EXEC_PATH;
 (2) Prepend that to PATH;
 (3) And invoke "git-foo" commands in the rest of the script.

This saves an extra fork/exec (gitk -> git -> git-foo).  I was
told qgit already does this.

Note that we may end up leaving some git-* commands in /usr/bin
while moving the rest to elsewhere (e.g. /usr/lib/git-core/exec/),
so (2) and (3) cannot be safely substituted with 

 (BAD) invoke "$GIT_EXEC_PATH/git-foo" instead.

I usually prefer patches to gitk to come through paulus, so
please CC: when sending patches to gitk ("git whatchanged gitk"
would give you the e-mail address).
