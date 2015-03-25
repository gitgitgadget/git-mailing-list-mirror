From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] t0020: use test_* helpers instead of hand-rolled messages
Date: Wed, 25 Mar 2015 01:31:41 -0400
Message-ID: <20150325053141.GG31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:31:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaduv-00032X-1A
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbbCYFbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:31:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:38178 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750833AbbCYFbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:31:44 -0400
Received: (qmail 17554 invoked by uid 102); 25 Mar 2015 05:31:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:31:44 -0500
Received: (qmail 11745 invoked by uid 107); 25 Mar 2015 05:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:31:41 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266260>

These tests are not wrong, but it is much shorter and more
idiomatic to say "verbose" or "test_must_fail" rather than
printing our own messages on failure. Likewise, there is no
need to say "happy" at the end of a test; the test suite
takes care of that.

Signed-off-by: Jeff King <peff@peff.net>
---
I somehow missed these when doing 9157c5c in the earlier series.

 t/t0020-crlf.sh | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 144fdcd..f94120a 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -35,9 +35,7 @@ test_expect_success setup '
 	for w in Some extra lines here; do echo $w; done >>one &&
 	git diff >patch.file &&
 	patched=$(git hash-object --stdin <one) &&
-	git read-tree --reset -u HEAD &&
-
-	echo happy.
+	git read-tree --reset -u HEAD
 '
 
 test_expect_success 'safecrlf: autocrlf=input, all CRLF' '
@@ -225,29 +223,9 @@ test_expect_success '.gitattributes says two is binary' '
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
-	if has_cr dir/two
-	then
-		echo "Huh?"
-		false
-	else
-		: happy
-	fi &&
-
-	if has_cr one
-	then
-		: happy
-	else
-		echo "Huh?"
-		false
-	fi &&
-
-	if has_cr three
-	then
-		echo "Huh?"
-		false
-	else
-		: happy
-	fi
+	test_must_fail has_cr dir/two &&
+	verbose has_cr one &&
+	test_must_fail has_cr three
 '
 
 test_expect_success '.gitattributes says two is input' '
@@ -256,13 +234,7 @@ test_expect_success '.gitattributes says two is input' '
 	echo "two crlf=input" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	if has_cr dir/two
-	then
-		echo "Huh?"
-		false
-	else
-		: happy
-	fi
+	test_must_fail has_cr dir/two
 '
 
 test_expect_success '.gitattributes says two and three are text' '
-- 
2.3.4.635.gd6ffcfe
