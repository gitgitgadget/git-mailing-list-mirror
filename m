From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/4] daemon.c:handle: Remove unneeded check for null pointer.
Date: Sun, 14 Jul 2013 23:35:46 +0200
Message-ID: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 23:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTxO-0001NW-67
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab3GNVfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:35:44 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:46250 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab3GNVfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:35:43 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so7410498eek.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jYOLibKlxeAfYpetq1bA+hNm3rtbhvhVPGQRWy1UXjY=;
        b=n2xj76SVbLOcr0+4GaP9hc85r8kFDFWK+byoiqK1VfEMGFqJRCXaFL32kfkRzsXryj
         q7pSBhfZsJWs214dPjcMl7R4cWO1l3+NH2iqkrUEHCoQTgVVthJ62xcDf45i+U9UMKJU
         SrEziL3oWUOBFLO8OQDYktwk1ImqHO9mBiWvtwjxJHKLattVi49mwAkHXX7r+FBYKePB
         iuclmHy+aQBmJbcrXFY9vYNs+lLMqpRnCcnEwRK0REqZFMILFF8H2f8274riDByVW8bc
         zPqpBCRnJs+C4YaODbDJ7WYNqAlHie6XdEni/FqhiUT5rvKct9HkeDnirt/1ZVcf+fE4
         SV7w==
X-Received: by 10.14.1.70 with SMTP id 46mr56235146eec.82.1373837741947;
        Sun, 14 Jul 2013 14:35:41 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id p49sm97600919eeu.2.2013.07.14.14.35.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.806.gdee5b9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230393>

addr doesn't need to be checked at that line as it it already accessed
7 lines before in the if (addr->sa_family).

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 6aeddcb..5e48c1e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -754,19 +754,19 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	}
 
 	if (addr->sa_family == AF_INET) {
 		struct sockaddr_in *sin_addr = (void *) addr;
 		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
 		    sizeof(addrbuf) - 12);
 		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
 		    ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
-	} else if (addr && addr->sa_family == AF_INET6) {
+	} else if (addr->sa_family == AF_INET6) {
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
 
 		char *buf = addrbuf + 12;
 		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
 		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf,
 		    sizeof(addrbuf) - 13);
 		strcat(buf, "]");
 
 		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
-- 
1.8.3.2.806.gdee5b9b
