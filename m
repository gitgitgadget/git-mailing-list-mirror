From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 16:20:37 +0200
Message-ID: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Thu May 28 16:21:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxygZ-0000dA-L3
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 16:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbE1OVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 10:21:18 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37026 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752212AbbE1OVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 10:21:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 419C227B5;
	Thu, 28 May 2015 16:21:12 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gj-H9uHctg3v; Thu, 28 May 2015 16:21:12 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3088C27B3;
	Thu, 28 May 2015 16:21:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 2B5B120D6;
	Thu, 28 May 2015 16:21:12 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M4O1xdTRzUas; Thu, 28 May 2015 16:21:12 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-029096.grenet.fr [130.190.29.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 0979520D4;
	Thu, 28 May 2015 16:21:12 +0200 (CEST)
X-Mailer: git-send-email 2.0.5.6.g818b3fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270151>

Preparatory commit for a git rebase --status command. This command
will indicate the state of the process in the rebase, and the reason
why it stopped.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---

The observations from Matthieu Moy have been taken into account=20

It is an almost empty code sent to validate the global architecture of
this command.  It is written in C because git status is already in C
and it seems that it is the current tendency to port shell code to
C. Moreover will likely use code from wt_status to implement this
functionnality. The command calls a helper from a shell script, as it
is made in bisect (bisect--helper.c).

 Makefile                         |  2 ++
 builtin.h                        |  1 +
 builtin/rebase--status--helper.c | 23 +++++++++++++++++++++++
 git-rebase.sh                    |  6 +++++-
 git.c                            |  1 +
 rebase--status.c                 |  6 ++++++
 rebase--status.h                 |  7 +++++++
 7 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 builtin/rebase--status--helper.c
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
diff --git a/builtin/rebase--status--helper.c b/builtin/rebase--status-=
-helper.c
new file mode 100644
index 0000000..efda29c
--- /dev/null
+++ b/builtin/rebase--status--helper.c
@@ -0,0 +1,23 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "rebase--status.h"
+
+static const char * const git_rebase_status_helper_usage[] =3D {
+	N_("git rebase--status--helper"),
+	NULL
+};
+
+int cmd_rebase_status__helper(int argc, const char **argv, const char =
*prefix)
+{
+	struct option options[] =3D {
+	=09
+	};
+
+	argc =3D parse_options(argc, argv, prefix, options,
+			     git_rebase_status_helper_usage, 0);
+
+
+	/* next-all */
+	return rebase_status();
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index 47ca3b9..4e1f3e1 100755
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
@@ -401,6 +402,9 @@ abort)
 edit-todo)
 	run_specific_rebase
 	;;
+status)
+	exec git rebase--status--helper
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
index 0000000..1962349
--- /dev/null
+++ b/rebase--status.c
@@ -0,0 +1,6 @@
+#include "rebase--status.h"
+
+int rebase_status(){
+	printf("git rebase --status is not yet implemented\n");
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
2.0.5.6.g818b3fd
