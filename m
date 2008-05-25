From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Add some tests for git update-ref -d
Date: Sun, 25 May 2008 18:14:29 +0200
Message-ID: <20080525161429.25087.10930.stgit@yoghurt>
References: <20080525161125.25087.18083.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 18:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Isz-0000ur-Cu
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 18:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbYEYQPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 12:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbYEYQPA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 12:15:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1635 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbYEYQO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 12:14:59 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K0Ird-0001DN-00; Sun, 25 May 2008 17:14:29 +0100
In-Reply-To: <20080525161125.25087.18083.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82866>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1400-update-ref.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)


diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 78cd412..b88e767 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -32,6 +32,14 @@ test_expect_success \
 	"create $m" \
 	"git update-ref $m $B $A &&
 	 test $B"' =3D $(cat .git/'"$m"')'
+test_expect_success "fail to delete $m with stale ref" "
+	test_must_fail git update-ref -d $m $A &&
+	test $B =3D \$(cat .git/$m)
+"
+test_expect_success "delete $m" "
+	git update-ref -d $m $B &&
+	! test -f .git/$m
+"
 rm -f .git/$m
=20
 test_expect_success \
@@ -49,6 +57,14 @@ test_expect_success \
 	"create $m (by HEAD)" \
 	"git update-ref HEAD $B $A &&
 	 test $B"' =3D $(cat .git/'"$m"')'
+test_expect_success "fail to delete $m (by HEAD) with stale ref" "
+	test_must_fail git update-ref -d HEAD $A &&
+	test $B =3D \$(cat .git/$m)
+"
+test_expect_success "delete $m (by HEAD)" "
+	git update-ref -d HEAD $B &&
+	! test -f .git/$m
+"
 rm -f .git/$m
=20
 test_expect_success '(not) create HEAD with old sha1' "
