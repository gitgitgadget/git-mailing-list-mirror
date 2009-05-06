From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] t4118: avoid sed invocation on file without terminating newline
Date: Wed,  6 May 2009 13:29:15 -0500
Message-ID: <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 20:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lsO-00049q-DG
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbZEFS33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbZEFS32
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:29:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55576 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZEFS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:29:27 -0400
Received: by mail.nrlssc.navy.mil id n46ITQJE016326; Wed, 6 May 2009 13:29:27 -0500
In-Reply-To: <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 May 2009 18:29:26.0545 (UTC) FILETIME=[960AB010:01C9CE78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118365>

Some versions of sed exit non-zero if the file they are supplied is not
newline terminated. Solaris's /usr/xpg4/bin/sed is one such sed.  In
this case the sed invocation can be avoided entirely since the resulting
file is equivalent to a previously created file.  So, just copy that file
into place instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4118-apply-empty-context.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 314bc6e..65f2e4c 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 	cat file2 >file2.orig &&
 	git add file1 file2 &&
 	sed -e "/^B/d" <file1.orig >file1 &&
-	sed -e "/^[BQ]/d" <file2.orig >file2 &&
+	cat file1 > file2 &&
 	echo Q | tr -d "\\012" >>file2 &&
 	cat file1 >file1.mods &&
 	cat file2 >file2.mods &&
-- 
1.6.2.4.24.gde59d2
