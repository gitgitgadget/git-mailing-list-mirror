From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v5=2012/14=5D=20remote-hg=3A=20add=20biridectional=20tests?=
Date: Tue, 30 Oct 2012 05:35:34 +0100
Message-ID: <1351571736-4682-13-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3ZV-0006d7-Fn
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2J3Egs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 00:36:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2J3Egq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xCpXfnSbCYU9flQYPS5FFK3JeCGIwyXYfwkIn8ekf5U=;
        b=OWNnLxbDzgY5fpUBqQvQHqW+4jgh4igNlYCQZto8eWF/8ixa2FDjSgIXwYhF1LAiw1
         08nu4MjveLe1+i0CLN1DeMcvmvhSblS10ir29CANHCTfnOW97elGi8Vb0rqVa7/96R5T
         JovXFBcj8PVpEAnO+J7Eujo9+jzozJVviInQ1YBzohA+/1Afzqgtl0QWTParmMMTC05i
         c//RGR5ubsZJrGoeje9M3v4muld08W2IooAnpP+y408pwlBPG2Hpa7Mv8E3daO+kEEUl
         LW616/oCrm2xm3tXyIS1BDjkUDNHQ/X/s89SLPrlsDMmt/KRH1r2UYdFxEUO7pTlV3LM
         /+Rw==
Received: by 10.204.9.11 with SMTP id j11mr9530688bkj.135.1351571805748;
        Mon, 29 Oct 2012 21:36:45 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id s20sm5175507bkw.15.2012.10.29.21.36.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208675>

Base commands from hg-git tests:
https://bitbucket.org/durin42/hg-git/src

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/Makefile |  13 +++
 contrib/remote-hg/test.sh  | 241 +++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 contrib/remote-hg/Makefile
 create mode 100755 contrib/remote-hg/test.sh

diff --git a/contrib/remote-hg/Makefile b/contrib/remote-hg/Makefile
new file mode 100644
index 0000000..9a76575
--- /dev/null
+++ b/contrib/remote-hg/Makefile
@@ -0,0 +1,13 @@
+TESTS :=3D $(wildcard test*.sh)
+
+export T :=3D $(addprefix $(CURDIR)/,$(TESTS))
+export MAKE :=3D $(MAKE) -e
+export PATH :=3D $(CURDIR):$(PATH)
+
+test:
+	$(MAKE) -C ../../t $@
+
+$(TESTS):
+	$(MAKE) -C ../../t $(CURDIR)/$@
+
+.PHONY: $(TESTS)
diff --git a/contrib/remote-hg/test.sh b/contrib/remote-hg/test.sh
new file mode 100755
index 0000000..4ea2b24
--- /dev/null
+++ b/contrib/remote-hg/test.sh
@@ -0,0 +1,241 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+# clone to a git repo
+git_clone () {
+	hg -R $1 bookmark -f -r tip master &&
+	git clone -q "hg::$PWD/$1" $2
+}
+
+# clone to an hg repo
+hg_clone () {
+	(
+	hg init $2 &&
+	cd $1 &&
+	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
+	) &&
+
+	(cd $2 && hg -q update)
+}
+
+# push an hg repo
+hg_push () {
+	(
+	cd $2
+	old=3D$(git symbolic-ref --short HEAD)
+	git checkout -q -b tmp &&
+	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
+	git checkout -q $old &&
+	git branch -q -D tmp 2> /dev/null || true
+	)
+}
+
+hg_log () {
+	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+}
+
+test_expect_success 'setup' '
+	(
+	echo "[ui]"
+	echo "username =3D A U Thor <author@example.com>"
+	echo "[defaults]"
+	echo "backout =3D -d \"0 0\""
+	echo "commit =3D -d \"0 0\""
+	echo "debugrawcommit =3D -d \"0 0\""
+	echo "tag =3D -d \"0 0\""
+	) >> "$HOME"/.hgrc &&
+	git config --global remote-hg.hg-git-compat true
+
+	export HGEDITOR=3D/usr/bin/true
+
+	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+'
+
+test_expect_success 'encoding' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add =C3=A4lph=C3=A0" &&
+
+	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+
+	echo gamma > gamma &&
+	git add gamma &&
+	git commit -m "add g=C3=A4mm=C3=A2" &&
+
+	: TODO git config i18n.commitencoding latin-1 &&
+	echo delta > delta &&
+	git add delta &&
+	git commit -m "add d=C3=A9lt=C3=A0"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
+	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file removal' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta"
+	mkdir foo &&
+	echo blah > foo/bar &&
+	git add foo &&
+	git commit -m "add foo" &&
+	git rm alpha &&
+	git commit -m "remove alpha" &&
+	git rm foo/bar &&
+	git commit -m "remove foo/bar"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'git tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	git config receive.denyCurrentBranch ignore &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git tag alpha &&
+
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+	git tag -a -m "added tag beta" beta
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg branch' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -q -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg -q co master &&
+	hg mv alpha beta &&
+	hg -q commit -m "rename alpha to beta" &&
+	hg branch gamma | grep -v "permanent and global" &&
+	hg -q commit -m "started branch gamma"
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	: TODO, avoid "master" bookmark &&
+	(cd hgrepo2 && hg checkout gamma) &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg co master &&
+	hg tag alpha
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_done
--=20
1.8.0
