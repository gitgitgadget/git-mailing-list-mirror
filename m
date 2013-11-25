From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] test: make FILEMODE a lazy prereq
Date: Mon, 25 Nov 2013 13:02:16 -0800
Message-ID: <20131125210216.GX4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 22:02:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3IW-000489-B5
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab3KYVCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 16:02:20 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:42910 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3KYVCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:02:19 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2013 16:02:19 EST
Received: by mail-yh0-f45.google.com with SMTP id v1so2286782yhn.32
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MP5NuSUaBy8utqoy6zjKwwIS4vTXHkP0xHh4aSKktk8=;
        b=vUILTUH1H6p0tkiQ2zLgsTpgMBlAanBm0ZjWrcRG+OxAKlI1H745E7NuPOCoH6VVGn
         lQx7oKbk8v6NSsBQw62mfUbsJ9/ZsQnVi+ecTrQSM3MNWGY1GUFHRW4SdXgpqzJncDgZ
         BBxuvd3ngKmXVO46S6FrXqqMEQ1/TvznTXIB2HfVzBHyRuHRMqsLX6SZCJTVQeqp42hz
         B+d9VSFLhWR2uRFa3VkYfcT+yFq6B3SPGq0kSLiPM4uNfzDPGlhzOjpBLE2/6RyNc25/
         wIVf6WMW0xY1xYIh3LDPMO6cPpjg44S+ypN6hjqiww3gBkU2gLsjoVt/eiQJtMKuPjI+
         sU4g==
X-Received: by 10.236.119.102 with SMTP id m66mr21813yhh.90.1385413339080;
        Mon, 25 Nov 2013 13:02:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r64sm16851564yhc.23.2013.11.25.13.02.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 13:02:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238356>

This way, test authors don't need to remember to source
lib-prereq-FILEMODE.sh before using the FILEMODE prereq to guard tests
that rely on the executable bit being honored when checking out files.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/lib-prereq-FILEMODE.sh       | 11 -----------
 t/t3701-add-interactive.sh     |  1 -
 t/t4102-apply-rename.sh        |  1 -
 t/t4120-apply-popt.sh          |  1 -
 t/t4129-apply-samemode.sh      |  1 -
 t/t6031-merge-recursive.sh     |  1 -
 t/t9200-git-cvsexportcommit.sh |  1 -
 t/test-lib.sh                  |  4 ++++
 8 files changed, 4 insertions(+), 17 deletions(-)
 delete mode 100644 t/lib-prereq-FILEMODE.sh

diff --git a/t/lib-prereq-FILEMODE.sh b/t/lib-prereq-FILEMODE.sh
deleted file mode 100644
index bce5a4c..0000000
--- a/t/lib-prereq-FILEMODE.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 =C6var Arnfj=F6r=F0 Bjarmason
-#
-
-if test "$(git config --bool core.filemode)" =3D false
-then
-	say 'filemode disabled on the filesystem'
-else
-	test_set_prereq FILEMODE
-fi
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9dc91d0..24ddd8a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -2,7 +2,6 @@
=20
 test_description=3D'add -i basic tests'
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 if ! test_have_prereq PERL
 then
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index e3ea3d5..49e2d6c 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -7,7 +7,6 @@ test_description=3D'git apply handling copy/rename patc=
h.
=20
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 # setup
=20
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index c5fecdf..497b628 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -6,7 +6,6 @@
 test_description=3D'git apply -p handling.'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 test_expect_success setup '
 	mkdir sub &&
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 0d36ebd..c268298 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -3,7 +3,6 @@
 test_description=3D'applying patch with mode bits'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 test_expect_success setup '
 	echo original >file &&
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 1cd649e..a953f1b 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -2,7 +2,6 @@
=20
 test_description=3D'merge-recursive: handle file mode'
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 test_expect_success 'mode change in one branch: keep changed version' =
'
 	: >file1 &&
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 3fb3368..812c9cd 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -5,7 +5,6 @@
 test_description=3D'Test export of commits to CVS'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 if ! test_have_prereq PERL; then
 	skip_all=3D'skipping git cvsexportcommit tests, perl not available'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b25249e..5968157 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -830,6 +830,10 @@ test_lazy_prereq SYMLINKS '
 	ln -s x y && test -h y
 '
=20
+test_lazy_prereq FILEMODE '
+	test "$(git config --bool core.filemode)" =3D true
+'
+
 test_lazy_prereq CASE_INSENSITIVE_FS '
 	echo good >CamelCase &&
 	echo bad >camelcase &&
--=20
1.8.4.1
