From: Jeff King <peff@peff.net>
Subject: [PATCH 07/12] t0001: make symlink reinit test more careful
Date: Thu, 20 Mar 2014 19:17:15 -0400
Message-ID: <20140320231715.GG8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:17:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmDB-0002YG-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759987AbaCTXRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:17:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43588 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759652AbaCTXRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:17:17 -0400
Received: (qmail 27989 invoked by uid 102); 20 Mar 2014 23:17:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:17:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:17:15 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244609>

In the final test of t0001, we have a repo whose .git is a
symlink to a directory "here", and we use
"--separate-git-dir" to migrate that to a .git file pointing
to a different directory. We check that the data is migrated
to the new directory and that .git looks like a git-file.

We also check that "here" is not a directory, which is
slightly misleading. It should not be a directory, but
neither should it be gone. It is the actual resting place of
the git-file, and .git remains a symlink to it.

Let's check that more explicitly, both to make our test more
robust, and to make further cleanups in this area more
obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0001-init.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9b05fdf..5245711 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -402,8 +402,8 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	) &&
 	echo "gitdir: `pwd`/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
-	test -d realgitdir/refs &&
-	! test -d newdir/here
+	test_cmp expected newdir/here &&
+	test -d realgitdir/refs
 '
 
 test_done
-- 
1.9.0.560.g01ceb46
