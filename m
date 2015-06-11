From: Panagiotis Astithas <pastith@gmail.com>
Subject: [PATCH] Fix power checking on OS X
Date: Thu, 11 Jun 2015 17:37:25 +0300
Message-ID: <1434033445-35903-1-git-send-email-pastith@gmail.com>
Cc: vmiklos@frugalware.org, jon.delStrother@bestbefore.tv,
	jrnieder@gmail.com, Panagiotis Astithas <pastith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 16:37:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z33cB-0000VC-2u
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbbFKOhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 10:37:50 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35852 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbFKOhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:37:48 -0400
Received: by wgbgq6 with SMTP id gq6so6440178wgb.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tnt/C6nerFWPwLEkloBPS3Tle09s/UBR+XRLuPPM4E0=;
        b=RLUfw+VQ42lrYZBBktXdNTlUmJv8IzXJ8JGJRJEuzGGYaLsvxADJyQ6MjMYH6nYVNs
         4HyBskf2meulxHZ9B19+69JBbOM02cFkKfIaCmO0O6hhZXIpiTUZDi8USOQgvkChHEf/
         AKL/Rp8hk8wlw45fVFxTgtNblYEMJi5EAE5ZveGnmdw6n6HQ8nKvjPrHjp4b0RUcxxc1
         JZ0wQME6ISgiROD4TnP9HwToZoqePF7NWcXNuUwy4QraS9cadayL9W2StA2PHmphJk8P
         QWlVnYn1LEtcsqhbBIrs96mF/4uJ5IKHnF6S+0C2/WTAQo9hISdSmbNeed1ox12Fdu5m
         Jikg==
X-Received: by 10.194.157.168 with SMTP id wn8mr16762274wjb.79.1434033467546;
        Thu, 11 Jun 2015 07:37:47 -0700 (PDT)
Received: from localhost.localdomain (130.43.92.115.dsl.dyn.forthnet.gr. [130.43.92.115])
        by mx.google.com with ESMTPSA id pg1sm1364109wjb.39.2015.06.11.07.37.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 07:37:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271409>

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
