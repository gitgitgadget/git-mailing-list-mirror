From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] diffcore-pickaxe: make error messages more consistent
Date: Fri, 31 May 2013 17:42:14 +0530
Message-ID: <1370002335-6596-2-git-send-email-artagnon@gmail.com>
References: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 31 14:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiOAL-0001P9-4I
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 14:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab3EaMKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 08:10:36 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44825 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab3EaMKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 08:10:32 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so2096561pdi.36
        for <git@vger.kernel.org>; Fri, 31 May 2013 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GTLJvpndO9yec3cbMIMg8EtEEfymCj3l16RdmxdmK98=;
        b=HWGTPRtViVrAklV34p42MfX0p8oug8n81nsJAJK+q36OKQwJ/rNzuhYWSy7SXlPlUE
         HXUIhEy368ImibEhqqL20/HsS27muPM3CqKwVbbI/OQOglfLrb0pjFTjLnYZ9pxM52IE
         h/WiQK0ovdPbXcuKP50/xSDfNhqDS91Iu5QoL3Qfd6yE+J10zXl9k83ybhk7O27Ue5FV
         jhmv57wNUX3zYbCck2xPyAqHxBz6b/VTwCUiBBdZzXAvbc3M1BKpy4ptPmXJ1b85l91l
         Drd5IoOIl1ZsGgLX8jeLv6Z1yqK8SwD058EyPdgHzQl5aAa6ejB4zTAr8530zhf31J29
         A1cQ==
X-Received: by 10.68.132.199 with SMTP id ow7mr12462732pbb.161.1370002231476;
        Fri, 31 May 2013 05:10:31 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm46430663pbc.42.2013.05.31.05.10.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 05:10:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.114.gcd03571
In-Reply-To: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226091>

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
1.8.3.114.gcd03571
