From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
Date: Sat, 14 Feb 2009 20:15:04 +0100
Message-ID: <d2ca964918f3f930505cd969cf8407d4a8d67fe3.1234638466.git.trast@student.ethz.ch>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 20:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQ0Z-0008VK-G8
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZBNTPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZBNTPU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:15:20 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20714 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbZBNTPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:15:17 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
X-Mailer: git-send-email 1.6.2.rc0.288.g6852b
In-Reply-To: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 19:15:14.0584 (UTC) FILETIME=[908A6980:01C98ED8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109896>

This is the order documented in git-config(1), so we should stick to
it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

It's actually only _almost_ the documented order: the manpage says
that $GIT_EDITOR is used when it is set, presumably even when it is
set but empty.  I cannot see how that would be useful however.


 git-notes.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index 246df65..6859470 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -35,7 +35,8 @@ edit)
 		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
 	fi
 
-	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+	core_editor="$(git config core.editor)"
+	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MESSAGE"
 
 	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
 	mv "$MESSAGE".processed "$MESSAGE"
-- 
1.6.2.rc0.288.g6852b
