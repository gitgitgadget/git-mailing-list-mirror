From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 14:08:11 +0200
Message-ID: <1432814891-4717-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 14:15:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxwiu-0007KJ-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 14:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbbE1MPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 08:15:40 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:41686 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932094AbbE1MPi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 08:15:38 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2015 08:15:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6826548849;
	Thu, 28 May 2015 14:08:53 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COsVBs1KQ9Bm; Thu, 28 May 2015 14:08:53 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4729E48751;
	Thu, 28 May 2015 14:08:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 3EAEE20D6;
	Thu, 28 May 2015 14:08:53 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsJZRhMqGPIL; Thu, 28 May 2015 14:08:53 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-029096.grenet.fr [130.190.29.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 2447F20D4;
	Thu, 28 May 2015 14:08:53 +0200 (CEST)
X-Mailer: git-send-email 2.0.5.6.g819e04a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270140>

It is an almost empty code I send to validate the global architecture
of this command.  I choose to write it in C because git status is
already in C and it seems that it is the current tendency to port
shell code to C. Moreover I would like to use code from wt_status to
implement this functionnality. I wrote a helper that I call from shell
script, as it is made in bisect (bisect--helper.c).

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 Makefile         | 2 ++
 builtin.h        | 1 +
 git-rebase.sh    | 7 ++++++-
 git.c            | 1 +
 rebase--status.c | 6 ++++++
 rebase--status.h | 7 +++++++
 6 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 rebase--status.c
 create mode 100644 rebase--status.h

diff --git a/Makefile b/Makefile
index e0caec3..e3b3e63 100644
--- a/Makefile
+++ b/Makefile
@@ -853,6 +853,7 @@ LIB_OBJS +=3D prompt.o
 LIB_OBJS +=3D quote.o
 LIB_OBJS +=3D reachable.o
 LIB_OBJS +=3D read-cache.o
+LIB_OBJS +=3D rebase--status.o
 LIB_OBJS +=3D reflog-walk.o
 LIB_OBJS +=3D refs.o
 LIB_OBJS +=3D remote.o
@@ -969,6 +970,7 @@ BUILTIN_OBJS +=3D builtin/prune-packed.o
 BUILTIN_OBJS +=3D builtin/prune.o
 BUILTIN_OBJS +=3D builtin/push.o
 BUILTIN_OBJS +=3D builtin/read-tree.o
+BUILTIN_OBJS +=3D builtin/rebase--status--helper.o
 BUILTIN_OBJS +=3D builtin/receive-pack.o
 BUILTIN_OBJS +=3D builtin/reflog.o
 BUILTIN_OBJS +=3D builtin/remote.o
diff --git a/builtin.h b/builtin.h
index c47c110..5071a08 100644
--- a/builtin.h
+++ b/builtin.h
@@ -99,6 +99,7 @@ extern int cmd_prune(int argc, const char **argv, con=
st char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *p=
refix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *pref=
ix);
+extern int cmd_rebase_status__helper(int argc, const char **argv, cons=
t char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *p=
refix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_remote(int argc, const char **argv, const char *prefix)=
;
diff --git a/git-rebase.sh b/git-rebase.sh
index 47ca3b9..8454071 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
+status!            show the status of the current rebase
 "
 . git-sh-setup
 . git-sh-i18n
@@ -238,7 +239,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=3D
 		;;
-	--continue|--skip|--abort|--edit-todo)
+	--continue|--skip|--abort|--edit-todo|--status)
 		test $total_argc -eq 2 || usage
 		action=3D${1##--}
 		;;
@@ -401,6 +402,10 @@ abort)
 edit-todo)
 	run_specific_rebase
 	;;
+status)
+	git rebase--status--helper
+	die
+	;;
 esac
=20
 # Make sure no rebase is in progress
diff --git a/git.c b/git.c
index 9efd1a3..3ebc144 100644
--- a/git.c
+++ b/git.c
@@ -410,6 +410,7 @@ static struct cmd_struct commands[] =3D {
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "rebase--status--helper", cmd_rebase_status__helper, RUN_SETUP },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
diff --git a/rebase--status.c b/rebase--status.c
new file mode 100644
index 0000000..d67af52
--- /dev/null
+++ b/rebase--status.c
@@ -0,0 +1,6 @@
+#include "rebase--status.h"
+
+int rebase_status(){
+	printf("Rebase in progress\n");
+	return 0;
+}
diff --git a/rebase--status.h b/rebase--status.h
new file mode 100644
index 0000000..17d22a1
--- /dev/null
+++ b/rebase--status.h
@@ -0,0 +1,7 @@
+#ifndef REBASE__STATUS_H
+#define REBASE__STATUS_H
+
+
+extern int rebase_status();
+
+#endif
--=20
2.0.5.5.g1d968ca.dirty
