From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 05/19] index-helper: log warnings
Date: Mon,  9 May 2016 16:48:35 -0400
Message-ID: <1462826929-7567-6-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7q-0004LM-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbcEIUty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:54 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34223 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbcEIUtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id r184so101991904qkc.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=DWnA1LoYn9mmafV8aXXgYT6bz5877pnpSHbbOepthpw0KbogR7g+Rx0j5y0Rgwx29G
         MKjQ3fkOjmsOgAsLkOTrxPjFQGfpLo1t87T6IPU1YZVWLdtQWTUvjFYIAl+eGb9VQhRm
         X3fwNg2aTl+bVhgK94sZMqa06FYu7+AGI8Ejvja6b7Jkarc0BfNJq03rW8tFgX2kushL
         clDF/LU4nO0mYjhTwoE1rKLm+V4t1PLzZvsfwDyyrhbl+lljs1pqwTIJR6O0sAsYk0el
         L4BPEU9FlC3A30XjpMeIVcgMBCqC/oLiye9HNHqirYfoT+va/b6WTqKKEFNCXKEW7LpN
         fDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=aBXLTZ7t5uIaYdrYt2xZUZQIF2gtZC6Oc4yhCTSxaIrKbmQptZrj+J1Ov/muV+DU2H
         CP4DGvyKryc+FsH7u/GwUmKvEc1YC5xcx/p5r7KVUfoHeGXIwQTzGSQlFib9ND68a6aw
         YjscdAagaGrk6I4HpRQIc9NAqQZrI5/sQHrQ+r0sipxalnpPUOmEpGpSwNU0XAmb+5ML
         eYczpgasHh8C1q2H+gc+gpsa9+o33z7O3m0kssS6hHhuUmfaSll1hxTDc9mXvd81Sqn/
         b4c1b55ef9q/ZLGXyS6QRNWWNwKr6YUB+N0nxL0tehns1U1cn4S50sOkefHFCxS3faMF
         F9Yw==
X-Gm-Message-State: AOPr4FUKtJPMIulOUdGCnpPiZLoBANt/3T942CV9x6IIgsHBn3jfLI9AzWeR2f2UYFYcEg==
X-Received: by 10.233.239.193 with SMTP id d184mr12304754qkg.122.1462826950074;
        Mon, 09 May 2016 13:49:10 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:09 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294067>

Instead of writing warnings to stderr, write them to a log.  Later, we'll
probably be daemonized, so writing to stderr will be pointless.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 32 ++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index 1f92c89..9c2f5eb 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -54,6 +54,9 @@ command. The following commands are used to control the daemon:
 
 All commands and replies are terminated by a NUL byte.
 
+In the event of an error, messages may be written to
+$GIT_DIR/index-helper.log.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/index-helper.c b/index-helper.c
index bc7e110..21fb431 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -19,6 +19,29 @@ static struct shm shm_index;
 static struct shm shm_base_index;
 static int to_verify = 1;
 
+static void log_warning(const char *warning, ...)
+{
+	va_list ap;
+	FILE *fp;
+
+	fp = fopen(git_path("index-helper.log"), "a");
+	if (!fp)
+		/*
+		 * Probably nobody will see this, but it's the best
+		 * we can do.
+		 */
+		die("Failed to open log for warnings");
+
+	fprintf(fp, "%"PRIuMAX"\t", (uintmax_t)time(NULL));
+
+	va_start(ap, warning);
+	vfprintf(fp, warning, ap);
+	va_end(ap);
+
+	fputc('\n', fp);
+	fclose(fp);
+}
+
 static void release_index_shm(struct shm *is)
 {
 	if (!is->shm)
@@ -93,7 +116,8 @@ static void share_index(struct index_state *istate, struct shm *is)
 	if (shared_mmap_create(istate->mmap_size, &new_mmap,
 			       git_path("shm-index-%s",
 					sha1_to_hex(istate->sha1))) < 0) {
-		die("Failed to create shm-index file");
+		log_warning("Failed to create shm-index file");
+		exit(1);
 	}
 
 
@@ -135,7 +159,7 @@ static int verify_shm(void)
 		ce = istate.cache[i];
 		if (ce->ce_namelen != base->ce_namelen ||
 		    strcmp(ce->name, base->name)) {
-			warning("mismatch at entry %d", i);
+			log_warning("mismatch at entry %d", i);
 			break;
 		}
 		ce_flags = ce->ce_flags;
@@ -149,7 +173,7 @@ static int verify_shm(void)
 		ce->ce_flags = ce_flags;
 		base->ce_flags = base_flags;
 		if (ret) {
-			warning("mismatch at entry %d", i);
+			log_warning("mismatch at entry %d", i);
 			break;
 		}
 	}
@@ -255,7 +279,7 @@ static void loop(int fd, int idle_in_seconds)
 				 * alive, nothing to do.
 				 */
 			} else {
-				warning("BUG: Bogus command %s", buf);
+				log_warning("BUG: Bogus command %s", buf);
 			}
 		} else {
 			/*
-- 
2.4.2.767.g62658d5-twtrsrc
