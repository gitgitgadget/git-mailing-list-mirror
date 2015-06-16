From: Panagiotis Astithas <pastith@gmail.com>
Subject: [PATCH] Fix power checking on OS X
Date: Tue, 16 Jun 2015 10:36:07 +0300
Message-ID: <1434440167-1046-1-git-send-email-pastith@gmail.com>
Cc: git@vger.kernel.org, Panagiotis Astithas <pastith@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 16 09:37:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4lRF-0006Zq-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 09:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbbFPHhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 03:37:38 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35193 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbFPHhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 03:37:36 -0400
Received: by wgbhy7 with SMTP id hy7so5727892wgb.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tnt/C6nerFWPwLEkloBPS3Tle09s/UBR+XRLuPPM4E0=;
        b=kCE3vKhjZGyqDZeaGNOu1or16ySoi9aL4METj35GFMSFAbd45E5RNQ2lGgs4wAA+g9
         E+5ZdvY/Ci48nHq01er4RO04jRp5th8CFNlGVEXl9tboUXTk3KfnoAHDWsfGiKpGIPY2
         Hbo4UdfyN4tTWolMNuwRAT/XlsbqBwdI4me/5IoDY1cftH+JQLb1ft0AndZd62qamWnm
         oumnd0IwSY3+PWe4LDeookN4Z6nO5shwVmvSMA7wSWfeWoOOrlrU2xb1OCT3cTL3/Svy
         5hauSqN4cPaKgWUaplQqOOHl1puknRFyfLFFoo3KVKqc03MrhVDxJriuJt7vQEp9yVDp
         HeCw==
X-Received: by 10.180.91.166 with SMTP id cf6mr3261596wib.61.1434440255154;
        Tue, 16 Jun 2015 00:37:35 -0700 (PDT)
Received: from localhost.localdomain (193.92.220.118.dsl.dyn.forthnet.gr. [193.92.220.118])
        by mx.google.com with ESMTPSA id fi6sm1204193wib.6.2015.06.16.00.37.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 00:37:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271740>

The output of "pmset -g batt" changed at some point from
"Currently drawing from 'AC Power'" to the slightly different
"Now drawing from 'AC Power'". Starting the match from "drawing"
makes the check work in both old and new versions of OS X.

Signed-off-by: Panagiotis Astithas <pastith@gmail.com>
---
 contrib/hooks/pre-auto-gc-battery | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index 9d0c2d1..6a2cdeb 100755
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -33,7 +33,7 @@ elif grep -q "AC Power \+: 1" /proc/pmu/info 2>/dev/null
 then
 	exit 0
 elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt |
-	grep -q "Currently drawing from 'AC Power'"
+	grep -q "drawing from 'AC Power'"
 then
 	exit 0
 fi
-- 
2.4.1
