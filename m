From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 16/16] read-cache: config for waiting for index-helper
Date: Wed,  6 Apr 2016 18:12:02 -0400
Message-ID: <1459980722-4836-17-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhO-0004xc-OB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbcDFWNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:13:15 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33644 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbcDFWM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:59 -0400
Received: by mail-qk0-f179.google.com with SMTP id k135so19822331qke.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+jArlWpvwQlagUwt9iXAl4KBXmNw9Q4ncqXcQY9H98=;
        b=tI8lrhxvJoucykyF/pMl5XqlMZ12BX6z2NcWU0UfsusBYjFHDMjRbDlxIiGlswnX1L
         oM/MHqPbSvksFRsL6Ki4M5ixsuwwyTFmrHD98C7aWphVYeVL5ANWP5igVVxl7d278fn+
         WOMta6hYaFR721+20SP4jtU4ryaPhpP1qCSo8QeGVcFHP19TT+2oyPlHT+o0DrQPCfzK
         ryQcjRGIxk09PsrCbI/kctqUv+vHLZVwltWXmr+izj0LsSiRUlXLDlOONaacl+oIAMm1
         xuZ/m1Y2jBuh3rG68Zie7J25lpsb1UV5hI21YJ0YDNJL7caBIlT9ZfrxCHn/VKz96vI+
         shcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+jArlWpvwQlagUwt9iXAl4KBXmNw9Q4ncqXcQY9H98=;
        b=OCKGIfejz1iNHd5wOiGDUkN4wMYVQXIQoWUnXWBxLifHuljPylC7fHLOuDaLLR5TXM
         8jnxchPB9x3PC5MK1gGzGi8G4HGJT1oHAJzLsK9iA/MuI5y4xlPmseC23vzwJcHdYRAq
         I+sjeMqV0AUfBY5VrRStJYFPl3RsymWR4btqQFfzcAX6pEbQ4UZgLBrLKD7x76MTYjPC
         tMgpMlqV3vodKnsX1NUMXSEadiHSVCnDJK0uyPCSKnIH/qMhH/M69BL1ltkd673DCbPk
         ljeglGaNUu6SGT+DebmqqJy4qqJIQA3TQ/F90tAgFc4N7zoOakzBdUMXqls+YzhNs+FJ
         8fdg==
X-Gm-Message-State: AD7BkJKqgomGBC6/gAyExjVG9mXzwD2gbyohTssf2yGkRS+Y44Prp6TmH76cZAbPkJB7FQ==
X-Received: by 10.55.54.14 with SMTP id d14mr32786340qka.64.1459980772532;
        Wed, 06 Apr 2016 15:12:52 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290883>

When we poke index-helper, and index-helper is using watchman, we want
to wait for a response (showing that the watchman extension shm has
been prepared).  If it's not using watchman, we don't.

So add a new config, core.waitforindexhelper, with sensible defaults, to
configure this behavior.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt | 6 ++++++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 5 +++++
 read-cache.c             | 5 ++++-
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ec8824..f61e6fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -670,6 +670,12 @@ Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with
 another value or setting `core.pager` to `lv +c`.
 
+core.waitforindexhelper::
+	If true, git status and other commands which use the index
+	will wait for a response from the index-helper before continuing;
+	this gives time for the index-helper to communicate with watchman
+	and give information about modified files.
+
 core.whitespace::
 	A comma separated list of common whitespace problems to
 	notice.  'git diff' will use `color.diff.whitespace` to
diff --git a/cache.h b/cache.h
index 5713835..db66451 100644
--- a/cache.h
+++ b/cache.h
@@ -691,6 +691,7 @@ extern char *git_replace_ref_base;
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
index 470cd7b..23dbb73 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1800,7 +1800,10 @@ static int poke_daemon(struct index_state *istate,
 	if (refresh_cache) {
 		ret = write_in_full(fd, "refresh", 8) != 8;
 	} else {
-		ret = poke_and_wait_for_reply(fd);
+		if (wait_for_index_helper)
+			ret = poke_and_wait_for_reply(fd);
+		else
+			ret = write_in_full(fd, "poke", 5) != 5;
 	}
 
 	close(fd);
-- 
2.4.2.767.g62658d5-twtrsrc
