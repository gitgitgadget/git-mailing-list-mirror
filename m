From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/11] t8001/t8002: blame: demonstrate acceptance of bogus -L,+0 and -L,-0
Date: Wed, 31 Jul 2013 04:15:44 -0400
Message-ID: <1375258545-42240-11-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rdl-0008CM-95
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204Ab3GaIQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:51 -0400
Received: from mail-ye0-f171.google.com ([209.85.213.171]:36016 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab3GaIQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:49 -0400
Received: by mail-ye0-f171.google.com with SMTP id l10so176877yen.16
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HnLtZOkpnYU7+SA+XgII+VNLd/jHqDPou8yyLxaKK38=;
        b=IkUccxUEvgytmHB6yeL4gYePDLvB0k4SxXqAXP1ayw0dB8klGQS+zWyW9TRGurVPP9
         UxrwSxuvJ9QaVtn/07UJ5B0fWvrHMc0p+tQ0H7pwtAnpPUa2XcPst0VGJVu9uLvRRO0p
         Vol3kHvpMwoTlxlVQ4ocS+PJ07FSi0mGRe3XA0VySuhAURTXauBP+F5HuJtiWAVj3h4q
         rBumJN+8qDaGzC8dPgaouBk810gScPzrBLYMT6rhT18zHan1rKXrQ42MyJeKMILhq4i2
         DDeXKiuxVp//c15ExTI3uVbZNcXfkaXIrsQbL1xKN5VDJvhH+hXlqNGN7CXWyUszd97M
         0JwQ==
X-Received: by 10.236.192.225 with SMTP id i61mr32171127yhn.13.1375258608492;
        Wed, 31 Jul 2013 01:16:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231407>

Empty ranges -L,+0 and -L,-0 are nonsensical in the context of blame yet
they are accepted. They should be errors. Demonstrate this shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 01d50c5..d7807df 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,6 +185,10 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
+test_expect_failure 'blame -L ,+0' '
+	test_must_fail $PROG -L,+0 file
+'
+
 test_expect_success 'blame -L X,+0' '
 	test_must_fail $PROG -L1,+0 file
 '
@@ -197,6 +201,10 @@ test_expect_success 'blame -L X,+N' '
 	check_count -L3,+4 B 1 B1 1 B2 1 D 1
 '
 
+test_expect_failure 'blame -L ,-0' '
+	test_must_fail $PROG -L,-0 file
+'
+
 test_expect_success 'blame -L X,-0' '
 	test_must_fail $PROG -L1,-0 file
 '
-- 
1.8.3.4.1120.gc240c48
