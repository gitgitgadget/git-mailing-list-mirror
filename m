From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/6] t5000, t5003: create directories for extracted files lazily
Date: Mon, 20 May 2013 11:58:25 +0200
Message-ID: <1369043909-59207-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMrn-0004UC-Sy
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3ETJ6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:56479 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab3ETJ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:35 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 32538519
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224949>

Create the directories b and c just before they are needed instead of
up front.  For t5003 it turns out we don't need them at all.  For t5000
it makes the coming modifications easier.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh    | 6 +++---
 t/t5003-archive-zip.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 68b5698..41cd609 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -32,7 +32,7 @@ SUBSTFORMAT=3D%H%n
=20
 test_expect_success \
     'populate workdir' \
-    'mkdir a b c &&
+    'mkdir a &&
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
@@ -126,7 +126,7 @@ test_expect_success \
=20
 test_expect_success \
     'extract tar archive' \
-    '(cd b && "$TAR" xf -) <b.tar'
+    '(mkdir b && cd b && "$TAR" xf -) <b.tar'
=20
 test_expect_success \
     'validate filenames' \
@@ -143,7 +143,7 @@ test_expect_success \
=20
 test_expect_success \
     'extract tar archive with prefix' \
-    '(cd c && "$TAR" xf -) <c.tar'
+    '(mkdir c && cd c && "$TAR" xf -) <c.tar'
=20
 test_expect_success \
     'validate filenames with prefix' \
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 4e7b05d..c72f71e 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -37,7 +37,7 @@ check_zip() {
=20
 test_expect_success \
     'populate workdir' \
-    'mkdir a b c &&
+    'mkdir a &&
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
--=20
1.8.2.3
