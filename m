From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] config: set help text for --bool-or-int
Date: Sat,  7 Mar 2009 12:14:05 -0500
Message-ID: <1236446046-18319-3-git-send-email-peff@peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg08P-0002gY-90
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZCGRO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbZCGRO5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:14:57 -0500
Received: from peff.net ([208.65.91.99]:47635 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258AbZCGRO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:14:57 -0500
Received: (qmail 15995 invoked by uid 107); 7 Mar 2009 17:14:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 12:14:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 12:14:46 -0500
X-Mailer: git-send-email 1.6.2.195.g44251.dirty
In-Reply-To: <1236446046-18319-1-git-send-email-peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112552>

The conversion to parse_opt left this as NULL; on glibc
systems, the usage message prints

   --bool-or-int   (null)

and on other ones, segfaults.

Signed-off-by: Jeff King <peff@peff.net>
---
I found this by running t1300 on a non-glibc system. I guess printing
(null) is friendlier for real code, but for the test suite, it would be
much more convenient to have it segfault to detect the bug. This is not
the first such error we've had that I've caught in the same way.

 builtin-config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index b11a096..1a3baa1 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -68,7 +68,7 @@ static struct option builtin_config_options[] = {
 	OPT_GROUP("Type"),
 	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
 	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, NULL, TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
-- 
1.6.2.195.g44251.dirty
