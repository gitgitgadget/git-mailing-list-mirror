From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 10/11] test-dump-untracked-cache: don't modify the untracked cache
Date: Wed, 27 Jan 2016 07:58:06 +0100
Message-ID: <1453877887-11586-11-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:05:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKAa-0003in-SB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbcA0HE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:28 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33450 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbcA0HD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:58 -0500
Received: by mail-wm0-f49.google.com with SMTP id 123so137514235wmz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjMhlEx3X8iIc4MzHkrUS3R12PNEi1Mm0Sk1UVojhWs=;
        b=BGLKeejTXpe/NjKPVxBN1WQ8S6rwDFfJpl2ruj5j+GLiI7Ft8O/5vu0F15mCGPwEGZ
         I058qs3+bOX36kC/KImzjc6B2y42oOumNrhI8jtETsjS8KR+CQOIdlQqD/xv7V/I8D3N
         K0+7SlAmC1/oo8x2GiB6DHlWS1cJ8+A6AQcVR50IRV34nRKtwnKLK2I6eZf0Rljfpbis
         P3bUvwL0dqcnrKMo73a8ysEnf0jk6A1Ru/XM7Xp7trfFkSE0kKzWY5mW2lE/HobPNN7b
         pER+hmde0Sa+UkLeCeSQDlLZ4GBW7+J9J1nAbTtvk/m3Biawf0SKWehHm06oHlfu9r0g
         VPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjMhlEx3X8iIc4MzHkrUS3R12PNEi1Mm0Sk1UVojhWs=;
        b=ALTttnjGpXjlu6yCGj89WSGhEzZyXYJ7wwW6hwtlu6sbrSBKnULheKCLrfmhlFLFZE
         OBIK8A1S7ngyhpi1u15tZOuy4F9P8iHhfKs0M716to8PZxTwznLOnhKfLZlc7wzCgbtg
         UkC5XE2TSfXgwKVsQlA4RgPeGBvSrY3LSxbL3/o3KWiKVFKNDnEqEb9wCEQZ3zXS12TD
         bKlcmBxTTRPDcZsuK5/ln4skhk9zgg3wNfLJmKG+0sK0LX8oY2Wxq10tkrTIKmRvSQfu
         Zncc0pBO6HzoAHHafbNZECbrhuSTDZqdopTWbHtmEzkxzrznQP0ckYBKJqiblntImNKP
         qU+A==
X-Gm-Message-State: AG10YOQLuh7iB8Wo4b/vggtk7IxcY5hnSsQNWiGrQ7OYPZEzD8YDT4JSEzx0rFo7SMeDJQ==
X-Received: by 10.28.194.197 with SMTP id s188mr26929100wmf.44.1453878237018;
        Tue, 26 Jan 2016 23:03:57 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:55 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284883>

To correctly perform its testing function,
test-dump-untracked-cache should not change the state of the
untracked cache in the index.

As a previous patch makes read_index_from() change the state of
the untracked cache and as test-dump-untracked-cache indirectly
calls this function, we need a mechanism to prevent
read_index_from() from changing the untracked cache state when
it's called from test-dump-untracked-cache.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h                     | 7 +++++++
 config.c                    | 4 ++++
 environment.c               | 7 +++++++
 test-dump-untracked-cache.c | 4 ++++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index e2900d1..69b08e9 100644
--- a/cache.h
+++ b/cache.h
@@ -1608,6 +1608,13 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 
+/*
+ * This is a hack for test programs like test-dump-untracked-cache to
+ * ensure that they do not modify the untracked cache when reading it.
+ * Do not use it otherwise!
+ */
+extern int ignore_untracked_cache_config;
+
 struct key_value_info {
 	const char *filename;
 	int linenr;
diff --git a/config.c b/config.c
index 647a15e..b95ac3a 100644
--- a/config.c
+++ b/config.c
@@ -1599,6 +1599,10 @@ int git_config_get_untracked_cache(void)
 	int val = -1;
 	const char *v;
 
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		return -1;
+
 	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
 		return val;
 
diff --git a/environment.c b/environment.c
index 1cc4aab..6dec9d0 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,13 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+/*
+ * This is a hack for test programs like test-dump-untracked-cache to
+ * ensure that they do not modify the untracked cache when reading it.
+ * Do not use it otherwise!
+ */
+int ignore_untracked_cache_config;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 25d855d..0a1c285 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,10 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
+
+	/* Hack to avoid modifying the untracked cache when we read it */
+	ignore_untracked_cache_config = 1;
+
 	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
-- 
2.7.0.181.g07d31f8
