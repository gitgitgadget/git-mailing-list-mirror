From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code check with test_expect_code
Date: Sun, 26 Sep 2010 17:14:26 -0600
Message-ID: <1285542879-16381-3-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Pv-0005ch-JC
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab0IZXNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37370 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab0IZXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:06 -0400
Received: by pvg2 with SMTP id 2so1087690pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=huwi+0/WXA2vq0MBjKlmaLzqtyyETnphrFYOQN7+BEE=;
        b=O8kHELe1FWqYLLRgC3S05zUTGQwLu3BDkVPGcahBwTsBnuo4wTWsP1OaHmMunGZDZg
         HF+nBnz5v/8FZmlDTqIIvWDCoAv5KWD5Cm2XnLfzbZ3LFkh/bwhI5RwSBbXtSZp8lFzT
         rzWBJIIWKARFvQ6/MwuyC1MeljUB1v2au5SdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=O/5ZteXQDDlG28sqPj7cuxOBTNTs98OCAH2p7yuwRZMWzCxuk+aDrZQpTZVI+HBpEN
         ESAtpY1tn6e65NT/bbr8hXVyL9uVyUZivMd1OFwEGm53fQvKn+P0+6bR6FS2D3ZiySwx
         9v5vJA6qGcsaPBFdlACCYBzrNeaQuJNGgjhHA=
Received: by 10.114.80.10 with SMTP id d10mr7340447wab.180.1285542786098;
        Sun, 26 Sep 2010 16:13:06 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157271>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4017-diff-retval.sh |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6158985..6605e12 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -28,37 +28,29 @@ test_expect_success 'git diff --quiet -w  HEAD^ HEA=
D' '
 	test_must_fail git diff --quiet -w HEAD^ HEAD
 '
=20
-test_expect_success 'git diff-tree HEAD^ HEAD' '
+test_expect_code 1 'git diff-tree HEAD^ HEAD' '
 	git diff-tree --exit-code HEAD^ HEAD
-	test $? =3D 1
 '
-test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
+test_expect_code 0 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --exit-code HEAD^ HEAD -- a
-	test $? =3D 0
 '
-test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
+test_expect_code 1 'git diff-tree HEAD^ HEAD -- b' '
 	git diff-tree --exit-code HEAD^ HEAD -- b
-	test $? =3D 1
 '
-test_expect_success 'echo HEAD | git diff-tree --stdin' '
+test_expect_code 1 'echo HEAD | git diff-tree --stdin' '
 	echo $(git rev-parse HEAD) | git diff-tree --exit-code --stdin
-	test $? =3D 1
 '
-test_expect_success 'git diff-tree HEAD HEAD' '
+test_expect_code 0 'git diff-tree HEAD HEAD' '
 	git diff-tree --exit-code HEAD HEAD
-	test $? =3D 0
 '
-test_expect_success 'git diff-files' '
+test_expect_code 0 'git diff-files' '
 	git diff-files --exit-code
-	test $? =3D 0
 '
-test_expect_success 'git diff-index --cached HEAD' '
+test_expect_code 0 'git diff-index --cached HEAD' '
 	git diff-index --exit-code --cached HEAD
-	test $? =3D 0
 '
-test_expect_success 'git diff-index --cached HEAD^' '
+test_expect_code 1 'git diff-index --cached HEAD^' '
 	git diff-index --exit-code --cached HEAD^
-	test $? =3D 1
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
@@ -74,9 +66,8 @@ test_expect_success 'git diff-tree -Stext HEAD^ HEAD =
-- b' '
 		test $? =3D 1
 	}
 '
-test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
+test_expect_code 0 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree -p --exit-code -Snot-found HEAD^ HEAD -- b
-	test $? =3D 0
 '
 test_expect_success 'git diff-files' '
 	echo 3 >>c && {
@@ -113,10 +104,9 @@ test_expect_success '--check --exit-code returns 3=
 for a dirty difference' '
=20
 '
=20
-test_expect_success '--check with --no-pager returns 2 for dirty diffe=
rence' '
+test_expect_code 2 '--check with --no-pager returns 2 for dirty differ=
ence' '
=20
 	git --no-pager diff --check
-	test $? =3D 2
=20
 '
=20
--=20
1.7.3.95.g14291
