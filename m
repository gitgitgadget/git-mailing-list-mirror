From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/2] mingw: introduce the 'core.hideDotFiles' setting
Date: Wed, 11 May 2016 10:43:37 +0200 (CEST)
Message-ID: <5e802dd8c3ad7e18249cfa81aecc878f7dd4ec40.1462956195.git.johannes.schindelin@gmx.de>
References: <cover.1462881473.git.johannes.schindelin@gmx.de> <cover.1462956195.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:46:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PmV-0002Pq-6N
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcEKIqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:46:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:55592 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbcEKIpB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:45:01 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MD9uq-1aqTaL319Y-00GY2E; Wed, 11 May 2016 10:44:45
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462956195.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GzOi12u1M9nVW+GLmxpDdjBYnCPd7Gcs11X5dqbpCgUj/2DWASo
 K0Pdz8KqgTwGeaMGUDTbCL/owHyGm7gojADJa3ApbwQdBaigY32T1jUSYjozlGvz4loFgUT
 1fsGZqFcHCliozH/3jVDafupO/D+IyME52/1C6DsdIWHS8ZswTwMSEreMjGwxDkJ9SKTkwZ
 dgoAgpr0flzXWfNytsuDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1upfgzGmAvY=:O1+F8SXN4wQZhJI8gx7HLk
 ZJIW091NkB8J2GEZkzw5WZQXkYIqVYXV76MhMWhtvV+NQwDnL4lUPcdUiDPFSBEsZVYHeY8p0
 l/MtvhZ9NCyA7Db/H+gPMdNcP29hrNM0qQoKQef8D+VqXihftHJsCMxmPazMjLbBkm1/WR4dV
 tPIC5lSJXgHvDedCHEEGZaUlF5na0+mm3AKsnCb45KVzi0KhrHjaDxJrjyZCRWTQODz8KuhWU
 omvkOIEH1/M7g7p3eCSWcXsIZ6Vk9G3HslezmHpoePgFqpmZfuLmTbrY6RuQM/rOy0T1j6Rpz
 I6EH/Y9PjqM6JGyyBUEJEstTHPFgppbCqWfkJ2vfH2cZTXWdj+T+LEghzpFQY0s/yuyYVRzhE
 O1D2fPyHSIadpwC10OD94HaxKrjK0OkX7p6Bx0yzWsW4M92BylP7fg5zY0ENbcqLetKRz7qXG
 XvtSeVeRfjbTnAx/dAFz/pIN67Z8KuPWvdRstNRUa73ccncf9G6kMQb7Y92JvDkNGVQqmw0Pv
 kNl03gB5G9qLqNq7UFgBBsDpC9o0rE+c8sAFTym1cGrGxxhD+9u6rqsJOJYPKac3VCwwlhdg1
 Mw8hfcQkfXJYBpiPIazXanF15m6CbywE69K+/4w2pvtzEWEfBg1hDqvI6B3Qbi7XVAS9tikGY
 713QVhTebyk6Sx4+eUJRmjkYbLfgj+f14CALHDmj/Qod8tgw0wzAm6aHMcmvioz2GiVWhxtF6
 8JwQp8MsnZ+4oq40T5Ef/1LxSAYrk8hki8KCQlj3ekqhlUFQ4CY+Hj4elejncCRXulUZTscc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294246>

On Unix (and Linux), files and directories whose names start with a dot
are usually not shown by default. This convention is used by Git: the
.git/ directory should be left alone by regular users, and only accessed
through Git itself.

On Windows, no such convention exists. Instead, there is an explicit flag
to mark files or directories as hidden.

In the early days, Git for Windows did not mark the .git/ directory (or
for that matter, any file or directory whose name starts with a dot)
hidden. This lead to quite a bit of confusion, and even loss of data.

Consequently, Git for Windows introduced the core.hideDotFiles setting,
with three possible values: true, false, and dotGitOnly, defaulting to
marking only the .git/ directory as hidden.

The rationale: users do not need to access .git/ directly, and indeed (as
was demonstrated) should not really see that directory, either. However,
not all dot files should be hidden by default, as e.g. Eclipse does not
show them (and the user would therefore be unable to see, say, a
.gitattributes file).

In over five years since the last attempt to bring this patch into core
Git, a slightly buggy version of this patch has served Git for Windows'
users well: no single report indicated problems with the hidden .git/
directory, and the stream of problems caused by the previously non-hidden
.git/ directory simply stopped. The bugs have been fixed during the
process of getting this patch upstream.

Note that there is a funny quirk we have to pay attention to when
creating hidden files: we use Win32's _wopen() function which
transmogrifies its arguments and hands off to Win32's CreateFile()
function. That latter function errors out with ERROR_ACCESS_DENIED (the
equivalent of EACCES) when the equivalent of the O_CREAT flag was passed
and the file attributes (including the hidden flag) do not match an
existing file's. And _wopen() accepts no parameter that would be
transmogrified into said hidden flag. Therefore, we simply try again
without O_CREAT.

A slightly different method is required for our fopen()/freopen()
function as we cannot even *remove* the implicit O_CREAT flag.
Therefore, we briefly mark existing files as unhidden when opening them
via fopen()/freopen().

The ERROR_ACCESS_DENIED error can also be triggered by opening a file
that is marked as a system file (which is unlikely to be tracked in
Git), and by trying to create a file that has *just* been deleted and is
awaiting the last open handles to be released (which would be handled
better by the "Try again?" logic, a story for a different patch series,
though). In both cases, it does not matter much if we try again without
the O_CREAT flag, read: it does not hurt, either.

For details how ERROR_ACCESS_DENIED can be triggered, see
https://msdn.microsoft.com/en-us/library/windows/desktop/aa363858

Original-patch-by: Erik Faye-Lund <kusmabite@gmail.com>
Initial-Test-By: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  6 ++++
 cache.h                  |  7 +++++
 compat/mingw.c           | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 config.c                 |  8 ++++++
 environment.c            |  1 +
 t/t0001-init.sh          | 30 ++++++++++++++++++++
 t/t5611-clone-config.sh  | 20 +++++++++++++
 7 files changed, 146 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ece0acd..acd0b56 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -269,6 +269,12 @@ See linkgit:git-update-index[1].
 +
 The default is true (when core.filemode is not specified in the config file).
 
+core.hideDotFiles::
+	(Windows-only) If true, mark newly-created directories and files whose
+	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
+	directory is hidden, but no other files starting with a dot.  The
+	default mode is 'dotGitOnly'.
+
 core.ignoreCase::
 	If true, this option enables various workarounds to enable
 	Git to work better on filesystems that are not case sensitive,
diff --git a/cache.h b/cache.h
index 160f8e3..6d41b53 100644
--- a/cache.h
+++ b/cache.h
@@ -700,6 +700,13 @@ extern int ref_paranoia;
 extern char comment_line_char;
 extern int auto_comment_line_char;
 
+enum hide_dotfiles_type {
+	HIDE_DOTFILES_FALSE = 0,
+	HIDE_DOTFILES_TRUE,
+	HIDE_DOTFILES_DOTGITONLY
+};
+extern enum hide_dotfiles_type hide_dotfiles;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/compat/mingw.c b/compat/mingw.c
index 0413d5c..a8218e6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -286,6 +286,49 @@ int mingw_rmdir(const char *pathname)
 	return ret;
 }
 
+static inline int needs_hiding(const char *path)
+{
+	const char *basename;
+
+	if (hide_dotfiles == HIDE_DOTFILES_FALSE)
+		return 0;
+
+	/* We cannot use basename(), as it would remove trailing slashes */
+	mingw_skip_dos_drive_prefix((char **)&path);
+	if (!*path)
+		return 0;
+
+	for (basename = path; *path; path++)
+		if (is_dir_sep(*path)) {
+			do {
+				path++;
+			} while (is_dir_sep(*path));
+			/* ignore trailing slashes */
+			if (*path)
+				basename = path;
+		}
+
+	if (hide_dotfiles == HIDE_DOTFILES_TRUE)
+		return *basename == '.';
+
+	assert(hide_dotfiles == HIDE_DOTFILES_DOTGITONLY);
+	return !strncasecmp(".git", basename, 4) &&
+		(!basename[4] || is_dir_sep(basename[4]));
+}
+
+static int set_hidden_flag(const wchar_t *path, int set)
+{
+	DWORD original = GetFileAttributesW(path), modified;
+	if (set)
+		modified = original | FILE_ATTRIBUTE_HIDDEN;
+	else
+		modified = original & ~FILE_ATTRIBUTE_HIDDEN;
+	if (original == modified || SetFileAttributesW(path, modified))
+		return 0;
+	errno = err_win_to_posix(GetLastError());
+	return -1;
+}
+
 int mingw_mkdir(const char *path, int mode)
 {
 	int ret;
@@ -293,6 +336,8 @@ int mingw_mkdir(const char *path, int mode)
 	if (xutftowcs_path(wpath, path) < 0)
 		return -1;
 	ret = _wmkdir(wpath);
+	if (!ret && needs_hiding(path))
+		return set_hidden_flag(wpath, 1);
 	return ret;
 }
 
@@ -319,6 +364,21 @@ int mingw_open (const char *filename, int oflags, ...)
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
 	}
+	if ((oflags & O_CREAT) && needs_hiding(filename)) {
+		/*
+		 * Internally, _wopen() uses the CreateFile() API which errors
+		 * out with an ERROR_ACCESS_DENIED if CREATE_ALWAYS was
+		 * specified and an already existing file's attributes do not
+		 * match *exactly*. As there is no mode or flag we can set that
+		 * would correspond to FILE_ATTRIBUTE_HIDDEN, let's just try
+		 * again *without* the O_CREAT flag (that corresponds to the
+		 * CREATE_ALWAYS flag of CreateFile()).
+		 */
+		if (fd < 0 && errno == EACCES)
+			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);
+		if (fd >= 0 && set_hidden_flag(wfilename, 1))
+			warning("could not mark '%s' as hidden.", filename);
+	}
 	return fd;
 }
 
@@ -350,6 +410,7 @@ int mingw_fgetc(FILE *stream)
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
+	int hide = needs_hiding(filename);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
@@ -357,12 +418,19 @@ FILE *mingw_fopen (const char *filename, const char *otype)
 	if (xutftowcs_path(wfilename, filename) < 0 ||
 		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
 		return NULL;
+	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
+		error("could not unhide %s", filename);
+		return NULL;
+	}
 	file = _wfopen(wfilename, wotype);
+	if (file && hide && set_hidden_flag(wfilename, 1))
+		warning("could not mark '%s' as hidden.", filename);
 	return file;
 }
 
 FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 {
+	int hide = needs_hiding(filename);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
@@ -370,7 +438,13 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 	if (xutftowcs_path(wfilename, filename) < 0 ||
 		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
 		return NULL;
+	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
+		error("could not unhide %s", filename);
+		return NULL;
+	}
 	file = _wfreopen(wfilename, wotype, stream);
+	if (file && hide && set_hidden_flag(wfilename, 1))
+		warning("could not mark '%s' as hidden.", filename);
 	return file;
 }
 
diff --git a/config.c b/config.c
index 262d8d7..127d9f0 100644
--- a/config.c
+++ b/config.c
@@ -912,6 +912,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.hidedotfiles")) {
+		if (value && !strcasecmp(value, "dotgitonly"))
+			hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+		else
+			hide_dotfiles = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 57acb2f..96160a7 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,7 @@ int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
+enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5b9e7a..a6fdd5e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -354,4 +354,34 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
+# Tests for the hidden file attribute on windows
+is_hidden () {
+	# Use the output of `attrib`, ignore the absolute path
+	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
+
+test_expect_success MINGW '.git hidden' '
+	rm -rf newdir &&
+	(
+		unset GIT_DIR GIT_WORK_TREE
+		mkdir newdir &&
+		cd newdir &&
+		git init &&
+		is_hidden .git
+	) &&
+	check_config newdir/.git false unset
+'
+
+test_expect_success MINGW 'bare git dir not hidden' '
+	rm -rf newdir &&
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir newdir &&
+		cd newdir &&
+		git --bare init
+	) &&
+	! is_hidden newdir
+'
+
 test_done
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 27d730c..e4850b7 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -37,4 +37,24 @@ test_expect_success 'clone -c config is available during clone' '
 	test_cmp expect child/file
 '
 
+# Tests for the hidden file attribute on windows
+is_hidden () {
+	# Use the output of `attrib`, ignore the absolute path
+	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
+
+test_expect_success MINGW 'clone -c core.hideDotFiles' '
+	test_commit attributes .gitattributes "" &&
+	rm -rf child &&
+	git clone -c core.hideDotFiles=false . child &&
+	! is_hidden child/.gitattributes &&
+	rm -rf child &&
+	git clone -c core.hideDotFiles=dotGitOnly . child &&
+	! is_hidden child/.gitattributes &&
+	rm -rf child &&
+	git clone -c core.hideDotFiles=true . child &&
+	is_hidden child/.gitattributes
+'
+
 test_done
-- 
2.8.2.465.gb077790
