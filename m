From: Daniel Trstenjak <daniel.trstenjak@science-computing.de>
Subject: [PATCH] Show the presence of untracked files in the bash prompt.
Date: Tue, 21 Jul 2009 19:14:45 +0200
Message-ID: <20090721171445.GA25762@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 19:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTIwA-0006Es-DD
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbZGUROy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755817AbZGUROx
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 13:14:53 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:39650 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812AbZGUROv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 13:14:51 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id n6LHEoHx001852
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 19:14:50 +0200 (MEST)
	env-from (prvs=44694d3a7=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.43,241,1246831200"; 
   d="scan'208";a="68494"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 21 Jul 2009 19:14:50 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 8A8EB414001;
	Tue, 21 Jul 2009 19:14:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHhUTr6S2zOC; Tue, 21 Jul 2009 19:14:46 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id 21C6B414002;
	Tue, 21 Jul 2009 19:14:46 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id ED1891285E1; Tue, 21 Jul 2009 19:14:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123677>

Added the envvar GIT_PS1_SHOWUNTRACKEDFILES to 'git-completion.bash'.
When set to a nonempty value, then the char '%' will be shown next
to the branch name in the bash prompt.

Signed-off-by: Daniel Trstenjak <daniel.trstenjak@science-computing.de>
---
 contrib/completion/git-completion.bash |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 887731e..4c0f7d2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -44,6 +44,10 @@
 #       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is st=
ashed,
 #       then a '$' will be shown next to the branch name.
 #
+#       If you would like to see if there're untracked files, then you=
 can
+#       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there'r=
e
+#       untracked files, then a '%' will be shown next to the branch n=
ame.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -132,6 +136,7 @@ __git_ps1 ()
 		local w
 		local i
 		local s
+		local u
 		local c
=20
 		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
@@ -156,12 +161,19 @@ __git_ps1 ()
 			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
 			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+			   local num_untracked_files=3D$(git ls-files --others --exclude-st=
andard | wc -l)
+			   if [ $num_untracked_files -gt "0" ]; then
+			      u=3D"%"
+			   fi
+			fi
 		fi
=20
 		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$s$r"
+			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
 		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$s$r"
+			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
 		fi
 	fi
 }
--=20
1.6.2


--=20
                                                                       =
                                                                   =20
 Daniel Trstenjak         Tel   : +49 (0)7071-9457-264
 science + computing ag   FAX   : +49 (0)7071-9457-511
 Hagellocher Weg 73       mailto: Daniel.Trstenjak@science-computing.de
 D-72070 T=FCbingen         WWW   : http://www.science-computing.de/   =
                                                                  =20
--=20
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier,=20
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196=20
