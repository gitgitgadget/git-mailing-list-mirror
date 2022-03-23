Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F70C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 06:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiCWGey (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiCWGev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 02:34:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972E4EF4D
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 23:33:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb19so767144pjb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38OgOCGY8+pBrL6YSI3oELK3mt1PxjIymbdgGupKNco=;
        b=fOCIHvCw0Y9XviYVCQZ0rpvVYjZBkUEr3MC0GkLUwQOkvIQChIOW/K3H0C42S7X42v
         DT6alHYqxjwMpTuS/iXOab8JDW/e9AWUecILCFRGXj4XI62GDqhcYcAZgb4o/8VQ9j4K
         bo89ZUMpPuSixL5QP9634OblPXHStTNC2PAEhj6z7nkwcbBOF62WBz8kdK6nHq+9YUF2
         I+gb3OW+02tn8AbZlDVCdNW8ntMukf/WE/kL7EazQ6aQi69T36HGM0drTBPB+iU8155h
         RkpFO8fuKJfWYq5x286E9OnW1YIwtyaesrRn5Rf8NTfiKfriPDd8m0hsiQUKBxFyNgHx
         pUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38OgOCGY8+pBrL6YSI3oELK3mt1PxjIymbdgGupKNco=;
        b=S+RdczmnprgkZ+caMV1Qq8tbYzNCfMxOa/EwaU9yIimM9JKdFxWIVjennEa6scSsgm
         g5WXsQQscWutc1kdO/M+WZ39QKFkXMXWc5xpDWA95X42E0v3QUzTNVnlpXPscS9K06R0
         ubGaXiPCO0HFqriq5ieB1VzHlTACCYD26+mSAjiZV5UKRifhRerZELDFdtYDJu4ww5dq
         bVbq0+XYVjk5lQanwi7/JMa6BB+lTcsnkIqw4UjNful6w4Jl0AUjIMLIo8BzofOtOJcb
         A2fTyzKQipo2N7SXa89LqqJnVd4aCednio/zAcuDFJpF+QYsV7+woXvddfRf18ybbnIt
         Dtug==
X-Gm-Message-State: AOAM533MqeoWTYYISXex8Ao6cuTNxkJzoML5lt2g4QPYere1G/pQRiQy
        8j05YLE/oiAqNt/0zVGlhyk=
X-Google-Smtp-Source: ABdhPJyh7EN10292+l56tXnYu2trds1hCRmSB/4phE1GAjVpYAwZNacoKwIkg0U4PW+OoX7Jdo9w4A==
X-Received: by 2002:a17:90a:5a86:b0:1bf:7860:c0f6 with SMTP id n6-20020a17090a5a8600b001bf7860c0f6mr9606961pji.213.1648017201569;
        Tue, 22 Mar 2022 23:33:21 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm5192512pfu.197.2022.03.22.23.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2022 23:33:21 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [RFC PATCH 1/1] tempfile: invalid outdated temporary files
Date:   Wed, 23 Mar 2022 14:33:13 +0800
Message-Id: <61af2576cd94b1958584da2b231aa75ecffb3cb4.1648007488.git.hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.35.1.55.gde4365fc52.agit.6.5.7
In-Reply-To: <cover.1648007488.git.hanxin.hx@alibaba-inc.com>
References: <cover.1648007488.git.hanxin.hx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When git quits unexpectedly, some temporary files(e.g. HEAD.lock,
packed-refs.lock, packed-refs.new) may remain in the repository. These
files will prevent us from performing the corresponding operations
again, even if they were created a long time ago before, until we
manually remove them.

In order for git to automatically fix this situation, let's add a config
named "core.tempfileExpire". When an attempt is made to create a
temporary file that exists and is older than this config value, the file
will be unlinked and recreated.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 Documentation/config/core.txt |  6 ++++++
 cache.h                       |  1 +
 config.c                      |  5 +++++
 environment.c                 |  1 +
 t/t3210-pack-refs.sh          | 10 ++++++++++
 tempfile.c                    | 21 +++++++++++++++++++++
 6 files changed, 44 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a..9907c9e6f3 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -424,6 +424,12 @@ be delta compressed, but larger binary media files won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.tempfileExpire::
+	When an attempt is made to create a temporary file that exists
+	and is older than this config value, the file will be unlinked
+	and recreated. This feature is used to ignore temporary files
+	(e.g. *.lock and *.new) remaining due to abnormal exits.
+
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
diff --git a/cache.h b/cache.h
index 0bc0a37cec..4264fe7960 100644
--- a/cache.h
+++ b/cache.h
@@ -972,6 +972,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern const char *tempfile_expire;
 extern unsigned long pack_size_limit_cfg;
 
 /*
diff --git a/config.c b/config.c
index e78397725c..36a5bc1960 100644
--- a/config.c
+++ b/config.c
@@ -1518,6 +1518,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.tempfileexpire")) {
+		git_config_get_expiry(var, &tempfile_expire);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.packedgitlimit")) {
 		packed_git_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index fb55bf6129..20b928e71b 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
+const char *tempfile_expire = "1.day.ago";
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 577f32dc71..7d443c1cfd 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -231,6 +231,16 @@ test_expect_success 'timeout if packed-refs.lock exists' '
 	test_must_fail git pack-refs --all --prune
 '
 
+test_expect_success 'success if packed-refs.lock expires' '
+	LOCK=.git/packed-refs.lock &&
+	>"$LOCK" &&
+	test_when_finished "rm -f $LOCK" &&
+	test-tool chmtime -86000 $LOCK &&
+	test_must_fail git pack-refs --all --prune &&
+	test-tool chmtime -400 $LOCK &&
+	git pack-refs --all --prune
+'
+
 test_expect_success 'retry acquiring packed-refs.lock' '
 	LOCK=.git/packed-refs.lock &&
 	>"$LOCK" &&
diff --git a/tempfile.c b/tempfile.c
index 94aa18f3f7..f18e0121d0 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -51,6 +51,7 @@
  */
 
 #include "cache.h"
+#include "date.h"
 #include "tempfile.h"
 #include "sigchain.h"
 
@@ -137,6 +138,26 @@ struct tempfile *create_tempfile_mode(const char *path, int mode)
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf,
 			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, mode);
+	if (tempfile->fd < 0 && errno == EEXIST) {
+		struct stat st;
+		int err = errno;
+		if (lstat(tempfile->filename.buf, &st) < 0) {
+			warning_errno(_("failed to stat %s"),
+				      tempfile->filename.buf);
+			errno = err;
+		} else if (st.st_mtime <= approxidate(tempfile_expire)) {
+			/*
+			 * If the file is older than core.tmpfileExpire, it is
+			 * probably outdated.  We'll try to remove it and try
+			 * again.
+			 */
+			warning(_("remove outdated tempfile %s"), tempfile->filename.buf);
+			unlink_or_warn(tempfile->filename.buf);
+			tempfile->fd = open(tempfile->filename.buf,
+					    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC,
+					    mode);
+		}
+	}
 	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
 		/* Try again w/o O_CLOEXEC: the kernel might not support it */
 		tempfile->fd = open(tempfile->filename.buf,
-- 
2.35.1.55.gde4365fc52.agit.6.5.7

