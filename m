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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0AAC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D080610C7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhHFMCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhHFMCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A90C06179A
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q2so6714102plr.11
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xidKIzmSOw2lfgcjtUfjTTwFNc7MdGAzzbspzFT8gZA=;
        b=iVbsoAMlCm4DJo3XlDlB7Cb6ukBy4aODbRuTZSApm+iECskNnLxs2sWvEY/iKOCo1/
         jfCLOp4MSZNRDTF5zNuZWTJFkXRPehbuwSVZfA13Ea1b4cKHHNnmJx92rLj8ZZeiv/F0
         ipDpNIzjDBhK0RE5fOVXDDZaqsCpGoYfP+2+xx5CRWieY/IuYjANBr3DJkRNi4a+pJw+
         Z9vwJtgZjxbQ/yvG05mX4O5T24SjtgpwerFtRVvBzAL6mN+Rk+V8vuhYl7pl+6rEi/OQ
         S6ek/fEr0oZqZYFvdiCuqZtF9yMyHuiX7KCJ2TwDfR8oWbyDvu1iyuT5mPGl6ukcx7EK
         8r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xidKIzmSOw2lfgcjtUfjTTwFNc7MdGAzzbspzFT8gZA=;
        b=UbESdj64G5rWxNazRhn3U4p8e7izxc0hykCT6Ee/6RBQoFOs7gg11TbREqSR8P8rPI
         4nIOHaJ7Iu6w353I6P92qRyDkmYnbHFykbAl38/1jkPd7QTLdPjKNxAthOVOK5fr+Gly
         DAh7eEGUIZcd9nZnwKcUghSo2+sFB2sQxij/dltyxo2g6eO6kiYabKEiBoBzp7yF+lnd
         QYksKqYnrPMIDXPXiZO5v/sACxb1yhuFivX0eSU6iJNveMkowOTQ74LB/U9hSZSqFABt
         tZQfPVKT/FDAkySsBsjJMo+W/nimOAgyOhGWiYhEQz2kj1+dtpghiZ4ZynH9skknfRgn
         10fA==
X-Gm-Message-State: AOAM531veaPu9iMMEba/5sveZXoNwD187OS4zO0kdWZltAfXyEcbjoUx
        3/4H+vSvy9HqCbTjZHf5I3Y=
X-Google-Smtp-Source: ABdhPJzNfEenEIKCM2wa6y58VlltCtSnytq0MmAra4bQ7c9BGxDQSiq2S7ic41AxRj6hc1lVRjnq5w==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr185794pgk.48.1628251344735;
        Fri, 06 Aug 2021 05:02:24 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:24 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 4/8] dir: libify and export helper functions from clone.c
Date:   Fri,  6 Aug 2021 17:31:43 +0530
Message-Id: <20210806120147.73349-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
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
index 66fe66679c..fab0a3cef6 100644
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
+		dir = guess_target_dir_from_git_url(repo_name, is_bundle, option_bare);
+	strip_dir_trailing_slashes(dir);
 
 	dest_exists = path_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
diff --git a/dir.c b/dir.c
index 03c4d21267..9a9ab135c4 100644
--- a/dir.c
+++ b/dir.c
@@ -2970,6 +2970,120 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare)
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
index b3e1a54a97..6f0abdfe04 100644
--- a/dir.h
+++ b/dir.h
@@ -453,6 +453,17 @@ static inline int is_dot_or_dotdot(const char *name)
 
 int is_empty_dir(const char *dir);
 
+/*
+ * Retrieve a target directory name by reading "humanish" part of the
+ * given Git URL.
+ *
+ * For example:
+ * 	/path/to/repo.git => "repo"
+ * 	host.xz.foo/.git => "foo"
+ */
+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare);
+void strip_dir_trailing_slashes(char *dir);
+
 void setup_standard_excludes(struct dir_struct *dir);
 
 char *get_sparse_checkout_filename(void);
-- 
2.32.0

