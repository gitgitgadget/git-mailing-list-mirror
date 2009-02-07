From: Jeff King <peff@peff.net>
Subject: [PATCH] fix uninitialized variable in string_expand_length
Date: Sat, 7 Feb 2009 05:37:23 -0500
Message-ID: <20090207103723.GA18823@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Feb 07 11:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVkaL-0001qo-VP
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 11:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZBGKh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbZBGKh1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 05:37:27 -0500
Received: from peff.net ([208.65.91.99]:41964 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbZBGKh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 05:37:26 -0500
Received: (qmail 20226 invoked by uid 107); 7 Feb 2009 10:37:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 05:37:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 05:37:23 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108839>

This led to totally unpredictable results from the function. The style
matches the loop in string_expand.

Signed-off-by: Jeff King <peff@peff.net>
---
 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 79afdb1..97794b0 100644
--- a/tig.c
+++ b/tig.c
@@ -193,7 +193,7 @@ string_expand_length(const char *line, int tabsize)
 {
 	size_t size, pos;
 
-	for (pos = 0; line[pos]; pos++) {
+	for (size = pos = 0; line[pos]; pos++) {
 		if (line[pos] == '\t' && tabsize > 0)
 			size += tabsize - (size % tabsize);
 		else
-- 
1.6.1.2.552.g1682c.dirty
