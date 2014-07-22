From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 03:49:56 -0700
Message-ID: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 12:51:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Xf6-00024m-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 12:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbaGVKvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 06:51:07 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39516 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaGVKvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 06:51:06 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so10871112pdj.35
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JreLshngltMcWXoFoK1ERvTVQBToa0OPljXh5mFChWs=;
        b=b+ozeJtvNo7EntgGzBHxcZT4HFPIifz7Bd5ptqLcMJEQ/J9OFOwlqmLOLGYcv4Kkfa
         CXjaJGFAEMNfpDbtQBHTdS9nEe/LEOAb0eUGK7KxvmQhnrDrx2c/zaB/wQbsTDoxsEG/
         /G0CryAYIuIFwpMyGGy7mAQKPOItkOpSCTGsrbv/4a/Xhd8taLWktr6+K/F6cWj4DNtG
         32rJyA/BKVdBp+JTO7xETGFebDdWYzSKxVAfpYadasGZj/UdiaNpMSMv/QcygKQPjPIB
         xYS847ilA9LExiM7YhmuPP49YW5ANCLGeiTlKRtM2sO67Gq4WsCFjhqzhbjyWuKnfHqs
         +rrw==
X-Received: by 10.68.194.229 with SMTP id hz5mr20918379pbc.91.1406026263941;
        Tue, 22 Jul 2014 03:51:03 -0700 (PDT)
Received: from localhost.localdomain ([182.67.207.4])
        by mx.google.com with ESMTPSA id fb7sm26304pdb.68.2014.07.22.03.51.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 03:51:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254011>

`git_config_string()` output parameter `dest` is declared as a const
which is unnecessary as the caller of the function is given a strduped
string which can be modified without causing any harm.

Thus, remove the const from the function signature.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h  | 2 +-
 config.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 92fc9f1..93d357a 100644
--- a/cache.h
+++ b/cache.h
@@ -1303,7 +1303,7 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
-extern int git_config_string(const char **, const char *, const char *);
+extern int git_config_string(char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
diff --git a/config.c b/config.c
index ba882a1..25e28a7 100644
--- a/config.c
+++ b/config.c
@@ -633,7 +633,7 @@ int git_config_bool(const char *name, const char *value)
 	return !!git_config_bool_or_int(name, value, &discard);
 }
 
-int git_config_string(const char **dest, const char *var, const char *value)
+int git_config_string(char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
-- 
1.9.0.GIT
