From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/17] t5303: adapt the tests to run with --packv4
Date: Sat, 21 Sep 2013 20:58:03 +0700
Message-ID: <1379771883-10278-18-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNfc-0002To-Oo
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab3IUN4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:56:21 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46562 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUN4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:56:20 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1463641pbc.21
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/bCvELa0spmInd+fVjnx5m8iG8Q9DsQXWF4182dOy9s=;
        b=U3qqFjVFJfkGB9aOvytZfKts0QOLXDFQUMsvLKY1cP5xCTbC6r1DLRuRrm7/XTXpic
         UFbgo1ebJtPXAVd0X1j+0Fat89WVDSL1Y5Smsvly5/81rMd6cujRkLbsNJf/9jxVocPn
         Pd6MeWWUp3xNrQRGUFE3QUqSv26E8KJBR4djqu4VhFWsMXcs1yEHpW83JWih6hW5kOTz
         RsXNyJ4BTvES0nhEpKD83zTJ9PeaIJXbRqw0oDV30XDx8SdO+JOkxfGPDwCaD5M0/Ko4
         +YWqnAb0PVyM0cJYphAgsd3QoPYAS34V3AmU1pMIdSK5D8mH+PukuJNwNvZBd67P7CaU
         cMDA==
X-Received: by 10.68.242.99 with SMTP id wp3mr13710487pbc.1.1379771779670;
        Sat, 21 Sep 2013 06:56:19 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id sn4sm17615442pbc.37.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:56:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235118>

"git show-index" does not work with .idx v3 which is the default for
=2Epack v4. Force .idx back to v2. Disable tests about OBJ_OFS_DELTA on
v4 because that is not supported.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5303-pack-corruption-resilience.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corru=
ption-resilience.sh
index 35926de..21fd54a 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -36,7 +36,7 @@ create_new_pack() {
     blob_2=3D`git hash-object -t blob -w file_2` &&
     blob_3=3D`git hash-object -t blob -w file_3` &&
     pack=3D`printf "$blob_1\n$blob_2\n$blob_3\n" |
-          git pack-objects $@ .git/objects/pack/pack` &&
+	  git pack-objects --index-version=3D2 $@ .git/objects/pack/pack` &&
     pack=3D".git/objects/pack/pack-${pack}" &&
     git verify-pack -v ${pack}.pack
 }
@@ -205,7 +205,7 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     'corruption #0 in delta base reference of first delta (OBJ_OFS_DEL=
TA)' \
     'create_new_pack --delta-base-offset &&
      git prune-packed &&
@@ -214,7 +214,7 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '... but having a loose copy allows for full recovery' \
     'mv ${pack}.idx tmp &&
      git hash-object -t blob -w file_2 &&
@@ -223,7 +223,7 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '... and then a repack "clears" the corruption' \
     'do_repack --delta-base-offset &&
      git prune-packed &&
@@ -232,7 +232,7 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     'corruption #1 in delta base reference of first delta (OBJ_OFS_DEL=
TA)' \
     'create_new_pack --delta-base-offset &&
      git prune-packed &&
@@ -241,7 +241,7 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '... but having a loose copy allows for full recovery' \
     'mv ${pack}.idx tmp &&
      git hash-object -t blob -w file_2 &&
@@ -250,7 +250,7 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '... and then a repack "clears" the corruption' \
     'do_repack --delta-base-offset &&
      git prune-packed &&
@@ -259,7 +259,7 @@ test_expect_success \
      git cat-file blob $blob_2 > /dev/null &&
      git cat-file blob $blob_3 > /dev/null'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '... and a redundant pack allows for full recovery too' \
     'do_corrupt_object $blob_2 2 < zero &&
      git cat-file blob $blob_1 > /dev/null &&
--=20
1.8.2.83.gc99314b
