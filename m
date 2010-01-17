From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 13/20] t3301: Verify successful annotation of non-commits
Date: Sun, 17 Jan 2010 22:04:30 +0100
Message-ID: <1263762277-31419-14-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:05:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcJZ-0007Cz-OW
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab0AQVF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725Ab0AQVFV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:21 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62630 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754777Ab0AQVFT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:19 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002D1T8U0RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:18 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:17 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137328>

Adds a testcase verifying that git-notes works successfully on
tree, blob, and tag objects.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index c6031b1..0881db6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -229,4 +229,21 @@ test_expect_success 'Do not show note when core.notesRef is overridden' '
 	test_cmp expect-not-other output
 '
 
+test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
+	echo "Note on a tree" > expect
+	git notes edit -m "Note on a tree" HEAD: &&
+	git notes show HEAD: > actual &&
+	test_cmp expect actual &&
+	echo "Note on a blob" > expect
+	filename=$(git ls-tree --name-only HEAD | head -n1) &&
+	git notes edit -m "Note on a blob" HEAD:$filename &&
+	git notes show HEAD:$filename > actual &&
+	test_cmp expect actual &&
+	echo "Note on a tag" > expect
+	git tag -a -m "This is an annotated tag" foobar HEAD^ &&
+	git notes edit -m "Note on a tag" foobar &&
+	git notes show foobar > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.6.rc1.321.g0496e
