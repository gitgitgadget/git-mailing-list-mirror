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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1DC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9B260EBB
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhHJLs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhHJLrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFCC0617A5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d1so20655478pll.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+UUKksn3KuDWhIprdDIn5xVbdTLguTDRUt9PvuESEI=;
        b=VYdtQ3yxSEkLTBk5bJ3Ny4XqnZu4tB8yGu2LPqrJ//bJI4ZNdbfrH/ispC1cdC7kaJ
         H1LloUY59uD280JVwbwnephE6TAtRrKLS2FgS6+wdTMH8KxMEzPNwfkla3tMdqMNHBKE
         +7aK4YJA4VBiQBxZR0z8GaB5u0d0KwvVWFDVc66WK1dBHAvqGQGL1at2YcPmzMcm4y8Y
         mOf9OXav2Wo1HWQHpLNEurQmMUC4ny76OB7f8+CWSIZIuwG5eywzBhPV1Om6nvOXOQvy
         9zPDHOyKQFxPlVJYKm+aCg/c+RNYcYS0BEU8awXpLtIb0r6gGZRoo9Vk5Xy3M3MLFdvV
         YkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+UUKksn3KuDWhIprdDIn5xVbdTLguTDRUt9PvuESEI=;
        b=R+HEOIP5JEDA9NM4dnaHiz4iDMdrI523Aa7xe63Eq7kG4rRgCAbrosxqz2S0TJt33m
         gfZBqBf/m/NZCONs/pNJk12uEqF7djqFRXFiJLnV3SWjgz5SoJ5YUbd0EBHa/sn6bpAN
         PQIonLnBLlY7NH3B/w3gQGkxlzc/opAtLZkL1lY0CyylGGbukPLGvEx4Yy8dsvKJPP65
         dEgvvbBLmRUDotjlCDdM88oK+7B743g6S/f58sW+CcFyGk/bKKl0awacP83sZQ/jOAFn
         mCeg1KqeAvJFFHGlACdGwnxNvU8kj+7e3aqY1cDDDKmFYOihjQTOYpuKDcGcBy9pqFkQ
         KP1Q==
X-Gm-Message-State: AOAM532mMmWZ7c1XVZyIG3rIAIK5bwJRgWCf7jMcA6wPoUtAxJy6n5mq
        7WgiQdXHBc5q1taR+AlmsyY=
X-Google-Smtp-Source: ABdhPJx2GDRe+i3PN+GFIc5Zk49xjacrmwOY15FKi+veC/zjuriT73Sid09dN+z4PwpTsFgkR0I6Kw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr224146pgm.89.1628596039214;
        Tue, 10 Aug 2021 04:47:19 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:18 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 4/9] dir: libify and export helper functions from clone.c
Date:   Tue, 10 Aug 2021 17:16:36 +0530
Message-Id: <20210810114641.27188-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions can be useful to other parts of Git. Let's move them to
dir.c, while renaming them to be make their functionality more explicit.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/clone.c | 118 +-----------------------------------------------
 dir.c           | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 dir.h           |  11 +++++
 3 files changed, 127 insertions(+), 116 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..5ba24b7ae7 100644
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
+		dir = git_url_basename(repo_name, is_bundle, option_bare);
+	strip_dir_trailing_slashes(dir);
 
 	dest_exists = path_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
diff --git a/dir.c b/dir.c
index 03c4d21267..6d26db3189 100644
--- a/dir.c
+++ b/dir.c
@@ -2970,6 +2970,120 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
+char *git_url_basename(const char *repo, int is_bundle, int is_bare)
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
index b3e1a54a97..63ff04f5ac 100644
--- a/dir.h
+++ b/dir.h
@@ -453,6 +453,17 @@ static inline int is_dot_or_dotdot(const char *name)
 
 int is_empty_dir(const char *dir);
 
+/*
+ * Retrieve the "humanish" basename of the given Git URL.
+ *
+ * For example:
+ * 	/path/to/repo.git => "repo"
+ * 	host.xz:foo/.git => "foo"
+ * 	http://example.com/user/bar.baz => "bar.baz"
+ */
+char *git_url_basename(const char *repo, int is_bundle, int is_bare);
+void strip_dir_trailing_slashes(char *dir);
+
 void setup_standard_excludes(struct dir_struct *dir);
 
 char *get_sparse_checkout_filename(void);
-- 
2.32.0

