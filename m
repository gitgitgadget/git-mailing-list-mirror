From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] diffcore-pickaxe: make error messages more consistent
Date: Tue, 14 May 2013 19:46:13 +0530
Message-ID: <1368540973-25830-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 16:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcFzz-0001xi-9S
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 16:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab3ENOOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 10:14:36 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:64108 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3ENOOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 10:14:34 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so335360dan.39
        for <git@vger.kernel.org>; Tue, 14 May 2013 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Mm6JVp4eYpNAibEc+6R2ulwfiF9NMFN6q+dNodhzBUI=;
        b=x9GafUzQVFonMjM+j2nNzl3m7asMqvcoam4b/PYQMu/rXmXiqtBprt8iUfvzOpaMfQ
         73UbkTmQeQMlyex5Cadk4xR/czQFvKLwV9SYectefTiwXFzRP01A62jaz5E2GKEXgdtv
         sa3ILpGGe0KDh9PMPTAgmftKtIpiEhFyv85hny9E9Dc9ydwnFV+FpacWAZ3KLwnM7CXU
         UjT3Y8OOWyNkmdgS2ph/KCLPHcip4WlfDLs6ChedrdP+CUboCXMaXE+ST3U6omQEaO3x
         8x9Oh6nZsZ1qaSegm79gsaLSbvAI+VjfXAhXhqvMvo7MqEglTFXG4er/uMO/zKz23V2l
         iNIw==
X-Received: by 10.66.27.197 with SMTP id v5mr34426391pag.211.1368540874358;
        Tue, 14 May 2013 07:14:34 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ag4sm18431277pbc.20.2013.05.14.07.14.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 14 May 2013 07:14:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.61.g2cacfff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224300>

Currently, diffcore-pickaxe reports two distinct errors for the same
user error:

    $ git log --pickaxe-regex -S'\1'
    fatal: invalid pickaxe regex: Invalid back reference

    $ git log -G'\1' # --pickaxe-regex is implied
    fatal: invalid log-grep regex: Invalid back reference

Since the error has nothing to do with "log-grep", change the -G error
message to match the -S error message.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Sorry I couldn't do more.  diffcore-pickaxe.c isn't at all easy to
 hack on, because there are so few tests guarding it.

 diffcore-pickaxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 63722f8..d69a7a2 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -122,7 +122,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		char errbuf[1024];
 		regerror(err, &regex, errbuf, 1024);
 		regfree(&regex);
-		die("invalid log-grep regex: %s", errbuf);
+		die("invalid pickaxe regex: %s", errbuf);
 	}
 
 	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
-- 
1.8.3.rc1.61.g2cacfff
