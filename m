From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] t7510: stop referring to master in later tests
Date: Mon, 16 Jun 2014 19:59:59 -0400
Message-ID: <20140616235958.GA17110@sigill.intra.peff.net>
References: <20140616235917.GA19499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 02:00:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwgop-0001gw-1j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbaFQAAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:00:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:45631 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbaFQAAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:00:00 -0400
Received: (qmail 26782 invoked by uid 102); 17 Jun 2014 00:00:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 19:00:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 19:59:59 -0400
Content-Disposition: inline
In-Reply-To: <20140616235917.GA19499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251832>

Our setup creates a sequence of commits, each with its own
tag. However, we sometimes refer to "seventh-signed" as
"master". This works, since it is at the tip of the created
branch, but is brittle if new tests need to add more
commits. Let's use its tag name to be unambiguous.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7510-signed-commit.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 5ddac1a..37c3778 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -47,7 +47,7 @@ test_expect_success GPG 'create signed commits' '
 
 test_expect_success GPG 'show signatures' '
 	(
-		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual || exit 1
@@ -67,7 +67,7 @@ test_expect_success GPG 'show signatures' '
 '
 
 test_expect_success GPG 'detect fudged signature' '
-	git cat-file commit master >raw &&
+	git cat-file commit seventh-signed >raw &&
 
 	sed -e "s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
@@ -77,7 +77,7 @@ test_expect_success GPG 'detect fudged signature' '
 '
 
 test_expect_success GPG 'detect fudged signature with NUL' '
-	git cat-file commit master >raw &&
+	git cat-file commit seventh-signed >raw &&
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
 	git hash-object -w -t commit forged2 >forged2.commit &&
-- 
2.0.0.566.gfe3e6b2
