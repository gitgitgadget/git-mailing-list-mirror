Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E221F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeDJPGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41271 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbeDJPGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id d3so13606200qth.8
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPEHrNiZeAs8trjDvZC7Ecj3e0CfOFDyCCqEeO5Kn6E=;
        b=OYNvWrL/8WrvcxfUFi+9f7LindxZEhkq9spUG4FUgmQCxOqB5jQiTN2aeqhdK55wUL
         BdpWiauxkMpDo0yYT2mzcKqHI1iSClpr4A2r71a3wrPLDkshWwBj2Ftd7d4TqR4vse4p
         veAI0sB9JVrMGFFEDmTWcvbxUpCwCDvnKJsBRAn5cIIlAt3f37Aqo7yJkTwVmm3dvgYh
         1KekeIUw0b1zqI4rwqOjA8/4a3KWH7B8dKGFtVL5QiQOp7agK2v8Uy7rXFNuhCCHNvxC
         Rx5s7d1toi9yjR1WRRDkwh8uRIfw7Eik9Lyh8q/j1cGiOU0okXZ3k6VyzahZXoMXiRWY
         SrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPEHrNiZeAs8trjDvZC7Ecj3e0CfOFDyCCqEeO5Kn6E=;
        b=FafNMKBn/c0GqLNhPlDzfKTf1Css9/UUMoub9W57EMPHlQWHI3/BYZQtakXapIvgTl
         2Dv5aY18C/9aCpErvoZZRMmcymIyRYoYsEzjYjXtYeA6ay2gEQ1dnJvfE0Prz40ksa6w
         j+uBjcXY+GaXzK2B8vlwhz2eKMMNSmnS/pcNlYt3zqYxux1XTRKVl/LOGv2IyoHIH35d
         bqFfeQeBaerg1N3Mr+tPsSqDVUkkEOZdo0WdtEIvLXeygeaF0epPJdwNpzKJKLC3nMJV
         95d46/bQfqLvfsTb0QHFNMbKlzzBkMDX8kycCSZBXK+hSUrS2L/dxTrSVPWAWxlh51cZ
         XU9Q==
X-Gm-Message-State: ALQs6tAvjK5BbhRSySp0qJ5JeZtPEoUwoHrTJ42tR9Ob2oSbpBDEcqcD
        K7hcje5whgDzFR7x6TTCmbP+dXx+KiE=
X-Google-Smtp-Source: AIpwx4+0BTnYgE/HrAvtFS7VZVQmoQsIUYUqcIY30L4f3/GMFN1tc0CFfxZH5rhyh6TI0CvQSJukqA==
X-Received: by 10.200.53.24 with SMTP id y24mr1179473qtb.65.1523372771238;
        Tue, 10 Apr 2018 08:06:11 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:06:08 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v8 3/5] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Tue, 10 Apr 2018 11:05:44 -0400
Message-Id: <20180410150546.38062-4-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180410150546.38062-1-dnj@google.com>
References: <20180410150546.38062-1-dnj@google.com>
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
 Makefile               |  28 +++++-
 cache.h                |   1 +
 common-main.c          |   4 +-
 config.mak.uname       |   7 ++
 exec_cmd.c             | 236 +++++++++++++++++++++++++++++++++++++++++++------
 exec_cmd.h             |   4 +-
 gettext.c              |   8 +-
 git.c                  |   2 +-
 t/t0061-run-command.sh |   2 +-
 9 files changed, 253 insertions(+), 39 deletions(-)

diff --git a/Makefile b/Makefile
index 13fb0e19a..960541e77 100644
--- a/Makefile
+++ b/Makefile
@@ -448,6 +448,18 @@ all::
 # can be moved to arbitrary filesystem locations. RUNTIME_PREFIX also causes
 # Perl scripts to use a modified entry point header allowing them to resolve
 # support files at runtime.
+#
+# When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
+# supports the KERN_PROC BSD sysctl function.
+#
+# When using RUNTIME_PREFIX, define PROCFS_EXECUTABLE_PATH if your platform
+# mounts a "procfs" filesystem capable of resolving the path of the current
+# executable. If defined, this must be the canonical path for the "procfs"
+# current executable path.
+#
+# When using RUNTIME_PREFIX, define HAVE_NS_GET_EXECUTABLE_PATH if your platform
+# supports calling _NSGetExecutablePath to retrieve the path of the running
+# executable.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1671,10 +1683,23 @@ ifdef HAVE_BSD_SYSCTL
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
@@ -2223,6 +2248,7 @@ endif
 exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
@@ -2240,7 +2266,7 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
-	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
+	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
diff --git a/cache.h b/cache.h
index 6e45c1b53..4f8754969 100644
--- a/cache.h
+++ b/cache.h
@@ -428,6 +428,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
+#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 
 /*
  * Environment variable used in handshaking the wire protocol.
diff --git a/common-main.c b/common-main.c
index 7d716d5a5..b2e5a86df 100644
--- a/common-main.c
+++ b/common-main.c
@@ -32,14 +32,14 @@ int main(int argc, const char **argv)
 	 */
 	sanitize_stdfds();
 
+	git_resolve_executable_dir(argv[0]);
+
 	git_setup_gettext();
 
 	initialize_the_repository();
 
 	attr_start();
 
-	git_extract_argv0_path(argv[0]);
-
 	restore_sigpipe_to_default();
 
 	return cmd_main(argc, argv);
diff --git a/config.mak.uname b/config.mak.uname
index 6a1d0de0c..e1cfe5e5e 100644
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
@@ -205,6 +207,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
@@ -217,6 +220,8 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -235,6 +240,8 @@ ifeq ($(uname_S),NetBSD)
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/exec_cmd.c b/exec_cmd.c
index ce192a2d6..38d52d90a 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -2,24 +2,52 @@
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
 				"but prefix computation failed.  "
@@ -28,27 +56,179 @@ static const char *system_prefix(void)
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
+ * Resolves the executable path by querying Darwin application stack.
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
+	 * preferring highly-available authoritative methods over
+	 * selectively-available or non-authoritative methods.
+	 *
+	 * All cases fall back on resolving against argv[0] if there isn't a
+	 * better functional method. However, note that argv[0] can be
+	 * used-supplied on many operating systems, and is not authoritative
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
+
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
 
+/*
+ * When not using a runtime prefix, Git uses a hard-coded path.
+ */
 static const char *system_prefix(void)
 {
 	return PREFIX;
 }
 
-void git_extract_argv0_path(const char *argv0)
+/*
+ * This is called during initialization, but No work needs to be done here when
+ * runtime prefix is not being used.
+ */
+void git_resolve_executable_dir(const char *argv0)
 {
 }
 
@@ -65,32 +245,28 @@ char *system_path(const char *path)
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
@@ -103,10 +279,12 @@ static void add_path(struct strbuf *out, const char *path)
 
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
@@ -125,7 +303,8 @@ const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 	return out->argv;
 }
 
-int execv_git_cmd(const char **argv) {
+int execv_git_cmd(const char **argv)
+{
 	struct argv_array nargv = ARGV_ARRAY_INIT;
 
 	prepare_git_cmd(&nargv, argv);
@@ -140,8 +319,7 @@ int execv_git_cmd(const char **argv) {
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
index 3a8989371..48432f9fb 100644
--- a/git.c
+++ b/git.c
@@ -83,7 +83,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		 */
 		if (skip_prefix(cmd, "--exec-path", &cmd)) {
 			if (*cmd == '=')
-				git_set_argv_exec_path(cmd + 1);
+				git_set_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
 				exit(0);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 24c92b6cd..1009595d6 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -145,7 +145,7 @@ test_trace () {
 	expect="$1"
 	shift
 	GIT_TRACE=1 test-run-command "$@" run-command true 2>&1 >/dev/null | \
-		sed 's/.* run_command: //' >actual &&
+		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
 }
-- 
2.15.0.chromium12

