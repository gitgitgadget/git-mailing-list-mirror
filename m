From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 8/9] t5521: test --dry-run does not make any changes
Date: Wed, 13 May 2015 17:08:55 +0800
Message-ID: <1431508136-15313-9-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:10:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfy-0003Or-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbbEMJJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33519 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbbEMJJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:47 -0400
Received: by pacwv17 with SMTP id wv17so44622025pac.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZYupdD9j+UNix69dClDrzSWI+5XO2cu1Dy5RdY4OG8=;
        b=wpuBrwx3q70kuoKMeansV4dgU5yTq4uCctlqgCgrWwNEd78RMpvC8Fg3QJTs9riX3U
         wcRAjbxmBl3K2/PTPDnQYsxawZH28Pfeg2YHd8VFwBZh7AEKtayYuIf3PL5J3j2D8EjB
         n6325pgDPqNRjTaN/sJMEu0XtuX97QVUGS9xRpeZ3DajHA2psGlu5lesWgKB5G1HwUSw
         eXblMr9wntu+kslfE0JBUbmb0O0PgACDsNCg930G3+qLg58ii4hVB/6DHN/iCOAgagy/
         j5t7kzJ1MO5QpvdVsSxNx49aTfz02AyvGML/UJrAqfa4v+O1aROcRXjP14aQ250xuhnR
         oqPg==
X-Received: by 10.68.216.10 with SMTP id om10mr35268751pbc.152.1431508186698;
        Wed, 13 May 2015 02:09:46 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:45 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268959>

Test that when --dry-run is provided to git-pull, it does not make any
changes, namely:

* --dry-run gets passed to git-fetch, so no FETCH_HEAD will be created
  and no refs will be fetched.

* The index and work tree will not be modified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5521-pull-options.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 453aba5..37d6db6 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,4 +117,17 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'git pull --dry-run' '
+	test_when_finished "rm -rf clonedry" &&
+	git init clonedry &&
+	(
+		cd clonedry &&
+		git pull --dry-run ../parent &&
+		test_path_is_missing .git/FETCH_HEAD &&
+		test_path_is_missing .git/refs/heads/master &&
+		test_path_is_missing .git/index &&
+		test_path_is_missing file
+	)
+'
+
 test_done
-- 
2.1.4
