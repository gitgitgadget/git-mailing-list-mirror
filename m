From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 10/11] test-dump-untracked-cache: don't modify the untracked cache
Date: Fri, 15 Jan 2016 07:59:51 +0100
Message-ID: <1452841192-620-11-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:01:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNc-0005DP-4s
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbcAOHBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:01:01 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34533 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbcAOHAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:51 -0500
Received: by mail-wm0-f49.google.com with SMTP id u188so11043193wmu.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6kf0mps+7ifNSv0yg4gWpu4PYmNLSKpxaRC4wxAYrUI=;
        b=VLLnUdlkxrXaGzFjYVH3Z8zsUIROoewe2o00e0peFcFFfSTkL0hJ27D2lkT2P9lN6o
         l+xF3Nuy0LWYz7xvCvXgPrnCjTxzfo4vto4UCyDtCcCDhpkpypV5MjbK64pZgoDkFFT1
         YvoHwuX8+U8YwIi1gzAvyG/oX3oIBzLfrku9e0sye9sBAI4ez+TV0k8zl4a3gnvTH2e8
         /SZ38fbgqVpx8eg5Fb47NO4T/uXgk+eEvNyLfly9PnppmLaNcsVeFae9khBGGvy2ALRL
         vH2XpjNJDsZ8CfdcbnlBRFIe4H4On6KY3BKnBShooI/TOtc546YXjWZe/YpUVk+HFXgS
         EnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6kf0mps+7ifNSv0yg4gWpu4PYmNLSKpxaRC4wxAYrUI=;
        b=Z0wz/3B+qTx768bC9HqJoLqN/hUnZfN0Bj6d9OTvRZDLBhj1rGwxpLJBjIx69lHZlj
         vEsFm1jw79sngCl2oZQH+j3HiCvwHZqi/zrZOyXx0aN+F7td4eklrqhN9Fmb5fFNNvFL
         Iy/syreiTxqMMU+DGZGyI8jNjvYqnC43O6hRNvTeQSKfj9T2bB5kt4gN4wQxFaHpz6Du
         H6AeW/9Yfk/uCzTLmbZ7z5/axWov6cXe92TsykT1jo6cFkGjtgnBl9+B6fN7dY4NE722
         LzLaNzihWnmnC12DVYFk7t6zqLJkcDTZtSnWU7MNYO/zlTx1w/sic7d+RZvuHiico9yI
         5CJg==
X-Gm-Message-State: ALoCoQk2+QF5jXT8cWqc6MB+b0HwAHjYSRl7trKLvNyIf5R8qBgVTGnz+GySJ+mJwbjZh5+LRhUA83D0MwcLXB9SJ47ZwYiMgg==
X-Received: by 10.194.103.164 with SMTP id fx4mr8211380wjb.56.1452841250399;
        Thu, 14 Jan 2016 23:00:50 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:49 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284148>

To correctly perform its testing function,
test-dump-untracked-cache should not change the state of the
untracked cache in the index.

As a previous patch makes read_index_from() change the untracked
cache status and as test-dump-untracked-cache indirectly calls
this function, we need a mechanism to prevent read_index_from()
to change the untracked cache state when it's called from
test-dump-untracked-cache.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h                     | 2 ++
 config.c                    | 3 +++
 environment.c               | 6 ++++++
 test-dump-untracked-cache.c | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/cache.h b/cache.h
index 59a15fd..89c7e10 100644
--- a/cache.h
+++ b/cache.h
@@ -1605,6 +1605,8 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 
+extern int ignore_untracked_cache_config;
+
 struct key_value_info {
 	const char *filename;
 	int linenr;
diff --git a/config.c b/config.c
index 647a15e..a4f70f7 100644
--- a/config.c
+++ b/config.c
@@ -1599,6 +1599,9 @@ int git_config_get_untracked_cache(void)
 	int val = -1;
 	const char *v;
 
+	if (ignore_untracked_cache_config)
+		return -1;
+
 	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
 		return val;
 
diff --git a/environment.c b/environment.c
index 1cc4aab..74294ee 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,12 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+/*
+ * This is to ensure that the untracked cache is not modified, for
+ * example in test programs like test-dump-untracked-cache.
+ */
+int ignore_untracked_cache_config;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 25d855d..8d1293c 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,8 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
+
+	ignore_untracked_cache_config = 1;
 	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
-- 
2.7.0.36.g20612a7
