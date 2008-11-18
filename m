From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] Fix deletion of last character in levenshtein distance
Date: Tue, 18 Nov 2008 19:53:26 +0100
Message-ID: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 19:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Vil-0006fG-K5
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 19:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbYKRSx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 13:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYKRSx3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 13:53:29 -0500
Received: from revol2.enst.fr ([137.194.2.14]:58018 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYKRSx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 13:53:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 5AE98B815B;
	Tue, 18 Nov 2008 19:53:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 297B3B802E;
	Tue, 18 Nov 2008 19:53:27 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 0AC8E203DF;
	Tue, 18 Nov 2008 19:53:27 +0100 (CET)
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101278>

Without this change, "git tags" will not suggest "git tag"
(it will only suggest "git status"), and "git statusx" will
not suggest anything.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 levenshtein.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/levenshtein.c b/levenshtein.c
index db52f2c..98fea72 100644
--- a/levenshtein.c
+++ b/levenshtein.c
@@ -25,7 +25,7 @@ int levenshtein(const char *string1, const char *string2,
 					row2[j + 1] > row0[j - 1] + w)
 				row2[j + 1] = row0[j - 1] + w;
 			/* deletion */
-			if (j + 1 < len2 && row2[j + 1] > row1[j + 1] + d)
+			if (row2[j + 1] > row1[j + 1] + d)
 				row2[j + 1] = row1[j + 1] + d;
 			/* insertion */
 			if (row2[j + 1] > row2[j] + a)
