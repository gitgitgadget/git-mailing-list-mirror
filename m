From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] t1300: test "git config --get-all" more thoroughly
Date: Tue, 23 Oct 2012 18:36:38 -0400
Message-ID: <20121023223638.GC17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn5h-0000RH-TA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933559Ab2JWWgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:36:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51680 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2JWWgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:36:42 -0400
Received: (qmail 23285 invoked by uid 107); 23 Oct 2012 22:37:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:37:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:36:38 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208264>

We check that we can "--get-all" a multi-valued variable,
but we do not actually confirm that the output is sensible.
Doing so reveals that it works fine, but this will help us
ensure we do not have regressions in the next few patches,
which will touch this area.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1300-repo-config.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c6489dc..74a297e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -256,8 +256,13 @@ test_expect_success 'ambiguous get' '
 	test_must_fail git config --get nextsection.nonewline
 '
 
-test_expect_success 'get multivar' '
-	git config --get-all nextsection.nonewline
+test_expect_success 'multi-valued get-all returns all' '
+	cat >expect <<-\EOF &&
+	wow
+	wow2 for me
+	EOF
+	git config --get-all nextsection.nonewline >actual &&
+	test_cmp expect actual
 '
 
 cat > expect << EOF
-- 
1.8.0.3.g3456896
