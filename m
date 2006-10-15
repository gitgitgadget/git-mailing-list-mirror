From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] Make write_sha1_file_prepare() void
Date: Sun, 15 Oct 2006 14:02:03 +0200
Message-ID: <4532233B.5070408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 14:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ4gg-0005Ib-Jo
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 14:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWJOMBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 08:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJOMBq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 08:01:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58331
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932105AbWJOMBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 08:01:46 -0400
Received: from [10.0.1.3] (p508E681A.dip.t-dialin.net [80.142.104.26])
	by neapel230.server4you.de (Postfix) with ESMTP id 84E9526015;
	Sun, 15 Oct 2006 14:01:44 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28912>

Move file name generation from write_sha1_file_prepare() to the one
caller that cares and make it a void function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 sha1_file.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d111be7..66cc767 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1347,9 +1347,9 @@ void *read_object_with_reference(const u
 	}
 }
 
-static char *write_sha1_file_prepare(void *buf, unsigned long len,
-                                     const char *type, unsigned char *sha1,
-                                     unsigned char *hdr, int *hdrlen)
+static void write_sha1_file_prepare(void *buf, unsigned long len,
+                                    const char *type, unsigned char *sha1,
+                                    unsigned char *hdr, int *hdrlen)
 {
 	SHA_CTX c;
 
@@ -1361,8 +1361,6 @@ static char *write_sha1_file_prepare(voi
 	SHA1_Update(&c, hdr, *hdrlen);
 	SHA1_Update(&c, buf, len);
 	SHA1_Final(sha1, &c);
-
-	return sha1_file_name(sha1);
 }
 
 /*
@@ -1521,7 +1519,8 @@ int write_sha1_file(void *buf, unsigned 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	filename = write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	filename = sha1_file_name(sha1);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
-- 
1.4.3.rc2.gdce3
