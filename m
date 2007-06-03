From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Test "stg rebase" after "stg commit"
Date: Sun, 03 Jun 2007 15:41:57 +0200
Message-ID: <20070603134157.1681.70969.stgit@gandelf.nowhere.earth>
References: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuqLP-0006Uz-Bv
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXFCNl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 09:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbXFCNl6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:41:58 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47647 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbXFCNl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:41:57 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 172495A247;
	Sun,  3 Jun 2007 15:41:57 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id BA3C11F019;
	Sun,  3 Jun 2007 15:41:57 +0200 (CEST)
In-Reply-To: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48996>


Two new tests for "stg rebase":

  1. Try to rebase to a commit that is ahead of HEAD. This should
     work, and does.

  2. Try to commit a patch, and then rebase. This doesn't work,
     because "stg rebase" aborts if orig-base !=3D base, and "stg
     commit" doesn't update orig-base. (It does work if "stg rebase"
     is given the --force flag.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t2200-rebase.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index 52462dd..b48e513 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -30,4 +30,20 @@ test_expect_success \
 	test `stg id base@stack` =3D `git rev-parse master~1`
 	'
=20
+test_expect_success \
+	'Rebase to next commit' \
+	'
+	stg rebase master &&
+	test $(stg id base@stack) =3D $(git rev-parse master)
+	'
+
+test_expect_success \
+	'Commit the patch and rebase again' \
+	'
+	stg commit &&
+	git tag committed-here &&
+	stg rebase master &&
+	test $(stg id base@stack) =3D $(git rev-parse master)
+	'
+
 test_done
