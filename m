From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Tue, 20 Dec 2005 21:03:21 -0800
Message-ID: <7vacevdoti.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 06:04:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eow8N-00074E-7Z
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVLUFDX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVLUFDX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:03:23 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13449 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751082AbVLUFDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:03:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221050232.GBKW20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 00:02:32 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 21 Dec 2005 15:28:46 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13864>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> If so, do your developers use git-shell?
>
> no...

While we established that your problem did not have anything to
do with git-shell, I am tempted to do something like this.

Thoughts?

-- >8 --
[PATCH] Force group writable umask in git-shell

Usually I do not like hardcoded policy in programs, but use of
git-shell is already a policy decision by the repository
administrator to use the shared repository style of development,
and I cannot think of a reason to forbid group (and self, but
that is obvious) writability in such use scenario.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/shell.c b/shell.c
index cd31618..40a2a97 100644
--- a/shell.c
+++ b/shell.c
@@ -52,6 +52,10 @@ int main(int argc, char **argv)
 		default:
 			continue;
 		}
+		/* Make sure myself and my group members can write
+		 * into what I create.
+		 */
+		umask(umask(0) & ~0770);
 		exit(cmd->exec(cmd->name, arg));
 	}
 	die("unrecognized command '%s'", prog);
