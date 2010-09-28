From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GITK PATCH] gitk: add menuitem for file checkout from selected or
	parent commit
Date: Tue, 28 Sep 2010 22:03:45 +0200
Message-ID: <20100928200344.GA12843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:03:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0gP2-00067s-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0I1UDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 16:03:48 -0400
Received: from darksea.de ([83.133.111.250]:45723 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752906Ab0I1UDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 16:03:47 -0400
Received: (qmail 14854 invoked from network); 28 Sep 2010 22:03:45 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 28 Sep 2010 22:03:45 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157465>

This is useful if a user wants to checkout a file from a certain
commit. This is equivalent to

  git checkout $commit $file

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 gitk     |   24 ++++++++++++++++++------
 po/de.po |    6 ++++++
 po/es.po |    6 ++++++
 po/fr.po |    6 ++++++
 po/hu.po |    6 ++++++
 po/it.po |    6 ++++++
 po/ja.po |    6 ++++++
 po/ru.po |    6 ++++++
 po/sv.po |    6 ++++++
 9 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..c582bb5 100755
--- a/gitk
+++ b/gitk
@@ -2497,6 +2497,8 @@ proc makewindow {} {
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
+	{mc "Checkout from this commit" command {external_checkout}}
+	{mc "Checkout from parent commit" command {external_checkout 1}}
     }
     $flist_menu configure -tearoff 0
=20
@@ -3533,6 +3535,20 @@ proc make_relative {f} {
 }
=20
 proc external_blame {parent_idx {line {}}} {
+
+    set cmdline [list git gui blame]
+    if {$line ne {} && $line > 1} {
+	lappend cmdline "--line=3D$line"
+    }
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc external_checkout {{parent_idx 0}} {
+    set cmdline [list git checkout]
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc run_command_on_selected_file {cmdline parent_idx} {
     global flist_menu_file gitdir
     global nullid nullid2
     global parentlist selectedline currentid
@@ -3548,17 +3564,13 @@ proc external_blame {parent_idx {line {}}} {
 	return
     }
=20
-    set cmdline [list git gui blame]
-    if {$line ne {} && $line > 1} {
-	lappend cmdline "--line=3D$line"
-    }
     set f [file join [file dirname $gitdir] $flist_menu_file]
-    # Unfortunately it seems git gui blame doesn't like
+    # Unfortunately some commands do not like
     # being given an absolute path...
     set f [make_relative $f]
     lappend cmdline $base_commit $f
     if {[catch {eval exec $cmdline &} err]} {
-	error_popup "[mc "git gui blame: command failed:"] $err"
+	error_popup "[mc "$cmdline: command failed:"] $err"
     }
 }
=20
diff --git a/po/de.po b/po/de.po
index bd194a3..8cfd299 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1276,3 +1276,9 @@ msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr=
 gitk:"
 #: gitk:11587
 msgid "Command line"
 msgstr "Kommandozeile"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/es.po b/po/es.po
index 0471dd0..a3092e0 100644
--- a/po/es.po
+++ b/po/es.po
@@ -909,3 +909,9 @@ msgstr "Argumentos incorrectos a Gitk:"
 #: gitk:10170
 msgid "Command line"
 msgstr "L=C3=ADnea de comandos"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/fr.po b/po/fr.po
index 5370ddc..e58cbdd 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -1252,3 +1252,9 @@ msgstr "Arguments invalides pour gitk :"
 #: gitk:11249
 msgid "Command line"
 msgstr "Ligne de commande"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/hu.po b/po/hu.po
index 7262b61..9237d2a 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -1293,3 +1293,9 @@ msgstr "Parancs sor"
 #~ msgstr ""
 #~ "Sajn=C3=A1ljuk, de a gitk nem futtathat=C3=B3 ezzel a Tcl/Tk verzi=
=C3=B3val.\n"
 #~ "Gitk futtat=C3=A1s=C3=A1hoz legal=C3=A1bb Tcl/Tk 8.4 sz=C3=BCks=C3=
=A9ges."
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/it.po b/po/it.po
index a730d63..6e0b76f 100644
--- a/po/it.po
+++ b/po/it.po
@@ -1274,3 +1274,9 @@ msgstr "Gitk: argomenti errati:"
 #: gitk:11587
 msgid "Command line"
 msgstr "Linea di comando"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/ja.po b/po/ja.po
index 4f47051..b47faab 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -1253,3 +1253,9 @@ msgstr "gitk=E3=81=B8=E3=81=AE=E4=B8=8D=E6=AD=A3=E3=
=81=AA=E5=BC=95=E6=95=B0:"
 #: gitk:11316
 msgid "Command line"
 msgstr "=E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89=E8=A1=8C"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
diff --git a/po/ru.po b/po/ru.po
index c3d0285..f136ec1 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1083,3 +1083,9 @@ msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=
=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=
=D1=82=D1=8B =D0=B4=D0=BB=D1=8F gitk:"
 msgid "Command line"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=B0=D1=8F =D1=81=D1=
=82=D1=80=D0=BE=D0=BA=D0=B0"
=20
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
+
diff --git a/po/sv.po b/po/sv.po
index 386763a..b079016 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1295,3 +1295,9 @@ msgstr "Kommandorad"
=20
 #~ msgid "Name"
 #~ msgstr "Namn"
+
+msgid "Checkout from this commit"
+msgstr ""
+
+msgid "Checkout from parent commit"
+msgstr ""
--=20
1.7.2.2.177.geec0d
