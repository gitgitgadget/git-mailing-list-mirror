From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] imap-send: don't check return value of git_getpass
Date: Thu, 8 Dec 2011 03:24:27 -0500
Message-ID: <20111208082427.GB26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZHO-00077p-4I
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab1LHIYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:24:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43096
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab1LHIY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:24:29 -0500
Received: (qmail 25633 invoked by uid 107); 8 Dec 2011 08:31:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:31:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:24:27 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186538>

git_getpass will always die() if we weren't able to get
input, so there's no point looking for NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
Not a bug, but just useless code I noticed.

 imap-send.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4c1e897..227253e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1213,10 +1213,6 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 			strbuf_addf(&prompt, "Password (%s@%s): ", srvc->user, srvc->host);
 			arg = git_getpass(prompt.buf);
 			strbuf_release(&prompt);
-			if (!arg) {
-				perror("getpass");
-				exit(1);
-			}
 			if (!*arg) {
 				fprintf(stderr, "Skipping account %s@%s, no password\n", srvc->user, srvc->host);
 				goto bail;
-- 
1.7.8.rc2.8.gf0f4f
