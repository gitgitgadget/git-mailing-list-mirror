Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C6C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D1360F94
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhHEHUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhHEHUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523FC061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:19:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so12705709pjb.3
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbLs9x3o5zCDEnUgVGn73d6DqvV7gyijtRaOLcYmCAs=;
        b=FUh49Nen6+XXGWm203BeVIWyhspkj6R2+5R95vtWrC9yujGzjKgY5y/VnCJJZvchbU
         nHFpKh7PoK/ka6GPzDYarWMb4JeDLMqLWMMq3hvDJKqLCoFRv+9bLWrD2MX3Mm9k0o0h
         EG0s23/D0Jiw3B7QIR6B55GVKz+RpM4+h3QmQ1anrFRe3S5xevjqI8fT2jzDKtUMpneG
         K0X0gi2mmyFLUGkniRYEdKU6P1q3an5qJbD1nUoVnpfMbKLR4H+wMNUsyQwVUEYlm+Oz
         6hnesAVaqzuts4lrZcmKIQoNaRBsFbYWkSDOOG7SzVIswZHrApgS/jJq72TepEvHiZ7m
         9jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbLs9x3o5zCDEnUgVGn73d6DqvV7gyijtRaOLcYmCAs=;
        b=jvF8cgBJ0Un0fDhbuXW4SHsNWj7+AcqzB/JmmtvPJx1e+HZudrFPyOVLlI6tLriSek
         56kcWkZIP/5Jg4fRavrcvAEeVjZii04H8N91uSH9RalFszvthDMy1TlYtpc/0Pd4L6Dv
         9X6v8Iettkvqx6YURtwuxFxFMnJaXl8G6S0irMqLaDbjD/NY81g0iGGAiY2RoP7Ip0XY
         xivoYWXgpmGYmeQd08utZEwe0VnQXLl8QarWEwbWacp9lue85ZLDaLtVPTc6pEnzPnOi
         H0pVYoMIKS0Kv6GUT9/zZSO0OR14hmDLHB221765xVlthadqQk1z2chDk3VZxX1PDRhG
         lZ4A==
X-Gm-Message-State: AOAM533Kg0Myl82kgtqAVoJfBdfqKeBb9If4RBcHHUFzj7B2jP7PXcj3
        bFPXiwi5H17yKK6vohxVht06MxOcKsOMWk0+
X-Google-Smtp-Source: ABdhPJw6hmZFHuwIXUW5T8FAev7VU6bUzdoOl2ufbJhwj3JNCs1wTAG1jZGTi79SFIkzXpPQfdsRCw==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr1847948pjd.107.1628147990944;
        Thu, 05 Aug 2021 00:19:50 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.19.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:19:50 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] [PATCH 3/8] dir: libify and export helper functions from clone.c
Date:   Thu,  5 Aug 2021 12:49:12 +0530
Message-Id: <20210805071917.29500-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions can be useful to other parts of Git. Let's move them to
dir.c, while renaming them to be make their functionality more explicit.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/clone.c | 118 +-----------------------------------------------
 dir.c           | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 dir.h           |   3 ++
 3 files changed, 119 insertions(+), 116 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..b9b59a838f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -217,120 +217,6 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 	return canon;
 }
 
-static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
-{
-	const char *end = repo + strlen(repo), *start, *ptr;
-	size_t len;
-	char *dir;
-
-	/*
-	 * Skip scheme.
-	 */
-	start = strstr(repo, "://");
-	if (start == NULL)
-		start = repo;
-	else
-		start += 3;
-
-	/*
-	 * Skip authentication data. The stripping does happen
-	 * greedily, such that we strip up to the last '@' inside
-	 * the host part.
-	 */
-	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
-		if (*ptr == '@')
-			start = ptr + 1;
-	}
-
-	/*
-	 * Strip trailing spaces, slashes and /.git
-	 */
-	while (start < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
-		end--;
-	if (end - start > 5 && is_dir_sep(end[-5]) &&
-	    !strncmp(end - 4, ".git", 4)) {
-		end -= 5;
-		while (start < end && is_dir_sep(end[-1]))
-			end--;
-	}
-
-	/*
-	 * Strip trailing port number if we've got only a
-	 * hostname (that is, there is no dir separator but a
-	 * colon). This check is required such that we do not
-	 * strip URI's like '/foo/bar:2222.git', which should
-	 * result in a dir '2222' being guessed due to backwards
-	 * compatibility.
-	 */
-	if (memchr(start, '/', end - start) == NULL
-	    && memchr(start, ':', end - start) != NULL) {
-		ptr = end;
-		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
-			ptr--;
-		if (start < ptr && ptr[-1] == ':')
-			end = ptr - 1;
-	}
-
-	/*
-	 * Find last component. To remain backwards compatible we
-	 * also regard colons as path separators, such that
-	 * cloning a repository 'foo:bar.git' would result in a
-	 * directory 'bar' being guessed.
-	 */
-	ptr = end;
-	while (start < ptr && !is_dir_sep(ptr[-1]) && ptr[-1] != ':')
-		ptr--;
-	start = ptr;
-
-	/*
-	 * Strip .{bundle,git}.
-	 */
-	len = end - start;
-	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
-
-	if (!len || (len == 1 && *start == '/'))
-		die(_("No directory name could be guessed.\n"
-		      "Please specify a directory on the command line"));
-
-	if (is_bare)
-		dir = xstrfmt("%.*s.git", (int)len, start);
-	else
-		dir = xstrndup(start, len);
-	/*
-	 * Replace sequences of 'control' characters and whitespace
-	 * with one ascii space, remove leading and trailing spaces.
-	 */
-	if (*dir) {
-		char *out = dir;
-		int prev_space = 1 /* strip leading whitespace */;
-		for (end = dir; *end; ++end) {
-			char ch = *end;
-			if ((unsigned char)ch < '\x20')
-				ch = '\x20';
-			if (isspace(ch)) {
-				if (prev_space)
-					continue;
-				prev_space = 1;
-			} else
-				prev_space = 0;
-			*out++ = ch;
-		}
-		*out = '\0';
-		if (out > dir && prev_space)
-			out[-1] = '\0';
-	}
-	return dir;
-}
-
-static void strip_trailing_slashes(char *dir)
-{
-	char *end = dir + strlen(dir);
-
-	while (dir < end - 1 && is_dir_sep(end[-1]))
-		end--;
-	*end = '\0';
-}
-
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -1041,8 +927,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (argc == 2)
 		dir = xstrdup(argv[1]);
 	else
-		dir = guess_dir_name(repo_name, is_bundle, option_bare);
-	strip_trailing_slashes(dir);
+		dir = guess_dir_name_from_git_url(repo_name, is_bundle, option_bare);
+	strip_dir_trailing_slashes(dir);
 
 	dest_exists = path_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
diff --git a/dir.c b/dir.c
index 03c4d21267..84b47c4dbc 100644
--- a/dir.c
+++ b/dir.c
@@ -2970,6 +2970,120 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
+char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare)
+{
+	const char *end = repo + strlen(repo), *start, *ptr;
+	size_t len;
+	char *dir;
+
+	/*
+	 * Skip scheme.
+	 */
+	start = strstr(repo, "://");
+	if (start == NULL)
+		start = repo;
+	else
+		start += 3;
+
+	/*
+	 * Skip authentication data. The stripping does happen
+	 * greedily, such that we strip up to the last '@' inside
+	 * the host part.
+	 */
+	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
+		if (*ptr == '@')
+			start = ptr + 1;
+	}
+
+	/*
+	 * Strip trailing spaces, slashes and /.git
+	 */
+	while (start < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
+		end--;
+	if (end - start > 5 && is_dir_sep(end[-5]) &&
+	    !strncmp(end - 4, ".git", 4)) {
+		end -= 5;
+		while (start < end && is_dir_sep(end[-1]))
+			end--;
+	}
+
+	/*
+	 * Strip trailing port number if we've got only a
+	 * hostname (that is, there is no dir separator but a
+	 * colon). This check is required such that we do not
+	 * strip URI's like '/foo/bar:2222.git', which should
+	 * result in a dir '2222' being guessed due to backwards
+	 * compatibility.
+	 */
+	if (memchr(start, '/', end - start) == NULL
+	    && memchr(start, ':', end - start) != NULL) {
+		ptr = end;
+		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
+			ptr--;
+		if (start < ptr && ptr[-1] == ':')
+			end = ptr - 1;
+	}
+
+	/*
+	 * Find last component. To remain backwards compatible we
+	 * also regard colons as path separators, such that
+	 * cloning a repository 'foo:bar.git' would result in a
+	 * directory 'bar' being guessed.
+	 */
+	ptr = end;
+	while (start < ptr && !is_dir_sep(ptr[-1]) && ptr[-1] != ':')
+		ptr--;
+	start = ptr;
+
+	/*
+	 * Strip .{bundle,git}.
+	 */
+	len = end - start;
+	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
+
+	if (!len || (len == 1 && *start == '/'))
+		die(_("No directory name could be guessed.\n"
+		      "Please specify a directory on the command line"));
+
+	if (is_bare)
+		dir = xstrfmt("%.*s.git", (int)len, start);
+	else
+		dir = xstrndup(start, len);
+	/*
+	 * Replace sequences of 'control' characters and whitespace
+	 * with one ascii space, remove leading and trailing spaces.
+	 */
+	if (*dir) {
+		char *out = dir;
+		int prev_space = 1 /* strip leading whitespace */;
+		for (end = dir; *end; ++end) {
+			char ch = *end;
+			if ((unsigned char)ch < '\x20')
+				ch = '\x20';
+			if (isspace(ch)) {
+				if (prev_space)
+					continue;
+				prev_space = 1;
+			} else
+				prev_space = 0;
+			*out++ = ch;
+		}
+		*out = '\0';
+		if (out > dir && prev_space)
+			out[-1] = '\0';
+	}
+	return dir;
+}
+
+void strip_dir_trailing_slashes(char *dir)
+{
+	char *end = dir + strlen(dir);
+
+	while (dir < end - 1 && is_dir_sep(end[-1]))
+		end--;
+	*end = '\0';
+}
+
 static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 {
 	DIR *dir;
diff --git a/dir.h b/dir.h
index b3e1a54a97..76441dde2d 100644
--- a/dir.h
+++ b/dir.h
@@ -453,6 +453,9 @@ static inline int is_dot_or_dotdot(const char *name)
 
 int is_empty_dir(const char *dir);
 
+char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare);
+void strip_dir_trailing_slashes(char *dir);
+
 void setup_standard_excludes(struct dir_struct *dir);
 
 char *get_sparse_checkout_filename(void);
-- 
2.32.0

