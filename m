From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/3] push: add --quiet flag
Date: Wed, 5 Aug 2009 16:22:19 -0400
Message-ID: <20090805202219.GA23226@coredump.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn0J-0001J1-2y
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZHEUWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZHEUWY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:22:24 -0400
Received: from peff.net ([208.65.91.99]:37853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbZHEUWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:22:23 -0400
Received: (qmail 12212 invoked by uid 107); 5 Aug 2009 20:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 16:24:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 16:22:19 -0400
Content-Disposition: inline
In-Reply-To: <20090805201937.GB9004@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124964>

Some transports produce output even without "--verbose"
turned on. This provides a way to tell them to be more
quiet (whereas simply redirecting might lose error
messages).

Signed-off-by: Jeff King <peff@peff.net>
---
Missing tests and docs still.

It may be a bit weird, but you can actually say "--quiet --verbose" and
they don't exactly cancel each other. But it can actually be useful to
say "don't show me the ref status unless there is an error (--quiet), in
which case show me the entire table (--verbose)".

 builtin-push.c |    1 +
 transport.h    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..bc0c91a 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -168,6 +168,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
+		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
diff --git a/transport.h b/transport.h
index 51b5397..f1d3ebf 100644
--- a/transport.h
+++ b/transport.h
@@ -36,6 +36,7 @@ struct transport {
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
+#define TRANSPORT_PUSH_QUIET 64
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.4.218.g9f65c.dirty
