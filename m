From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 7/7] t/t3300-funny-names: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:10 +0000
Message-ID: <1281553450-26467-8-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbT-00034v-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460Ab0HKTEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:36 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56245 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758444Ab0HKTEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:34 -0400
Received: by wwf26 with SMTP id 26so5386240wwf.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GDjbwUlc9IbFDXx4GsGpOGYqLDn5UrtauJ3Vljvs2yY=;
        b=Fx2abbW6D5ZMRGNMuegFZhw9BqG4FjB84+FyvxJlkqyhgZ/KVZQ2Od6nvKSu78a57p
         FAIxy6hA+pHitYlRy1Ukzg2ZAAtEAh8vIymxCveCKoAYMgylk7sg6Og6hUL5Qznjmkmb
         jz5g5CX77zS0xA92FZIzLxtwhMV+08g8V0/sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=W9SQNT3Sb0K3j4UifaUJN9DEw0zEH0Ibnq4TsMUi4Da5vwU39WKsBPaJTZ9FUvDij2
         CNA4wrwZU65blR0cccwwKoNgMNsPNOOqACozdptTi4kSR+SGpknYoj9mxcC4YvZTwLCE
         EXZ3Y7UXfmFhyCmCnNq+HNq4A2onn9oqIoOBU=
Received: by 10.227.157.198 with SMTP id c6mr16879294wbx.144.1281553472225;
        Wed, 11 Aug 2010 12:04:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153284>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3300-funny-names.sh |   82 +++++++++++++++++++++++++++++++++++-----=
--------
 1 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index a99e4d8..f39a261 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -24,19 +24,25 @@ EOF
 cat 2>/dev/null >"$p1" "$p0"
 echo 'Foo Bar Baz' >"$p2"
=20
-test -f "$p1" && cmp "$p0" "$p1" || {
+if test -f "$p1" && cmp "$p0" "$p1"
+then
+    test_set_prereq TABS_IN_FILENAMES
+else
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
-	test_done
-}
+	say 'Your filesystem does not allow tabs in filenames'
+fi
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' "
 echo 'just space
 no-funny' >expected
-test_expect_success 'git ls-files no-funny' \
+"
+
+test_expect_success TABS_IN_FILENAMES 'git ls-files no-funny' \
 	'git update-index --add "$p0" "$p2" &&
 	git ls-files >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 t0=3D`git write-tree`
 echo "$t0" >t0
=20
@@ -45,18 +51,24 @@ just space
 no-funny
 "tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git ls-files with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git ls-files with-funny' \
 	'git update-index --add "$p1" &&
 	git ls-files >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' "
 echo 'just space
 no-funny
-tabs	," (dq) and spaces' >expected
-test_expect_success 'git ls-files -z with-funny' \
+tabs	,\" (dq) and spaces' >expected
+"
+
+test_expect_success TABS_IN_FILENAMES 'git ls-files -z with-funny' \
 	'git ls-files -z | perl -pe y/\\000/\\012/ >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 t1=3D`git write-tree`
 echo "$t1" >t1
=20
@@ -65,60 +77,78 @@ just space
 no-funny
 "tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git ls-tree with funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git ls-tree with funny' \
 	'git ls-tree -r $t1 | sed -e "s/^[^	]*	//" >current &&
 	 test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
 A	"tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git diff-index with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-index with-funny' \
 	'git diff-index --name-status $t0 >current &&
 	test_cmp expected current'
=20
-test_expect_success 'git diff-tree with-funny' \
+test_expect_success TABS_IN_FILENAMES 'git diff-tree with-funny' \
 	'git diff-tree --name-status $t0 $t1 >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' "
 echo 'A
-tabs	," (dq) and spaces' >expected
-test_expect_success 'git diff-index -z with-funny' \
+tabs	,\" (dq) and spaces' >expected
+"
+
+test_expect_success TABS_IN_FILENAMES 'git diff-index -z with-funny' \
 	'git diff-index -z --name-status $t0 | perl -pe y/\\000/\\012/ >curre=
nt &&
 	test_cmp expected current'
=20
-test_expect_success 'git diff-tree -z with-funny' \
+test_expect_success TABS_IN_FILENAMES 'git diff-tree -z with-funny' \
 	'git diff-tree -z --name-status $t0 $t1 | perl -pe y/\\000/\\012/ >cu=
rrent &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
 CNUM	no-funny	"tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git diff-tree -C with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree -C with-funny' \
 	'git diff-tree -C --find-copies-harder --name-status \
 		$t0 $t1 | sed -e 's/^C[0-9]*/CNUM/' >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
 RNUM	no-funny	"tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git diff-tree delete with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny=
' \
 	'git update-index --force-remove "$p0" &&
 	git diff-index -M --name-status \
 		$t0 | sed -e 's/^R[0-9]*/RNUM/' >current &&
 	test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
 diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
 similarity index NUM%
 rename from no-funny
 rename to "tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git diff-tree delete with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny=
' \
 	'git diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
 	 test_cmp expected current'
=20
-chmod +x "$p1"
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
+chmod +x "$p1" &&
 cat > expected <<\EOF
 diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
 old mode 100644
@@ -127,31 +157,39 @@ similarity index NUM%
 rename from no-funny
 rename to "tabs\t,\" (dq) and spaces"
 EOF
-test_expect_success 'git diff-tree delete with-funny' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny=
' \
 	'git diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
 	 test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat >expected <<\EOF
  "tabs\t,\" (dq) and spaces"
  1 files changed, 0 insertions(+), 0 deletions(-)
 EOF
-test_expect_success 'git diff-tree rename with-funny applied' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree rename with-funny=
 applied' \
 	'git diff-index -M -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
 	 test_cmp expected current'
=20
+test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
  no-funny
  "tabs\t,\" (dq) and spaces"
  2 files changed, 3 insertions(+), 3 deletions(-)
 EOF
-test_expect_success 'git diff-tree delete with-funny applied' \
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny=
 applied' \
 	'git diff-index -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
 	 test_cmp expected current'
=20
-test_expect_success 'git apply non-git diff' \
+test_expect_success TABS_IN_FILENAMES 'git apply non-git diff' \
 	'git diff-index -p $t0 |
 	 sed -ne "/^[-+@]/p" |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
--=20
1.7.2.1.295.gdf931
