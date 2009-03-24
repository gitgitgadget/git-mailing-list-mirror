From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Increase the size of the die/warning buffer to avoid
	truncation
Date: Tue, 24 Mar 2009 16:10:35 -0700
Message-ID: <20090324231035.GR23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFmy-00062P-OD
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZCXXKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbZCXXKh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:10:37 -0400
Received: from george.spearce.org ([209.20.77.23]:51591 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbZCXXKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:10:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DC7F838211; Tue, 24 Mar 2009 23:10:35 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114509>

Long messages like those from lockfile.c when a lock can't be
obtained truncate with only 256 bytes in the message buffer.
Bump it to 1024 to give more space for these longer cases.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This works around the truncation I noticed in the error message
 from the second command in the sequence:

   $ git branch foo.lock
   $ git branch foo

 usage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/usage.c b/usage.c
index 24f5fc0..820d09f 100644
--- a/usage.c
+++ b/usage.c
@@ -7,7 +7,7 @@
 
 static void report(const char *prefix, const char *err, va_list params)
 {
-	char msg[256];
+	char msg[1024];
 	vsnprintf(msg, sizeof(msg), err, params);
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
-- 
1.6.2.1.471.g682837
