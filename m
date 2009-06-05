From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] t6030: test skipping away from an already skipped
	commit
Date: Fri, 05 Jun 2009 06:10:43 +0200
Message-ID: <20090605041044.8885.1948.chriscool@tuxfamily.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 06:12:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCQnM-0001a8-HU
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 06:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbZFEEMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 00:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZFEEMd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 00:12:33 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:55608 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbZFEEM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 00:12:26 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 743CB4B0072;
	Fri,  5 Jun 2009 06:12:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 660E84B0054;
	Fri,  5 Jun 2009 06:12:18 +0200 (CEST)
X-git-sha1: acaac9df8c7e1b4c291522fcdf05c1644f34ac25 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120738>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5254b23..4556cdd 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -555,6 +555,18 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	grep "$PARA_HASH4 is first bad commit" my_bisect_log.txt
 '
 
+test_expect_success 'skipping away from skipped commit' '
+	git bisect start $PARA_HASH7 $HASH1 &&
+	para4=$(git rev-parse --verify HEAD) &&
+	test "$para4" = "$PARA_HASH4" &&
+        git bisect skip &&
+	hash7=$(git rev-parse --verify HEAD) &&
+	test "$hash7" = "$HASH7" &&
+        git bisect skip &&
+	hash3=$(git rev-parse --verify HEAD) &&
+	test "$hash3" = "$HASH3"
+'
+
 #
 #
 test_done
-- 
1.6.3.GIT
