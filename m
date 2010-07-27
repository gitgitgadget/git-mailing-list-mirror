From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/4] t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
Date: Tue, 27 Jul 2010 21:14:12 +0000
Message-ID: <1280265254-19642-4-git-send-email-avarab@gmail.com>
References: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 23:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrUE-0007yl-3I
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0G0VOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 17:14:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42099 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0G0VOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:14:45 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so3597805bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UTfZLNK4upUcRt5F750YKNJXxPeQZdwNw9xFwxbJwBM=;
        b=rMpYKZj72NeW5WxcxFFtk8FaDB1nr1DtDsseJVq/c1/OvUQp9MxqDFMo9Gk5awA5dU
         kMQ+DknzlhHy4276/ushPsnbQfQ1VZ16+E4m42hFHxRj8iha5Yl6Asz5WC0vCWEJMcXP
         xxJ7kCc71qp0YvsDlT1Xc7CphpD3TOSaEJXHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sbjcH8dgELIAOg3GBM2KPWILrp01iSPjw5EnSJOGP/4mHAepYqdjxemqy0ub6OcLC9
         9+5mi8wT/Gzua4xmWGKdwYkW+1sGImQ171pWtDrq8aT4mYzfkJdJwhkUYVMGrQMaj2Q3
         NjIvJNaoXe7vbdFI5tjlSZ0nYqBEXoV+m1W9M=
Received: by 10.204.100.132 with SMTP id y4mr7030277bkn.117.1280265283338;
        Tue, 27 Jul 2010 14:14:43 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id y2sm4172562bkx.20.2010.07.27.14.14.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:14:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151993>

Change the t/t5800-remote-helpers.sh test to skip with the the
three-arg prereq form of test_expect_success instead of bailing out.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5800-remote-helpers.sh |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 637d8e9..1fb6380 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -13,13 +13,11 @@ if sys.hexversion < 0x02040000:
     sys.exit(1)
 '
 then
-	:
-else
-	skip_all=3D'skipping git remote-testgit tests: requires Python 2.4 or=
 newer'
-	test_done
+    # Requires Python 2.4 or newer
+	test_set_prereq PYTHON_24
 fi
=20
-test_expect_success 'setup repository' '
+test_expect_success PYTHON_24 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
 	(cd public &&
@@ -29,34 +27,34 @@ test_expect_success 'setup repository' '
 	 git push origin master)
 '
=20
-test_expect_success 'cloning from local repo' '
+test_expect_success PYTHON_24 'cloning from local repo' '
 	git clone "testgit::${PWD}/server" localclone &&
 	test_cmp public/file localclone/file
 '
=20
-test_expect_success 'cloning from remote repo' '
+test_expect_success PYTHON_24 'cloning from remote repo' '
 	git clone "testgit::file://${PWD}/server" clone &&
 	test_cmp public/file clone/file
 '
=20
-test_expect_success 'create new commit on remote' '
+test_expect_success PYTHON_24 'create new commit on remote' '
 	(cd public &&
 	 echo content >>file &&
 	 git commit -a -m two &&
 	 git push)
 '
=20
-test_expect_success 'pulling from local repo' '
+test_expect_success PYTHON_24 'pulling from local repo' '
 	(cd localclone && git pull) &&
 	test_cmp public/file localclone/file
 '
=20
-test_expect_success 'pulling from remote remote' '
+test_expect_success PYTHON_24 'pulling from remote remote' '
 	(cd clone && git pull) &&
 	test_cmp public/file clone/file
 '
=20
-test_expect_success 'pushing to local repo' '
+test_expect_success PYTHON_24 'pushing to local repo' '
 	(cd localclone &&
 	echo content >>file &&
 	git commit -a -m three &&
@@ -65,12 +63,12 @@ test_expect_success 'pushing to local repo' '
 	test $HEAD =3D $(git --git-dir=3Dserver/.git rev-parse --verify HEAD)
 '
=20
-test_expect_success 'synch with changes from localclone' '
+test_expect_success PYTHON_24 'synch with changes from localclone' '
 	(cd clone &&
 	 git pull)
 '
=20
-test_expect_success 'pushing remote local repo' '
+test_expect_success PYTHON_24 'pushing remote local repo' '
 	(cd clone &&
 	echo content >>file &&
 	git commit -a -m four &&
--=20
1.7.0.4
