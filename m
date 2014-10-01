From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 3/3] daemon: remove write-only variable maxfd
Date: Wed, 01 Oct 2014 12:21:57 +0200
Message-ID: <542BD5C5.7050604@web.de>
References: <542BD471.3000308@web.de> <542BD4E7.7030401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:22:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH3g-0008Vu-6B
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbaJAKWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:22:52 -0400
Received: from mout.web.de ([212.227.15.3]:63144 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaJAKWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 06:22:52 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M95ET-1XP8ZI2sxR-00CTYg; Wed, 01 Oct 2014 12:22:49
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <542BD4E7.7030401@web.de>
X-Provags-ID: V03:K0:ODI/xgu8Zy0A+rU4fvWrEBhxQ1YhD6MXOiFdzDrkUxcsMhyHDlY
 Vzt2qi4WskiAr+WmBixY7SeO9+S9H+Gn6rwRtGvJbsuYO23AKAj/Lssf0aP7Wv/8oFtQH6H
 pRR3FU/UTk2n0NO1NZoudXxjGPs1ilkihd188JvCYM22Ic8pr+i+f2iDUL0k52ursF3Rqim
 firlPJOEeORlPINSRtV5g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257698>

It became unused when 6573faff (NO_IPV6 support for git daemon) replaced
select() with poll().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 090f6a4..54a03bd 100644
--- a/daemon.c
+++ b/daemon.c
@@ -815,7 +815,6 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
 static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
 {
 	int socknum = 0;
-	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
@@ -883,9 +882,6 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
 		socklist->list[socklist->nr++] = sockfd;
 		socknum++;
-
-		if (maxfd < sockfd)
-			maxfd = sockfd;
 	}
 
 	freeaddrinfo(ai0);
-- 
2.1.2
