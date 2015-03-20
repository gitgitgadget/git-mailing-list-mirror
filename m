From: Jeff King <peff@peff.net>
Subject: [PATCH 12/25] t: avoid using ":" for comments
Date: Fri, 20 Mar 2015 06:12:37 -0400
Message-ID: <20150320101237.GL12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtv5-0005Ml-0n
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbCTKMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:12:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:35700 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751842AbbCTKMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:12:40 -0400
Received: (qmail 5857 invoked by uid 102); 20 Mar 2015 10:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:12:40 -0500
Received: (qmail 21575 invoked by uid 107); 20 Mar 2015 10:12:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:12:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:12:37 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265886>

The ":" is not a comment marker, but rather a noop command.
Using it as a comment like:

  : do something
  cmd1 &&

  : something else
  cmd2

breaks the &&-chain, and we would fail to notice if "cmd1"
failed in this instance. We can just use regular "#"
comments instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4104-apply-boundary.sh | 18 +++++++++---------
 t/t5533-push-cas.sh       |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index c97aad1..497afdc 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	cat victim >original &&
 	git update-index --add victim &&
 
-	: add to the head
+	# add to the head
 	for i in a b '"$L"' y
 	do
 		echo $i
@@ -27,7 +27,7 @@ test_expect_success setup '
 	git diff victim >add-a-patch.with &&
 	git diff --unified=0 >add-a-patch.without &&
 
-	: insert at line two
+	# insert at line two
 	for i in b a '"$L"' y
 	do
 		echo $i
@@ -36,7 +36,7 @@ test_expect_success setup '
 	git diff victim >insert-a-patch.with &&
 	git diff --unified=0 >insert-a-patch.without &&
 
-	: modify at the head
+	# modify at the head
 	for i in a '"$L"' y
 	do
 		echo $i
@@ -45,16 +45,16 @@ test_expect_success setup '
 	git diff victim >mod-a-patch.with &&
 	git diff --unified=0 >mod-a-patch.without &&
 
-	: remove from the head
+	# remove from the head
 	for i in '"$L"' y
 	do
 		echo $i
 	done >victim &&
 	cat victim >del-a-expect &&
-	git diff victim >del-a-patch.with
+	git diff victim >del-a-patch.with &&
 	git diff --unified=0 >del-a-patch.without &&
 
-	: add to the tail
+	# add to the tail
 	for i in b '"$L"' y z
 	do
 		echo $i
@@ -63,7 +63,7 @@ test_expect_success setup '
 	git diff victim >add-z-patch.with &&
 	git diff --unified=0 >add-z-patch.without &&
 
-	: modify at the tail
+	# modify at the tail
 	for i in b '"$L"' z
 	do
 		echo $i
@@ -72,7 +72,7 @@ test_expect_success setup '
 	git diff victim >mod-z-patch.with &&
 	git diff --unified=0 >mod-z-patch.without &&
 
-	: remove from the tail
+	# remove from the tail
 	for i in b '"$L"'
 	do
 		echo $i
@@ -81,7 +81,7 @@ test_expect_success setup '
 	git diff victim >del-z-patch.with &&
 	git diff --unified=0 >del-z-patch.without
 
-	: done
+	# done
 '
 
 for with in with without
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index dccf8a6..c402d8d 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -14,7 +14,7 @@ setup_srcdst_basic () {
 }
 
 test_expect_success setup '
-	: create template repository
+	# create template repository
 	test_commit A &&
 	test_commit B &&
 	test_commit C
-- 
2.3.3.520.g3cfbb5d
