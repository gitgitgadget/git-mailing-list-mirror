Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F4EC43333
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E946464F57
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhCRSoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhCRSoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 14:44:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047EC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:44:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 7so257849qka.7
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsyJct5pdX+o9U4JQQNixI3MfxW3aIgT78If7CNyjZo=;
        b=f6fSvAsaiZE6FdLNfjdrgbAi6IAdyNqIy53lJ3tfbh3Ujb2mfV20aWxPH7JPuUFTvJ
         RCZyDo0SZA+6hprYCm6pReQhL+VSdAFhn/kILdQ3bcInxPbRtkkHgKOIPhVu9QAssxvY
         ejEGbequuZomlrctw3jdfiuDojUe9mNNVms+KqNBQmkGTf3vE6wbGTONIqPToCqjVXkz
         PXRhqcoR4xHC/e1zuU+MUii7tkVNf8fXGaGqWETjNfXwkDGBZNXD/acA6oInHTIIxlXv
         4G+UsjcXlAis4BCN0PdaZaeaQ+7srp/nDiITFBNvb0Azqsy+ZzuLV0APdLUmtUBAG/MO
         n9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsyJct5pdX+o9U4JQQNixI3MfxW3aIgT78If7CNyjZo=;
        b=lXK/Te4yUwk0am2tbW4pH2UFN/ZyTxurDmUtt2o7w3jB2JsrA+82rlF/rhMl+G/JL5
         5aHk9QcfFQhr+kcunIz1I1Mveon29dqRdGjZNO+QyHX8RXWIFeOD35VC4f5hlxh8OGjr
         WCy/Ok953dBJzxiGXfp8RCY7HbGbE9gjXDILDSwSVk6Ye+Qjn+kVrfWHq33mh/5Lk3Nu
         E1RazYuPyg5kGQYF0X1rB6BKNWk7+V71BtAZT0zvONLmU8hx0Op/Jlqx3ayoqqKed9Op
         onteCpRTSzE4SZgqO2STRUR5XJhGTIIrxtcUMvBbJ0LudqlFq2RiuLC41Elysjy3rLxE
         dTEQ==
X-Gm-Message-State: AOAM533TJ16Tc8C92mdYhKgp/x8o7zKVo+Mj0x6IoobEA9cxPYocgDcy
        yrUMCkikjzzSKXGr0oaW0/bsyEhlwKNvBQ==
X-Google-Smtp-Source: ABdhPJxxApUaO3fp5RvIBMujxT3ozUdP6nP4UD3s4nAVLU6LPcRz7u1N5LnNlIahgLMqfolhQXa8zQ==
X-Received: by 2002:a05:620a:214a:: with SMTP id m10mr5997292qkm.372.1616093039114;
        Thu, 18 Mar 2021 11:43:59 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm2037324qto.46.2021.03.18.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:43:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de
Subject: [PATCH 2/2] checkout: don't follow symlinks when removing entries
Date:   Thu, 18 Mar 2021 15:43:47 -0300
Message-Id: <b7c98d5034fe77270971c57896f722640cbce7d8.1616091229.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616091229.git.matheus.bernardino@usp.br>
References: <cover.1616091229.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 1d718a5108 ("do not overwrite untracked symlinks", 2011-02-20),
symlink.c:check_leading_path() started returning different codes for
FL_ENOENT and FL_SYMLINK. But one of its callers, unlink_entry(), was
not adjusted for this change, so it started to follow symlinks on the
leading path of to-be-removed entries. Fix that and add a regression
test.

Note that since 1d718a5108 check_leading_path() no longer differentiates
the case where it found a symlink in the path's leading components from
the cases where it found a regular file or failed to lstat() the
component. So, a side effect of this current patch is that
unlink_entry() now returns early in all of these three cases. And
because we no longer try to unlink such paths, we also don't get the
warning from remove_or_warn().

For the regular file and symlink cases, it's questionable whether the
warning was useful in the first place: unlink_entry() removes tracked
paths that should no longer be present in the state we are checking out
to. If the path had its leading dir replaced by another file, it means
that the basename already doesn't exist, so there is no need for a
warning. Sure, we are leaving a regular file or symlink behind at the
path's dirname, but this file is either untracked now (so again, no
need to warn), or it will be replaced by a tracked file during the next
phase of this checkout operation.

As for failing to lstat() one of the leading components, the basename
might still exist only we cannot unlink it (e.g. due to the lack of the
required permissions). Since the user expect it to be removed
(especially with checkout's --no-overlay option), add back the warning
in this more relevant case.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache.h                       |  2 +-
 entry.c                       |  2 +-
 symlinks.c                    | 30 ++++++++++++++++++++++--------
 t/t2021-checkout-overwrite.sh | 12 ++++++++++++
 unpack-trees.c                |  2 +-
 5 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 6fda8091f1..4f0b29bfe4 100644
--- a/cache.h
+++ b/cache.h
@@ -1659,7 +1659,7 @@ static inline void cache_def_clear(struct cache_def *cache)
 
 int has_symlink_leading_path(const char *name, int len);
 int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
-int check_leading_path(const char *name, int len);
+int check_leading_path(const char *name, int len, int warn_on_lstat_err);
 int has_dirs_only_path(const char *name, int len, int prefix_len);
 void invalidate_lstat_cache(void);
 void schedule_dir_for_removal(const char *name, int len);
diff --git a/entry.c b/entry.c
index 7b9f43716f..33ce80ca91 100644
--- a/entry.c
+++ b/entry.c
@@ -530,7 +530,7 @@ void unlink_entry(const struct cache_entry *ce)
 		submodule_move_head(ce->name, "HEAD", NULL,
 				    SUBMODULE_MOVE_HEAD_FORCE);
 	}
-	if (!check_leading_path(ce->name, ce_namelen(ce)))
+	if (check_leading_path(ce->name, ce_namelen(ce), 1) >= 0)
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
diff --git a/symlinks.c b/symlinks.c
index fbccd340f0..5232d02020 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 
-static int threaded_check_leading_path(struct cache_def *cache, const char *name, int len);
+static int threaded_check_leading_path(struct cache_def *cache, const char *name,
+				       int len, int warn_on_lstat_err);
 static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len);
 
 /*
@@ -72,7 +73,7 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 				int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
-	int save_flags, ret;
+	int save_flags, ret, saved_errno = 0;
 	struct stat st;
 
 	if (cache->track_flags != track_flags ||
@@ -139,6 +140,7 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 
 		if (ret) {
 			*ret_flags = FL_LSTATERR;
+			saved_errno = errno;
 			if (errno == ENOENT)
 				*ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
@@ -180,6 +182,8 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	} else {
 		reset_lstat_cache(cache);
 	}
+	if (saved_errno)
+		errno = saved_errno;
 	return match_len;
 }
 
@@ -207,9 +211,10 @@ int has_symlink_leading_path(const char *name, int len)
 	return threaded_has_symlink_leading_path(&default_cache, name, len);
 }
 
-int check_leading_path(const char *name, int len)
+int check_leading_path(const char *name, int len, int warn_on_lstat_err)
 {
-	return threaded_check_leading_path(&default_cache, name, len);
+	return threaded_check_leading_path(&default_cache, name, len,
+					   warn_on_lstat_err);
 }
 
 /*
@@ -218,19 +223,28 @@ int check_leading_path(const char *name, int len)
  * Return -1 if leading path exists and is a directory.
  *
  * Return the length of a leading component if it either exists but it's not a
- * directory, or if we were unable to lstat() it.
+ * directory, or if we were unable to lstat() it. If warn_on_lstat_err is true,
+ * also emit a warning for this error.
  */
-static int threaded_check_leading_path(struct cache_def *cache, const char *name, int len)
+static int threaded_check_leading_path(struct cache_def *cache, const char *name,
+				       int len, int warn_on_lstat_err)
 {
 	int flags;
 	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
+	int saved_errno = errno;
+
 	if (flags & FL_NOENT)
 		return 0;
 	else if (flags & FL_DIR)
 		return -1;
-	else
-		return match_len;
+	if (warn_on_lstat_err && (flags & FL_LSTATERR)) {
+		char *path = xmemdupz(name, match_len);
+		errno = saved_errno;
+		warning_errno(_("failed to lstat '%s'"), path);
+		free(path);
+	}
+	return match_len;
 }
 
 int has_dirs_only_path(const char *name, int len, int prefix_len)
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index c2ada7de37..70d69263e6 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -51,4 +51,16 @@ test_expect_success SYMLINKS 'the symlink remained' '
 	test -h a/b
 '
 
+test_expect_success SYMLINKS 'checkout -f must not follow symlinks when removing entries' '
+	git checkout -f start &&
+	mkdir dir &&
+	>dir/f &&
+	git add dir/f &&
+	git commit -m "add dir/f" &&
+	mv dir untracked &&
+	ln -s untracked dir &&
+	git checkout -f HEAD~ &&
+	test_path_is_file untracked/f
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index eb8fcda31b..ed0db8031d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2097,7 +2097,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	len = check_leading_path(ce->name, ce_namelen(ce));
+	len = check_leading_path(ce->name, ce_namelen(ce), 0);
 	if (!len)
 		return 0;
 	else if (len > 0) {
-- 
2.30.1

