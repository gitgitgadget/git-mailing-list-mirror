From: Jeff King <peff@peff.net>
Subject: [PATCH 11/12] t0001: drop useless subshells
Date: Thu, 20 Mar 2014 19:21:25 -0400
Message-ID: <20140320232125.GK8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmHD-0000Om-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768AbaCTXV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:21:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:43607 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759458AbaCTXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:21:27 -0400
Received: (qmail 28273 invoked by uid 102); 20 Mar 2014 23:21:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:21:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:21:25 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244614>

Many tests use subshells, but don't actually change the
shell environment. They were probably cargo-culted from
earlier tests which did need subshells. Drop the useless
ones.

Signed-off-by: Jeff King <peff@peff.net>
---
These ones should produce no behavior change at all; they're purely
mechanical "(foo && bar)" to "foo && bar" (though of course I did them
by hand, because you need to know that "foo" and "bar" do not affect the
environment).

 t/t0001-init.sh | 61 +++++++++++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 4560bba..55a68bc 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -106,11 +106,8 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 '
 
 test_expect_success 'GIT_DIR bare' '
-
-	(
-		mkdir git-dir-bare.git &&
-		GIT_DIR=git-dir-bare.git git init
-	) &&
+	mkdir git-dir-bare.git &&
+	GIT_DIR=git-dir-bare.git git init &&
 	check_config git-dir-bare.git true unset
 '
 
@@ -242,36 +239,28 @@ test_expect_success 'init rejects insanely long --template' '
 
 test_expect_success 'init creates a new directory' '
 	rm -fr newdir &&
-	(
-		git init newdir &&
-		test_path_is_dir newdir/.git/refs
-	)
+	git init newdir &&
+	test_path_is_dir newdir/.git/refs
 '
 
 test_expect_success 'init creates a new bare directory' '
 	rm -fr newdir &&
-	(
-		git init --bare newdir &&
-		test_path_is_dir newdir/refs
-	)
+	git init --bare newdir &&
+	test_path_is_dir newdir/refs
 '
 
 test_expect_success 'init recreates a directory' '
 	rm -fr newdir &&
-	(
-		mkdir newdir &&
-		git init newdir &&
-		test_path_is_dir newdir/.git/refs
-	)
+	mkdir newdir &&
+	git init newdir &&
+	test_path_is_dir newdir/.git/refs
 '
 
 test_expect_success 'init recreates a new bare directory' '
 	rm -fr newdir &&
-	(
-		mkdir newdir &&
-		git init --bare newdir &&
-		test_path_is_dir newdir/refs
-	)
+	mkdir newdir &&
+	git init --bare newdir &&
+	test_path_is_dir newdir/refs
 '
 
 test_expect_success 'init creates a new deep directory' '
@@ -297,30 +286,24 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
 
 test_expect_success 'init notices EEXIST (1)' '
 	rm -fr newdir &&
-	(
-		>newdir &&
-		test_must_fail git init newdir &&
-		test_path_is_file newdir
-	)
+	>newdir &&
+	test_must_fail git init newdir &&
+	test_path_is_file newdir
 '
 
 test_expect_success 'init notices EEXIST (2)' '
 	rm -fr newdir &&
-	(
-		mkdir newdir &&
-		>newdir/a
-		test_must_fail git init newdir/a/b &&
-		test_path_is_file newdir/a
-	)
+	mkdir newdir &&
+	>newdir/a
+	test_must_fail git init newdir/a/b &&
+	test_path_is_file newdir/a
 '
 
 test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
 	rm -fr newdir &&
-	(
-		mkdir newdir &&
-		chmod -w newdir &&
-		test_must_fail git init newdir/a/b
-	)
+	mkdir newdir &&
+	chmod -w newdir &&
+	test_must_fail git init newdir/a/b
 '
 
 test_expect_success 'init creates a new bare directory with global --bare' '
-- 
1.9.0.560.g01ceb46
