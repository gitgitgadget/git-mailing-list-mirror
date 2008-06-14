From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] avoid whitespace on empty line in automatic usage
	message
Date: Sat, 14 Jun 2008 03:27:21 -0400
Message-ID: <20080614072721.GC17536@sigill.intra.peff.net>
References: <20080614072214.GA9975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:28:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QBN-00086m-IB
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYFNH1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbYFNH1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:27:24 -0400
Received: from peff.net ([208.65.91.99]:2078 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbYFNH1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:27:23 -0400
Received: (qmail 30997 invoked by uid 111); 14 Jun 2008 07:27:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 03:27:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 03:27:21 -0400
Content-Disposition: inline
In-Reply-To: <20080614072214.GA9975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84981>

When outputting a usage message with a blank line in the
header, we would output a line with four spaces. Make this
truly a blank line.

This helps us remove trailing whitespace from a test vector.

Signed-off-by: Jeff King <peff@peff.net>
---
This is equivalent to the fix you just posted.

 parse-options.c               |    8 ++++++--
 t/t1502-rev-parse-parseopt.sh |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index acf3fe3..8071711 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -312,8 +312,12 @@ void usage_with_options_internal(const char * const *usagestr,
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(stderr, "   or: %s\n", *usagestr++);
-	while (*usagestr)
-		fprintf(stderr, "    %s\n", *usagestr++);
+	while (*usagestr) {
+		fprintf(stderr, "%s%s\n",
+				**usagestr ? "    " : "",
+				*usagestr);
+		usagestr++;
+	}
 
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', stderr);
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index d24a47d..7cdd70a 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -5,7 +5,7 @@ test_description='test git rev-parse --parseopt'
 
 cat > expect.err <<EOF
 usage: some-command [options] <args>...
-    
+
     some-command does foo and bar!
 
     -h, --help            show the help
-- 
1.5.6.rc2.183.g04614
