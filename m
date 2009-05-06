From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] t/annotate-tests.sh: avoid passing a non-newline terminated file to sed
Date: Wed,  6 May 2009 13:29:16 -0500
Message-ID: <IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 20:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lsP-00049q-0d
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258AbZEFS3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbZEFS33
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:29:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55578 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbZEFS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:29:27 -0400
Received: by mail.nrlssc.navy.mil id n46ITQJG016326; Wed, 6 May 2009 13:29:27 -0500
In-Reply-To: <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 May 2009 18:29:26.0623 (UTC) FILETIME=[961696F0:01C9CE78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118364>

Some versions of sed exit non-zero if the file they are supplied is not
newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
rework this test to avoid doing so.

This affects tests t8001-annotate.sh and t8002-blame.sh.
---
 t/annotate-tests.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index cacb273..396b965 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -114,7 +114,10 @@ test_expect_success \
 test_expect_success \
     'some edit' \
     'mv file file.orig &&
-    sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" < file.orig > file &&
+    {
+	cat file.orig &&
+	echo
+    } | sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" > file &&
     echo "incomplete" | tr -d "\\012" >>file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
-- 
1.6.2.4.24.gde59d2
