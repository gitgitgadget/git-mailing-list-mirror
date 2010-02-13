From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 13/30] t3301: Verify successful annotation of non-commits
Date: Sat, 13 Feb 2010 22:28:21 +0100
Message-ID: <1266096518-2104-14-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZD-0001iD-FJ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083Ab0BMV3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:30 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51339 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940Ab0BMV3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:25 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EFKUCZVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:23 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:23 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139841>

Adds a testcase verifying that git-notes works successfully on
tree, blob, and tag objects.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 10f62f4..fd5e593 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -282,4 +282,21 @@ test_expect_success 'Do not show note when core.notesRef is overridden' '
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
1.7.0.rc1.141.gd3fd
