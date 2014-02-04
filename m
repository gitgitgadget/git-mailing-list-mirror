From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 3/6] t0060: Add test for prefix_path when path == work tree
Date: Tue,  4 Feb 2014 15:25:17 +0100
Message-ID: <1391523920-26946-4-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgws-0002hc-OF
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbaBDOZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:47 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:56781 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaBDOZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:45 -0500
Received: by mail-ea0-f169.google.com with SMTP id h10so4487290eak.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBhy0tvND9gUl9YxutFBhhKRf9KgTag8DtSlJxnGi9k=;
        b=FIj6l1iGho6ABOv1ArZkU9igg5K9R1nLaZ+2ykbalFV+ESakT1QTKndEd14CtiGXxa
         gpGlhIJvzmbohWwoKcguBHWkhRjvvOiLHntP5G0wepz0l9MacUcQl5HekAqboqIa7ix8
         C4pQ2sBmsdqVs1Yyri9QcPXZRKE3yv6RUlr+jDEYOSUc7dilmc8oKpiJ2Rfh/AliYlGN
         W6IVkVYgzqpxE3VHl2dYXiBKI0zXm9vbRqrMgoPFo+p+dGoK3FP0UQHP8wLiAI18w1e7
         TSMDACK87O8uWhA8URy6p6rtL3iNOoPWQc/+cE0JHVIwkQbF5z7Xdo/o4vB1f7kkgnmu
         T1+g==
X-Received: by 10.14.182.5 with SMTP id n5mr3599632eem.68.1391523943954;
        Tue, 04 Feb 2014 06:25:43 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:43 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241528>

The current behaviour of prefix_path is to return an empty string if
prefixing and absolute path that only contains exactly the work tree.
This behaviour is a potential regression point.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 t/t0060-path-utils.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0bba988..b8e92e1 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -195,6 +195,12 @@ test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree
 	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
 '
 
+test_expect_success 'prefix_path works with only absolute path to work tree' '
+	echo "" >expected &&
+	test-path-utils prefix_path prefix "$(pwd)" >actual &&
+	test_cmp expected actual
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
