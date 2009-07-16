From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 1/2] t5520-pull: Test for rebased upstream + fetch + pull --rebase
Date: Thu, 16 Jul 2009 02:09:14 +0200
Message-ID: <1247702955-1559-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 02:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MREWv-0000jF-Mi
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 02:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZGPAIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 20:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbZGPAIs
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 20:08:48 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47591 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZGPAIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 20:08:48 -0400
Received: by fxm18 with SMTP id 18so3779209fxm.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 17:08:45 -0700 (PDT)
Received: by 10.204.103.145 with SMTP id k17mr8142555bko.10.1247702925594;
        Wed, 15 Jul 2009 17:08:45 -0700 (PDT)
Received: from localhost (p5B0D3A8D.dip.t-dialin.net [91.13.58.141])
        by mx.google.com with ESMTPS id e17sm13934647fke.48.2009.07.15.17.08.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 17:08:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.408.g8ecf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123345>

If your upstream has rebased you can do:

git pull --rebase

but only if you haven't fetch before.

Mark this case as test_expect_failure, in a later patch it will be
changed to test_expect_success.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 t/t5520-pull.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c5a2e66..1aae494 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -117,6 +117,20 @@ test_expect_success '--rebase with rebased default=
 upstream' '
=20
 '
=20
+test_expect_failure 'rebased upstream + fetch + pull --rebase' '
+
+	git update-ref refs/remotes/me/copy copy-orig &&
+	git reset --hard to-rebase-orig &&
+	git checkout --track -b to-rebase3 me/copy &&
+	git reset --hard to-rebase-orig &&
+	git fetch &&
+	test_must_fail git pull --rebase &&
+	git rebase --abort &&
+	test "conflicting modification" =3D "$(cat file)" &&
+	test file =3D $(cat file2)
+
+'
+
 test_expect_success 'pull --rebase dies early with dirty working direc=
tory' '
=20
 	git checkout to-rebase &&
--=20
1.6.4.rc0.18.g60787.dirty
