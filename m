From: Jeff King <peff@peff.net>
Subject: [PATCH 05/12] t: prefer "git config --file" to GIT_CONFIG with
 test_must_fail
Date: Thu, 20 Mar 2014 19:15:54 -0400
Message-ID: <20140320231554.GE8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmBs-0000Yo-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760070AbaCTXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:15:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:43577 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759628AbaCTXP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:15:56 -0400
Received: (qmail 27817 invoked by uid 102); 20 Mar 2014 23:15:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:15:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:15:54 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244607>

This lets us get rid of an extra "env" invocation in the
middle, and is slightly more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
The case that started this all...

This is also the only reason this series needs to go on top of David's
patch.

 t/t1300-repo-config.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index cd23d07..e355aa1 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -961,15 +961,15 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 '
 
 test_expect_success 'nonexistent configuration' '
-	test_must_fail env GIT_CONFIG=doesnotexist git config --list &&
-	test_must_fail env GIT_CONFIG=doesnotexist git config test.xyzzy
+	test_must_fail git config --file=doesnotexist --list &&
+	test_must_fail git config --file=doesnotexist test.xyzzy
 '
 
 test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
 	ln -s doesnotexist linktonada &&
 	ln -s linktonada linktolinktonada &&
-	test_must_fail env GIT_CONFIG=linktonada git config --list &&
-	test_must_fail env GIT_CONFIG=linktolinktonada git config --list
+	test_must_fail git config --file=linktonada --list &&
+	test_must_fail git config --file=linktolinktonada --list
 '
 
 test_expect_success 'check split_cmdline return' "
-- 
1.9.0.560.g01ceb46
