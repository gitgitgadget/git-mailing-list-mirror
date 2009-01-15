From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC PATCH] Zooko's merge testcase
Date: Thu, 15 Jan 2009 01:53:38 +0100
Message-ID: <1231980818-24812-1-git-send-email-vmiklos@frugalware.org>
Cc: zooko <zooko@zooko.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 01:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGVf-00028a-2j
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZAOAxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZAOAxg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:53:36 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41129 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbZAOAxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:53:35 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 10195446CE6;
	Thu, 15 Jan 2009 01:53:34 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B4AA919DFC4; Thu, 15 Jan 2009 01:53:38 +0100 (CET)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105748>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

The original page is here:

https://zooko.com/badmerge/simple.html

IIRC it was Robin who mentioned it on IRC.

I obviously not send this patch for inclusion, but to raise a
discussion: if I were a naive user I would think the merge will at least
result in a conflict, however actually it just gaves a wrong result.

 t/t7608-merge-zooko.sh |   88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100755 t/t7608-merge-zooko.sh

diff --git a/t/t7608-merge-zooko.sh b/t/t7608-merge-zooko.sh
new file mode 100755
index 0000000..32609c0
--- /dev/null
+++ b/t/t7608-merge-zooko.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='git merge
+
+Testing merge with the examples of Zooko.'
+
+. ./test-lib.sh
+
+#
+# A - D     \
+#   \ B - C - E
+#
+test_expect_success 'setup' '
+	cat <<EOF >file &&
+A
+B
+C
+D
+E
+EOF
+	git add file &&
+	git commit -m A &&
+	git tag A &&
+	cat <<EOF >file &&
+G
+G
+G
+A
+B
+C
+D
+E
+EOF
+	git add file &&
+	git commit -m B &&
+	git tag B &&
+	cat <<EOF >file &&
+A
+B
+C
+D
+E
+G
+G
+G
+A
+B
+C
+D
+E
+EOF
+	git add file &&
+	git commit -m C &&
+	git tag C &&
+	git reset --hard A &&
+	cat <<EOF >file &&
+A
+B
+X
+D
+E
+EOF
+	git add file &&
+	git commit -m D &&
+	git tag D
+'
+
+test_expect_failure 'merge C' '
+	cat <<EOF >expected &&
+A
+B
+C
+D
+E
+G
+G
+G
+A
+B
+X
+D
+E
+EOF
+	git merge C &&
+	test_cmp expected file
+'
+
+test_done
-- 
1.6.1
