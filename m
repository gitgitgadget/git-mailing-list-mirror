From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/5] t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
Date: Wed, 28 Jul 2010 10:34:56 +0000
Message-ID: <1280313299-721-3-git-send-email-avarab@gmail.com>
References: <1280313299-721-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 12:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3z6-0006o8-IF
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab0G1Kfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:35:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab0G1Kf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:35:29 -0400
Received: by bwz1 with SMTP id 1so3850010bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MVEt4DtbEY5FhVAY9lSussqOUj1ODGdQ47ny8T06Hi8=;
        b=nhw67BHHq4qyW0jmS1fbIfhDlbbwb+78dqNithDvuEDxCsCJm5OqsiZ7hp27XxrlJ1
         6g+k5bynP11ephKpij9PJc+r8G6Nl5y3raELhv4nYqn+GX5jtlP65+GFGTQjHzZeX2WV
         LTPo4I3tgELo+z0yqNvdcZKTbsmGNVdqNktcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bIiTPcrNvigVax0Geb6IIsGzYDKRazpFWmwmUgnKRSHU/8n3dlF9gaM9PhcjiimWyk
         3xb4WHRThLyiORiNVb69r5f4U30+He5jaoVw9LQG/afBCgKpPhmOmn7XfC6odCDyYd/I
         Q2Dgnz/y5PPMrxZGXot6kxBNYIudfs8h/yB8Q=
Received: by 10.204.136.71 with SMTP id q7mr7690671bkt.111.1280313321052;
        Wed, 28 Jul 2010 03:35:21 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id g11sm4661233bkw.22.2010.07.28.03.35.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:35:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280313299-721-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152071>

Change the tests that skipped due to unavailable SYMLINKS support to
use the three-arg prereq form of test_expect_success.

This is like the "tests: implicitly skip SYMLINKS tests using
<prereq>" change, but I needed to create an additional test for some
setup code. It's in a separate change as suggested by Jonathan Nieder
for ease of reviewing.

    Date: Tue, 27 Jul 2010 16:17:37 -0500
    From: Jonathan Nieder <jrnieder@gmail.com>
    Message-ID: <20100727211737.GA11768@burratino>
    In-Reply-To: <1280265254-19642-2-git-send-email-avarab@gmail.com>
    Subject: Re: [PATCH 1/4] tests: implicitly skip SYMLINKS tests usin=
g <prereq>

    =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

    > +++ b/t/t4004-diff-rename-symlink.sh
    > @@ -40,8 +34,9 @@ test_expect_success \
    >  # rezrov and nitfol are rename/copy of frotz and bozbar should b=
e
    >  # a new creation.
    >
    > -GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >curren=
t
    > -cat >expected <<\EOF
    > +test_expect_success SYMLINKS 'setup diff output' "
    > +    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >cu=
rrent
    > +    cat >expected <<\EOF
    >  diff --git a/bozbar b/bozbar
    >  new file mode 120000
    >  --- /dev/null

    Probably belongs in a separate patch.  More importantly, it is miss=
ing
    &&-chaining (not a regression, but it is best to set a good example=
).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4004-diff-rename-symlink.sh |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symli=
nk.sh
index 1a09e8d..92a65f4 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -12,13 +12,7 @@ by an edit for them.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success \
+test_expect_success SYMLINKS \
     'prepare reference tree' \
     'echo xyzzy | tr -d '\\\\'012 >yomin &&
      ln -s xyzzy frotz &&
@@ -26,7 +20,7 @@ test_expect_success \
     tree=3D$(git write-tree) &&
     echo $tree'
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'prepare work tree' \
     'mv frotz rezrov &&
      rm -f yomin &&
@@ -40,8 +34,9 @@ test_expect_success \
 # rezrov and nitfol are rename/copy of frotz and bozbar should be
 # a new creation.
=20
-GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
-cat >expected <<\EOF
+test_expect_success SYMLINKS 'setup diff output' "
+    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current =
&&
+    cat >expected <<\EOF
 diff --git a/bozbar b/bozbar
 new file mode 120000
 --- /dev/null
@@ -65,8 +60,9 @@ deleted file mode 100644
 -xyzzy
 \ No newline at end of file
 EOF
+"
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'validate diff output' \
     'compare_diff_patch current expected'
=20
--=20
1.7.0.4
