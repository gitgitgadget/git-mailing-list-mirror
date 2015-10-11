From: larsxschneider@gmail.com
Subject: [PATCH v3 2/3] git-p4: Improve test case portability for t9815 git-p4-submit-fail
Date: Sun, 11 Oct 2015 10:55:01 -0700
Message-ID: <1444586102-82557-3-git-send-email-larsxschneider@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 19:55:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKqF-0006Hy-LM
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbJKRzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:55:20 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32786 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbJKRzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:55:07 -0400
Received: by pacex6 with SMTP id ex6so4803580pac.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zoLP7JWl/4xTMkqORVaI/Q88LatCRhtillji8kMtZc8=;
        b=HL0kMKsOE0FaVDIkCbsFU8xuIrlcDDSmTlhm5y6GEIqeXnBDSap5eVTtL5F/fDktxl
         udidHjLB6HF6KOtDJ+1kSqgvlAn6rZlevxWIaRRIDbz1ayCFXrDAbKQFOAiX73x28YiC
         5uGiaWAKvfdyYfZvKvvyHqHFNyw50TdO4Jgs2/miobL0/1W58/km99maOCeVLiFmmOnN
         JdxCTpC0sgG7PEDg9yaZUouPjKHfSMzyk+bqGEe+REZHOEkiqTqkRxDkt/FZ7q75ARcp
         uS7pgCEJKWIqg5qUIEr+0y4eYKLOMN6rUOMT4dppshcpFkW63e+93/pgfolRY4gawo/L
         SGJw==
X-Received: by 10.68.57.197 with SMTP id k5mr29318800pbq.142.1444586107315;
        Sun, 11 Oct 2015 10:55:07 -0700 (PDT)
Received: from slxBook3.hsd1.ca.comcast.net (c-69-181-162-247.hsd1.ca.comcast.net. [69.181.162.247])
        by smtp.gmail.com with ESMTPSA id de4sm13746279pbb.60.2015.10.11.10.55.06
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2015 10:55:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279350>

From: Lars Schneider <larsxschneider@gmail.com>

Replace the stats command with the ls command to check file mode bits.
The stats command is not available on Windows and has different
command line options on OS X.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9815-git-p4-submit-fail.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 4cff6a7..37b42d0 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -417,11 +417,8 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		! p4 fstat -T action text &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		if test_have_prereq !CYGWIN
-		then
-			stat --format=%A text | egrep ^-r-- &&
-			stat --format=%A text+x | egrep ^-r-x
-		fi
+		ls -l text | egrep ^-r-- &&
+		ls -l text+x | egrep ^-r-x
 	)
 '
 
-- 
2.5.1
