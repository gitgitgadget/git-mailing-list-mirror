From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 01/13] Add some more tests of "stg status" output
Date: Sat, 15 Sep 2007 00:31:14 +0200
Message-ID: <20070914223114.7001.27153.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhO-0001NS-1z
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348AbXINWbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757251AbXINWbZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:25 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56493 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbXINWbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 860C6200A1D7;
	Sat, 15 Sep 2007 00:31:23 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-2; Sat, 15 Sep 2007 00:31:18 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0AE5E200A1B8;
	Sat, 15 Sep 2007 00:31:14 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 46848BFA59;
	Sat, 15 Sep 2007 00:31:14 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58193>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 t/t0002-status.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)


diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index ce3b688..790b9fb 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -85,6 +85,12 @@ test_expect_success 'Status after refresh' '
     diff -u expected.txt output.txt
 '
=20
+test_expect_success 'Add another file' '
+    echo lajbans > fie &&
+    stg add fie &&
+    stg refresh
+'
+
 test_expect_success 'Make a conflicting patch' '
     stg pop &&
     stg new -m "third patch" &&
@@ -105,6 +111,28 @@ test_expect_success 'Status after conflicting push=
' '
 '
=20
 cat > expected.txt <<EOF
+C foo/bar
+EOF
+test_expect_success 'Status of file' '
+    stg status foo/bar > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status of dir' '
+    stg status foo > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status of other file' '
+    stg status fie > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
 M foo/bar
 EOF
 test_expect_success 'Status after resolving the push' '
