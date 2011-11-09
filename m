From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: don't leak variable from the prompt into
	environment
Date: Wed, 9 Nov 2011 11:02:50 +0100
Message-ID: <1320832970-26239-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 11:03:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO4zx-0000Ax-2N
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 11:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab1KIKDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 05:03:07 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:3711 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1KIKDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 05:03:06 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 11:03:00 +0100
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 11:03:02 +0100
X-Mailer: git-send-email 1.7.8.rc0.107.g695cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185148>

Commit e5b8eebc (completion: fix issue with process substitution not
working on Git for Windows, 2011-10-26) introduced a new variable in
__git_ps1_show_upstream(), but didn't declare it as local to prevent
it from leaking into the environment.
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b3571ab4..d18895b1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -110,7 +110,7 @@ __git_ps1_show_upstream ()
 	local upstream=git legacy="" verbose=""
 
 	# get some config options from git-config
-	output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
+	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
 	while read key value; do
 		case "$key" in
 		bash.showupstream)
-- 
1.7.8.rc0.107.g695cb
