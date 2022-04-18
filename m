Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC9C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbiDRR1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbiDRR0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8833E12
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12137050wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv38No44NQhSEcPN1ONAwA/N9eGIYUK1zDtwP0RVhIU=;
        b=CeJt8s6WmBTicjKQa2Wo7iJqpqHTglJEUSo7Xaki1iGXyZ9rfLKPJvbTmdbfe26AaS
         KE2O1ByCwliXlZl0p6c+r/HTd1pjcjiBccj8pVHc3YrBu787vafNi7FIg5bVYuzBRpzp
         BXJZLnv9rh3raaHAvh+A1IoGfEybbEqzURCmSvQ6wNKEWiQgDcIkWS+d+iY2TjnpTg8q
         tJu8k2aTuNYn9tpGRMCz8EEXaRllut3YZGxE9lInZQ99uDeJQM8quXlSzmbtHhJlUsss
         965AyhfYC9ysAM/Q+do3D5t+aWhnYhiL175sSoSLbKGhr/d0LUlohD3hFm0k72Gyy0Y6
         xn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv38No44NQhSEcPN1ONAwA/N9eGIYUK1zDtwP0RVhIU=;
        b=RXYiQEnNOMToxoOHS3MKOPChj8FMXAYG4nqwAGj/vPGaWthdMBtfK0UZPDYqRBDNIT
         rkKahDJ0FcEkNumZKmbBekWfmQGPPw4Q9GcHHwMltWonfrpZ5IbkJFIRtwyCTUPV7+0d
         +BN5o6dNA7QnkSUxJTEg0VLlVbLqBU7QTHciTV/fYQHlCox3AWsabbb3D5mb0WW14OYL
         lsSasIkQkBgUOxDJKbddl/HpTjNpQI+YOQfXr+TDz6n8930s1L6ae8Y8LuZVMujMyCRa
         CHkKCbxvkN2OkbUCKL6ZEZ4quODw8/gVg6MrbXUa4HTMFjeuODywQIEZHz/It1DlOKvS
         ekdA==
X-Gm-Message-State: AOAM530J2lZpQt5syQ+uBo3j5yae0/vhBjCVn8dMQWydn/447zTr3hNo
        /I+alYYEY7eb02p2wtuKk81a9KECo0DrIw==
X-Google-Smtp-Source: ABdhPJw1b+EvbrAVlns3nQufjg1ntWwTzwAodlub9kq0SdDL3v8nIz07C4b4GCSMknYjBMP7m2gFdg==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr12741012wml.160.1650302646687;
        Mon, 18 Apr 2022 10:24:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 06/36] remote: move relative_url()
Date:   Mon, 18 Apr 2022 19:23:23 +0200
Message-Id: <RFC-patch-v2-06.36-97a9f38f08d-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method was initially written in 63e95beb0 (submodule: port
resolve_relative_url from shell to C, 2016-05-15). As we will need
similar functionality in the bundle URI feature, extract this to be
available in remote.h.

The code is almost exactly the same, except for the following trivial
differences:

 * Fix whitespace and wrapping issues with the prototype and argument
   lists.

 * Let's call starts_with_dot_{,dot_}slash_native() instead of the
   functionally identical "starts_with_dot_{,dot_}slash()" wrappers
   "builtin/submodule--helper.c".

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 141 +++---------------------------------
 remote.c                    |  91 +++++++++++++++++++++++
 remote.h                    |  31 ++++++++
 3 files changed, 134 insertions(+), 129 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b68102bb3ed..86f38e489b0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,135 +72,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-/*
- * Returns 1 if it was the last chop before ':'.
- */
-static int chop_last_dir(char **remoteurl, int is_relative)
-{
-	char *rfind = find_last_dir_sep(*remoteurl);
-	if (rfind) {
-		*rfind = '\0';
-		return 0;
-	}
-
-	rfind = strrchr(*remoteurl, ':');
-	if (rfind) {
-		*rfind = '\0';
-		return 1;
-	}
-
-	if (is_relative || !strcmp(".", *remoteurl))
-		die(_("cannot strip one component off url '%s'"),
-			*remoteurl);
-
-	free(*remoteurl);
-	*remoteurl = xstrdup(".");
-	return 0;
-}
-
-static int starts_with_dot_slash(const char *const path)
-{
-	return starts_with_dot_slash_native(path);;
-}
-
-static int starts_with_dot_dot_slash(const char *const path)
-{
-	return starts_with_dot_dot_slash_native(path);
-}
-
-/*
- * The `url` argument is the URL that navigates to the submodule origin
- * repo. When relative, this URL is relative to the superproject origin
- * URL repo. The `up_path` argument, if specified, is the relative
- * path that navigates from the submodule working tree to the superproject
- * working tree. Returns the origin URL of the submodule.
- *
- * Return either an absolute URL or filesystem path (if the superproject
- * origin URL is an absolute URL or filesystem path, respectively) or a
- * relative file system path (if the superproject origin URL is a relative
- * file system path).
- *
- * When the output is a relative file system path, the path is either
- * relative to the submodule working tree, if up_path is specified, or to
- * the superproject working tree otherwise.
- *
- * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          expectation
- * http://a.com/b  ../c             http://a.com/c   as is
- * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
- *                                                   ignore trailing slash in url
- * http://a.com/b  ../../c          http://c         error out
- * http://a.com/b  ../../../c       http:/c          error out
- * http://a.com/b  ../../../../c    http:c           error out
- * http://a.com/b  ../../../../../c    .:c           error out
- * NEEDSWORK: Given how chop_last_dir() works, this function is broken
- * when a local part has a colon in its path component, too.
- */
-static char *relative_url(const char *remote_url,
-				const char *url,
-				const char *up_path)
-{
-	int is_relative = 0;
-	int colonsep = 0;
-	char *out;
-	char *remoteurl = xstrdup(remote_url);
-	struct strbuf sb = STRBUF_INIT;
-	size_t len = strlen(remoteurl);
-
-	if (is_dir_sep(remoteurl[len-1]))
-		remoteurl[len-1] = '\0';
-
-	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
-		is_relative = 0;
-	else {
-		is_relative = 1;
-		/*
-		 * Prepend a './' to ensure all relative
-		 * remoteurls start with './' or '../'
-		 */
-		if (!starts_with_dot_slash(remoteurl) &&
-		    !starts_with_dot_dot_slash(remoteurl)) {
-			strbuf_reset(&sb);
-			strbuf_addf(&sb, "./%s", remoteurl);
-			free(remoteurl);
-			remoteurl = strbuf_detach(&sb, NULL);
-		}
-	}
-	/*
-	 * When the url starts with '../', remove that and the
-	 * last directory in remoteurl.
-	 */
-	while (url) {
-		if (starts_with_dot_dot_slash(url)) {
-			url += 3;
-			colonsep |= chop_last_dir(&remoteurl, is_relative);
-		} else if (starts_with_dot_slash(url))
-			url += 2;
-		else
-			break;
-	}
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
-	if (ends_with(url, "/"))
-		strbuf_setlen(&sb, sb.len - 1);
-	free(remoteurl);
-
-	if (starts_with_dot_slash(sb.buf))
-		out = xstrdup(sb.buf + 2);
-	else
-		out = xstrdup(sb.buf);
-
-	if (!up_path || !is_relative) {
-		strbuf_release(&sb);
-		return out;
-	}
-
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s%s", up_path, out);
-	free(out);
-	return strbuf_detach(&sb, NULL);
-}
-
 static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *resolved_url;
@@ -592,6 +463,18 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int starts_with_dot_slash(const char *const path)
+{
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
+}
+
+static int starts_with_dot_dot_slash(const char *const path)
+{
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
+}
+
 struct init_cb {
 	const char *prefix;
 	const char *superprefix;
diff --git a/remote.c b/remote.c
index 42a4e7106e1..87656138645 100644
--- a/remote.c
+++ b/remote.c
@@ -14,6 +14,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
+#include "connect.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -2727,3 +2728,93 @@ void remote_state_clear(struct remote_state *remote_state)
 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
 	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
 }
+
+/*
+ * Returns 1 if it was the last chop before ':'.
+ */
+static int chop_last_dir(char **remoteurl, int is_relative)
+{
+	char *rfind = find_last_dir_sep(*remoteurl);
+	if (rfind) {
+		*rfind = '\0';
+		return 0;
+	}
+
+	rfind = strrchr(*remoteurl, ':');
+	if (rfind) {
+		*rfind = '\0';
+		return 1;
+	}
+
+	if (is_relative || !strcmp(".", *remoteurl))
+		die(_("cannot strip one component off url '%s'"),
+			*remoteurl);
+
+	free(*remoteurl);
+	*remoteurl = xstrdup(".");
+	return 0;
+}
+
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path)
+{
+	int is_relative = 0;
+	int colonsep = 0;
+	char *out;
+	char *remoteurl = xstrdup(remote_url);
+	struct strbuf sb = STRBUF_INIT;
+	size_t len = strlen(remoteurl);
+
+	if (is_dir_sep(remoteurl[len-1]))
+		remoteurl[len-1] = '\0';
+
+	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
+		is_relative = 0;
+	else {
+		is_relative = 1;
+		/*
+		 * Prepend a './' to ensure all relative
+		 * remoteurls start with './' or '../'
+		 */
+		if (!starts_with_dot_slash_native(remoteurl) &&
+		    !starts_with_dot_dot_slash_native(remoteurl)) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "./%s", remoteurl);
+			free(remoteurl);
+			remoteurl = strbuf_detach(&sb, NULL);
+		}
+	}
+	/*
+	 * When the url starts with '../', remove that and the
+	 * last directory in remoteurl.
+	 */
+	while (url) {
+		if (starts_with_dot_dot_slash_native(url)) {
+			url += 3;
+			colonsep |= chop_last_dir(&remoteurl, is_relative);
+		} else if (starts_with_dot_slash_native(url))
+			url += 2;
+		else
+			break;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
+	if (ends_with(url, "/"))
+		strbuf_setlen(&sb, sb.len - 1);
+	free(remoteurl);
+
+	if (starts_with_dot_slash_native(sb.buf))
+		out = xstrdup(sb.buf + 2);
+	else
+		out = xstrdup(sb.buf);
+
+	if (!up_path || !is_relative) {
+		strbuf_release(&sb);
+		return out;
+	}
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s", up_path, out);
+	free(out);
+	return strbuf_detach(&sb, NULL);
+}
diff --git a/remote.h b/remote.h
index 4a1209ae2c8..f18fd27e530 100644
--- a/remote.h
+++ b/remote.h
@@ -409,4 +409,35 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+/*
+ * The `url` argument is the URL that navigates to the submodule origin
+ * repo. When relative, this URL is relative to the superproject origin
+ * URL repo. The `up_path` argument, if specified, is the relative
+ * path that navigates from the submodule working tree to the superproject
+ * working tree. Returns the origin URL of the submodule.
+ *
+ * Return either an absolute URL or filesystem path (if the superproject
+ * origin URL is an absolute URL or filesystem path, respectively) or a
+ * relative file system path (if the superproject origin URL is a relative
+ * file system path).
+ *
+ * When the output is a relative file system path, the path is either
+ * relative to the submodule working tree, if up_path is specified, or to
+ * the superproject working tree otherwise.
+ *
+ * NEEDSWORK: This works incorrectly on the domain and protocol part.
+ * remote_url      url              outcome          expectation
+ * http://a.com/b  ../c             http://a.com/c   as is
+ * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
+ *                                                   ignore trailing slash in url
+ * http://a.com/b  ../../c          http://c         error out
+ * http://a.com/b  ../../../c       http:/c          error out
+ * http://a.com/b  ../../../../c    http:c           error out
+ * http://a.com/b  ../../../../../c    .:c           error out
+ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
+ * when a local part has a colon in its path component, too.
+ */
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path);
+
 #endif
-- 
2.36.0.rc2.902.g60576bbc845

