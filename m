From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t2200: check that "add -u" limits itself to subdirectory
Date: Wed, 13 Mar 2013 00:10:22 -0400
Message-ID: <20130313041022.GA5378@sigill.intra.peff.net>
References: <20130313040845.GA5057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 13 05:10:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFd1g-0005fO-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 05:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab3CMEK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 00:10:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50498 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914Ab3CMEKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 00:10:25 -0400
Received: (qmail 1431 invoked by uid 107); 13 Mar 2013 04:12:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Mar 2013 00:12:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2013 00:10:22 -0400
Content-Disposition: inline
In-Reply-To: <20130313040845.GA5057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218030>

This behavior is due to change in the future, but let's test
it anyway. That helps make sure we do not accidentally
switch the behavior too soon while we are working in the
area, and it means that we can easily verify the change when
we do make it.

Signed-off-by: Jeff King <peff@peff.net>
---
We didn't seem to be testing this transition at all. I think it's sane
to do so now, and Junio's "now it is 2.0, let's switch" patch should
update the test.

 t/t2200-add-update.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..fe4f548 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,6 +80,17 @@ test_expect_success 'change gets noticed' '
 
 '
 
+# Note that this is scheduled to change in Git 2.0, when
+# "git add -u" will become full-tree by default.
+test_expect_success 'update did not touch files at root' '
+	cat >expect <<-\EOF &&
+	check
+	top
+	EOF
+	git diff-files --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.8.2.rc2.7.gef06216
