From: larsxschneider@gmail.com
Subject: [PATCH v3 3/3] git-p4: Skip t9819 test case on case insensitive file systems
Date: Sun, 11 Oct 2015 10:55:02 -0700
Message-ID: <1444586102-82557-4-git-send-email-larsxschneider@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 19:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKq7-00069m-D3
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbJKRzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:55:13 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36165 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbJKRzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:55:08 -0400
Received: by pablk4 with SMTP id lk4so133112536pab.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BC5cffmXa5iEIAuMaeR8MLyedjAxAR5GDd9+QL3rpB4=;
        b=qm4cxeCnpzWJBjyGdGoQy50H/JMC30cVH3UjaUjXg8FFQIN+WKLJB0+hgL3kW2QxbI
         +gAAq5V7xMIdGo9V6yq3j50gIOHJMAiKvOekvKoYa64/N32uIf208Gnuc2TuhT2TXdxK
         23LpFLOn8mAIZLvgfnUHGeNfKamrIw2XIRyjCpzhz+YOByqH47EI4E9drw4J0rNEdxW1
         QEkKVfy2zOVQUbDKXZe8klNKqCGyBeTnQ9VACO/XUuUXAIMbrryWmbYij+fxIH738Gqk
         KHm7kjRQ29hlM//1z5I58M0kvfY9mTqe18n7pJiVL7CIXiAWB3OhssPfCskTAkQZ9zLw
         y2OA==
X-Received: by 10.68.87.161 with SMTP id az1mr29562887pbb.47.1444586108154;
        Sun, 11 Oct 2015 10:55:08 -0700 (PDT)
Received: from slxBook3.hsd1.ca.comcast.net (c-69-181-162-247.hsd1.ca.comcast.net. [69.181.162.247])
        by smtp.gmail.com with ESMTPSA id de4sm13746279pbb.60.2015.10.11.10.55.07
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2015 10:55:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279349>

From: Lars Schneider <larsxschneider@gmail.com>

Windows and OS X file systems are case insensitive by default.
Consequently the "git-p4-case-folding" test case does not apply to
them.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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
