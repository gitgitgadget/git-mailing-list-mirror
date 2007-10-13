From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 12/14] t0021-conversion.sh: Test that the clean filter really cleans content.
Date: Sat, 13 Oct 2007 22:06:22 +0200
Message-ID: <1192305984-22594-13-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-10-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-11-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-12-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:08:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnH0-0008Ve-I5
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbXJMUGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757729AbXJMUGo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:44 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52598 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbXJMUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:29 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id A4C3513A6A6;
	Sat, 13 Oct 2007 22:06:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-12-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60771>

This test uses a rot13 filter, which is its own inverse. It tested only
that the content was the same as the original after both the 'clean' and
the 'smudge' filter were applied. This way it would not detect whether
any filter was run at all. Hence, here we add another test that checks
that the repository contained content that was processed by the 'clean'
filter.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t0021-conversion.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a839f4e..cb86029 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -42,7 +42,12 @@ test_expect_success check '
 	git diff --raw --exit-code :test :test.i &&
 	id=$(git rev-parse --verify :test) &&
 	embedded=$(sed -ne "$script" test.i) &&
-	test "z$id" = "z$embedded"
+	test "z$id" = "z$embedded" &&
+
+	git cat-file blob :test.t > test.r &&
+
+	./rot13.sh < test.o > test.t &&
+	cmp test.r test.t
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that
-- 
1.5.3.3.1134.gee562
