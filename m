From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed,  8 Jun 2016 02:24:53 +0530
Message-ID: <20160607205454.22576-3-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO2m-0004Hr-Md
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161529AbcFGU4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:56:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35382 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161206AbcFGU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:56:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id t190so1763503pfb.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8n8Jp9xv8NBKOir2t1Yix595T+wCDSKDPQ4utJx24s=;
        b=YGvhq2lAGtj3gpjB5pEvWxDvX0Ig3abwI57md7E8GOqR9YYyC5aTLemBTp1ZhzihXQ
         ZWU2tUo6SK72q0soxbqPFjsYjlU4BytWJYW++Lxp4yEETvcVKwh7Au+R9sAHRwpDqLjJ
         dCp0AKzwIOABWCS+radn/l+1QTs05RfIGPLpxacNM8MQIW45Qn6jYbRLL4H8yWwxZyTY
         r5Qrp1inM/acHrKOK5cRla07LKZqSatQlqzNHbDCJrwmLSPSlE1/13fGns2Zgor8P9vK
         CPAi6zMcQTmZEuZ+eGM3dlRschDZWxPJXGeyqnLk2R2mkybesMLyKn5vgU7fS/h9f5nb
         UsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8n8Jp9xv8NBKOir2t1Yix595T+wCDSKDPQ4utJx24s=;
        b=N771mfDY4yFzG4dozLIB8jiH2zE0kZlIaqH8U0bh2qJWciyHx0uCW6nhspGZp4WVEJ
         3sUtTd7EH9Uo131LGciX1Z+260Gzi6GU8p1GmacMhQqF/nfyMBgtR+voy0acHu2RwnIY
         CZSEc58CWACPKve3kJqR3iBiq8IVOqGfwJolovNfHAb+Z4YglisqCj9pi9UQWfee3LnE
         8groub5jCwAPHg+aygKU3hvf7BWdbmlQYPtpdCll7FBr+qY8O19gR+JdG+FLVev3+CBj
         aSa6vy1UHWR6Z6XCugaQ/GRxRxoTC7v265ATUuOoUNpCnncC9A+xPUP7ReePaX0hmFf8
         FY2A==
X-Gm-Message-State: ALyK8tIzRUEL4CnXEqvsB8ARtdjrhQZLurkz6GcD4/u67zf6NBLbrthZx4LloycUEk57Vw==
X-Received: by 10.98.96.67 with SMTP id u64mr1465890pfb.152.1465332965071;
        Tue, 07 Jun 2016 13:56:05 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.232])
        by smtp.gmail.com with ESMTPSA id hw10sm35183194pac.15.2016.06.07.13.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jun 2016 13:56:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296719>

At times we require to see if the file is empty and get the size of the
file. By using stat we can get the file size without actually having to
open the file to check for its contents.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 dir.c | 8 ++++++++
 dir.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/dir.c b/dir.c
index 6172b34..eaee718 100644
--- a/dir.c
+++ b/dir.c
@@ -2036,6 +2036,14 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+ssize_t file_size(const char *filename)
+{
+	struct stat st;
+	if (stat(filename, &st) < 0)
+		return -1;
+	return xsize_t(st.st_size);
+}
+
 static int cmp_icase(char a, char b)
 {
 	if (a == b)
diff --git a/dir.h b/dir.h
index bfde698..aa9d276 100644
--- a/dir.h
+++ b/dir.h
@@ -248,6 +248,13 @@ extern void clear_exclude_list(struct exclude_list *el);
 extern void clear_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
 
+/*
+ * Return the size of the file `filename`. It returns -1 if error
+ * occurred, 0 if file is empty and a positive number denoting the size
+ * of the file.
+ */
+extern ssize_t file_size(const char *);
+
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
 
-- 
2.8.3
