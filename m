From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] t7502: properly quote GIT_EDITOR
Date: Thu, 26 Jul 2012 16:28:00 -0400
Message-ID: <20120726202759.GB16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUfJ-0003CX-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab2GZU2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:28:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37587 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab2GZU2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:28:02 -0400
Received: (qmail 13290 invoked by uid 107); 26 Jul 2012 20:28:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:28:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:28:00 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202304>

One of the tests tries to ensure that editor is not run due
to an early failure. However, it needs to quote the pathname
of the trash directory used in $GIT_EDITOR, since git will
pass it along to the shell. In other words, the test would
pass whether the code was correct or not, since the unquoted
editor specification would never run.

We never noticed the problem because the code is indeed
correct, so git-commit never even tried to run the editor.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7502-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ddce53a..3f9fb55 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -290,7 +290,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	test_must_fail git cherry-pick -n master &&
 	echo "editor not started" >.git/result &&
 	(
-		GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" &&
+		GIT_EDITOR="\"$(pwd)/.git/FAKE_EDITOR\"" &&
 		export GIT_EDITOR &&
 		test_must_fail git commit
 	) &&
-- 
1.7.11.3.8.ge78f547
