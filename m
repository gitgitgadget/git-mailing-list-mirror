From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t3903: stop hard-coding commit sha1s
Date: Wed, 22 Apr 2015 15:30:52 -0400
Message-ID: <20150422193052.GA27945@peff.net>
References: <20150422192948.GA27656@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:31:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0MN-0004LI-OO
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbbDVTaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:30:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:48762 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbbDVTay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:30:54 -0400
Received: (qmail 11038 invoked by uid 102); 22 Apr 2015 19:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:30:54 -0500
Received: (qmail 13165 invoked by uid 107); 22 Apr 2015 19:31:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:31:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:30:52 -0400
Content-Disposition: inline
In-Reply-To: <20150422192948.GA27656@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267619>

When testing the diff output of "git stash list", we look
for the stash's subject of "WIP on master: $sha1", even
though it's not relevant to the diff output. This makes the
test brittle to refactoring, as any changes to earlier tests
may impact the commit sha1.

Since we don't care about the commit subject here, we can
simply ask stash not to print it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3903-stash.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1e29962..6da4856 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -695,8 +695,8 @@ test_expect_success 'setup stash with index and worktree changes' '
 '
 
 test_expect_success 'stash list implies --first-parent -m' '
-	cat >expect <<-\EOF &&
-	stash@{0}: WIP on master: b27a2bc subdir
+	cat >expect <<-EOF &&
+	stash@{0}
 
 	diff --git a/file b/file
 	index 257cc56..d26b33d 100644
@@ -706,13 +706,13 @@ test_expect_success 'stash list implies --first-parent -m' '
 	-foo
 	+working
 	EOF
-	git stash list -p >actual &&
+	git stash list --format=%gd -p >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'stash list --cc shows combined diff' '
 	cat >expect <<-\EOF &&
-	stash@{0}: WIP on master: b27a2bc subdir
+	stash@{0}
 
 	diff --cc file
 	index 257cc56,9015a7a..d26b33d
@@ -723,7 +723,7 @@ test_expect_success 'stash list --cc shows combined diff' '
 	 -index
 	++working
 	EOF
-	git stash list -p --cc >actual &&
+	git stash list --format=%gd -p --cc >actual &&
 	test_cmp expect actual
 '
 
-- 
2.4.0.rc2.498.g02440db
