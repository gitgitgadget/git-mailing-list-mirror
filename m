From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/3] Make patch deletion test more specific
Date: Sun, 13 May 2007 20:27:20 +0200
Message-ID: <20070513182720.18810.64330.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 20:36:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIvt-00005q-BF
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbXEMSgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757616AbXEMSgd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:36:33 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54270 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757573AbXEMSgc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 14:36:32 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:60141 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HnIvk-0006TD-7C; Sun, 13 May 2007 20:36:30 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HnImu-0004tp-F3; Sun, 13 May 2007 20:27:20 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HnIvk-0006TD-7C.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HnIvk-0006TD-7C 33ff15cc3abd51c604eb0c01bcf0aa16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47161>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Don't just test the number of applied and unapplied patches; also test
their name and order.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1601-delete-many.sh |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t1601-delete-many.sh b/t/t1601-delete-many.sh
index 8648ed1..8eff308 100755
--- a/t/t1601-delete-many.sh
+++ b/t/t1601-delete-many.sh
@@ -10,13 +10,13 @@ test_expect_success \
 test_expect_success \
     'Create five applied and five unapplied patches' \
     '
-    stg new foo0 -m foo0 &&
-    echo foo0 > foo.txt &&
+    stg new p0 -m p0 &&
+    echo p0 > foo.txt &&
     stg add foo.txt &&
     stg refresh &&
     for i in 1 2 3 4 5 6 7 8 9; do
-        stg new foo$i -m foo$i &&
-        echo foo$i >> foo.txt &&
+        stg new p$i -m p$i &&
+        echo p$i >> foo.txt &&
         stg refresh;
     done &&
     stg pop -n 5
@@ -25,31 +25,31 @@ test_expect_success \
 test_expect_success \
     'Delete some patches' \
     '
-    [ $(stg applied | wc -l) -eq 5 ] &&
-    [ $(stg unapplied | wc -l) -eq 5 ] &&
-    stg delete foo7 foo6 foo3 foo4 &&
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg unapplied | wc -l) -eq 3 ]
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p6 p7 p8 p9" ] &&
+    stg delete p7 p6 p3 p4 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ]
     '
=20
 test_expect_success \
     'Delete some more patches, some of which do not exist' \
     '
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg unapplied | wc -l) -eq 3 ] &&
-    ! stg delete foo7 foo8 foo2 foo0 &&
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg unapplied | wc -l) -eq 3 ]
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ] &&
+    ! stg delete p7 p8 p2 p0 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ]
     '
=20
 test_expect_success \
     'Delete a range of patches' \
     '
-    [ $(stg applied | wc -l) -eq 3 ] &&
-    [ $(stg unapplied | wc -l) -eq 3 ] &&
-    stg delete foo1..foo8 &&
-    [ $(stg applied | wc -l) -eq 1 ] &&
-    [ $(stg unapplied | wc -l) -eq 1 ]
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ] &&
+    stg delete p1..p8 &&
+    [ "$(echo $(stg applied))" =3D "p0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p9" ]
     '
=20
 test_done
