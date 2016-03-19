From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 17/17] read-cache: config for waiting for index-helper
Date: Fri, 18 Mar 2016 21:04:50 -0400
Message-ID: <1458349490-1704-18-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Ni-00018v-RN
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbcCSBIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:38 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33019 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbcCSBI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:29 -0400
Received: by mail-qg0-f46.google.com with SMTP id a36so83023466qge.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNuDyUcpgM+YUySMqHn9nh5LTZ/VhCOcq9+mATEBJfU=;
        b=qnyrHKslZgnLOEyafjExJrCVefuT6Lnb646J2JTanVb89RZaiT7J2ZEQ4Z2wltPofq
         x/oK2ZBSAe1DZBcIHq0tnbNQwarGdZKWBqETl0jd9ZlL3t6fRd0SavDZlNqBZFMsGK6N
         ckJCRzgFWAkAgTSF5GYKO/dpGQ/8XtumFMt5Z3IOPZeGvCwPpJ8CemO4enhHbWfzVmQG
         7efnjYGVP75hrTSdbf7+2ccRaRGl5Ek3Eej0Z0VjQzGnYjqnI2rdspvdpzvXoleHrm9X
         HrwQguD5uk9MPzs4azAywXClIkaDJyKnv90AzeHFUJXsHjRVGM5PoIGLYr6oVZCxl3uF
         Bgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNuDyUcpgM+YUySMqHn9nh5LTZ/VhCOcq9+mATEBJfU=;
        b=D8XyHIDT2IwrZzPv9x918Zyt2jwxv23EJ7hd6GOSQEYpc5QVSIcL+EeBWy4+kDeQgp
         /WdmM8BLaCKCPbMmh7yhLoAM2XFlgenrT4seFFJxixOF0VwUQ3my6GyCKGh5bsJc3jDX
         MuisUYpLQh32GQbqtwVyodujibBO0cvYnCSuNaSfoJefeYJakfS43zpL0vcx7e0x0ox6
         6FBWqMATV2NvdLr92Nn/C3AQ6gQrQsavk2OYiDnyJL+SRiMBP1c0/Jtf5ivCqvmv8K9s
         On8geeOgokJnTpzhFnr31h1VgoOZ9ztDy9O2FoddCDRW+zxwQRlDe8+CIvQpGbt8Skta
         3P4w==
X-Gm-Message-State: AD7BkJIa0VlHD8Ibo9A6QyU+foG7EWQmip3TOCL/WQgJaOPj6kaIMLoljvA/d8tBUDrIzg==
X-Received: by 10.140.177.17 with SMTP id x17mr27905608qhx.39.1458349708087;
        Fri, 18 Mar 2016 18:08:28 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289282>

When we poke index-helper, and index-helper is using watchman, we want
to wait for a response (showing that the watchman extension shm has
been prepared).  If it's not using watchman, we don't.

So add a new config, core.waitforindexhelper, with sensible defaults, to
configure this behavior.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 cache.h       | 1 +
 config.c      | 5 +++++
 environment.c | 5 +++++
 read-cache.c  | 5 ++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 4ae7dd0..f8b8dbf 100644
--- a/cache.h
+++ b/cache.h
@@ -692,6 +692,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_watchman_sync_timeout;
+extern int wait_for_index_helper;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index e6dc141..5f1b8bd 100644
--- a/config.c
+++ b/config.c
@@ -887,6 +887,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.waitforindexhelper")) {
+		wait_for_index_helper = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
diff --git a/environment.c b/environment.c
index 35e03c7..c7fb0a9 100644
--- a/environment.c
+++ b/environment.c
@@ -95,6 +95,11 @@ int core_preload_index = 1;
 int ignore_untracked_cache_config;
 
 int core_watchman_sync_timeout = 300;
+#ifdef USE_WATCHMAN
+int wait_for_index_helper = 1;
+#else
+int wait_for_index_helper = 0;
+#endif
 
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
diff --git a/read-cache.c b/read-cache.c
index c141fec..7fd9b2c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1821,7 +1821,10 @@ static int poke_daemon(struct index_state *istate,
 	if (refresh_cache) {
 		ret = write_in_full(fd, "refresh", 8) == 8;
 	} else {
-		ret = poke_and_wait_for_reply(fd);
+		if (wait_for_index_helper)
+			ret = poke_and_wait_for_reply(fd);
+		else
+			ret = write_in_full(fd, "poke", 5) == 5;
 	}
 
 	close(fd);
-- 
2.4.2.767.g62658d5-twtrsrc
