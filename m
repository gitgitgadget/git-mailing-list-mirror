From: Jeff King <peff@peff.net>
Subject: [PATCH] commit: match explicit-ident semantics for summary and
 template
Date: Sun, 17 Jan 2010 14:34:01 -0500
Message-ID: <20100117193401.GA28448@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWat3-0000kP-Ii
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab0AQTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548Ab0AQTeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:34:09 -0500
Received: from peff.net ([208.65.91.99]:33008 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab0AQTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:34:07 -0500
Received: (qmail 27790 invoked by uid 107); 17 Jan 2010 19:38:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 14:38:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 14:34:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137312>

Currently the commit summary will show the committer only if
neither the name or email was set explicitly. However, the
commit message template will show the committer unless
_both_ are set explicitly. This patch gives the same
behavior.

The difference came about because the two topics (one
enhancing the template semantics, and the other adding the
summary warning) were developed independently.

Signed-off-by: Jeff King <peff@peff.net>
---
This goes on top of 'next' as a result of merging jc/ident and
jk/warn-author-committer-after-commit. It's not correct on top of either
topic individually.

 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 37c902c..d4eef6d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1099,7 +1099,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
-	if (!user_ident_explicitly_given) {
+	if (user_ident_explicitly_given != IDENT_ALL_GIVEN) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
 		if (advice_implicit_identity) {
-- 
1.6.6.418.gd5443
