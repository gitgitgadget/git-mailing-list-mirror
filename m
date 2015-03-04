From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] completion: simplify __git_remotes()
Date: Wed,  4 Mar 2015 15:10:29 +0100
Message-ID: <1425478229-11252-2-git-send-email-szeder@ira.uka.de>
References: <20150304150447.Horde.t4rJ5Q_QdRg1uznQKWetMg1@webmail.informatik.kit.edu>
 <1425478229-11252-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Korostoff <mkorostoff@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:11:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTA18-0003fI-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 15:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409AbbCDOLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 09:11:12 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33209 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758240AbbCDOLK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 09:11:10 -0500
Received: from x590c628a.dyn.telefonica.de ([89.12.98.138] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YTA0v-00065x-SK; Wed, 04 Mar 2015 15:11:07 +0100
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1425478229-11252-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1425478267.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264759>

The __git_remotes() helper function lists the remotes from the config
file by processing the output of a 'git config' query.  A simple 'git
remote' produces the exact same output, so run that instead.

Remotes under '$GIT_DIR/remotes' are still listed by running 'ls -1',
because 'git remote' unfortunately ignores them.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c21190d..f5ae5e3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -411,12 +411,9 @@ __git_refs_remotes ()
=20
 __git_remotes ()
 {
-	local i IFS=3D$'\n' d=3D"$(__gitdir)"
+	local d=3D"$(__gitdir)"
 	test -d "$d/remotes" && ls -1 "$d/remotes"
-	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url'=
 2>/dev/null); do
-		i=3D"${i#remote.}"
-		echo "${i/.url*/}"
-	done
+	git --git-dir=3D"$d" remote
 }
=20
 __git_list_merge_strategies ()
--=20
2.1.2.1369.g8751039
