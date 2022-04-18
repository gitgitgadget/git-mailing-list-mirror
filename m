Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2480C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiDRR0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347013AbiDRR0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6D33A1B
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so9108809wmr.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3VN/7jF45EC8QKxSNVFSlXJ3I2h7S0yPl8a4FGMBDM=;
        b=mSGq8nYVM6x0LhzljAGxIjR6V/NdcSbW4lbgI7HCu6d030p9lnEEtd3nGqW73DXKFG
         NRGgYKsU7tlWqTJg2iowJVNwnEQxrJl2S+hJIpqXhYLfu8jdp33nmx3f1+ILMFVgXwin
         giGlQx8VMlELMgKKhOT4FOacxSNVXkVSjX66oUCY2K0otYrqC+KrsWIdOzn/qbeWMxby
         KQ3hLy4AejPBKBnHkb734APb7EFr5Mm1/e133/l81a7EB+VCSqtoxdkG6sAvIopYQWD1
         FMqIeRmNoK1ADSdo7OBOmVB0jI3YDuBBga3DZU6NnYstr5h/lM85LoR+d0SjaMvSz1VA
         US8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3VN/7jF45EC8QKxSNVFSlXJ3I2h7S0yPl8a4FGMBDM=;
        b=juuOS4puVgTDz/IpBUMoQqnwTrqvRYuHnKI/P+C7pcd88E5pWqAdDcB40C/gqCUcJa
         0JT1c5ORzlkyuSxOgo/1kcF1Ll9rnaCUGiAYE5qQpQo2UbkbdKUedRhw0kOvJId71UPw
         OSKffFmqnbK5TXmYzHQU+6mWQkaw89ShEEFVkQFFSIHrHwjCanWnSskYH/Tc1bZIvh8e
         x8/l+uns3ntYKvKTcXms0Ni5nOpFZwu5cTOyI5OgFC8yVID2rjcYviM0tCXfvS5yRk3O
         BA9dnUNa1Y19gJK0pEZV830JW3OwqCdUaCSGymkZmutR+M//92k5/rFP3Zb8B/rNjBgy
         kg+Q==
X-Gm-Message-State: AOAM532muApoA//OLZL/CY/RmqYtdy3RfSGVQb8kKpH06Exhyz6JIYsn
        QedWnLK9AmeIGFV+L0fNx6JttuMYoX3xaQ==
X-Google-Smtp-Source: ABdhPJySBpgL5mdA/F89Bc7prBM1UorMGnGVvmEZd+/dnVRE7qv+dBPbxcI+wlnKr1j4+JGT1EDwWw==
X-Received: by 2002:a7b:c190:0:b0:38e:7e47:744a with SMTP id y16-20020a7bc190000000b0038e7e47744amr12135970wmi.38.1650302643032;
        Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/36] dir API: add a generalized path_match_flags() function
Date:   Mon, 18 Apr 2022 19:23:19 +0200
Message-Id: <RFC-patch-v2-02.36-8f6e4f12e8a-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a path_match_flags() function and have the two sets of
starts_with_dot_{,dot_}slash() functions added in
63e95beb085 (submodule: port resolve_relative_url from shell to C,
2016-04-15) and a2b26ffb1a8 (fsck: convert gitmodules url to URL
passed to curl, 2020-04-18) be thin wrappers for it.

As the latter of those notes the fsck version was copied from the
initial builtin/submodule--helper.c version.

Since the code added in a2b26ffb1a8 was doing really doing the same as
win32_is_dir_sep() added in 1cadad6f658 (git clone <url>
C:\cygwin\home\USER\repo' is working (again), 2018-12-15) let's move
the latter to git-compat-util.h is a is_xplatform_dir_sep(). We can
then call either it or the platform-specific is_dir_sep() from this
new function.

Let's likewise change code in various other places that was hardcoding
checks for "'/' || '\\'" with the new is_xplatform_dir_sep(). As can
be seen in those callers some of them still concern themselves with
':' (Mac OS classic?), but let's leave the question of whether that
should be consolidated for some other time.

As we expect to make wider use of the "native" case in the future,
define and use two starts_with_dot_{,dot_}slash_native() convenience
wrappers. This makes the diff in builtin/submodule--helper.c much
smaller.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 20 ++++++------
 compat/mingw.c              |  2 +-
 compat/win32/path-utils.h   |  6 +---
 dir.c                       | 29 +++++++++++++++++
 dir.h                       | 63 +++++++++++++++++++++++++++++++++++++
 fsck.c                      | 23 ++++----------
 git-compat-util.h           |  8 ++++-
 path.c                      |  2 +-
 submodule-config.c          |  6 ++--
 9 files changed, 121 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364f..b68102bb3ed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,16 +72,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-static int starts_with_dot_slash(const char *str)
-{
-	return str[0] == '.' && is_dir_sep(str[1]);
-}
-
-static int starts_with_dot_dot_slash(const char *str)
-{
-	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
-}
-
 /*
  * Returns 1 if it was the last chop before ':'.
  */
@@ -108,6 +98,16 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	return 0;
 }
 
+static int starts_with_dot_slash(const char *const path)
+{
+	return starts_with_dot_slash_native(path);;
+}
+
+static int starts_with_dot_dot_slash(const char *const path)
+{
+	return starts_with_dot_dot_slash_native(path);
+}
+
 /*
  * The `url` argument is the URL that navigates to the submodule origin
  * repo. When relative, this URL is relative to the superproject origin
diff --git a/compat/mingw.c b/compat/mingw.c
index 6fe80fdf014..b94b473d978 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2830,7 +2830,7 @@ int is_valid_win32_path(const char *path, int allow_literal_nul)
 			}
 
 			c = path[i];
-			if (c && c != '.' && c != ':' && c != '/' && c != '\\')
+			if (c && c != '.' && c != ':' && !is_xplatform_dir_sep(c))
 				goto not_a_reserved_name;
 
 			/* contains reserved name */
diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index bba2b644080..65fa3b9263a 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -6,11 +6,7 @@ int win32_has_dos_drive_prefix(const char *path);
 
 int win32_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix win32_skip_dos_drive_prefix
-static inline int win32_is_dir_sep(int c)
-{
-	return c == '/' || c == '\\';
-}
-#define is_dir_sep win32_is_dir_sep
+#define is_dir_sep is_xplatform_dir_sep
 static inline char *win32_find_last_dir_sep(const char *path)
 {
 	char *ret = NULL;
diff --git a/dir.c b/dir.c
index f2b0f242101..d25aa6ade55 100644
--- a/dir.c
+++ b/dir.c
@@ -3890,3 +3890,32 @@ void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
 
 	connect_work_tree_and_git_dir(path, new_git_dir, 0);
 }
+
+int path_match_flags(const char *const str, const enum path_match_flags flags)
+{
+	const char *p = str;
+
+	if (flags & PATH_MATCH_NATIVE &&
+	    flags & PATH_MATCH_XPLATFORM)
+		BUG("path_match_flags() must get one match kind, not multiple!");
+	else if (!(flags & PATH_MATCH_KINDS_MASK))
+		BUG("path_match_flags() must get at least one match kind!");
+
+	if (flags & PATH_MATCH_STARTS_WITH_DOT_SLASH &&
+	    flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
+		BUG("path_match_flags() must get one platform kind, not multiple!");
+	else if (!(flags & PATH_MATCH_PLATFORM_MASK))
+		BUG("path_match_flags() must get at least one platform kind!");
+
+	if (*p++ != '.')
+		return 0;
+	if (flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH &&
+	    *p++ != '.')
+		return 0;
+
+	if (flags & PATH_MATCH_NATIVE)
+		return is_dir_sep(*p);
+	else if (flags & PATH_MATCH_XPLATFORM)
+		return is_xplatform_dir_sep(*p);
+	BUG("unreachable");
+}
diff --git a/dir.h b/dir.h
index 8e02dfb505d..7bc862030cf 100644
--- a/dir.h
+++ b/dir.h
@@ -578,4 +578,67 @@ void connect_work_tree_and_git_dir(const char *work_tree,
 void relocate_gitdir(const char *path,
 		     const char *old_git_dir,
 		     const char *new_git_dir);
+
+/**
+ * The "enum path_matches_kind" determines how path_match_flags() will
+ * behave. The flags come in sets, and one (and only one) must be
+ * provided out of each "set":
+ *
+ * PATH_MATCH_NATIVE:
+ *	Path separator is is_dir_sep()
+ * PATH_MATCH_XPLATFORM:
+ *	Path separator is is_xplatform_dir_sep()
+ *
+ * Do we use is_dir_sep() to check for a directory separator
+ * (*_NATIVE), or do we always check for '/' or '\' (*_XPLATFORM). The
+ * "*_NATIVE" version on Windows is the same as "*_XPLATFORM",
+ * everywhere else "*_NATIVE" means "only /".
+ *
+ * PATH_MATCH_STARTS_WITH_DOT_SLASH:
+ *	Match a path starting with "./"
+ * PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH:
+ *	Match a path starting with "../"
+ *
+ * The "/" in the above is adjusted based on the "*_NATIVE" and
+ * "*_XPLATFORM" flags.
+ */
+enum path_match_flags {
+	PATH_MATCH_NATIVE = 1 << 0,
+	PATH_MATCH_XPLATFORM = 1 << 1,
+	PATH_MATCH_STARTS_WITH_DOT_SLASH = 1 << 2,
+	PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH = 1 << 3,
+};
+#define PATH_MATCH_KINDS_MASK (PATH_MATCH_STARTS_WITH_DOT_SLASH | \
+	PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
+#define PATH_MATCH_PLATFORM_MASK (PATH_MATCH_NATIVE | PATH_MATCH_XPLATFORM)
+
+/**
+ * path_match_flags() checks if a given "path" matches a given "enum
+ * path_match_flags" criteria.
+ */
+int path_match_flags(const char *const path, const enum path_match_flags f);
+
+/**
+ * starts_with_dot_slash_native(): convenience wrapper for
+ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_SLASH and
+ * PATH_MATCH_NATIVE.
+ */
+static inline int starts_with_dot_slash_native(const char *const path)
+{
+	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_SLASH;
+
+	return path_match_flags(path, what | PATH_MATCH_NATIVE);
+}
+
+/**
+ * starts_with_dot_slash_native(): convenience wrapper for
+ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH and
+ * PATH_MATCH_NATIVE.
+ */
+static inline int starts_with_dot_dot_slash_native(const char *const path)
+{
+	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH;
+
+	return path_match_flags(path, what | PATH_MATCH_NATIVE);
+}
 #endif
diff --git a/fsck.c b/fsck.c
index 3ec500d707a..dd4822ba1be 100644
--- a/fsck.c
+++ b/fsck.c
@@ -975,27 +975,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	return ret;
 }
 
-/*
- * Like builtin/submodule--helper.c's starts_with_dot_slash, but without
- * relying on the platform-dependent is_dir_sep helper.
- *
- * This is for use in checking whether a submodule URL is interpreted as
- * relative to the current directory on any platform, since \ is a
- * directory separator on Windows but not on other platforms.
- */
-static int starts_with_dot_slash(const char *str)
+static int starts_with_dot_slash(const char *const path)
 {
-	return str[0] == '.' && (str[1] == '/' || str[1] == '\\');
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
 }
 
-/*
- * Like starts_with_dot_slash, this is a variant of submodule--helper's
- * helper of the same name with the twist that it accepts backslash as a
- * directory separator even on non-Windows platforms.
- */
-static int starts_with_dot_dot_slash(const char *str)
+static int starts_with_dot_dot_slash(const char *const path)
 {
-	return str[0] == '.' && starts_with_dot_slash(str + 1);
+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
+				PATH_MATCH_XPLATFORM);
 }
 
 static int submodule_url_is_relative(const char *url)
diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..ba3436db9a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -236,6 +236,12 @@
 #include <sys/sysctl.h>
 #endif
 
+/* Used by compat/win32/path-utils.h, and more */
+static inline int is_xplatform_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+
 #if defined(__CYGWIN__)
 #include "compat/win32/path-utils.h"
 #endif
@@ -416,11 +422,11 @@ static inline int git_skip_dos_drive_prefix(char **path)
 #define skip_dos_drive_prefix git_skip_dos_drive_prefix
 #endif
 
-#ifndef is_dir_sep
 static inline int git_is_dir_sep(int c)
 {
 	return c == '/';
 }
+#ifndef is_dir_sep
 #define is_dir_sep git_is_dir_sep
 #endif
 
diff --git a/path.c b/path.c
index d73146b6cd2..2ab78278943 100644
--- a/path.c
+++ b/path.c
@@ -1413,7 +1413,7 @@ int is_ntfs_dotgit(const char *name)
 
 	for (;;) {
 		c = *(name++);
-		if (!c || c == '\\' || c == '/' || c == ':')
+		if (!c || is_xplatform_dir_sep(c) || c == ':')
 			return 1;
 		if (c != '.' && c != ' ')
 			return 0;
diff --git a/submodule-config.c b/submodule-config.c
index 29668b0620d..ce3beaf5d4f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -204,17 +204,17 @@ int check_submodule_name(const char *name)
 		return -1;
 
 	/*
-	 * Look for '..' as a path component. Check both '/' and '\\' as
+	 * Look for '..' as a path component. Check is_xplatform_dir_sep() as
 	 * separators rather than is_dir_sep(), because we want the name rules
 	 * to be consistent across platforms.
 	 */
 	goto in_component; /* always start inside component */
 	while (*name) {
 		char c = *name++;
-		if (c == '/' || c == '\\') {
+		if (is_xplatform_dir_sep(c)) {
 in_component:
 			if (name[0] == '.' && name[1] == '.' &&
-			    (!name[2] || name[2] == '/' || name[2] == '\\'))
+			    (!name[2] || is_xplatform_dir_sep(name[2])))
 				return -1;
 		}
 	}
-- 
2.36.0.rc2.902.g60576bbc845

