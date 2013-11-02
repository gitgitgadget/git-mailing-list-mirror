From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] remote: unify main and subcommand usage strings
Date: Sat,  2 Nov 2013 17:11:31 +0100
Message-ID: <c2d51c4014545f037bb9399dba7b378d6d79d18b.1383407880.git.tr@thomasrast.ch>
References: <52746664.1050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
	<vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 17:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcdnu-0001RQ-PL
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 17:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3KBQL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Nov 2013 12:11:58 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:38148 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab3KBQL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 12:11:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6E5164D6528;
	Sat,  2 Nov 2013 17:11:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JAA2wyzJpTMK; Sat,  2 Nov 2013 17:11:45 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A6D404D6414;
	Sat,  2 Nov 2013 17:11:43 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.g4c8c068
In-Reply-To: <52746664.1050806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237245>

We had separate usages for each subcommand, and for the main command,
even though the latter is essentially a concatenation of all of the
former.  This leads to a lot of duplication and unnecessary
differences, e.g., in the 'set-head' case the two strings differ only
in a space.

Unify the strings in the usages by putting each of them in a variable,
and assembling the usage arrays from them.

Note that this patch changes the usage strings for the following
subcommands:

- prune and show: the individual usage only said [<options>].  Kept
  the snippet from the main usage, which is more specific.

- set-branches: kept the main usage, which is more concise in saying
  that --add is optional

Reported-by: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> wrote:
> On 02/11/2013 09:23, Jiang Xin wrote:
> > Confirmed, there is a typo in builtin/remote.c line 15. Have you se=
nd
> > patch to this list for this, Tr=E1=BA=A7n?
> >
> This is minor error, so let Junio C Hamano do it!

Dunno, this generally isn't the nicest way to get things done, nor the
most productive use of maintainer bandwidth.

How about patching it like this instead?  That should prevent similar
issues from cropping up again.


 builtin/remote.c | 70 +++++++++++++++++++++++++++++++++++++-----------=
--------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4e14891..2f6366a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -7,67 +7,91 @@
 #include "run-command.h"
 #include "refs.h"
=20
+static const char builtin_remote_add_usage_str[] =3D
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags=
] "
+	   "[--mirror=3D<fetch|push>] <name> <url>");
+static const char builtin_remote_rename_usage_str[] =3D
+	N_("git remote rename <old> <new>");
+static const char builtin_remote_rm_usage_str[] =3D
+	N_("git remote remove <name>");
+static const char builtin_remote_sethead_usage_str[] =3D
+	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch=
>)");
+static const char builtin_remote_setbranches_usage_str[] =3D
+	N_("git remote set-branches [--add] <name> <branch>...");
+static const char builtin_remote_show_usage_str[] =3D
+	N_("git remote [-v | --verbose] show [-n] <name>");
+static const char builtin_remote_prune_usage_str[] =3D
+	N_("git remote prune [-n | --dry-run] <name>");
+static const char builtin_remote_update_usage_str[] =3D
+	N_("git remote [-v | --verbose] update [-p | --prune] "
+	   "[(<group> | <remote>)...]");
+static const char builtin_remote_seturl_usage_str[] =3D
+	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]");
+static const char builtin_remote_seturl_add_usage_str[] =3D
+	N_("git remote set-url --add <name> <newurl>");
+static const char builtin_remote_seturl_delete_usage_str[] =3D
+	N_("git remote set-url --delete <name> <url>");
+
 static const char * const builtin_remote_usage[] =3D {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags=
] [--mirror=3D<fetch|push>] <name> <url>"),
-	N_("git remote rename <old> <new>"),
-	N_("git remote remove <name>"),
-	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>=
)"),
-	N_("git remote [-v | --verbose] show [-n] <name>"),
-	N_("git remote prune [-n | --dry-run] <name>"),
-	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <re=
mote>)...]"),
-	N_("git remote set-branches [--add] <name> <branch>..."),
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	builtin_remote_add_usage_str,
+	builtin_remote_rename_usage_str,
+	builtin_remote_rm_usage_str,
+	builtin_remote_sethead_usage_str,
+	builtin_remote_show_usage_str,
+	builtin_remote_prune_usage_str,
+	builtin_remote_update_usage_str,
+	builtin_remote_setbranches_usage_str,
+	builtin_remote_seturl_usage_str,
+	builtin_remote_seturl_add_usage_str,
+	builtin_remote_seturl_delete_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_add_usage[] =3D {
-	N_("git remote add [<options>] <name> <url>"),
+	builtin_remote_add_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_rename_usage[] =3D {
-	N_("git remote rename <old> <new>"),
+	builtin_remote_rename_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_rm_usage[] =3D {
-	N_("git remote remove <name>"),
+	builtin_remote_rm_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_sethead_usage[] =3D {
-	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch=
>)"),
+	builtin_remote_sethead_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_setbranches_usage[] =3D {
-	N_("git remote set-branches <name> <branch>..."),
-	N_("git remote set-branches --add <name> <branch>..."),
+	builtin_remote_setbranches_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_show_usage[] =3D {
-	N_("git remote show [<options>] <name>"),
+	builtin_remote_show_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_prune_usage[] =3D {
-	N_("git remote prune [<options>] <name>"),
+	builtin_remote_prune_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_update_usage[] =3D {
-	N_("git remote update [<options>] [<group> | <remote>]..."),
+	builtin_remote_update_usage_str,
 	NULL
 };
=20
 static const char * const builtin_remote_seturl_usage[] =3D {
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	builtin_remote_seturl_usage_str,
+	builtin_remote_seturl_add_usage_str,
+	builtin_remote_seturl_delete_usage_str,
 	NULL
 };
=20
--=20
1.8.4.2.838.g4c8c068
