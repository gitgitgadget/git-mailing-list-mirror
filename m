From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Tue, 21 Aug 2012 11:31:02 +0700
Message-ID: <1345523464-14586-6-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3g8k-0006ui-JX
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab2HUEcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:32:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62578 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab2HUEcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:32:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so7914089pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oE2KmHCasWOn/yUcXjY0IXziSy9nm7j5klvZ9AAwHJ0=;
        b=UAkgk1VbTyzxItmmQy9Z7+czTWXhPnjCCi8wU6PGHHFJ/PTuoODETHvAtoOvaEOa8H
         iZ66aaM5rA/OAQid+y94SPEER3Ar62DiwyVZDCZjFmAVxR98UtiB4Jmcy9NUhOaWr+FD
         D8mYvoz7CCRwX9vNvMZeboPWf+GmFY6oAnaM0UpfdyDdbg4QObhGbI6qXpGoCb28oVAP
         FhWklYelnYlYm+qa+HAMy90Bz/ilO3PoITwtqH6J989905L/77+EAoAKDtxlKpK3ABak
         BOByJv5RJf1AzZLEUr768VOKQ6jI8spRlZgjWoBufyEB+gxzCiCPvLxRmFWrJthxwhkq
         3Jtw==
Received: by 10.68.228.193 with SMTP id sk1mr40416833pbc.97.1345523538029;
        Mon, 20 Aug 2012 21:32:18 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id kt2sm563077pbc.73.2012.08.20.21.32.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:32:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:32:02 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203929>

=46rom: Jiang Xin <worldhello.net@gmail.com>

Use i18n-specific test functions in test scripts for pack-object.
This issue was was introduced in v1.7.10.2-556-g46140:

    46140 index-pack: use streaming interface for collision test on lar=
ge blobs
    cf2ba pack-objects: use streaming interface for reading large loose=
 blobs

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5300-pack-object.sh       | 4 ++--
 t/t5530-upload-pack-error.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2e52f8b..a07c871 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -416,11 +416,11 @@ test_expect_success \
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
     'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
-     grep "SHA1 COLLISION FOUND" msg'
+     test_i18ngrep "SHA1 COLLISION FOUND" msg'
=20
 test_expect_success \
     'make sure index-pack detects the SHA1 collision (large blobs)' \
     'test_must_fail git -c core.bigfilethreshold=3D1 index-pack -o bad=
=2Eidx test-3.pack 2>msg &&
-     grep "SHA1 COLLISION FOUND" msg'
+     test_i18ngrep "SHA1 COLLISION FOUND" msg'
=20
 test_done
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.s=
h
index 6b2a5f4..99f8dbc 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -35,7 +35,7 @@ test_expect_success 'upload-pack fails due to error i=
n pack-objects packing' '
 	printf "0032want %s\n00000009done\n0000" \
 		$(git rev-parse HEAD) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	grep "unable to read" output.err &&
+	test_i18ngrep "unable to read" output.err &&
 	grep "pack-objects died" output.err
 '
=20
--=20
1.7.12.rc2
