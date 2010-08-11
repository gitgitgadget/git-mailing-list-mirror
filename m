From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 6/7] t/t3902-quoted: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:09 +0000
Message-ID: <1281553450-26467-7-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbU-00034v-BC
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461Ab0HKTEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34485 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab0HKTEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:32 -0400
Received: by wwj40 with SMTP id 40so479780wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x8J32FNMG1izw80GHNyT+1ZHljcvwKrMytaJ5uU+HEY=;
        b=Zls6UnrlOONfxl/hGxsVs3PjyUuGwvQY26+sk+5+f2FM4xLs64U1fjip14XiONLrhV
         K/imqvhl2tvuA+DunuFWSa9gbXib5atYJHjFDRNIPKq/dhlDquQIUhxy4tYBRYXfgwJp
         TTjn3sogWd9/qdl5cWEeOf3f1y86b1CyrBFLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DXVgndLCiGRI3MUQUKReNdRvg8WKuqjI9ZZxlUXfasjxPDVl/ZWtyCliZDUy1PJH9t
         5mr1dif4QPjEuuLzIM6i5pDhz3AlTU4gA8EE7H+X/XLjJ8/oEFuYpuea5bnqrK4NKn7A
         DTkSzDtK4sQGS/GurMTfzXoFQv2EJi9jtM+NQ=
Received: by 10.227.156.212 with SMTP id y20mr17084525wbw.142.1281553471589;
        Wed, 11 Aug 2010 12:04:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153286>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3902-quoted.sh |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 147e634..7d49469 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -15,11 +15,13 @@ LF=3D'
 DQ=3D'"'
=20
 echo foo 2>/dev/null > "Name and an${HT}HT"
-test -f "Name and an${HT}HT" || {
-	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
-	test_done
-}
+if ! test -f "Name and an${HT}HT"
+then
+	# FAT/NTFS does not allow tabs in filenames
+	say 'Your filesystem does not allow tabs in filenames'
+else
+	test_set_prereq TABS_IN_FILENAMES
+fi
=20
 for_each_name () {
 	for name in \
@@ -31,7 +33,7 @@ for_each_name () {
 	done
 }
=20
-test_expect_success setup '
+test_expect_success TABS_IN_FILENAMES 'setup' '
=20
 	mkdir "$FN" &&
 	for_each_name "echo initial >\"\$name\""
@@ -45,6 +47,7 @@ test_expect_success setup '
=20
 '
=20
+test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect.quoted <<\EOF
 Name
 "Name and a\nLF"
@@ -72,75 +75,76 @@ With SP in it
 =E6=BF=B1=E9=87=8E/file
 =E6=BF=B1=E9=87=8E=E7=B4=94
 EOF
+'
=20
-test_expect_success 'check fully quoted output from ls-files' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
ls-files' '
=20
 	git ls-files >current && test_cmp expect.quoted current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-files' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-files' '
=20
 	git diff --name-only >current &&
 	test_cmp expect.quoted current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-index' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-index' '
=20
 	git diff --name-only HEAD >current &&
 	test_cmp expect.quoted current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-tree' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-tree' '
=20
 	git diff --name-only HEAD^ HEAD >current &&
 	test_cmp expect.quoted current
=20
 '
=20
-test_expect_success 'check fully quoted output from ls-tree' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
ls-tree' '
=20
 	git ls-tree --name-only -r HEAD >current &&
 	test_cmp expect.quoted current
=20
 '
=20
-test_expect_success 'setting core.quotepath' '
+test_expect_success TABS_IN_FILENAMES 'setting core.quotepath' '
=20
 	git config --bool core.quotepath false
=20
 '
=20
-test_expect_success 'check fully quoted output from ls-files' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
ls-files' '
=20
 	git ls-files >current && test_cmp expect.raw current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-files' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-files' '
=20
 	git diff --name-only >current &&
 	test_cmp expect.raw current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-index' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-index' '
=20
 	git diff --name-only HEAD >current &&
 	test_cmp expect.raw current
=20
 '
=20
-test_expect_success 'check fully quoted output from diff-tree' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
diff-tree' '
=20
 	git diff --name-only HEAD^ HEAD >current &&
 	test_cmp expect.raw current
=20
 '
=20
-test_expect_success 'check fully quoted output from ls-tree' '
+test_expect_success TABS_IN_FILENAMES 'check fully quoted output from =
ls-tree' '
=20
 	git ls-tree --name-only -r HEAD >current &&
 	test_cmp expect.raw current
--=20
1.7.2.1.295.gdf931
