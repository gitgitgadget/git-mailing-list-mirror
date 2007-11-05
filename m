From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] t7501-commit.sh: Add test case for fixing author in amend commit.
Date: Sun,  4 Nov 2007 22:42:45 -0500
Message-ID: <1194234165-9498-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 03:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ios2z-0007A5-5q
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 03:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbXKECuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 21:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbXKECuV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 21:50:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbXKECuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 21:50:20 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA52o6FK024414;
	Sun, 4 Nov 2007 21:50:06 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA52o5qE010885;
	Sun, 4 Nov 2007 21:50:05 -0500
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA52o3h2019332;
	Sun, 4 Nov 2007 21:50:03 -0500
X-Mailer: git-send-email 1.5.3.5.1527.g6161-dirty
In-Reply-To: 7vy7dg1kdg.fsf@gitster.siamese.dyndns.org
References: 7vy7dg1kdg.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63470>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 t/t7501-commit.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b151b51..7a37c13 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -151,6 +151,7 @@ test_expect_success 'partial commit that involves r=
emoval (2)' '
 	diff expected current
=20
 '
+test_tick
=20
 test_expect_success 'partial commit that involves removal (3)' '
=20
@@ -163,4 +164,19 @@ test_expect_success 'partial commit that involves =
removal (3)' '
=20
 '
=20
+oldtick=3D$GIT_AUTHOR_DATE
+test_tick
+
+author=3D"The Real Author <someguy@his.email.org>"
+committer=3D"$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE"
+
+test_expect_success 'amend commit to fix author' '
+
+	git reset --hard
+	git cat-file -p HEAD | sed -e "s/author.*/author $author $oldtick/" -=
e "s/committer.*/committer $committer/" > expected &&
+	git commit --amend --author=3D"$author" &&
+	git cat-file -p HEAD > current &&
+	diff expected current
+=09
+'
 test_done
--=20
1.5.3.5.1527.g6161-dirty
