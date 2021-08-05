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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E7C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1463861040
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhHEHmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhHEHmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F2C06179B
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so12810407pjr.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbLs9x3o5zCDEnUgVGn73d6DqvV7gyijtRaOLcYmCAs=;
        b=Pmuj5v+1vsKScVkhpZ42tr5kumGldGcFt5BvNkidcoVEavrju5srlXWgJz8ubG1v6q
         CxUd4S3iIMw8+x5p/RlydL4FZbo7yKE6AjmON25iLeM51lyOPhd3kn5b1zFMaUcsw8z6
         wto1mZVkz8KEuCeuZAWeQOspoe3VpYYvhqBiOvkpiXr/39qX89iWdbvAzCj/rggnQiCG
         YxXSJ79lKeKPgOvzGFt6i85PYpAJCXdUPtF+dYAEQBEEv+oq4dEcWqPmX7T3aNK8vOOg
         obblhJvJb1Wcpli56myncwzaXqjPWHM7sBQZhMXfn6rniKZEGAjtnq1oBMiR+RFEqwSI
         ppbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbLs9x3o5zCDEnUgVGn73d6DqvV7gyijtRaOLcYmCAs=;
        b=IHgQJyA4A3kff4ftNHtmNDKi+9r9KWzN8VXVym3ADnSgP3y59eaKnHSlH4f3uiyN4D
         jhsS3IhgzA2rc/r8L1Zpt/sdWu6Kkb6ep44VtMizXbXK4gNMetwUKvnSvWAEc420SWdT
         z1dx0hfFE56AmNiF8dpoem47pRW7fQn6+3tsSlvaDOzNhtgf6Bg8Vq4TbYryQdcBaW0j
         rQVAHQSk5PgWEo9dOuLQ16LkThEtwRtqUSUl8xytU8TzE/8zTzQD/d4mrmafQEJJoPNA
         7g94oCMoy0nsK9ZFdZOYMWtIQGYssQWMf0Ell4Ymc6mpY6jCHHiOstb843WGVwbFDuQ7
         /Cvw==
X-Gm-Message-State: AOAM533pRbVL3daANPFT+/Hzdu6e6HkSDXLq8hZ8jGbwr7dYlOfQASkU
        PI0ZvSfZ1UqKSK9iNBp8oSM=
X-Google-Smtp-Source: ABdhPJwcAKLNAOxzfZ/j/F86KhvSkR+2o6y7cdTORhnR2Zi3/elrdNA/5N7UNR0Dtd2P3fj/YLsrUg==
X-Received: by 2002:a17:90a:f486:: with SMTP id bx6mr3349807pjb.26.1628149304826;
        Thu, 05 Aug 2021 00:41:44 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:44 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] [PATCH v2 4/9] dir: libify and export helper functions from clone.c
Date:   Thu,  5 Aug 2021 13:10:49 +0530
Message-Id: <20210805074054.29916-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
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

