From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] git-daemon: fix poll timeout
Date: Thu, 20 Oct 2005 11:33:43 +0300
Message-ID: <20051020113343.692c991d.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 10:34:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESVsC-00044A-2B
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 10:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbVJTIdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 04:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbVJTIdt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 04:33:49 -0400
Received: from magister.suomi.net ([212.50.131.141]:63687 "EHLO
	magister.suomi.net") by vger.kernel.org with ESMTP id S1751788AbVJTIdt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 04:33:49 -0400
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by magister.suomi.net
 (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0ION001PBGXN4170@magister.suomi.net> for git@vger.kernel.org;
 Thu, 20 Oct 2005 11:29:47 +0300 (EEST)
Received: from garlic.home.net (addr-82-128-203-69.suomi.net [82.128.203.69])
	by spam1.suomi.net (Postfix) with SMTP id 600D31A1F02; Thu,
 20 Oct 2005 11:33:40 +0300 (EEST)
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.2 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.422,	required 5,
 autolearn=not spam, AWL 1.10, BAYES_01 -1.52)
X-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10354>

Timeout must be negative (infinite), not 0.

---

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 50f9bed9a78e1f51178ebf6be3cd9c20b2ffcb0b
a6603be778e535b12f7aa42174889981af42b10c
diff --git a/daemon.c b/daemon.c
index c3381b3..b3bcd7a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -533,7 +533,7 @@ static int service_loop(int socknum, int
 	for (;;) {
 		int i;
 
-		if (poll(pfd, socknum, 0) < 0) {
+		if (poll(pfd, socknum, -1) < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
---
0.99.8.GIT
