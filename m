From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: complete 'git stash' subcommands only once
Date: Wed,  5 Mar 2008 20:16:04 +0100
Message-ID: <59b1b35932d76bc6b8cc50d2a1184fec7d0d903d.1204725800.git.szeder@ira.uka.de>
References: <>
 <9956781bfd3f6ec8776c055aa21a4d3d4a504623.1204725800.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWz72-0006Ni-GB
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbYCETQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYCETQI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:16:08 -0500
Received: from francis.fzi.de ([141.21.7.5]:17731 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754306AbYCETQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:16:06 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Mar 2008 20:16:02 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <9956781bfd3f6ec8776c055aa21a4d3d4a504623.1204725800.git.szeder@ira.uka.de>
In-Reply-To: <9956781bfd3f6ec8776c055aa21a4d3d4a504623.1204725800.git.szeder@ira.uka.de>
References: <9956781bfd3f6ec8776c055aa21a4d3d4a504623.1204725800.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 05 Mar 2008 19:16:02.0535 (UTC) FILETIME=[5A31A770:01C87EF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76251>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d138bda..5ecdca0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1087,7 +1087,22 @@ _git_show ()
=20
 _git_stash ()
 {
-	__gitcomp 'save list show apply clear'
+	local i c=3D1 command
+
+	while [ $c -lt $COMP_CWORD ]; do
+		i=3D"${COMP_WORDS[c]}"
+		case "$i" in
+		save|list|show|apply|clear)
+			command=3D"$i"
+			break
+			;;
+		esac
+		c=3D$((++c))
+	done
+
+	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+		__gitcomp 'save list show apply clear'
+	fi
 }
=20
 _git_submodule ()
--=20
1.5.4.3

