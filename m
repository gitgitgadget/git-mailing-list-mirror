From: Paul Serice <paul@serice.net>
Subject: [PATCH] Fixed git:// IPv4 address problem when compiled with -DNO_IPV6.
Date: Tue, 22 Nov 2005 07:54:23 -0600
Message-ID: <4383230F.7060007@serice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 22 14:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeYbO-0004ty-4a
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 14:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVKVNyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 08:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVKVNyY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 08:54:24 -0500
Received: from serice.org ([206.123.107.184]:37390 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S964938AbVKVNyX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 08:54:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id 341B658230
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 07:54:23 -0600 (CST)
User-Agent: Thunderbird 1.5 (X11/20051025)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12547>

Failure to dereference a pointer caused incorrect initialization of
the IPv4 address when calling connect() when compiled with -DNO_IPV6.

With this patch and yesterday's patch for git-daemon, it should now be
possible to use the native git protocol for both the client and server
on Cygwin.

Signed-off-by: Paul Serice <paul@serice.net>


---

 connect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 5bc7f67c535dbbbb9340285c82226a8dd6e4afec
b16765657940be2f4d14e8f1e65d35e4b32bea0f
diff --git a/connect.c b/connect.c
index 7a417e5..93f6f80 100644
--- a/connect.c
+++ b/connect.c
@@ -427,7 +427,7 @@ static int git_tcp_connect(int fd[2], co
 		memset(&sa, 0, sizeof sa);
 		sa.sin_family = he->h_addrtype;
 		sa.sin_port = htons(nport);
-		memcpy(&sa.sin_addr, ap, he->h_length);
+		memcpy(&sa.sin_addr, *ap, he->h_length);
 
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
 			close(sockfd);
---
0.99.9.GIT
