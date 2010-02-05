From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/9] cherry-pick: add tests for new --ff option
Date: Sat, 06 Feb 2010 00:11:08 +0100
Message-ID: <20100205231112.3689.86986.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXLg-0008Fb-L9
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195Ab0BEXML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53989 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310Ab0BEXMC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:12:02 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4AC448180CE;
	Sat,  6 Feb 2010 00:11:51 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3DE5E8180B2;
	Sat,  6 Feb 2010 00:11:49 +0100 (CET)
X-git-sha1: 047bc55429e066aec060fbc88063ff3dadedd36f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139113>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3506-cherry-pick-ff.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t3506-cherry-pick-ff.sh

diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
new file mode 100755
index 0000000..21c0729
--- /dev/null
+++ b/t/t3506-cherry-pick-ff.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='test cherry-picking with --ff option'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo first > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "first" &&
+	git tag first &&
+
+	git checkout -b other &&
+	echo second >> file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "second" &&
+	git tag second
+'
+
+test_expect_success 'cherry-pick using --ff fast forwards' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick --ff second &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify second)"
+'
+
+test_expect_success 'cherry-pick not using --ff does not fast forwards' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick second &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify second)"
+'
+
+test_done
-- 
1.6.6.1.557.g77031
