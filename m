Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6906820A40
	for <e@80x24.org>; Wed, 29 Nov 2017 15:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbdK2P4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 10:56:53 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46842 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755195AbdK2P4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 10:56:50 -0500
Received: by mail-qt0-f196.google.com with SMTP id r39so4861679qtr.13
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3HGn2LFCXR/x9rVLCvN2+sB0rZf6jADRCYVqOeFPKU=;
        b=AR0vKoZDBfiXFFQI/rk/r55ZFUXB656E+nH40XmUFkk8fmv265ELPFt/sGdrwN/IYJ
         5/UMW3VNcEcxzb/CeS6VbaJgURTsdk2IHfPxFXuoXZoMbZD8HXHCdlSKhgWKr91DHI6d
         XiwMXQ+Vfs3xmmT5enGl/T1aHWJv2y6IkkgqljdZRggF2TXFrUXzpvNiopd3lpqZ4UwI
         1rG9v3a4qPZXOZmE0vGvOYu9p4Qw5Q2w96LcUumZ5Zac6eRY/jYBWq9zR+QF1XN4f+8s
         YJ1tq2BQzP1KyIn+42F4Fwxuxrs94c/Xy1KffJIHmWWihmFRpJZTEUH/JPg35PcCLcYt
         V7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3HGn2LFCXR/x9rVLCvN2+sB0rZf6jADRCYVqOeFPKU=;
        b=X++K5O9DG8jv2chqkKdVurAj1uITE3nAXWFRwvcIuqEvp2kxvwf2O7km5mFMB2ZsCg
         t1Dx3Zzu5J8nmnQt9dceeSJS/WYsQ79RaKU5F9hsxcA7Jq2TSRQznHHycJIW+r7PyZeC
         7aRdZK8lofUo2l2fyT0MQgHYKm4x+ffDkeYnrmjKQvF/33vCdohcvISiDj9DPRsfLQH4
         kfveKN5lh8rANSjsaiBLIZY/1iCEvm5cU1rs0+C6rm+4nBAPs0vaCK2EeFDQI4Qxgg5q
         mc5xDmjxHgUSeFcsaypQ85Bb1+ZMVdTkrb8NxJ7VNLn+P7eavYlgoSPuZndn7yuwJ9Il
         Fh4Q==
X-Gm-Message-State: AJaThX6F7FhY36SgKQxZP42aK0PTyXYpB6B9tan0sV9yZiPpaYteK+4F
        ZCoo2eT2Z497gt5vJBzvK0t3mePOkMI=
X-Google-Smtp-Source: AGs4zMZX5MYMm7e+PZFzTmOtJZAZ2jrS1IMPQdwcz8tiPmsU5Cz5HCYB01WOpX5xgxmeT5/xtbSN2g==
X-Received: by 10.237.60.46 with SMTP id t43mr5123649qte.294.1511971008383;
        Wed, 29 Nov 2017 07:56:48 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id z126sm1390465qka.70.2017.11.29.07.56.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 07:56:47 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v4 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Wed, 29 Nov 2017 10:56:37 -0500
Message-Id: <20171129155637.89075-5-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20171129155637.89075-1-dnj@google.com>
References: <20171129155637.89075-1-dnj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable Git to resolve its own binary location using a variety of
OS-specific and generic methods, including:

- procfs via "/proc/self/exe" (Linux)
- _NSGetExecutablePath (Darwin)
- KERN_PROC_PATHNAME sysctl on BSDs.
- argv0, if absolute (all, including Windows).

This is used to enable RUNTIME_PREFIX support for non-Windows systems,
notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
do a best-effort resolution of its executable path and automatically use
this as its "exec_path" for relative helper and data lookups, unless
explicitly overridden.

Small incidental formatting cleanup of "exec_cmd.c".

Signed-off-by: Dan Jacques <dnj@google.com>
Thanks-to: Robbie Iannucci <iannucci@google.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |  35 +++++++-
 cache.h          |   1 +
 common-main.c    |   4 +-
 config.mak.uname |   7 ++
 exec_cmd.c       | 239 +++++++++++++++++++++++++++++++++++++++++++++++--------
 exec_cmd.h       |   4 +-
 gettext.c        |   8 +-
 git.c            |   2 +-
 8 files changed, 260 insertions(+), 40 deletions(-)

diff --git a/Makefile b/Makefile
index 741d1583f..e663fda1f 100644
--- a/Makefile
+++ b/Makefile
@@ -416,6 +416,16 @@ all::
 #
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
+# Define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the KERN_PROC BSD
+# sysctl function.
+#
+# Define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs" filesystem
+# capable of resolving the path of the current executable. If defined, this
+# must be the canonical path for the "procfs" current executable path.
+#
+# Define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports calling
+# _NSGetExecutablePath to retrieve the path of the running executable.
+#
 # Define HAVE_GETDELIM if your system has the getdelim() function.
 #
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
@@ -426,6 +436,12 @@ all::
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
 #
+# Define RUNTIME_PREFIX to configure Git to resolve its ancillary tooling and
+# support files relative to the location of the runtime binary, rather than
+# hard-coding them into the binary. Git installations built with RUNTIME_PREFIX
+# can be moved to arbitrary filesystem locations. Users may want to enable
+# RUNTIME_PREFIX_PERL as well (see below).
+#
 # Define RUNTIME_PREFIX_PERL to configure Git's PERL commands to locate Git
 # support libraries relative to their filesystem path instead of hard-coding
 # it.
@@ -466,6 +482,7 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
 #   perllibdir
 # This can help installing the suite in a relocatable way.
 
@@ -491,6 +508,7 @@ mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 sharedir_relative = $(patsubst $(prefix)/%,%,$(sharedir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
@@ -1637,10 +1655,23 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
+ifdef HAVE_BSD_KERN_PROC_SYSCTL
+	BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
+endif
+
 ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifneq ($(PROCFS_EXECUTABLE_PATH),)
+	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
+	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
+endif
+
+ifdef HAVE_NS_GET_EXECUTABLE_PATH
+	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -1723,6 +1754,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
@@ -2185,6 +2217,7 @@ endif
 exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
@@ -2202,7 +2235,7 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
-	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
+	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
diff --git a/cache.h b/cache.h
index 2e1434505..3d84aa0bf 100644
--- a/cache.h
+++ b/cache.h
@@ -449,6 +449,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
+#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 
 /*
  * This environment variable is expected to contain a boolean indicating
diff --git a/common-main.c b/common-main.c
index 6a689007e..6516a1f89 100644
--- a/common-main.c
+++ b/common-main.c
@@ -32,12 +32,12 @@ int main(int argc, const char **argv)
 	 */
 	sanitize_stdfds();
 
+	git_resolve_executable_dir(argv[0]);
+
 	git_setup_gettext();
 
 	attr_start();
 
-	git_extract_argv0_path(argv[0]);
-
 	restore_sigpipe_to_default();
 
 	return cmd_main(argc, argv);
diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..58fd62b4d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -111,6 +112,7 @@ ifeq ($(uname_S),Darwin)
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -206,6 +208,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
@@ -218,6 +221,8 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -236,6 +241,8 @@ ifeq ($(uname_S),NetBSD)
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/exec_cmd.c b/exec_cmd.c
index ce192a2d6..c9006c4c9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -2,53 +2,232 @@
 #include "exec_cmd.h"
 #include "quote.h"
 #include "argv-array.h"
-#define MAX_ARGS	32
 
-static const char *argv_exec_path;
+#if defined(RUNTIME_PREFIX)
+
+#if defined(HAVE_NS_GET_EXECUTABLE_PATH)
+#include <mach-o/dyld.h>
+#endif
+
+#if defined(HAVE_BSD_KERN_PROC_SYSCTL)
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/sysctl.h>
+#endif
+
+#endif /* RUNTIME_PREFIX */
+
+#define MAX_ARGS 32
+
+static const char *system_prefix(void);
 
 #ifdef RUNTIME_PREFIX
-static const char *argv0_path;
+
+/**
+ * When using a runtime prefix, Git dynamically resolves paths relative to its
+ * executable.
+ *
+ * The method for determining the path of the executable is highly
+ * platform-specific.
+ */
+
+/**
+ * Path to the current Git executable. Resolved on startup by
+ * 'git_resolve_executable_dir'.
+ */
+static const char *executable_dirname;
 
 static const char *system_prefix(void)
 {
 	static const char *prefix;
 
-	assert(argv0_path);
-	assert(is_absolute_path(argv0_path));
+	assert(executable_dirname);
+	assert(is_absolute_path(executable_dirname));
 
 	if (!prefix &&
-	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
-	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
-	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
+	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
+	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
+	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
 		prefix = PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
-				"but prefix computation failed.  "
-				"Using static fallback '%s'.\n", prefix);
+			     "but prefix computation failed.  "
+			     "Using static fallback '%s'.\n",
+			     prefix);
 	}
 	return prefix;
 }
 
-void git_extract_argv0_path(const char *argv0)
+/*
+ * Resolves the executable path from argv[0], only if it is absolute.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_from_argv0(struct strbuf *buf, const char *argv0)
 {
 	const char *slash;
 
 	if (!argv0 || !*argv0)
-		return;
+		return -1;
 
 	slash = find_last_dir_sep(argv0);
+	if (slash) {
+		trace_printf("trace: resolved executable path from argv0: %s\n",
+			     argv0);
+		strbuf_add_absolute_path(buf, argv0);
+		return 0;
+	}
+	return -1;
+}
+
+#ifdef PROCFS_EXECUTABLE_PATH
+/*
+ * Resolves the executable path by examining a procfs symlink.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_procfs(struct strbuf *buf)
+{
+	if (strbuf_realpath(buf, PROCFS_EXECUTABLE_PATH, 0)) {
+		trace_printf(
+			"trace: resolved executable path from procfs: %s\n",
+			buf->buf);
+		return 0;
+	}
+	return -1;
+}
+#endif /* PROCFS_EXECUTABLE_PATH */
+
+#ifdef HAVE_BSD_KERN_PROC_SYSCTL
+/*
+ * Resolves the executable path using KERN_PROC_PATHNAME BSD sysctl.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
+{
+	int mib[4];
+	char path[MAXPATHLEN];
+	size_t cb = sizeof(path);
+
+	mib[0] = CTL_KERN;
+	mib[1] = KERN_PROC;
+	mib[2] = KERN_PROC_PATHNAME;
+	mib[3] = -1;
+	if (!sysctl(mib, 4, path, &cb, NULL, 0)) {
+		trace_printf(
+			"trace: resolved executable path from sysctl: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
+
+#ifdef HAVE_NS_GET_EXECUTABLE_PATH
+/*
+ * Resolves the executable path by querying Darwin applicaton stack.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_darwin(struct strbuf *buf)
+{
+	char path[PATH_MAX];
+	uint32_t size = sizeof(path);
+	if (!_NSGetExecutablePath(path, &size)) {
+		trace_printf(
+			"trace: resolved executable path from Darwin stack: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+
+/*
+ * Resolves the absolute path of the current executable.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path(struct strbuf *buf, const char *argv0)
+{
+	/*
+	 * Identifying the executable path is operating system specific.
+	 * Selectively employ all available methods in order of preference,
+	 * preferring highly-available authoratative methods over
+	 * selectively-available or non- authoratative methods.
+	 *
+	 * All cases fall back on resolving against argv[0] if there isn't a
+	 * better functional method. However, note that argv[0] can be
+	 * used-supplied on many operating sysetems, and is not authoratative
+	 * in those cases.
+	 *
+	 * Each of these functions returns 0 on success, so evaluation will stop
+	 * after the first successful method.
+	 */
+	if (
+#ifdef HAVE_BSD_KERN_PROC_SYSCTL
+		git_get_exec_path_bsd_sysctl(buf) &&
+#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
+
+#ifdef HAVE_NS_GET_EXECUTABLE_PATH
+		git_get_exec_path_darwin(buf) &&
+#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
+
+#ifdef PROCFS_EXECUTABLE_PATH
+		git_get_exec_path_procfs(buf) &&
+#endif /* PROCFS_EXECUTABLE_PATH */
+
+		git_get_exec_path_from_argv0(buf, argv0)) {
+		return -1;
+	}
 
+	if (strbuf_normalize_path(buf)) {
+		trace_printf("trace: could not normalize path: %s\n", buf->buf);
+		return -1;
+	}
+
+	return 0;
+}
+
+void git_resolve_executable_dir(const char *argv0)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *resolved;
+	const char *slash;
+
+	if (git_get_exec_path(&buf, argv0)) {
+		trace_printf(
+			"trace: could not determine executable path from: %s\n",
+			argv0);
+		strbuf_release(&buf);
+		return;
+	}
+
+	resolved = strbuf_detach(&buf, NULL);
+	slash = find_last_dir_sep(resolved);
 	if (slash)
-		argv0_path = xstrndup(argv0, slash - argv0);
+		resolved[slash - resolved] = '\0';
+
+	executable_dirname = resolved;
+	trace_printf("trace: resolved executable dir: %s\n",
+		     executable_dirname);
 }
 
 #else
 
+/**
+ * When not using a runtime prefix, Git uses a hard-coded path, and there is
+ * nothing to resolve.
+ */
+
 static const char *system_prefix(void)
 {
 	return PREFIX;
 }
 
-void git_extract_argv0_path(const char *argv0)
+void git_resolve_executable_dir(const char *argv0)
 {
 }
 
@@ -65,32 +244,28 @@ char *system_path(const char *path)
 	return strbuf_detach(&d, NULL);
 }
 
-void git_set_argv_exec_path(const char *exec_path)
+static const char *exec_path_value;
+
+void git_set_exec_path(const char *exec_path)
 {
-	argv_exec_path = exec_path;
+	exec_path_value = exec_path;
 	/*
 	 * Propagate this setting to external programs.
 	 */
 	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
 
-
-/* Returns the highest-priority, location to look for git programs. */
+/* Returns the highest-priority location to look for git programs. */
 const char *git_exec_path(void)
 {
-	static char *cached_exec_path;
-
-	if (argv_exec_path)
-		return argv_exec_path;
-
-	if (!cached_exec_path) {
+	if (!exec_path_value) {
 		const char *env = getenv(EXEC_PATH_ENVIRONMENT);
 		if (env && *env)
-			cached_exec_path = xstrdup(env);
+			exec_path_value = xstrdup(env);
 		else
-			cached_exec_path = system_path(GIT_EXEC_PATH);
+			exec_path_value = system_path(GIT_EXEC_PATH);
 	}
-	return cached_exec_path;
+	return exec_path_value;
 }
 
 static void add_path(struct strbuf *out, const char *path)
@@ -103,10 +278,12 @@ static void add_path(struct strbuf *out, const char *path)
 
 void setup_path(void)
 {
+	const char *exec_path = git_exec_path();
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
-	add_path(&new_path, git_exec_path());
+	git_set_exec_path(exec_path);
+	add_path(&new_path, exec_path);
 
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -125,7 +302,8 @@ const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 	return out->argv;
 }
 
-int execv_git_cmd(const char **argv) {
+int execv_git_cmd(const char **argv)
+{
 	struct argv_array nargv = ARGV_ARRAY_INIT;
 
 	prepare_git_cmd(&nargv, argv);
@@ -140,8 +318,7 @@ int execv_git_cmd(const char **argv) {
 	return -1;
 }
 
-
-int execl_git_cmd(const char *cmd,...)
+int execl_git_cmd(const char *cmd, ...)
 {
 	int argc;
 	const char *argv[MAX_ARGS + 1];
diff --git a/exec_cmd.h b/exec_cmd.h
index ff0b48048..2522453cd 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,8 +3,8 @@
 
 struct argv_array;
 
-extern void git_set_argv_exec_path(const char *exec_path);
-extern void git_extract_argv0_path(const char *path);
+extern void git_set_exec_path(const char *exec_path);
+extern void git_resolve_executable_dir(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
diff --git a/gettext.c b/gettext.c
index db727ea02..6b64d5c2e 100644
--- a/gettext.c
+++ b/gettext.c
@@ -2,7 +2,8 @@
  * Copyright (c) 2010 Ævar Arnfjörð Bjarmason
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
+#include "exec_cmd.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
@@ -157,10 +158,11 @@ static void init_gettext_charset(const char *domain)
 
 void git_setup_gettext(void)
 {
-	const char *podir = getenv("GIT_TEXTDOMAINDIR");
+	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
 
 	if (!podir)
-		podir = GIT_LOCALE_PATH;
+		podir = system_path(GIT_LOCALE_PATH);
+
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
diff --git a/git.c b/git.c
index 9e96dd409..dc4cc1419 100644
--- a/git.c
+++ b/git.c
@@ -65,7 +65,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		 */
 		if (skip_prefix(cmd, "--exec-path", &cmd)) {
 			if (*cmd == '=')
-				git_set_argv_exec_path(cmd + 1);
+				git_set_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
 				exit(0);
-- 
2.15.0.chromium12

