From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/9] t1508 (at-combinations): document @{N} versus HEAD@{N}
Date: Thu,  2 May 2013 19:09:30 +0530
Message-ID: <1367501974-6879-6-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtiP-0002D0-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759570Ab3EBNiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39453 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3EBNiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq8so351803pbb.33
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hAYztHIgeJCvLSLQHMx/ftpaM5Efb69AbHjwf5uJ5Zo=;
        b=IMT4JcJKwB12pd0PCQuGunbTtbf5A6SqpTkOCsWTmC8mXYRX6G+Zpu8BCxRbHqLMQs
         35ihkbE86R0HVFetCmQsNPkpT/oh+i3bsuEvpFGzpQMY17nyz3Z5r2DDy6D5n9Tx03ev
         oe84q28qKI5tD/KBV7lRzOV5mt4lq09B97HDtLJAMpu61Dl5L+9lpN0T+GVn+WJPpqiC
         f8Ncr9EXyDnxHNA9wKhhPez/1zT8dETqtPhocExBpnKO1467ZRh4PGZ5g6liYHSoUCFj
         JDSWeDjC4kJHAMeAQ1JFO96usW6zPqQlYoyyG/mifsSb46eM2n10EJJTRC5WTUbHwDJz
         PaMQ==
X-Received: by 10.68.108.196 with SMTP id hm4mr9042717pbb.88.1367501894319;
        Thu, 02 May 2013 06:38:14 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223200>

All the tests so far check that @{N} is the same as HEAD@{N} (for
positive N).  However, this is not always the case: write a couple of
tests for this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index eaa5337..29ffd73 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -59,4 +59,18 @@ nonsense "@{1}@{u}"
 nonsense "HEAD@{-1}"
 nonsense "@{-1}@{-1}"
 
+# Document differences between @{N} and HEAD@{N}.  The former resolves
+# HEAD to a branch and looks up the logs for that branch, while the
+# latter looks for the logs of HEAD.
+check "HEAD@{3}" commit old-two
+nonsense "@{3}"
+
+test_expect_success 'switch to old-branch' '
+	git checkout old-branch
+'
+
+check HEAD refs/heads/old-branch
+check "HEAD@{1}" commit new-two
+check "@{1}" commit old-one
+
 test_done
-- 
1.8.3.rc0.40.g09a0447
