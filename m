From: Jeff King <peff@peff.net>
Subject: [PATCH] t5531: further "matching" fixups
Date: Wed, 8 Jan 2014 05:47:56 -0500
Message-ID: <20140108104756.GA32078@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093531.GD15720@sigill.intra.peff.net>
 <20140108102707.GA23145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 11:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0qgC-0000HL-4M
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 11:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbaAHKsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 05:48:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:57139 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbaAHKsC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 05:48:02 -0500
Received: (qmail 1225 invoked by uid 102); 8 Jan 2014 10:48:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 04:48:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 05:47:56 -0500
Content-Disposition: inline
In-Reply-To: <20140108102707.GA23145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240206>

Commit 43eb920 switched one of the sub-repository in this
test to matching to prepare for a world where the default
becomes "simple". However, the main repository needs a
similar change.

We did not notice any test failure when merged with b2ed944
(push: switch default from "matching" to "simple", 2013-01-04)
because t5531.6 is trying to provoke a failure of "git push"
due to a submodule check. When combined with b2ed944 the
push still fails, but for the wrong reason (because our
upstream setup does not exist, not because of the submodule).

Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Jan 08, 2014 at 05:27:07AM -0500, Jeff King wrote:

> This patch passes the test suite by itself (with or without that fixup).
> But oddly, it seems to fail t5531 when merged with 'next'. I can't
> figure out why, though. It shouldn't affect any code that doesn't look
> at branch->pushremote.

I still don't understand the full reason for this interaction, but the
failing test is actually somewhat broken in 'next' already. This patch
fixes it, and should be done regardless of the other series.

 t/t5531-deep-submodule-push.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 8c16e04..445bb5f 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -12,6 +12,7 @@ test_expect_success setup '
 	(
 		cd work &&
 		git init &&
+		git config push.default matching &&
 		mkdir -p gar/bage &&
 		(
 			cd gar/bage &&
-- 
1.8.5.2.500.g8060133
