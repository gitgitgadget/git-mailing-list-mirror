From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 05/19] index-helper: log warnings
Date: Thu,  5 May 2016 17:46:57 -0400
Message-ID: <1462484831-13643-6-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7R-0007pU-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbcEEVre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:47:34 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35452 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912AbcEEVrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:32 -0400
Received: by mail-qk0-f178.google.com with SMTP id j68so38888007qke.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=kxgcZJML60b5uKaL9EaU0WU9wJIw5SuFbELu5cY4hiWEiTqe86g4d++1EtttHplkX8
         lbxFHDHoJsvDDXWZeFt8yceLM6PM98MeztQOcRtCtNOhXmH2L7nkQKwELH9z/raXHuo7
         oxxwLVqbYrjkiijJeoiwnkEVZ15o8OAscjIFzutXGqVToIyZhzQwNdHyfxyCjkNd7J8R
         3nLMlZW7MfcL5Mr+V7VasJeq73XsiH9oUfWTudYWSvsQgLIgzydf9yl1i9VTMyFbbb0S
         ui7ZACvAZgByPe6kPjWwYcG39ae891PPH7OsdPkqBMl0K/CR6Q5FGCgzwRo5ewb5b1C3
         xCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=iehSTn7kdvwMwVglxMsJImz4LoxLOqUQY+jLHjwPVXyeOIKJMVEMP5MjNp5h3/+T+d
         Erw3sAGZYrM4W+cWNn3vMajQvNqC/P93obE5klg0MRnYnl2oPa/NsSMmyAPLd9x41n1p
         VSzFB6MFqf+//tQd5u9zCOUCVMv/peAL3nfYSpXH/MsciKjyZuIH0NNLeSS95+6WE9NQ
         9iRYsEM47LV8WV/pPjvOF8HqNSAPacXYFvRdB51Dsf+L3gDwCkKwdMto/3/Vm+H0WWTL
         Lytz4hjAiF6dQncWC4IWi9nT94x6TWnliAqrRPBUFu5zz7dFHh+GInkvbrt3T/kse6Qc
         mGIg==
X-Gm-Message-State: AOPr4FVdGJ5zJJ7SA/eI1mGA8aDVI5OtrFFKzGGbXwocfRLW1bhKLmylVbeg/GdlpQQqVA==
X-Received: by 10.55.60.130 with SMTP id j124mr17606149qka.197.1462484851466;
        Thu, 05 May 2016 14:47:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293688>

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
