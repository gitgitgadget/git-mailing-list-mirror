From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Tue, 06 Jun 2006 16:58:40 -0700
Message-ID: <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
	<20060604212050.GV10488@pasky.or.cz>
	<Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 01:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnlRe-0001uk-8N
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 01:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWFFX6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFFX6n
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 19:58:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42678 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751378AbWFFX6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 19:58:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606235841.QWZH19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 19:58:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 4 Jun 2006 16:31:54 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21415>

This allows you to say:

	git --less diff v2.6.16-rc5..

to pipe the output of any git command to your pager.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@osdl.org> writes:

  > On Sun, 4 Jun 2006, Petr Baudis wrote:
  >> 
  >> And I forgot to mention that it also adds the interactivity test
  >> requested by Janek - aliases are now interpreted only when stdout is a
  >> tty.
  >
  > I don't think that's a good test.
  >
  > The fact is, I do
  >
  > 	git diff | less -S
  >
  > all the time,...

  This is not a serious patch, since I suspect it would obviously
  not make much sense to say "git --less commit" or somesuch,
  but it was fun to do.

 git.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bc463c9..c52da8c 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h"
 
 #include "builtin.h"
 
@@ -162,6 +163,10 @@ int main(int argc, const char **argv, ch
 			puts(git_exec_path());
 			exit(0);
 		}
+		if (!strcmp(cmd, "less")) {
+			setup_pager();
+			continue;
+		}
 		cmd_usage(0, NULL, NULL);
 	}
 	argv[0] = cmd;
