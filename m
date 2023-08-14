Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D21C05052
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHNPMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHNPM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408481705
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3196fdb3238so1524392f8f.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025940; x=1692630740;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acCVgj/MHDyqLLBjR9qI3rCSPLZ2cTxNAsxbj86HRlY=;
        b=FT0ZCi5+84fCXTCtYjpZb6BzC2gZ5b8hQYt/6E/AeqjNTjY1m03caqXB/WKZRp/yXZ
         ZHrgsj08+NjjJYAcD6Q0tgp0zoHMu4SC1tW0PHArOxCZFkwzTbL2TUPUtuQB4WoEyHzb
         rwmN8th3dUWTIJazdTlnanyIWsInqYN+sAXjU2G4KVa1svk5Y0pyqhanoKXuqdZkq+sQ
         tQDRwFiY2/ihu784GG1h7S1aLQ/TA6VPHkRR1zyEwdT4LIrzZXzGewqSNMeq49VC5jSp
         7ompBWUCT7TcqlUY0hV4rjL1/hlEVAIpUhRyEVXB7LCCBKJxzokeFseatzurHtk5zowZ
         upvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025940; x=1692630740;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acCVgj/MHDyqLLBjR9qI3rCSPLZ2cTxNAsxbj86HRlY=;
        b=KXGPPZWL4oMQ5bSITkE1uUwLeGzyzLPqfnneXyyhA8P+z7d6YLtM6VPyPYCN+dE2Vc
         1rOGpdc1ZqQZ2hIG4QlGBqwaUJraaUnM2JCUnQEILyzc7957QT3J01ayZYEoNMtZbGd/
         osLhTweul37/fZIdt4qKLp3JFieym+fSympDjnNpz3nh2c/puEZWC+1e8ckZNP5ZoBpE
         pwVjhWGir6159cpNQ/MeHjhHwpo6we1OJv3akrJnyLAfoajIcmfOI+pn3HdRT3arZtzw
         7PXlud0K362pdtzfz4xizhMjYWvaw3G9qTOhcdw1YxE4KBId4nIshiMfo3h7NIFggcUX
         T51w==
X-Gm-Message-State: AOJu0YzIB45TPEqK3JEZ9eaTGl94v3LnQlT5XhB/T98082DAS+mZNTyK
        Lj6oxzUoS5P4ER23J2PS+Pu6476H/RU=
X-Google-Smtp-Source: AGHT+IEp1xXfaI4E//1MRQH791TKtefTdpsMiQ0PGtMTegq+KiGYx/C7hTeFoSJvaEMeTWu85wHe5Q==
X-Received: by 2002:adf:e607:0:b0:315:adf3:67db with SMTP id p7-20020adfe607000000b00315adf367dbmr7348371wrm.59.1692025940170;
        Mon, 14 Aug 2023 08:12:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2-20020a05600c014200b003fbc9b9699dsm14493058wmm.45.2023.08.14.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:19 -0700 (PDT)
Message-ID: <fbba6252aeabc9a77d8529e4725feb3ea995545f.1692025937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 15:12:16 +0000
Subject: [PATCH 2/3] setup: add discover_git_directory_reason()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

There are many reasons why discovering a Git directory may fail. In
particular, 8959555cee7 (setup_git_directory(): add an owner check for
the top-level directory, 2022-03-02) added ownership checks as a
security precaution.

Callers attempting to set up a Git directory may want to inform the user
about the reason for the failure. For that, expose the enum
discovery_result from within setup.c and into cache.h where
discover_git_directory() is defined.

I initially wanted to change the return type of discover_git_directory()
to be this enum, but several callers rely upon the "zero means success".
The two problems with this are:

1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
   results are errors.

2. There are multiple successful states, so some positive results are
   successful.

Instead of updating all callers immediately, add a new method,
discover_git_directory_reason(), and convert discover_git_directory() to
be a thin shim on top of it.

Because there are extra checks that discover_git_directory_reason() does
after setup_git_directory_gently_1(), there are other modes that can be
returned for failure states. Add these modes to the enum, but be sure to
explicitly add them as BUG() states in the switch of
setup_git_directory_gently().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 setup.c | 32 +++++++++++---------------------
 setup.h | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/setup.c b/setup.c
index 18927a847b8..bbf8f684d93 100644
--- a/setup.c
+++ b/setup.c
@@ -1221,19 +1221,6 @@ static const char *allowed_bare_repo_to_string(
 	return NULL;
 }
 
-enum discovery_result {
-	GIT_DIR_NONE = 0,
-	GIT_DIR_EXPLICIT,
-	GIT_DIR_DISCOVERED,
-	GIT_DIR_BARE,
-	/* these are errors */
-	GIT_DIR_HIT_CEILING = -1,
-	GIT_DIR_HIT_MOUNT_POINT = -2,
-	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4,
-	GIT_DIR_DISALLOWED_BARE = -5,
-};
-
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -1385,21 +1372,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-int discover_git_directory(struct strbuf *commondir,
-			   struct strbuf *gitdir)
+enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
+						    struct strbuf *gitdir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
 	size_t commondir_offset = commondir->len;
 	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
+	enum discovery_result result;
 
 	if (strbuf_getcwd(&dir))
-		return -1;
+		return GIT_DIR_CWD_FAILURE;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir, NULL, 0) <= 0) {
+	if ((result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0)) <= 0) {
 		strbuf_release(&dir);
-		return -1;
+		return result;
 	}
 
 	/*
@@ -1429,11 +1417,11 @@ int discover_git_directory(struct strbuf *commondir,
 		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
 		clear_repository_format(&candidate);
-		return -1;
+		return GIT_DIR_INVALID_FORMAT;
 	}
 
 	clear_repository_format(&candidate);
-	return 0;
+	return result;
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
@@ -1516,9 +1504,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		*nongit_ok = 1;
 		break;
 	case GIT_DIR_NONE:
+	case GIT_DIR_CWD_FAILURE:
+	case GIT_DIR_INVALID_FORMAT:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
-		 * this value, fallthrough to BUG. Otherwise it is possible to
+		 * these values, fallthrough to BUG. Otherwise it is possible to
 		 * set startup_info->have_repository to 1 when we did nothing to
 		 * find a repository.
 		 */
diff --git a/setup.h b/setup.h
index 58fd2605dd2..b87d0d6fb2b 100644
--- a/setup.h
+++ b/setup.h
@@ -42,6 +42,30 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
 
 void setup_work_tree(void);
+
+/*
+ * discover_git_directory_reason() is similar to discover_git_directory(),
+ * except it returns an enum value instead. It is important to note that
+ * a zero-valued return here is actually GIT_DIR_NONE, which is different
+ * from discover_git_directory.
+ */
+enum discovery_result {
+	GIT_DIR_NONE = 0,
+	GIT_DIR_EXPLICIT,
+	GIT_DIR_DISCOVERED,
+	GIT_DIR_BARE,
+	/* these are errors */
+	GIT_DIR_HIT_CEILING = -1,
+	GIT_DIR_HIT_MOUNT_POINT = -2,
+	GIT_DIR_INVALID_GITFILE = -3,
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
+	GIT_DIR_INVALID_FORMAT = -6,
+	GIT_DIR_CWD_FAILURE = -7,
+};
+enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
+						    struct strbuf *gitdir);
+
 /*
  * Find the commondir and gitdir of the repository that contains the current
  * working directory, without changing the working directory or other global
@@ -50,8 +74,12 @@ void setup_work_tree(void);
  * both have the same result appended to the buffer.  The return value is
  * either 0 upon success and non-zero if no repository was found.
  */
-int discover_git_directory(struct strbuf *commondir,
-			   struct strbuf *gitdir);
+static inline int discover_git_directory(struct strbuf *commondir,
+					 struct strbuf *gitdir)
+{
+	return discover_git_directory_reason(commondir, gitdir) <= 0;
+}
+
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);
-- 
gitgitgadget

