From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH -resend] Add a helper script to send patches with Mozilla
 Thunderbird
Date: Fri, 20 Jun 2008 01:21:33 +0200
Organization: Chalmers
Message-ID: <485AE9FD.8050508@etek.chalmers.se>
References: <484D6A40.60002@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TSZ-000654-CR
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYFSXVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYFSXVg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:21:36 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:33910 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYFSXVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:21:36 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id DDF2785AB;
	Fri, 20 Jun 2008 01:21:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <484D6A40.60002@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85562>

The script appp.sh can be used with the External Editor extension for
Mozilla Thunderbird in order to be able to send inline patches in an
easy way.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

Resending. It would be nice if this ended up in contrib/

/Lukas

 Documentation/SubmittingPatches          |    5 +++
 contrib/thunderbird-patch-inline/README  |   20 +++++++++++
 contrib/thunderbird-patch-inline/appp.sh |   55 ++++++++++++++++++++++=
++++++++
 3 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 contrib/thunderbird-patch-inline/README
 create mode 100755 contrib/thunderbird-patch-inline/appp.sh

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 0e155c9..7c16852 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -419,6 +419,11 @@ settings but I haven't tried, yet.
 	mail.identity.default.compose_html	=3D> false
 	mail.identity.id?.compose_html		=3D> false
=20
+( Lukas Sandstr=C3=B6m )
+
+There is a script in contrib/thunderbird-patch-inline which can help
+you include patches with Thunderbird in an easy way. To use it, do the
+steps above and then use the script as the external editor.
=20
 Gnus
 ----
diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderb=
ird-patch-inline/README
new file mode 100644
index 0000000..39f96aa
--- /dev/null
+++ b/contrib/thunderbird-patch-inline/README
@@ -0,0 +1,20 @@
+appp.sh is a script that is supposed to be used together with External=
Editor
+for Mozilla Thundebird. It will let you include patches inline in e-ma=
ils
+in an easy way.
+
+Usage:
+- Generate the patch with git format-patch.
+- Start writing a new e-mail in Thunderbird.
+- Press the external editor button (or Ctrl-E) to run appp.sh
+- Select the previosly generated patch file.
+- Finish editing the e-mail.
+
+Any text that is entered into the message editor before appp.sh is cal=
led
+will be moved to the section between the --- and the diffstat.
+
+All S-O-B:s and Cc:s in the patch will be added to the CC list.
+
+To set it up, just install External Editor and tell it to use appp.sh =
as the
+editor.
+
+Zenity is a required dependency.
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunder=
bird-patch-inline/appp.sh
new file mode 100755
index 0000000..cc518f3
--- /dev/null
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# Copyright 2008 Lukas Sandstr=C3=B6m <luksan@gmail.com>
+#
+# AppendPatch - A script to be used together with ExternalEditor
+# for Mozilla Thunderbird to properly include pathes inline i e-mails.
+
+# ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2
+
+CONFFILE=3D~/.appprc
+
+SEP=3D"-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-"
+if [ -e "$CONFFILE" ] ; then
+	LAST_DIR=3D`grep -m 1 "^LAST_DIR=3D" "${CONFFILE}"|sed -e 's/^LAST_DI=
R=3D//'`
+	cd "${LAST_DIR}"
+else
+	cd > /dev/null
+fi
+
+PATCH=3D$(zenity --file-selection)
+
+if [ "$?" !=3D "0" ] ; then
+	#zenity --error --text "No patchfile given."
+	exit 1
+fi
+
+cd - > /dev/null
+
+SUBJECT=3D`sed -n -e '/^Subject: /p' "${PATCH}"`
+HEADERS=3D`sed -e '/^'"${SEP}"'$/,$d' $1`
+BODY=3D`sed -e "1,/${SEP}/d" $1`
+CMT_MSG=3D`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
+DIFF=3D`sed -e '1,/^---$/d' "${PATCH}"`
+
+CCS=3D`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp=
' \
+	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
+
+echo "$SUBJECT" > $1
+echo "Cc: $CCS" >> $1
+echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
+echo "$SEP" >> $1
+
+echo "$CMT_MSG" >> $1
+echo "---" >> $1
+if [ "x${BODY}x" !=3D "xx" ] ; then
+	echo >> $1
+	echo "$BODY" >> $1
+	echo >> $1
+fi
+echo "$DIFF" >> $1
+
+LAST_DIR=3D`dirname "${PATCH}"`
+
+grep -v "^LAST_DIR=3D" "${CONFFILE}" > "${CONFFILE}_"
+echo "LAST_DIR=3D${LAST_DIR}" >> "${CONFFILE}_"
+mv "${CONFFILE}_" "${CONFFILE}"
--=20
1.5.3.7
