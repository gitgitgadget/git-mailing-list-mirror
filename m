From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Don't allow git-describe failures to go unnoticed in t6120
Date: Mon, 3 Mar 2008 20:09:31 -0500
Message-ID: <20080304010931.GA15791@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWLfY-00032h-R6
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 02:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYCDBJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 20:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbYCDBJf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 20:09:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52119 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYCDBJf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 20:09:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWLek-0001Hp-S6; Mon, 03 Mar 2008 20:09:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F084420FBAE; Mon,  3 Mar 2008 20:09:31 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76008>

If git-describe fails we never execute the test_expect_success,
so we never actually test for failure.  This is horribly wrong.
We need to always run the test case, but the test case is only
supposed to succeed if the prior git-describe returned 0.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t6120-describe.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a7557bd..ba9ea60 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -15,8 +15,10 @@ test_description='test describe
 check_describe () {
 	expect="$1"
 	shift
-	R=$(git describe "$@") &&
+	R=$(git describe "$@")
+	S=$?
 	test_expect_success "describe $*" '
+	test $S = 0 &&
 	case "$R" in
 	$expect)	echo happy ;;
 	*)	echo "Oops - $R is not $expect";
-- 
1.5.4.3.529.gb25fb

