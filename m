From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] fetch-pack: mention server version with verbose output
Date: Fri, 10 Aug 2012 03:59:29 -0400
Message-ID: <20120810075929.GD8399@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szk8D-00073F-SC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab2HJH7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:59:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60078 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab2HJH7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:59:36 -0400
Received: (qmail 27252 invoked by uid 107); 10 Aug 2012 07:59:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 03:59:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 03:59:29 -0400
Content-Disposition: inline
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203210>

Fetch-pack's verbose mode is more of a debugging mode (and
in fact takes two "-v" arguments to trigger via the
porcelain layer). Let's mention the server version as
another possible item of interest.

Signed-off-by: Jeff King <peff@peff.net>
---
Like I mentioned before, I'm lukewarm on this one, because I doubt
anybody actually uses this debugging information. If we drop it, it
makes sense to drop 3/4, too, which is just infrastructure for this.

 builtin/fetch-pack.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bc7a0f9..bfe31ee 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -823,8 +823,14 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (server_supports("agent"))
+	if (server_supports("agent")) {
 		agent_supported = 1;
+		if (args.verbose) {
+			char *v = server_feature_value("agent");
+			fprintf(stderr, "Server version is %s\n", v);
+			free(v);
+		}
+	}
 
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
-- 
1.7.12.rc2.4.g7f05cf9
