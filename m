From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/10] t/t9600-cvsimport.sh: change from skip_all=* to prereq skip
Date: Fri, 13 Aug 2010 20:40:07 +0000
Message-ID: <1281732013-18284-5-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok147-0007V9-6B
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0HMUlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab0HMUlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:05 -0400
Received: by wyb32 with SMTP id 32so3042025wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WCgMk+hqGelTsAoDmjjirNinr3GJ0At1scfwtTeix7U=;
        b=LRvMWwAaM5D6xVn6+eFk2AnI1t/3WYdOQcWPbvvNSwIpQBIc1OJPwZ8+6X24GEwfmd
         hj1MG1Et/ockEeNleZ2zTnaiFBRkDAkYDapnn06pzwUQ5PvnKbDmm7MDCv0HVdN7TIlt
         Bc5gVWRNN3yLl98SE1f6F1TtUaXq3qsvLo/5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VeowYkqjYvAr7PjfAiJG+nDRr9J8oc+mA5JXCJn8ODDBtMC93DhLaJHytbKmcXlHOL
         EENJWyZWoKLLW/H93iI9lRosQZUsnv0HcDLXNUWgEmr7Xjb1W2IPLMo2jQkzjSkG0e+e
         5NiRoxa437blUKi87J7VhES2RWc1FhF2e3arQ=
Received: by 10.216.11.129 with SMTP id 1mr125385wex.90.1281732064007;
        Fri, 13 Aug 2010 13:41:04 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153493>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9600-cvsimport.sh |   39 ++++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 2eff9cd..559ce41 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,17 +3,14 @@
 test_description=3D'git cvsimport basic tests'
 . ./lib-cvs.sh
=20
-if ! test_have_prereq PERL; then
-	skip_all=3D'skipping git cvsimport tests, perl not available'
-	test_done
-fi
-
-CVSROOT=3D$(pwd)/cvsroot
-export CVSROOT
+test_expect_success PERL 'setup cvsroot environment' '
+	CVSROOT=3D$(pwd)/cvsroot &&
+	export CVSROOT
+'
=20
-test_expect_success 'setup cvsroot' '$CVS init'
+test_expect_success PERL 'setup cvsroot' '$CVS init'
=20
-test_expect_success 'setup a cvs module' '
+test_expect_success PERL 'setup a cvs module' '
=20
 	mkdir "$CVSROOT/module" &&
 	$CVS co -d module-cvs module &&
@@ -45,23 +42,23 @@ EOF
 	cd ..
 '
=20
-test_expect_success 'import a trivial module' '
+test_expect_success PERL 'import a trivial module' '
=20
 	git cvsimport -a -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
=20
 '
=20
-test_expect_success 'pack refs' 'cd module-git && git gc && cd ..'
+test_expect_success PERL 'pack refs' 'cd module-git && git gc && cd ..=
'
=20
-test_expect_success 'initial import has correct .git/cvs-revisions' '
+test_expect_success PERL 'initial import has correct .git/cvs-revision=
s' '
=20
 	(cd module-git &&
 	 git log --format=3D"o_fortuna 1.1 %H" -1) > expected &&
 	test_cmp expected module-git/.git/cvs-revisions
 '
=20
-test_expect_success 'update cvs module' '
+test_expect_success PERL 'update cvs module' '
=20
 	cd module-cvs &&
 	cat <<EOF >o_fortuna &&
@@ -90,7 +87,7 @@ EOF
 	cd ..
 '
=20
-test_expect_success 'update git module' '
+test_expect_success PERL 'update git module' '
=20
 	cd module-git &&
 	git cvsimport -a -R -z 0 module &&
@@ -100,7 +97,7 @@ test_expect_success 'update git module' '
=20
 '
=20
-test_expect_success 'update has correct .git/cvs-revisions' '
+test_expect_success PERL 'update has correct .git/cvs-revisions' '
=20
 	(cd module-git &&
 	 git log --format=3D"o_fortuna 1.1 %H" -1 HEAD^ &&
@@ -108,7 +105,7 @@ test_expect_success 'update has correct .git/cvs-re=
visions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
=20
-test_expect_success 'update cvs module' '
+test_expect_success PERL 'update cvs module' '
=20
 	cd module-cvs &&
 		echo 1 >tick &&
@@ -118,7 +115,7 @@ test_expect_success 'update cvs module' '
=20
 '
=20
-test_expect_success 'cvsimport.module config works' '
+test_expect_success PERL 'cvsimport.module config works' '
=20
 	cd module-git &&
 		git config cvsimport.module module &&
@@ -129,7 +126,7 @@ test_expect_success 'cvsimport.module config works'=
 '
=20
 '
=20
-test_expect_success 'second update has correct .git/cvs-revisions' '
+test_expect_success PERL 'second update has correct .git/cvs-revisions=
' '
=20
 	(cd module-git &&
 	 git log --format=3D"o_fortuna 1.1 %H" -1 HEAD^^ &&
@@ -138,7 +135,7 @@ test_expect_success 'second update has correct .git=
/cvs-revisions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
=20
-test_expect_success 'import from a CVS working tree' '
+test_expect_success PERL 'import from a CVS working tree' '
=20
 	$CVS co -d import-from-wt module &&
 	cd import-from-wt &&
@@ -150,12 +147,12 @@ test_expect_success 'import from a CVS working tr=
ee' '
=20
 '
=20
-test_expect_success 'no .git/cvs-revisions created by default' '
+test_expect_success PERL 'no .git/cvs-revisions created by default' '
=20
 	! test -e import-from-wt/.git/cvs-revisions
=20
 '
=20
-test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
+test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree mast=
er'
=20
 test_done
--=20
1.7.2.1.338.gf2379
