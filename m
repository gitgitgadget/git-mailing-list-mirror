From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 05/19] index-helper: log warnings
Date: Fri, 29 Apr 2016 21:01:59 -0400
Message-ID: <1461978133-13966-6-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJIq-0007qi-2K
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcD3BCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:02:34 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33688 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbcD3BCa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:30 -0400
Received: by mail-qk0-f180.google.com with SMTP id n63so53072984qkf.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=XfOfhtOjEO2X+ixg/+rzBnC8FsZD/BgcpM0zZtsVWP4/nGE6sNR3g3KJY2VtwRyps1
         bMxg+e7RK4bogu6JFZAqSq+flLH1DaC1i2xdCls3DDey6ywYJPFsTEvqEw9iWxkC4S99
         EgsZAiwamcyb+ef2+u8EPs9lf/hYpOaCbV0V8XnGgqAwwNDRTiIsjJoZEVvRlth9T4LE
         ecowJGVQbcQe4X0gtOeiTyXgQ1di7JhhFxcOYPOdf9IGHRduC6BgqLOkxYq+k9Ugq5MW
         iSvL6p5NkKAZeB+LMfOeh80b+WLM3+Wttfv8YV97m1CZFPMP767kmQvd2/RsAIyBex3U
         aBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/t1Jxy0igjVHaTCDNOztNiLhrnftOkHVMQjKkTAfEaA=;
        b=O9QqikSqcYw1ZZoCd4b76YL36PLJhBCLzBe3QAksvYF9ft2P9GJF6VEQHd8PhJ366R
         t6lsz6uPZqmfkMUmTGTFLGKKiIkQPIu9EAPmusXGWypmmTT51sgBppPJkEXsuI/X5v73
         nzObRT+lWx3mZbTF3BPIKUayYqHzwSktRiHKWN+XJOrVjAYyEH8/IveWbGLMb3G4j6dO
         Kl8tHyBQNyhQr/Xo+rFUfxGl0sipq8iOYpU/V1QM7aIVObTBi9yD0+2dXg05qsvivte2
         BN6UZ8EmETBUf8HFxca6OR8tHxxyzt8Uy0U5BXmeQq+5mEBVQDWqeQ77HwD7jN78LHt6
         oxsQ==
X-Gm-Message-State: AOPr4FWL9gQpm9NAW/CfPPGMUBvf+WxWX8792DjDn6GIMpyrSXrdfV0BZ/mzsCpv+ierKg==
X-Received: by 10.55.197.203 with SMTP id k72mr22408263qkl.15.1461978149481;
        Fri, 29 Apr 2016 18:02:29 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293101>

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
