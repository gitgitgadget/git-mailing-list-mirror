From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] diffcore-pickaxe: make error messages more consistent
Date: Fri, 24 May 2013 16:03:54 +0530
Message-ID: <1369391635-13056-2-git-send-email-artagnon@gmail.com>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 12:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfpIQ-0007LH-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760385Ab3EXKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:32:18 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47650 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760348Ab3EXKcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:32:16 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4040864pbb.24
        for <git@vger.kernel.org>; Fri, 24 May 2013 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kX0ewCnoHOIdl9hwFXnk6S8WSMrrEVVornpayv7f+Ck=;
        b=ewaEi2pWMPxBEkliD8H/Y3Sn5HxbSt4bmWf1C+nMPRBPI/USAwkLgrPM+4Abn25PNp
         CXI0DxiHHa//PMPdUeNvKpMVvRReSLHqFBru5mCrwaoKGVJaFZgLYj4+qz7ZtYQbfsvD
         UPY9LWnPH6iw541Lw5rxI4rOyZ7CrVRJl52UpYOaBZeB7bdKf+CHTNfwJiGzgW06rUyc
         6Ml+UCtS5dXw3FthCOggUksdqQuIwARH0MbDqSMoTMaC7TploVdNKpb/IKcucd4yW8Xj
         ifdIeUiKpyDPaHXCoJLcacpU+oLmvMXdTNQzaIEbLbRl+sxMx9nKgdvvI2iGiG8p5/mH
         LuLg==
X-Received: by 10.68.191.167 with SMTP id gz7mr17503622pbc.16.1369391536393;
        Fri, 24 May 2013 03:32:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id v7sm15680718pbq.32.2013.05.24.03.32.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 03:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225342>

Currently, diffcore-pickaxe reports two distinct errors for the same
user error:

    $ git log --pickaxe-regex -S'\1'
    fatal: invalid pickaxe regex: Invalid back reference

    $ git log -G'\1' # --pickaxe-regex is implied
    fatal: invalid log-grep regex: Invalid back reference

Since the error has nothing to do with "log-grep", change the -G and -S
error messages to say "invalid regex".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diffcore-pickaxe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 63722f8..c97ac9b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -122,7 +122,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		char errbuf[1024];
 		regerror(err, &regex, errbuf, 1024);
 		regfree(&regex);
-		die("invalid log-grep regex: %s", errbuf);
+		die("invalid regex: %s", errbuf);
 	}
 
 	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
@@ -246,7 +246,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 			char errbuf[1024];
 			regerror(err, &regex, errbuf, 1024);
 			regfree(&regex);
-			die("invalid pickaxe regex: %s", errbuf);
+			die("invalid regex: %s", errbuf);
 		}
 		regexp = &regex;
 	} else {
-- 
1.8.3.rc3.17.gd95ec6c.dirty
