From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: simple test for operation in a bare repository
Date: Wed, 03 Feb 2010 19:16:28 +0100
Message-ID: <4B69BD7C.4010608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nck0T-0000sk-36
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab0BCSbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:31:12 -0500
Received: from india601.server4you.de ([85.25.151.105]:52913 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0BCSbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:31:11 -0500
Received: from [10.0.1.100] (p57B7CCAF.dip.t-dialin.net [87.183.204.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 604202F803C;
	Wed,  3 Feb 2010 19:16:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138858>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t7002-grep.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index bf4d4dc..8cf958d 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -45,6 +45,23 @@ test_expect_success 'grep should not segfault with a bad input' '
 	test_must_fail git grep "("
 '
 
+bare_repo=.git/bare_test_repo
+test_expect_success 'setup bare repo' '
+	git clone --bare . $bare_repo
+'
+
+test_expect_success "grep HEAD (t-1), bare repo" '(
+	cd $bare_repo &&
+	echo "HEAD:t/t:1:test" >expected &&
+	git grep -n -e test HEAD >actual &&
+	diff expected actual
+)'
+
+test_expect_success "grep (t-1), bare repo, must fail" '(
+	cd $bare_repo &&
+	test_must_fail git grep -n -e test
+)'
+
 for H in HEAD ''
 do
 	case "$H" in
-- 
1.7.0.rc1
