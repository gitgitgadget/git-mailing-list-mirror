Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4096DC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiBWSbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiBWSbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF764B416
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i19so14277714wmq.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nqJ7gYx5eQohJ5KAa6XRx1AGCVw3/JtF38IijvN1zdw=;
        b=mpmAc6b4SXQBLVhG8zIEYEQo2dAoK/5+HkWN9BveSryoh/sPNmqQyQaBaA1fKXG94c
         9azW1KjUHwNZUMWZdTuOVXOlLY4QGyVOBNWgrDkg6LnanQZNsCC8Fmq88jHWvEF5BvKW
         CYk9HIlxNGE5mbHYfUFhC+u21svndSM5kK5NoQu5jSaOebrcio8uLSkpdnKk7qByBbd3
         1Ns4mcRW7TFBdyLYZL0vOKvs1EpxXBit3fzUmfUSKI/XsjEqIlYOk6Rq0Je+lkE8Q0p0
         rlgtS2deOTW4mHPxKF+Ph0P6e6u4xmqeTOsnXNpQ3YH7wIUlPzQw4Umb7sMXIaf1NvNH
         yH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nqJ7gYx5eQohJ5KAa6XRx1AGCVw3/JtF38IijvN1zdw=;
        b=f568jzE55MMxZ/uaOQeExq1x+iNgBTyhZgLgaFrIGa0GH5DTUI1cdBbgFfqznznUvz
         mgNXe8kq1Y8FbqaWSAeTJvRuYzs1LanCwiXEaUbFrIoqNRPoCGBAbRQag3+2F7T6Lmuy
         oNYcO5EvcG6B0W64yB9PKT8x2eZEd6/gSQWWtdjom5nwC8NTpQjU3wu0NdU66+ppQxv/
         Zh8NKchFCNdAVRZIk/dGkcw+XpfI0N2rJJJyDzA/rWaCVnVeR0Hy1A7iOhJR77ojkJ5W
         zc5s4XI2rfiToHuYBtLt9KcBxzWIC7QDsPF1AJYEnqNtoVCLLAii+HVZHXsj5JucrDhf
         ay3w==
X-Gm-Message-State: AOAM533R/xJwB6Fro3Hy7RKHgduYJJo/oxI9XypaFj/tK9Bl9bnddYTU
        Wr/+yeeFxkA6XUoCYbMBpJsojEkVNJU=
X-Google-Smtp-Source: ABdhPJz6yCUlaNFHRJ1xbC/5E2CJb+DmcVHzChn+Puuxpqtf9k2dG4Hnem2xh4YR7b+csyt+X+QXUQ==
X-Received: by 2002:a05:600c:284a:b0:37e:9244:abea with SMTP id r10-20020a05600c284a00b0037e9244abeamr796400wmb.2.1645641069160;
        Wed, 23 Feb 2022 10:31:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm322133wrt.72.2022.02.23.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:08 -0800 (PST)
Message-Id: <d36012fa27ab1d56d6711a9c920bd69b4f5c1b47.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:42 +0000
Subject: [PATCH 04/25] remote: move relative_url()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method was initially written in 63e95beb0 (submodule: port
resolve_relative_url from shell to C, 2016-05-15). As we will need
similar functionality in the bundle URI feature, extract this to be
available in remote.h.

The code is exactly the same. The prototype is different only in
whitespace. The documentation comment only adds explicit instructions on
what happens when supplying two absolute URLs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/submodule--helper.c | 119 ------------------------------------
 remote.c                    |  96 +++++++++++++++++++++++++++++
 remote.h                    |  30 +++++++++
 3 files changed, 126 insertions(+), 119 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c17dde4170f..506ebd8e6bc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -70,125 +70,6 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
 	return 0;
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
diff --git a/remote.c b/remote.c
index c97c626eaa8..c4a56749e85 100644
--- a/remote.c
+++ b/remote.c
@@ -14,6 +14,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
+#include "connect.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -2727,3 +2728,98 @@ void remote_state_clear(struct remote_state *remote_state)
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
+/*
+ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
+ * when a local part has a colon in its path component, too.
+ */
+char *relative_url(const char *remote_url,
+		   const char *url,
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
+		if (!starts_with_dot_slash(remoteurl) &&
+		    !starts_with_dot_dot_slash(remoteurl)) {
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
+		if (starts_with_dot_dot_slash(url)) {
+			url += 3;
+			colonsep |= chop_last_dir(&remoteurl, is_relative);
+		} else if (starts_with_dot_slash(url))
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
+	if (starts_with_dot_slash(sb.buf))
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
index 4a1209ae2c8..91c7f187863 100644
--- a/remote.h
+++ b/remote.h
@@ -409,4 +409,34 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
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
+ */
+char *relative_url(const char *remote_url,
+		   const char *url,
+		   const char *up_path);
+
 #endif
-- 
gitgitgadget

