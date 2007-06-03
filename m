From: Steven Grimm <koreth@midwinter.com>
Subject: [tig PATCH] Fix integer type mismatch on 64-bit systems
Date: Sun, 3 Jun 2007 14:12:06 -0700
Message-ID: <20070603211206.GA16445@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 23:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuxN1-0005AA-5U
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 23:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXFCVMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXFCVMI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 17:12:08 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53823 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbXFCVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 17:12:07 -0400
Received: (qmail 16648 invoked by uid 1001); 3 Jun 2007 21:12:06 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49036>

fprintf wants an int parameter for the field width of a "%.*s" expression, but
the code was passing a size_t instead. This potentially broke systems where
sizeof(size_t) != sizeof(int). And even on systems where it did't break,
it still caused a compiler warning.
---
 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 6adfb33..b09d91b 100644
--- a/tig.c
+++ b/tig.c
@@ -1153,7 +1153,7 @@ read_option(char *opt, size_t optlen, char *value, size_t valuelen)
 
 	if (status == ERR) {
 		fprintf(stderr, "Error on line %d, near '%.*s': %s\n",
-			config_lineno, optlen, opt, config_msg);
+			config_lineno, (int) optlen, opt, config_msg);
 		config_errors = TRUE;
 	}
 
-- 
1.5.2.35.ga334
