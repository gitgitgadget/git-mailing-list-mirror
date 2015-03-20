From: Jeff King <peff@peff.net>
Subject: [PATCH 17/25] t0020: use modern test_* helpers
Date: Fri, 20 Mar 2015 06:13:08 -0400
Message-ID: <20150320101308.GQ12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvf-0005qT-6X
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbCTKNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35709 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbbCTKNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:11 -0400
Received: (qmail 5912 invoked by uid 102); 20 Mar 2015 10:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:11 -0500
Received: (qmail 21629 invoked by uid 107); 20 Mar 2015 10:13:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:08 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265893>

This test contains a lot of hand-rolled messages to show
when the test fails. We can omit most of these by using
"verbose" and "test_must_fail". A few of them are for
update-index, but we can assume it produces reasonable error
messages when it fails.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0020-crlf.sh | 144 +++++++++++---------------------------------------------
 1 file changed, 28 insertions(+), 116 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index d2e51a8..9fa26df 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -104,18 +104,12 @@ test_expect_success 'update with autocrlf=input' '
 	for f in one dir/two
 	do
 		append_cr <$f >tmp && mv -f tmp $f &&
-		git update-index -- $f || {
-			echo Oops
-			false
-			break
-		}
+		git update-index -- $f ||
+		break
 	done &&
 
 	differs=$(git diff-index --cached HEAD) &&
-	test -z "$differs" || {
-		echo Oops "$differs"
-		false
-	}
+	verbose test -z "$differs"
 
 '
 
@@ -128,18 +122,12 @@ test_expect_success 'update with autocrlf=true' '
 	for f in one dir/two
 	do
 		append_cr <$f >tmp && mv -f tmp $f &&
-		git update-index -- $f || {
-			echo "Oops $f"
-			false
-			break
-		}
+		git update-index -- $f ||
+		break
 	done &&
 
 	differs=$(git diff-index --cached HEAD) &&
-	test -z "$differs" || {
-		echo Oops "$differs"
-		false
-	}
+	verbose test -z "$differs"
 
 '
 
@@ -152,19 +140,13 @@ test_expect_success 'checkout with autocrlf=true' '
 	for f in one dir/two
 	do
 		remove_cr <"$f" >tmp && mv -f tmp $f &&
-		git update-index -- $f || {
-			echo "Eh? $f"
-			false
-			break
-		}
+		verbose git update-index -- $f ||
+		break
 	done &&
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
 	differs=$(git diff-index --cached HEAD) &&
-	test -z "$differs" || {
-		echo Oops "$differs"
-		false
-	}
+	verbose test -z "$differs"
 '
 
 test_expect_success 'checkout with autocrlf=input' '
@@ -187,10 +169,7 @@ test_expect_success 'checkout with autocrlf=input' '
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
 	differs=$(git diff-index --cached HEAD) &&
-	test -z "$differs" || {
-		echo Oops "$differs"
-		false
-	}
+	verbose test -z "$differs"
 '
 
 test_expect_success 'apply patch (autocrlf=input)' '
@@ -200,10 +179,7 @@ test_expect_success 'apply patch (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
-	test "$patched" = "$(git hash-object --stdin <one)" || {
-		echo "Eh?  apply without index"
-		false
-	}
+	verbose test "$patched" = "$(git hash-object --stdin <one)"
 '
 
 test_expect_success 'apply patch --cached (autocrlf=input)' '
@@ -213,10 +189,7 @@ test_expect_success 'apply patch --cached (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
-	test "$patched" = $(git rev-parse :one) || {
-		echo "Eh?  apply with --cached"
-		false
-	}
+	verbose test "$patched" = $(git rev-parse :one)
 '
 
 test_expect_success 'apply patch --index (autocrlf=input)' '
@@ -226,11 +199,8 @@ test_expect_success 'apply patch --index (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
-	test "$patched" = $(git rev-parse :one) &&
-	test "$patched" = $(git hash-object --stdin <one) || {
-		echo "Eh?  apply with --index"
-		false
-	}
+	verbose test "$patched" = $(git rev-parse :one) &&
+	verbose test "$patched" = $(git hash-object --stdin <one)
 '
 
 test_expect_success 'apply patch (autocrlf=true)' '
@@ -240,10 +210,7 @@ test_expect_success 'apply patch (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
-	test "$patched" = "$(remove_cr <one | git hash-object --stdin)" || {
-		echo "Eh?  apply without index"
-		false
-	}
+	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
 '
 
 test_expect_success 'apply patch --cached (autocrlf=true)' '
@@ -253,10 +220,7 @@ test_expect_success 'apply patch --cached (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
-	test "$patched" = $(git rev-parse :one) || {
-		echo "Eh?  apply without index"
-		false
-	}
+	verbose test "$patched" = $(git rev-parse :one)
 '
 
 test_expect_success 'apply patch --index (autocrlf=true)' '
@@ -266,11 +230,8 @@ test_expect_success 'apply patch --index (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
-	test "$patched" = $(git rev-parse :one) &&
-	test "$patched" = "$(remove_cr <one | git hash-object --stdin)" || {
-		echo "Eh?  apply with --index"
-		false
-	}
+	verbose test "$patched" = $(git rev-parse :one) &&
+	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
 '
 
 test_expect_success '.gitattributes says two is binary' '
@@ -326,21 +287,8 @@ test_expect_success '.gitattributes says two and three are text' '
 	echo "t* crlf" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	if has_cr dir/two
-	then
-		: happy
-	else
-		echo "Huh?"
-		false
-	fi &&
-
-	if has_cr three
-	then
-		: happy
-	else
-		echo "Huh?"
-		false
-	fi
+	verbose has_cr dir/two &&
+	verbose has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (1)' '
@@ -352,17 +300,8 @@ test_expect_success 'in-tree .gitattributes (1)' '
 	rm -rf tmp one dir .gitattributes patch.file three &&
 	git read-tree --reset -u HEAD &&
 
-	if has_cr one
-	then
-		echo "Eh? one should not have CRLF"
-		false
-	else
-		: happy
-	fi &&
-	has_cr three || {
-		echo "Eh? three should still have CRLF"
-		false
-	}
+	test_must_fail has_cr one &&
+	verbose has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (2)' '
@@ -371,17 +310,8 @@ test_expect_success 'in-tree .gitattributes (2)' '
 	git read-tree --reset HEAD &&
 	git checkout-index -f -q -u -a &&
 
-	if has_cr one
-	then
-		echo "Eh? one should not have CRLF"
-		false
-	else
-		: happy
-	fi &&
-	has_cr three || {
-		echo "Eh? three should still have CRLF"
-		false
-	}
+	test_must_fail has_cr one &&
+	verbose has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (3)' '
@@ -391,17 +321,8 @@ test_expect_success 'in-tree .gitattributes (3)' '
 	git checkout-index -u .gitattributes &&
 	git checkout-index -u one dir/two three &&
 
-	if has_cr one
-	then
-		echo "Eh? one should not have CRLF"
-		false
-	else
-		: happy
-	fi &&
-	has_cr three || {
-		echo "Eh? three should still have CRLF"
-		false
-	}
+	test_must_fail has_cr one &&
+	verbose has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (4)' '
@@ -411,17 +332,8 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	git checkout-index -u one dir/two three &&
 	git checkout-index -u .gitattributes &&
 
-	if has_cr one
-	then
-		echo "Eh? one should not have CRLF"
-		false
-	else
-		: happy
-	fi &&
-	has_cr three || {
-		echo "Eh? three should still have CRLF"
-		false
-	}
+	test_must_fail has_cr one &&
+	verbose has_cr three
 '
 
 test_expect_success 'checkout with existing .gitattributes' '
-- 
2.3.3.520.g3cfbb5d
