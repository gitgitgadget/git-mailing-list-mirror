From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t7810: test git grep --no-index from a bare repository
Date: Fri, 23 Jul 2010 07:22:52 +0700
Message-ID: <1279844572-17780-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 00:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4Sj-0004Cl-PI
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 00:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab0GVWlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 18:41:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49986 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0GVWlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 18:41:51 -0400
Received: by pvc7 with SMTP id 7so3238507pvc.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Llez14PWNyc1Ox5KWAQrPc9Z3vgiR+fygnPMqzUI4jI=;
        b=ijpAiKampTecxXmgDlaY9QAngc5kN/QVpBSfSbCdBP4GmSZB9Zq8xJYsTRFlc06qmq
         b+oZldDKcf850hRvQsmyszhxMn/Ivn5Suiz+i7jNANuV5bjm/2SOZe7wMovrL81HpCG0
         ab0qh7xgM5m4ZFhkppfwxn4ZYMAXoYyLC4ukk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=XnCu5o8nS3BnMt/eRda3DkdMY9PxZoOQkuPcWsHOa8WKrWvMaT4FejNWGSEgNGGGwr
         vQHY2Muzte7Vt4FQ5prjW6w9xDIU/Nr28x3sGdsYdLSdn7Me2SN5szO7tBYq193LzXt8
         u1PGkaWsEA61FQ07WMzvlqtNlMJwfTtaccwfI=
Received: by 10.114.110.10 with SMTP id i10mr4117071wac.70.1279838511302;
        Thu, 22 Jul 2010 15:41:51 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm88038401waj.22.2010.07.22.15.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 15:41:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 23 Jul 2010 07:22:53 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151491>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

If git grep --no-index is to be a general-purpose replacement for
standard grep, then it should work even for examining the content of a
=2Egit directory.  The current implementation has some problems:

 * .git/info/exclude is honored though it shouldn=E2=80=99t be
 * when run from within a .git directory, grep --no-index searches
   the entire .git directory instead of just directories below
   the current working directory.

The last few tests (which demonstrate that grep --no-index looks for
=2Egit/info/exclude even when no repository is involved) are by Duy.
Any bugs in the other tests are my fault.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 The original version. Good thing anyway, with or without tp/setup seri=
es.

 t/t7810-grep.sh |  116 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8a63227..7329433 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -494,6 +494,98 @@ test_expect_success 'inside git repository but wit=
h --no-index' '
 	)
 '
=20
+test_expect_success 'set up bare repository' '
+
+	rm -fr bare &&
+	mkdir -p bare/basis/sub &&
+	echo hello >bare/basis/file1 &&
+	echo world >bare/basis/sub/file2 &&
+	echo ".*o*" >bare/basis/.gitignore &&
+	(
+		cd bare/basis &&
+		git init &&
+		git ls-files --other | git update-index --add --stdin &&
+		tree=3D$(git write-tree) &&
+		commit=3D$(printf "basis\n" | git commit-tree "$tree") &&
+		git update-ref -m init refs/heads/master "$commit" &&
+		git update-index --refresh &&
+		git diff-index --exit-code HEAD
+	) &&
+	git clone --no-checkout --bare bare/basis bare/d.git &&
+	mkdir -p bare/d.git/sub &&
+	echo olleh >bare/d.git/fich1 &&
+	echo dlrow >bare/d.git/sub/file2 &&
+	echo "file2" >bare/d.git/.gitignore &&
+	echo "o*" >>bare/d.git/.gitignore
+	{
+		echo "HEAD:.gitignore:.*o*" &&
+		echo HEAD:file1:hello &&
+		echo HEAD:sub/file2:world
+	} >bare/expect.full &&
+	: >bare/expect.empty &&
+	echo file2:dlrow >bare/expect.sub
+'
+
+test_expect_success 'in bare repo, grep without --no-index or --cached=
 fails' '
+	(
+		cd bare/d.git &&
+		test_must_fail git grep o >../actual.plain 2>../actual.msg &&
+		grep "work tree" ../actual.msg &&
+		test_cmp ../expect.empty ../actual.plain &&
+		cd sub &&
+		test_must_fail git grep o >../../actual.sub 2>../../actual.msg &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		grep "work tree" ../../actual.msg
+	)
+'
+
+test_expect_success 'in bare repo, --cached and HEAD ignore working di=
r' '
+
+	(
+		cd bare/d.git &&
+		test_must_fail git grep --cached o >../actual.cached 2>../actual.msg=
 &&
+		test_cmp ../expect.empty ../actual.cached &&
+		! grep fatal ../actual.msg &&
+		git grep -e o HEAD >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep o >../../actual.sub 2>../../actual.msg &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		git grep -e o HEAD >../../actual.full-sub &&
+		test_cmp ../../expect.full ../../actual.full-sub
+	)
+'
+
+test_expect_success '--no-index from a bare repository' '
+	rm -f bare/d.git/info/exclude &&
+	(
+		cd bare/d.git &&
+		git grep --no-index o >../actual.noindex &&
+		grep "^fich1:olleh\$" ../actual.noindex &&
+		grep "^.gitignore:o[*]\$" ../actual.noindex &&
+		! grep file2 ../actual.noindex
+	)
+'
+
+test_expect_failure '--no-index from a subdirectory of a bare reposito=
ry' '
+	(
+		cd bare/d.git/sub &&
+		git grep --no-index o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
+test_expect_failure '--no-index neglects info/exclude in bare repo' '
+	echo "fich1" >bare/d.git/info/exclude &&
+	(
+		cd bare/d.git &&
+		git grep --no-index o >../actual.noindex &&
+		grep "^fich1:olleh\$" ../actual.noindex &&
+		grep "^.gitignore:o[*]\$" ../actual.noindex &&
+		! grep file2 ../actual.noindex
+	)
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
@@ -527,4 +619,28 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'Setup fake .git' '
+	cd t &&
+	GIT_CEILING_DIRECTORIES=3D"`pwd`" &&
+	export GIT_CEILING_DIRECTORIES &&
+	cd a &&
+	mkdir -p .git/info &&
+	cd ../..
+
+'
+
+test_expect_failure 'Ignore fake .git/info/exclude' '
+	(
+		cd t/a &&
+		echo v > .git/info/exclude &&
+		git grep --no-index vvv . &&
+		rm .git/info/exclude
+	)
+'
+
+test_expect_success 'Unsetup fake .git' '
+	rm -rf t/a &&
+	unset GIT_CEILING_DIRECTORIES
+'
+
 test_done
--=20
1.7.1.rc1.69.g24c2f7
