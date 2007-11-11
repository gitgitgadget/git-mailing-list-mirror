From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH] t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 18:38:11 +0100
Message-ID: <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: aroben@apple.com, dak@gnu.org, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
To: benji@silverinsanity.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGlW-0006cs-DG
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbXKKRiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 12:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbXKKRiS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:38:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:54850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756189AbXKKRiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:38:17 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:38:16 -0000
Received: from i577B84F1.versanet.de (EHLO localhost) [87.123.132.241]
  by mail.gmx.net (mp031) with SMTP; 11 Nov 2007 18:38:16 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+IlMcZh+OI3IrmSC6te453aUTFg3Bp+TBysyDBDE
	rVwW7Bm/wW6jCg
X-Mailer: git-send-email 1.5.3.5.622.g6fd7a
In-Reply-To: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64485>

The git wrapper executable always prepends the GIT_EXEC_PATH build
variable to the current PATH, so prepending "." to the PATH is not
enough to give precedence to the fake vi executable.

The --exec-path option allows to prepend a directory to PATH even befor=
e
GIT_EXEC_PATH (which is added anyway), so we can use that instead.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
---
 t/t7005-editor.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 01cc0c0..0b36ee1 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -61,7 +61,7 @@ do
 		;;
 	esac
 	test_expect_success "Using $i" '
-		git commit --amend &&
+		git --exec-path=3D. commit --amend &&
 		git show -s --pretty=3Doneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
 		diff actual expect
@@ -83,7 +83,7 @@ do
 		;;
 	esac
 	test_expect_success "Using $i (override)" '
-		git commit --amend &&
+		git --exec-path=3D. commit --amend &&
 		git show -s --pretty=3Doneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
 		diff actual expect
--=20
1.5.3.5.622.g6fd7a
