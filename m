From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: display git prompt in case of merge conflict during
	rebase
Date: Thu, 28 May 2009 18:17:21 +0200
Message-ID: <1243527441-3394-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 28 18:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9iXt-0003tV-2e
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 18:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbZE1QdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZE1QdB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 12:33:01 -0400
Received: from francis.fzi.de ([141.21.7.5]:33635 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751374AbZE1QdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 12:33:00 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2009 12:33:00 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 18:17:45 +0200
X-Mailer: git-send-email 1.6.3.1.189.g9321
X-OriginalArrivalTime: 28 May 2009 16:17:45.0452 (UTC) FILETIME=[D5B612C0:01C9DFAF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120197>

Since e5dd864a (completion: Better __git_ps1 support when not in
working directory, 2009-02-11) the git prompt becomes empty, if we hit
a merge conflict during a rebase.

e5dd864a added an if statement at the end of __git_ps1 to only display
anything in the prompt, if the branch name is not empty.  This caused
the empty prompt in the "merge conflict during rebase" case, because
in this case we display neither the branch name nor the abbreviated
SHA1, the ongoing rebase is identified.

This patch removes that check, so the git prompt is displayed even if
the branch name is empty.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0c8bb53..6c78c94 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -152,12 +152,10 @@ __git_ps1 ()
 			fi
 		fi
=20
-		if [ -n "$b" ]; then
-			if [ -n "${1-}" ]; then
-				printf "$1" "$c${b##refs/heads/}$w$i$r"
-			else
-				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
-			fi
+		if [ -n "${1-}" ]; then
+			printf "$1" "$c${b##refs/heads/}$w$i$r"
+		else
+			printf " (%s)" "$c${b##refs/heads/}$w$i$r"
 		fi
 	fi
 }
--=20
1.6.3.1.189.g9321
