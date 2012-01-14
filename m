From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Sat, 14 Jan 2012 19:55:36 +0100
Message-ID: <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20120114152030.GX30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 14 19:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm8lq-00033U-OR
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 19:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab2ANSzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 13:55:44 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34942 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab2ANSzn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 13:55:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0EIs2tf022250
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 14 Jan 2012 19:54:02 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Rm8lO-0003zb-Ix; Sat, 14 Jan 2012 19:55:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Rm8lO-0000Zj-Er; Sat, 14 Jan 2012 19:55:38 +0100
X-Mailer: git-send-email 1.7.9.rc0.25.gb9a1f.dirty
In-Reply-To: <20120114152030.GX30469@goldbirke>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 14 Jan 2012 19:54:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0EIs2tf022250
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1327172043.32824@+DJby7R6zznX99qEsx3KTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188576>

Commit a31e626 (completion: optimize refs completion) introduced a
regression for ZSH users: ref names were completed with a quoted traili=
ng
space (i.e. "git checkout ma" completes to "git checkout master\ "). Th=
e
space is convenient for bash users since we use "-o nospace", but a
quoted space is worse than nothing. The absence of trailing space for Z=
SH
is a long-standing issue, that this patch is not fixing. We just fix th=
e
regression by not appending a space when the shell is ZSH.

Original-patch-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/completion/git-completion.bash |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b0062ba..488e1f4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -534,6 +534,12 @@ __gitcomp_nl ()
 		fi
 	fi
=20
+	# ZSH would quote the trailing space added with -S. bash users
+	# will appreciate the extra space to compensate the use of -o nospace=
=2E
+	if [ -n "${ZSH_VERSION-}" ] && [ "$suffix" =3D " " ]; then
+		suffix=3D""
+	fi
+
 	IFS=3D$s
 	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
 }
--=20
1.7.9.rc0.25.gb9a1f.dirty
