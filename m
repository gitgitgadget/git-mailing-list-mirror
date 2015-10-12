From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] git-p4: Improve test case portability for t9815 git-p4-submit-fail
Date: Mon, 12 Oct 2015 10:03:03 -0700
Message-ID: <1444669384-85419-2-git-send-email-larsxschneider@gmail.com>
References: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 19:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlgVN-0004nL-Fu
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbbJLRDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:03:14 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37143 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbJLRDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:03:11 -0400
Received: by wijq8 with SMTP id q8so67206851wij.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zoLP7JWl/4xTMkqORVaI/Q88LatCRhtillji8kMtZc8=;
        b=evozkOMqQd3sF0DBbvomaBoE/0KziypiYRkNl4xFWERxR+CyF0XSZeUrLWM91XOS3D
         RHlwNESNJ/Cj2E7HBN34GPXgMcBoYmx3YIidhNWaPVvVxRY7NkSj+GOEocHdJN5WRXPV
         nQuSVOhsa4aga2Zq/p/bLOk31TCGxfMcdINbT6q5P1yUwfZoS2Gosz+mjLeTOV7IEa8v
         lV26thhKpbMJT6946nHdXKlDqHZZsF0tVUum+yTqvl6H0CnCpOApReIYhPyVvAbA5YiL
         Oa+RMQ5x28ee4qB9dxQWlYIzj43sf/6CP83rys6SorLxd0N7VfpJ2Mv0XdG8KLMPLD28
         +xnw==
X-Received: by 10.180.93.199 with SMTP id cw7mr15881485wib.4.1444669390591;
        Mon, 12 Oct 2015 10:03:10 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id ka10sm20913697wjc.30.2015.10.12.10.03.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 10:03:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279384>

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
