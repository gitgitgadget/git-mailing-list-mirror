From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] t1302 (core.repositoryversion): style tweaks
Date: Mon, 6 Sep 2010 20:52:27 -0500
Message-ID: <20100907015227.GF1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnOJ-0000K2-G9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0IGBy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 21:54:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61379 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0IGBy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 21:54:26 -0400
Received: by gxk23 with SMTP id 23so1787196gxk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QfL3AHILAOShMfsx8VF3+8vGpk1wREwBMqnk8ZHrmzs=;
        b=BEAKtCVoA749qL3SQrcR9EibYMVsRe3skYdwFG6o4hj4QDjM0hmXn68TWkbtp9NYXr
         pO3uQzb6FpGDuAAhD0lsiE8ykfu4CdbztPiK98icJhz+s4P20E9921rTe9pN6bi9LpPv
         5cKWhbfteUbVjORdRKdLmOjY4VwqGmQbRaAdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VbYX5/e2nFbDXgp/2jMQJyXbz+2vwICk1YI/LIvv/5A0bR4NYV1lsJMaULBHWZtu3a
         GdkMSEmYrUOUFBkFMDQnEcv37Q3zpXujm6yasnK44DgwVXxpL/O08OERCjsZBy31myuT
         LW8v+iw3La2/SFqQi9KSG2guQn35YXKqt+44g=
Received: by 10.100.25.23 with SMTP id 23mr470177any.225.1283824465392;
        Mon, 06 Sep 2010 18:54:25 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c19sm10333066ana.22.2010.09.06.18.54.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155663>

This test is from 2007, which is late enough for the style to be
recognizably modern but still a while ago.  Freshen it up to
follow new best practices:

 - guard setup commands with test_expect_setup, so errors at
   that stage can be caught;
 - use <<\EOF in preference to <<EOF, to save reviewers the
   trouble of looking for variable interpolations;
 - use test_cmp instead of test "$foo" =3D "$bar", for better
   output with -v on failure;
 - indent commands in subshells and let them span multiple lines;
 - combine the two "gitdir required mode" tests that do not make
   as much sense alone.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1302-repo-version.sh |   64 +++++++++++++++++++++++++++++----------=
-------
 1 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 0da2799..a6bf1bf 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -7,29 +7,41 @@ test_description=3D'Test repository version check'
=20
 . ./test-lib.sh
=20
-cat >test.patch <<EOF
-diff --git a/test.txt b/test.txt
-new file mode 100644
---- /dev/null
-+++ b/test.txt
-@@ -0,0 +1 @@
-+123
-EOF
+test_expect_success 'setup' '
+	cat >test.patch <<-\EOF &&
+	diff --git a/test.txt b/test.txt
+	new file mode 100644
+	--- /dev/null
+	+++ b/test.txt
+	@@ -0,0 +1 @@
+	+123
+	EOF
=20
-test_create_repo "test"
-test_create_repo "test2"
-
-GIT_CONFIG=3Dtest2/.git/config git config core.repositoryformatversion=
 99 || exit 1
+	test_create_repo "test" &&
+	test_create_repo "test2" &&
+	GIT_CONFIG=3Dtest2/.git/config git config core.repositoryformatversio=
n 99
+'
=20
 test_expect_success 'gitdir selection on normal repos' '
-	(test "$(git config core.repositoryformatversion)" =3D 0 &&
-	cd test &&
-	test "$(git config core.repositoryformatversion)" =3D 0)'
+	echo 0 >expect &&
+	git config core.repositoryformatversion >actual &&
+	(
+		cd test &&
+		git config core.repositoryformatversion >../actual2
+	) &&
+	test_cmp expect actual &&
+	test_cmp expect actual2
+'
=20
-# Make sure it would stop at test2, not trash
 test_expect_success 'gitdir selection on unsupported repo' '
-	(cd test2 &&
-	test "$(git config core.repositoryformatversion)" =3D 99)'
+	# Make sure it would stop at test2, not trash
+	echo 99 >expect &&
+	(
+		cd test2 &&
+		git config core.repositoryformatversion >../actual
+	)
+	test_cmp expect actual
+'
=20
 test_expect_success 'gitdir not required mode' '
 	git apply --stat test.patch &&
@@ -43,12 +55,16 @@ test_expect_success 'gitdir not required mode' '
 	)
 '
=20
-test_expect_success 'gitdir required mode on normal repos' '
-	(git apply --check --index test.patch &&
-	cd test && git apply --check --index ../test.patch)'
-
-test_expect_success 'gitdir required mode on unsupported repo' '
-	(cd test2 && test_must_fail git apply --check --index ../test.patch)
+test_expect_success 'gitdir required mode' '
+	git apply --check --index test.patch &&
+	(
+		cd test &&
+		git apply --check --index ../test.patch
+	) &&
+	(
+		cd test2 &&
+		test_must_fail git apply --check --index ../test.patch
+	)
 '
=20
 test_done
--=20
1.7.2.3
