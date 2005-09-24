From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/4] Fix git-daemon's pid_t logging
Date: Sat, 24 Sep 2005 16:12:56 +0200
Message-ID: <20050924141256.8423.53339.stgit@machine.or.cz>
References: <20050924141254.8423.80265.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:15:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAmK-0002Hw-1p
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVIXOM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVIXOM6
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:12:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3268 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932178AbVIXOM6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:12:58 -0400
Received: (qmail 8449 invoked from network); 24 Sep 2005 16:12:56 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 16:12:56 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050924141254.8423.80265.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9235>

git-daemon's logging code did not properly printf() pid_t - we need
to explicitly typecast it, since it might not be int. Pointed out
by Morten Welinder.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -22,7 +22,7 @@ static void logreport(const char *err, v
 	int maxlen, msglen;
 
 	/* sizeof(buf) should be big enough for "[pid] \n" */
-	buflen = snprintf(buf, sizeof(buf), "[%d] ", getpid());
+	buflen = snprintf(buf, sizeof(buf), "[%ld] ", (long) getpid());
 
 	maxlen = sizeof(buf) - buflen - 1; /* -1 for our own LF */
 	msglen = vsnprintf(buf + buflen, maxlen, err, params);
