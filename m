From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 75/83] builtin/apply: make create_one_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:15 +0200
Message-ID: <1461504863-15946-76-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDU-0000Cp-5D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbcDXNgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34627 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbcDXNgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id v200so10012875wmv.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3veF4Bzryw4kmOP8vzLXYQErsFHh0Ur1ce3o6nE0kGM=;
        b=jq8+rIy9+X5guAf1S6DvuV4NDzAS2QnR73Clv5m4PjzlwkH3w+rxi+pC3GRmw4huw3
         UBsHIHuRSPDD7FkgnjrKAGwWn+bp2jES1/eZCVvcwKPDQzu/SYn7f7cL8yozyG0O083I
         /7M0IUFh7sd+sm7IPU5RZ+FmOt1MPVejz5VhRNb2Wt6J/AmGJ1yrDtDYQPmkHXduETyW
         3v2rDdHTxeJ+caZpDcD3+VrKyeTlAmN0idU0RgEAxxlLJnkjxIljzhfxF69b+AIOykM1
         OP/eOc37fz3qkjkk3dDISj9Z6u8zYMoos7zeGsqOC/P8HtOoo3L+lkdExt5/LwYdO8Hy
         kjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3veF4Bzryw4kmOP8vzLXYQErsFHh0Ur1ce3o6nE0kGM=;
        b=JTQQcThKbHmbuU5hBO8d8LCG40XLeaxlrCzeuJ1UPD55FFfb1k7hjKTJWhna+tOovN
         hHFv7v/9BqSonOiAiPotf8w5WUmva58Ug6qqSASC61OQe6Ic9MjghLg0ZPwc3b0ix7Vu
         b4n5BCSW19MO2EiuVqDzLOAqbxjArXv9Bjuq/if2KBdg7vQSUaBRuPKZq1/EiPbQxhAU
         if0Q/0IcMwRaLNGcUVtWb7raVYMaP62MjDcMWMlBLoAedsbEIozSw0JU4EO+lpFLEb5/
         Clh2WzkcXpn+5BjQn2Gbe+cS1U139foVRqQizo1P+6abPX6ZwwFpoZqDjHA6mzo2ISW1
         Bt/g==
X-Gm-Message-State: AOPr4FW5bMVe0BgqwAhm4IWCkpWDMowNq83c161AMH7M20VmyhYVIVs/hbj0+6bnACra3g==
X-Received: by 10.194.201.37 with SMTP id jx5mr4520818wjc.60.1461504990361;
        Sun, 24 Apr 2016 06:36:30 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:29 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292365>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 32c38f0..5bd5154 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4184,32 +4184,36 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
  * We optimistically assume that the directories exist,
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
+ *
+ * Returns:
+ *   -1 on error
+ *   0 otherwise
  */
-static void create_one_file(struct apply_state *state,
-			    char *path,
-			    unsigned mode,
-			    const char *buf,
-			    unsigned long size)
+static int create_one_file(struct apply_state *state,
+			   char *path,
+			   unsigned mode,
+			   const char *buf,
+			   unsigned long size)
 {
 	int res;
 
 	if (state->cached)
-		return;
+		return 0;
 
 	res = try_create_file(path, mode, buf, size);
 	if (!res)
-		return;
+		return 0;
 	if (res < 0)
-		exit(1);
+		return -1;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
-			return;
+			return 0;
 		res = try_create_file(path, mode, buf, size);
 		if (!res)
-			return;
+			return 0;
 		if (res < 0)
-			exit(1);
+			return -1;
 	}
 
 	if (errno == EEXIST || errno == EACCES) {
@@ -4230,18 +4234,19 @@ static void create_one_file(struct apply_state *state,
 			res = try_create_file(newpath, mode, buf, size);
 			if (!res) {
 				if (!rename(newpath, path))
-					return;
+					return 0;
 				unlink_or_warn(newpath);
 				break;
 			}
 			if (res < 0)
-				exit(1);
+				return -1;
 			if (errno != EEXIST)
 				break;
 			++nr;
 		}
 	}
-	die_errno(_("unable to write file '%s' mode %o"), path, mode);
+	return error(_("unable to write file '%s' mode %o: %s"),
+		     path, mode, strerror(errno));
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4284,7 +4289,8 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(state, path, mode, buf, size);
+	if (create_one_file(state, path, mode, buf, size))
+		return -1;
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-- 
2.8.1.300.g5fed0c0
