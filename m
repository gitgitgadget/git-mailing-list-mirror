From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Tue, 23 Jul 2013 10:28:05 -0400
Message-ID: <1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1da8-00053l-7J
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab3GWO2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:41 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64401 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3GWO2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:40 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so11174228oag.26
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=e8EAJkCIA6Hx8e5JZ2lSSXUmiurqxJKzWpIkNqWukNY=;
        b=Z81E1xRAgi/qwytFZY2OYOc1wz0SXqmmLwIwr5fUtoyrBKK/2fvQk+HQhbv/ESsBxe
         FTZLhegiCQjQd2/wODSXjcM7OSqHaEOuaA92wCSH++1pCDGdCD9to5SzzUCvJoqyrFix
         GNJ2Vw1ECgDQ1Tt8p7JxgdBPwTNeZEDLkZqpMthCSxz0IIF8jItL4PkKUgEjDBGDmttc
         6foCsHPDEt6o0AoNU4MDdNqxthIqR+aOSrnDhd+Z1uljc08gAdeLpuSw0LnuHjSq7QBS
         LqJOe+R/h1qQGZVVTIwp/QkUoK0zKdcddH8clFXHm4euXJGHfAZ2x/ExOBg/WHZnEhs9
         ICIg==
X-Received: by 10.182.165.198 with SMTP id za6mr24163128obb.88.1374589719511;
        Tue, 23 Jul 2013 07:28:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231037>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4211-line-log.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7776f93..1db1edd 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -64,4 +64,12 @@ test_bad_opts "-L 1,1000:b.c" "has only.*lines"
 test_bad_opts "-L :b.c" "argument.*not of the form"
 test_bad_opts "-L :foo:b.c" "no match"
 
+# There is a separate bug when an empty -L range is the first -L encountered,
+# thus to demonstrate this particular bug, the empty -L range must follow a
+# non-empty -L range.
+test_expect_failure '-L {empty-range} (any -L)' '
+	n=$(expr $(cat b.c | wc -l) + 1) &&
+	git log -L1,1:b.c -L$n:b.c
+'
+
 test_done
-- 
1.8.3.4.1120.gc240c48
