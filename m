From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] merge-tree: fix typo in "both changed identically"
Date: Sat, 27 Apr 2013 14:40:33 +0100
Message-ID: <dbbdae2f2a471a61a578fcd74471d2b64391a31d.1367069938.git.john@keeping.me.uk>
References: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 15:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW5N0-0000SG-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab3D0Nku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 09:40:50 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41098 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3D0Nkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:40:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 45E8B198019;
	Sat, 27 Apr 2013 14:40:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1kCIJVijtFN; Sat, 27 Apr 2013 14:40:48 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id B07EA198017;
	Sat, 27 Apr 2013 14:40:48 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A44F7161E40C;
	Sat, 27 Apr 2013 14:40:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1v22fk6NI80f; Sat, 27 Apr 2013 14:40:48 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6BAAF161E0F0;
	Sat, 27 Apr 2013 14:40:41 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc0.149.g98a72f2.dirty
In-Reply-To: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222648>

Commit aacecc3 (merge-tree: don't print entries that match "local" -
2013-04-07) had a typo causing the "same in both" check to be incorrect
and check if both the base and "their" versions are removed instead of
checking that both the "our" and "their" versions are removed.  Fix
this.

Reported-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Test-written-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v1:
- Add test from Ren=C3=A9
- s/empty/removed/g in the commit message

 builtin/merge-tree.c  |  2 +-
 t/t4300-merge-tree.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ed25d81..ec49917 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -302,7 +302,7 @@ static void unresolved(const struct traverse_info *=
info, struct name_entry n[3])
 static int threeway_callback(int n, unsigned long mask, unsigned long =
dirmask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
-	if (same_entry(entry+1, entry+2) || both_empty(entry+0, entry+2)) {
+	if (same_entry(entry+1, entry+2) || both_empty(entry+1, entry+2)) {
 		/* Modified, added or removed identically */
 		resolve(info, NULL, entry+1);
 		return mask;
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index bd43b3d..2defb42 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -205,6 +205,19 @@ EXPECTED
 	test_cmp expected actual
 '
=20
+test_expect_success 'file remove A, B (same)' '
+	cat >expected <<\EXPECTED &&
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "rm-a-b-base" "ONE" "AAA" &&
+	git rm ONE &&
+	git commit -m "rm-a-b" &&
+	git tag "rm-a-b" &&
+	git merge-tree rm-a-b-base rm-a-b rm-a-b >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'file change A, remove B' '
 	cat >expected <<\EXPECTED &&
 removed in remote
--=20
1.8.3.rc0.149.g98a72f2.dirty
