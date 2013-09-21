From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/17] t5300: avoid testing ofs-delta with --packv4
Date: Sat, 21 Sep 2013 20:58:01 +0700
Message-ID: <1379771883-10278-16-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNfS-00028q-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IUN4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:56:09 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:60114 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUN4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:56:08 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1481029pdi.13
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3DcTBxgUHi8vc6Z/4Jwrg2a+YUvgfYT2Y5Eoj5Bp0G8=;
        b=Z26WTNNpADM2/KmdzYq5Oa3HWxuwgRbIigrsBoepF5kQUgdPFu8j5e+vuq3OOz1CTH
         apiN9I/L4EAfPMwNwjScIWIkZ+yciKG3QDpyoXTzeFfph/ihQ1dOPDGLWaxDF2ll9iJl
         mZrgvDvUqeFCQDHcov4C2xrC/2qcno4aHKV6CHV4WqOWGJoObI/v8Zvb79MpnBKhHGb/
         uUPNZC03zJz9wFu/GRFXsdz88zvn3V1WdSBfd1TkDXYfuyIhs+ZWG0BZpkMjsXMnGY+r
         ICla6dacBK0CiVWCr/yJAcW3pXDNLbL5fdZwKxJ7HeSti6cAbtfNON4rWauBGQlWGQhY
         X3Gg==
X-Received: by 10.67.11.103 with SMTP id eh7mr1481969pad.153.1379771768077;
        Sat, 21 Sep 2013 06:56:08 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id gg10sm22127409pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:56:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235116>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5300-pack-object.sh | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a07c871..62fc997 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -98,7 +98,7 @@ test_expect_success \
      done'
 cd "$TRASH"
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     'pack with OFS_DELTA' \
     'pwd &&
      packname_3=3D$(git pack-objects --delta-base-offset test-3 <obj-l=
ist)'
@@ -106,7 +106,7 @@ test_expect_success \
 rm -fr .git2
 mkdir .git2
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     'unpack with OFS_DELTA' \
     'GIT_OBJECT_DIRECTORY=3D.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
@@ -116,7 +116,7 @@ test_expect_success \
=20
 unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
-test_expect_success \
+test_expect_success !PACKV4 \
     'check unpack with OFS_DELTA' \
     '(cd ../.git && find objects -type f -print) |
      while read path
@@ -128,7 +128,7 @@ test_expect_success \
      done'
 cd "$TRASH"
=20
-test_expect_success 'compare delta flavors' '
+test_expect_success !PACKV4 'compare delta flavors' '
 	"$PERL_PATH" -e '\''
 		defined($_ =3D -s $_) or die for @ARGV;
 		exit 1 if $ARGV[0] <=3D $ARGV[1];
@@ -168,7 +168,7 @@ test_expect_success \
     } >current &&
     test_cmp expect current'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     'use packed deltified (OFS_DELTA) objects' \
     'GIT_OBJECT_DIRECTORY=3D.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
@@ -185,7 +185,7 @@ test_expect_success \
=20
 unset GIT_OBJECT_DIRECTORY
=20
-test_expect_success 'survive missing objects/pack directory' '
+test_expect_success !PACKV4 'survive missing objects/pack directory' '
 	(
 		rm -fr missing-pack &&
 		mkdir missing-pack &&
@@ -205,14 +205,17 @@ test_expect_success 'survive missing objects/pack=
 directory' '
 test_expect_success \
     'verify pack' \
     'git verify-pack	test-1-${packname_1}.idx \
-			test-2-${packname_2}.idx \
-			test-3-${packname_3}.idx'
+			test-2-${packname_2}.idx'
=20
 test_expect_success \
     'verify pack -v' \
     'git verify-pack -v	test-1-${packname_1}.idx \
-			test-2-${packname_2}.idx \
-			test-3-${packname_3}.idx'
+			test-2-${packname_2}.idx'
+
+test_expect_success !PACKV4 \
+    'verify ofs pack' \
+    'git verify-pack	test-3-${packname_3}.idx
+     git verify-pack -v test-3-${packname_3}.idx'
=20
 test_expect_success \
     'verify-pack catches mismatched .idx and .pack files' \
@@ -277,14 +280,16 @@ test_expect_success \
      git index-pack test-3.pack &&
      cmp test-3.idx test-2-${packname_2}.idx &&
=20
-     cat test-3-${packname_3}.pack >test-3.pack &&
-     git index-pack -o tmp.idx test-3-${packname_3}.pack &&
-     cmp tmp.idx test-3-${packname_3}.idx &&
-
-     git index-pack test-3.pack &&
-     cmp test-3.idx test-3-${packname_3}.idx &&
+     if ! test_have_prereq PACKV4
+     then
+	cat test-3-${packname_3}.pack >test-3.pack &&
+	git index-pack -o tmp.idx test-3-${packname_3}.pack &&
+	cmp tmp.idx test-3-${packname_3}.idx &&
=20
-     :'
+	git index-pack test-3.pack &&
+	cmp test-3.idx test-3-${packname_3}.idx
+     fi
+     '
=20
 test_expect_success 'unpacking with --strict' '
=20
--=20
1.8.2.83.gc99314b
