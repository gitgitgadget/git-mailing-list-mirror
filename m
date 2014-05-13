From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] contrib: completion: fix 'eread()' namespace
Date: Tue, 13 May 2014 08:21:19 -0500
Message-ID: <1399987279-12487-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Tue May 13 15:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkCof-0003TS-C2
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 15:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbaEMNcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 09:32:17 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:59183 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaEMNcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 09:32:16 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so367536obc.11
        for <git@vger.kernel.org>; Tue, 13 May 2014 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=/DDwnnXPMBkTJ2vMMSMwG0IeV5gN4SJgdzi8DZ8/YiI=;
        b=l/NqnRW+96D0VRzzNRa/eVztmIL3Nt3d53E6UUhFQ17YNnYnW45ksmn8/tV48YjXN/
         /l6sbG4YLTiwmflMfQMUG6YiZlg8I1pvCmV14vzH+LG6Sa8J9YBVMiG/57Uw2VZUzMUh
         a9t+ekuRgptzW4sdks2WvpO2JunYLoOB/JmdnTmVjQqPKM1LOtpLSG66l8M0w8y6GEzk
         ceylrZZNuQ8vho+t32HTXGpw2ltXDxyfphm0Bak+syQ2wkNlx72L6pdlPbU5sARSD0jJ
         bMk62owA43En8U1tZIgcl5hKLD8hXbCDXarPLbkWllXRhyWnQiGv4X1/a5CU1633Fbg7
         888g==
X-Received: by 10.60.133.81 with SMTP id pa17mr42387756oeb.35.1399987936414;
        Tue, 13 May 2014 06:32:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tz6sm26066070obc.10.2014.05.13.06.32.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 06:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.3+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248781>

Otherwise it might collide with a function of the same name in the
user's environment.

Suggested-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 96b8087..853425d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -270,7 +270,7 @@ __git_ps1_colorize_gitstring ()
 	r=3D"$c_clear$r"
 }
=20
-eread ()
+__git_eread ()
 {
 	f=3D"$1"
 	shift
@@ -339,9 +339,9 @@ __git_ps1 ()
 	local step=3D""
 	local total=3D""
 	if [ -d "$g/rebase-merge" ]; then
-		eread "$g/rebase-merge/head-name" b
-		eread "$g/rebase-merge/msgnum" step
-		eread "$g/rebase-merge/end" total
+		__git_eread "$g/rebase-merge/head-name" b
+		__git_eread "$g/rebase-merge/msgnum" step
+		__git_eread "$g/rebase-merge/end" total
 		if [ -f "$g/rebase-merge/interactive" ]; then
 			r=3D"|REBASE-i"
 		else
@@ -349,10 +349,10 @@ __git_ps1 ()
 		fi
 	else
 		if [ -d "$g/rebase-apply" ]; then
-			eread "$g/rebase-apply/next" step
-			eread "$g/rebase-apply/last" total
+			__git_eread "$g/rebase-apply/next" step
+			__git_eread "$g/rebase-apply/last" total
 			if [ -f "$g/rebase-apply/rebasing" ]; then
-				eread "$g/rebase-apply/head-name" b
+				__git_eread "$g/rebase-apply/head-name" b
 				r=3D"|REBASE"
 			elif [ -f "$g/rebase-apply/applying" ]; then
 				r=3D"|AM"
@@ -376,7 +376,7 @@ __git_ps1 ()
 			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
 		else
 			local head=3D""
-			if ! eread "$g/HEAD" head; then
+			if ! __git_eread "$g/HEAD" head; then
 				if [ $pcmode =3D yes ]; then
 					PS1=3D"$ps1pc_start$ps1pc_end"
 				fi
--=20
1.9.3+fc1
