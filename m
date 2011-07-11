From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] pretty: support %G to show the generation number of a
 commit
Date: Mon, 11 Jul 2011 12:18:27 -0400
Message-ID: <20110711161827.GD10418@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:18:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJBw-0007sv-GM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab1GKQSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:18:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39521
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066Ab1GKQS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:18:29 -0400
Received: (qmail 2845 invoked by uid 107); 11 Jul 2011 16:18:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 12:18:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 12:18:27 -0400
Content-Disposition: inline
In-Reply-To: <20110711161332.GA10057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176865>

This might be useful for external programs doing topological
sorting or other graph analysis. It's also handy for testing
the generation calculation code.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..c58ab52 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -133,6 +133,7 @@ The placeholders are:
 - '%gD': reflog selector, e.g., `refs/stash@\{1\}`
 - '%gd': shortened reflog selector, e.g., `stash@\{1\}`
 - '%gs': reflog subject
+- '%G': generation number (i.e., distance of path to farthest root ancestor)
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f45eb54..8f1b321 100644
--- a/pretty.c
+++ b/pretty.c
@@ -965,6 +965,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			return 2;
 		}
 		return 0;	/* unknown %g placeholder */
+	case 'G':
+		strbuf_addf(sb, "%lu", commit_generation(commit));
+		return 1;
 	case 'N':
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
-- 
1.7.6.37.g989c6
