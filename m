From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/11] t8001/t8002: blame: demonstrate acceptance of bogus -LX,+0 and -LX,-0
Date: Wed, 31 Jul 2013 04:15:42 -0400
Message-ID: <1375258545-42240-9-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rdu-0008JQ-MB
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab3GaIQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:46 -0400
Received: from mail-gh0-f176.google.com ([209.85.160.176]:42229 "EHLO
	mail-gh0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063Ab3GaIQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:44 -0400
Received: by mail-gh0-f176.google.com with SMTP id z17so173459ghb.21
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DmVOKCOm9jkbPAUs7VsoFFbxLvyYDu24w2jxwV1NRmg=;
        b=GrPt8QCZvQn4NBC0hfKjiFtjsVnE0olmhTOAtDamvQdOK3RM1EQ2AnkHYmmmBb/+Q+
         yF6xw4nJ3ae1dF1iwywYJGLDvG3taHzwA8OpDAVvtVLw9fD5eeCOPPvFQjMpXK75/U1T
         KoznSKZTb+FDuhP6VIIznvB4NfidH6W8c3QuwPWlDSm4X0B0M3sz3qwWA7Wm6SLv0XP1
         E6JBZOBEViw7EQ+a3teKcA9ZinvEg5MgtFP2EII4kLuydMjvuYyYQFvn/4xRXObUbtne
         ViTcDf7g8GWp81f7mUnGxcO556XLDDFESHEPqWu3SXwZAoREY2pJgSaV8QhNBGLO85MM
         A0Dw==
X-Received: by 10.236.105.173 with SMTP id k33mr31529146yhg.87.1375258604098;
        Wed, 31 Jul 2013 01:16:44 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231409>

Empty ranges -LX,+0 and -LX,-0 are nonsensical in the context of blame
yet they are accepted. They should be errors. Demonstrate this
shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index f117ef0..0f80cba 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,6 +185,10 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
+test_expect_failure 'blame -L X,+0' '
+	test_must_fail $PROG -L1,+0 file
+'
+
 test_expect_success 'blame -L X,+1' '
 	check_count -L3,+1 B2 1
 '
@@ -193,6 +197,10 @@ test_expect_success 'blame -L X,+N' '
 	check_count -L3,+4 B 1 B1 1 B2 1 D 1
 '
 
+test_expect_failure 'blame -L X,-0' '
+	test_must_fail $PROG -L1,-0 file
+'
+
 test_expect_success 'blame -L X,-1' '
 	check_count -L3,-1 B2 1
 '
-- 
1.8.3.4.1120.gc240c48
