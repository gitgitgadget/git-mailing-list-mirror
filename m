From: Jeff King <peff@peff.net>
Subject: [PATCHv2 5/5] mv: be quiet about overwriting
Date: Mon, 12 Dec 2011 16:54:42 -0500
Message-ID: <20111212215442.GB18310@sigill.intra.peff.net>
References: <20111212215238.GD9754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDph-0006Vg-LR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab1LLVyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:54:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48356
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab1LLVyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:54:45 -0500
Received: (qmail 5920 invoked by uid 107); 12 Dec 2011 22:01:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 17:01:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:54:42 -0500
Content-Disposition: inline
In-Reply-To: <20111212215238.GD9754@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186961>

When a user asks us to force a mv and overwrite the
destination, we print a warning. However, since a typical
use would be:

  $ git mv one two
  fatal: destination exists, source=one, destination=two
  $ git mv -f one two
  warning: overwriting 'two'

this warning is just noise. We already know we're
overwriting; that's why we gave -f!

This patch silences the warning unless "--verbose" is given.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mv.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 8dd5a45..2a144b0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -177,7 +177,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning(_("overwriting '%s'"), dst);
+					if (verbose)
+						warning(_("overwriting '%s'"), dst);
 					bad = NULL;
 				} else
 					bad = _("Cannot overwrite");
-- 
1.7.8.13.g74677
