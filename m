From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/4] t0050: Test autodetect core.ignorecase
Date: Sun, 11 May 2008 18:16:40 +0200
Message-ID: <1210522602-4724-2-git-send-email-prohaska@zib.de>
References: <1210522602-4724-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEFZ-0008VV-As
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbYEKQRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbYEKQRV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:17:21 -0400
Received: from mailer.zib.de ([130.73.108.11]:62455 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914AbYEKQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:16:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BGGhxU004670;
	Sun, 11 May 2008 18:16:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BGGgDV019981;
	Sun, 11 May 2008 18:16:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1210522602-4724-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81782>

Verify if core.ignorecase is automatically set to 'true' during
repository initialization if the file system is case insensitive,
and unset or 'false' otherwise.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 3fbad77..66d3647 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -7,6 +7,7 @@ test_description='Various filesystem issues'
 auml=`printf '\xc3\xa4'`
 aumlcdiar=`printf '\x61\xcc\x88'`
 
+case_insensitive=
 test_expect_success 'see if we expect ' '
 
 	test_case=test_expect_success
@@ -17,6 +18,7 @@ test_expect_success 'see if we expect ' '
 	if test "$(cat junk/CamelCase)" != good
 	then
 		test_case=test_expect_failure
+		case_insensitive=t
 		say "will test on a case insensitive filesystem"
 	fi &&
 	rm -fr junk &&
@@ -32,6 +34,20 @@ test_expect_success 'see if we expect ' '
 	rm -fr junk
 '
 
+if test "$case_insensitive"
+then
+test_expect_success "detection of case insensitive filesystem during repo init" '
+
+	test $(git config --bool core.ignorecase) = true
+'
+else
+test_expect_success "detection of case insensitive filesystem during repo init" '
+
+	! git config --bool core.ignorecase >/dev/null ||
+	test $(git config --bool core.ignorecase) = false
+'
+fi
+
 test_expect_success "setup case tests" '
 
 	touch camelcase &&
-- 
1.5.5.1.313.g9decb
