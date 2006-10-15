From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] Replace open-coded version of hash_sha1_file()
Date: Sun, 15 Oct 2006 14:02:18 +0200
Message-ID: <4532234A.3090700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 14:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ4go-0005JX-Is
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 14:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWJOMBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 08:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJOMBz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 08:01:55 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59611
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932107AbWJOMBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 08:01:55 -0400
Received: from [10.0.1.3] (p508E681A.dip.t-dialin.net [80.142.104.26])
	by neapel230.server4you.de (Postfix) with ESMTP id 1E75C26015;
	Sun, 15 Oct 2006 14:01:54 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28913>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 sha1_file.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 66cc767..716aef3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -671,14 +671,8 @@ static void reprepare_packed_git(void)
 
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
-	char header[100];
 	unsigned char real_sha1[20];
-	SHA_CTX c;
-
-	SHA1_Init(&c);
-	SHA1_Update(&c, header, 1+sprintf(header, "%s %lu", type, size));
-	SHA1_Update(&c, map, size);
-	SHA1_Final(real_sha1, &c);
+	hash_sha1_file(map, size, type, real_sha1);
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-- 
1.4.3.rc2.gdce3
