From: larsxschneider@gmail.com
Subject: [PATCH v1 2/2] git-p4: Skip t9819 test case on case insensitive file systems
Date: Mon, 12 Oct 2015 10:03:04 -0700
Message-ID: <1444669384-85419-3-git-send-email-larsxschneider@gmail.com>
References: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 19:03:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlgVO-0004nL-3O
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbJLRDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:03:16 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34863 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbJLRDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:03:13 -0400
Received: by wicge5 with SMTP id ge5so158479999wic.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lytGf8wwIpBZsNsM/vnzH/Of89h++XrTbz0wX3oqLs=;
        b=y2yvDnD9aSjH2zf+A8A6bUc1vHu0bF4FjlPQgeOqBd8VTvxxl3hl2ERfbNfb7ya/yG
         j2DBWO45XUFUvkihKQHuRO9f02vFsNshIZNnmnJmO8La+gvxxEiPecTiWfS7EQly8f9O
         gCPg2InTMeiRPtpgntwhrLEshRVJORir4UdJAH96CkEVJ5Jaf31uzEe6DN7Z+++/BUdw
         jJCEJE1aF9LNop/svQKegq/BTEuG3czm6V3XIwyPQ8Wa0/ylceeBrmeVmQkrbIxpBk5A
         YukZzPeHMf94sLnmtq5EYy1blbo80uKJ4SfnFg2QMQHN+BHEzftuTG31AfhCDBDA4vCp
         1BDw==
X-Received: by 10.180.105.33 with SMTP id gj1mr14881291wib.90.1444669392526;
        Mon, 12 Oct 2015 10:03:12 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id ka10sm20913697wjc.30.2015.10.12.10.03.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 10:03:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279385>

From: Lars Schneider <larsxschneider@gmail.com>

Windows and OS X file systems are case insensitive by default.
Consequently the "git-p4-case-folding" test case does not apply to
them.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 t/t9819-git-p4-case-folding.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index 78f1d0f..d808c00 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -4,6 +4,12 @@ test_description='interaction with P4 case-folding'
 
 . ./lib-git-p4.sh
 
+if test_have_prereq CASE_INSENSITIVE_FS
+then
+	skip_all='skipping P4 case-folding tests; case insensitive file system detected'
+	test_done
+fi
+
 test_expect_success 'start p4d with case folding enabled' '
 	start_p4d -C1
 '
-- 
2.5.1
