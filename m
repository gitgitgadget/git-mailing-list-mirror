From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/17] t5302: disable sealth corruption tests when run with --packv4
Date: Sat, 21 Sep 2013 20:58:00 +0700
Message-ID: <1379771883-10278-15-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:56:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNfN-0001y9-3C
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab3IUN4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:56:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45043 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUN4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:56:02 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so531671pad.35
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dyG+diBQpzPnOcX+NeMl9dBbD79/v+Ptnrqbq/mJBVc=;
        b=O/wK/i6386lC29fL9fMgMrnCT5p+RHrDuRxVaVpRxj5+OMKsbEiyIZaUa+CMY9aVbE
         woteVP3Uu8tqN0NephM8RG/r7qaEE3CqD0JUrWKCZkl7dicl2hkEvOv2UwtLycmrxAkl
         WnzFBRf4g535LDKc7+fA/QFfZAMVJLKEs7VGPMW+b320EYJ7B8ETkAzwwvM+4JypQPAf
         f8VJWK41pyePUSwOhQpDwDmi26QFVDzgy0gC7Mc/ZRfAgeyR5x/KS2LPmu8pPrBB/lHf
         ocnanpQxpXpS1kQUVYqNfjlIs/zrS5Ph0YFIpY3No7uslVyvQzOrt5DRD9glgQ5pCu6o
         7ntg==
X-Received: by 10.66.164.136 with SMTP id yq8mr14288084pab.67.1379771762285;
        Sat, 21 Sep 2013 06:56:02 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ef10sm25729011pac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:56:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235115>

These tests assume .pack v2 format and won't work with v4. New tests
may be needed to do the same thing with v4 format.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5302-pack-index.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index fe82025..2f99cd1 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -140,7 +140,7 @@ index_obj_offset()
     ( read offs extra && echo "$offs" )
 }
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 1) stream pack to repository' \
     'git index-pack --index-version=3D1 --stdin < "test-1-${pack1}.pac=
k" &&
      git prune-packed &&
@@ -148,7 +148,7 @@ test_expect_success \
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack"=
 &&
      cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 2) create a stealth corruption in a delta base referen=
ce' \
     '# This test assumes file_101 is a delta smaller than 16 bytes.
      # It should be against file_100 but we substitute its base for fi=
le_099
@@ -163,24 +163,24 @@ test_expect_success \
         bs=3D1 count=3D20 conv=3Dnotrunc &&
      git cat-file blob $sha1_101 > file_101_foo1'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 3) corrupted delta happily returned wrong data' \
     'test -f file_101_foo1 && ! cmp file_101 file_101_foo1'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 4) confirm that the pack is actually corrupted' \
     'test_must_fail git fsck --full $commit'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 5) pack-objects happily reuses corrupted data' \
     'pack4=3D$(git pack-objects test-4 <obj-list) &&
      test -f "test-4-${pack1}.pack"'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v1] 6) newly created pack is BAD !' \
     'test_must_fail git verify-pack -v "test-4-${pack1}.pack"'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 1) stream pack to repository' \
     'rm -f .git/objects/pack/* &&
      git index-pack --index-version=3D2 --stdin < "test-1-${pack1}.pac=
k" &&
@@ -189,7 +189,7 @@ test_expect_success \
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack"=
 &&
      cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 2) create a stealth corruption in a delta base referen=
ce' \
     '# This test assumes file_101 is a delta smaller than 16 bytes.
      # It should be against file_100 but we substitute its base for fi=
le_099
@@ -204,20 +204,20 @@ test_expect_success \
         bs=3D1 count=3D20 conv=3Dnotrunc &&
      git cat-file blob $sha1_101 > file_101_foo2'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 3) corrupted delta happily returned wrong data' \
     'test -f file_101_foo2 && ! cmp file_101 file_101_foo2'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 4) confirm that the pack is actually corrupted' \
     'test_must_fail git fsck --full $commit'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
     'test_must_fail git pack-objects test-5 <obj-list &&
      test_must_fail git pack-objects --no-reuse-object test-6 <obj-lis=
t'
=20
-test_expect_success \
+test_expect_success !PACKV4 \
     '[index v2] 6) verify-pack detects CRC mismatch' \
     'rm -f .git/objects/pack/* &&
      git index-pack --index-version=3D2 --stdin < "test-1-${pack1}.pac=
k" &&
--=20
1.8.2.83.gc99314b
