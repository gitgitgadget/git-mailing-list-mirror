From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 05/19] index-helper: log warnings
Date: Wed, 27 Apr 2016 16:04:27 -0400
Message-ID: <1461787481-877-6-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVja-0003mY-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbcD0UGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:06:38 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34260 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbcD0UFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:16 -0400
Received: by mail-qk0-f170.google.com with SMTP id r184so23559221qkc.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBhDac/c2oFhCJ1W7IB9anTJLfmh5otYVccYoXvM3+Q=;
        b=UlcBQJs4WSI1eTLImiVMFcJoyO9SsrrOLz9UWssudVNdp90qr7qrS70f0C9xRQonvU
         FVj2nMWo04iEjcJ3qt62dIJWp4mHs1NTqDh0ZuywdwxpbyT13Uea8Vc7Q6fGuogIw2oo
         njUDPeE2SvJeu/Lo3aNAd3O0ox/7QFNVAbAnh00ETWt+AEmJHAccTwqAjWnxrWD6uETd
         vfjXbMqpAcHaq2IDIpqMrPNJtmIdaNjM1O/MqusRmuxiryEpTJgYVrhl9HPT0pS6QiYU
         CWy+SWc9pjRQM0UfX+ZCZ+bQUQXAQFY4+r+XQXcCOGYP8bxJeW05i8xlRKPyRv2EHIx7
         9k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBhDac/c2oFhCJ1W7IB9anTJLfmh5otYVccYoXvM3+Q=;
        b=H6LCIIW+g+N63vvasA7kaCUGdv8ErNkq7Ml5IgRhWn6ZMrcHnjwtaxi4+xr0SbMDJJ
         KlNAo3TYXC1limWr42q9tMGJBMurrWhJtWGKn1jF1IdE4rBWunliQ+ZZ8GwRZ+DtILJZ
         4Epib7kJ2rT1PzYXTKUAIACCeF3LUutoJhRRx8opxPK8lbap26maT2n4jLdbYmfZU9JC
         wTpYAtvm37dXNwxr0OIC4dz1gMVT2j5GWakUbmfg3f8Jm0biezRJpSBifxckXshzUSoI
         cljq8iSuWCf9M2V0aPtLExRfxJ2NAjs3x0yybtWz5Lw24qHjxMb1s721wj0eyaj5hRc6
         AkiQ==
X-Gm-Message-State: AOPr4FUYyiGk+iXTKDaQ5ueUqftzCPDaLELtgGO/yKTKq/QR5rwD/aK7KVto2CFnbORJ2Q==
X-Received: by 10.55.11.4 with SMTP id 4mr10306616qkl.92.1461787515052;
        Wed, 27 Apr 2016 13:05:15 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292807>

Instead of writing warnings to stderr, write them to a log.  Later, we'll
probably be daemonized, so writing to stderr will be pointless.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 29 ++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index a5c058f..4eb3d95 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -51,6 +51,9 @@ command. The following commands are used to control the daemon:
 
 All commands and replies are terminated by a 0 byte.
 
+In the event of an error, messages may be written to
+$GIT_DIR/index-helper.log.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/index-helper.c b/index-helper.c
index 5cadd0d..7400d68 100644
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
@@ -132,7 +155,7 @@ static int verify_shm(void)
 		ce = istate.cache[i];
 		if (ce->ce_namelen != base->ce_namelen ||
 		    strcmp(ce->name, base->name)) {
-			warning("mismatch at entry %d", i);
+			log_warning("mismatch at entry %d", i);
 			break;
 		}
 		ce_flags = ce->ce_flags;
@@ -146,7 +169,7 @@ static int verify_shm(void)
 		ce->ce_flags = ce_flags;
 		base->ce_flags = base_flags;
 		if (ret) {
-			warning("mismatch at entry %d", i);
+			log_warning("mismatch at entry %d", i);
 			break;
 		}
 	}
@@ -263,7 +286,7 @@ static void loop(int fd, int idle_in_seconds)
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
