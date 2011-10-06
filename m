From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] strbuf.c: remove unnecessary strbuf_grow() from strbuf_getwholeline()
Date: Wed,  5 Oct 2011 23:21:33 -0500
Message-ID: <1317874893-4167-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 06:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBfj6-0004w3-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 06:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab1JFEWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 00:22:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33843 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1JFEWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 00:22:00 -0400
Received: by gyg10 with SMTP id 10so2236522gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CL0hUlfjpr5oPeDfP8CQSzq7ZznHq6gICZLz461NSz4=;
        b=nTa9+9Ct5Sxk68kEDNXPY/zca0/Ycaw48+riIvNgUK6j7WAtWfUB5lExYc8QCXHmlT
         GyEiNkhoCyXKTqpFwrz750gy53f8Lx9Xcud29Zq5jwvjcllqDGExYXr0gDcen8/nxISf
         2xymTWtoG6vCxmWPVqf2RTMYRZE078vMgvKWU=
Received: by 10.150.142.1 with SMTP id p1mr213608ybd.254.1317874919356;
        Wed, 05 Oct 2011 21:21:59 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id j13sm11296889ani.19.2011.10.05.21.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 21:21:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1.ge3b6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182927>

This use of strbuf_grow() is a historical artifact that was once used to
ensure that strbuf.buf was allocated and properly nul-terminated.  This
was added before the introduction of the slopbuf in b315c5c0, which
guarantees that strbuf.buf always points to a usable nul-terminated string.
So let's remove it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 strbuf.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 9ff1b59..3ad2cc0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -357,7 +357,6 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
 
-	strbuf_grow(sb, 0);
 	if (feof(fp))
 		return EOF;
 
-- 
1.7.7.1.ge3b6f
