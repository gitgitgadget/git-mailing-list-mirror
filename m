From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 3/7] add a test for semantic errors in config files
Date: Wed, 23 Jul 2014 11:42:54 -0700
Message-ID: <1406140978-9472-4-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WK-0006cP-AX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbaGWSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:44:00 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51321 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:43:58 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so2098832pdb.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vw99kqtXlgp59UTS7Z0O4H9bO1Ajveyi2HxAQBYS9qc=;
        b=CGmYHV1UxiUQcJ5LtbnGE+BCer7vEr0JN8NtnYLJsGoqVkpi0nWfX578YGXhiSizhi
         QCqWLlRVeDiU2Hjvh0Cit2wtEgtqE5X/6ykKcFqYjrhbgAyrmuLJVLDsO/KmSzWvB1Ug
         ck4+HTlH7CHi+dAdWhQvXcWiaj8XPDaEzQg3pMIYssNeuj7EkYjwlmJFF897bedXgv2z
         K1tQzGPusPl7v8aJrLF1h0lWM96B3Cm5yxuKFTOJFo0Vta31ckjfR6eayD93dhQMBgOF
         kI2HDuHQjRDOdlD6gUsXa34mfeNjYcqo+eEzXNEo0nrwrgob6dFFe4U118LVpNEA8hZd
         UyWQ==
X-Received: by 10.70.137.103 with SMTP id qh7mr4383247pdb.69.1406141037988;
        Wed, 23 Jul 2014 11:43:57 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.43.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:43:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254104>

Semantic errors (for example, for alias.* variables NULL values are
not allowed) in configuration files cause a die printing the line
number and file name of the offending value.

Add a test documenting that such errors cause a die printing the
accurate line number and file name.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..bd033df 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -197,4 +197,12 @@ test_expect_success 'proper error on error in custom config files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check line errors for malformed values' '
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	echo "[alias]\n br" >.git/config &&
+	test_expect_code 128 git br 2>result &&
+	grep "fatal: bad config file line 2 in .git/config" result
+'
+
 test_done
-- 
1.9.0.GIT
