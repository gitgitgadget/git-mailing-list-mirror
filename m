From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] t7501-commit.sh: Add test case for fixing author in amend commit.
Date: Mon,  5 Nov 2007 12:17:27 -0500
Message-ID: <1194283047-16565-1-git-send-email-krh@redhat.com>
References: <Pine.LNX.4.64.0711051020330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip5d9-0005Sk-RZ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 18:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303AbXKERR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759286AbXKERR7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 12:17:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760291AbXKERR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 12:17:57 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA5HHcqD025371;
	Mon, 5 Nov 2007 12:17:38 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA5HHa5M011337;
	Mon, 5 Nov 2007 12:17:37 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA5HHWWT018358;
	Mon, 5 Nov 2007 12:17:33 -0500
X-Mailer: git-send-email 1.5.3.4.1482.gfb8a1-dirty
In-Reply-To: <Pine.LNX.4.64.0711051020330.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63529>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

How about this?

 t/t7501-commit.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b151b51..c5d122f 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -163,4 +163,19 @@ test_expect_success 'partial commit that involves =
removal (3)' '
=20
 '
=20
+author=3D"The Real Author <someguy@his.email.org>"
+test_expect_success 'amend commit to fix author' '
+
+	oldtick=3D$GIT_AUTHOR_DATE &&
+	test_tick &&
+	git reset --hard &&
+	git cat-file -p HEAD |
+	sed -e "s/author.*/author $author $oldtick/" \
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
+		expected &&
+	git commit --amend --author=3D"$author" &&
+	git cat-file -p HEAD > current &&
+	diff expected current
+=09
+'
 test_done
--=20
1.5.3.4
