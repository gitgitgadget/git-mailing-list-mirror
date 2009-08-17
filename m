From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 09/11] Add MSVC porting header files.
Date: Tue, 18 Aug 2009 00:05:00 +0800
Message-ID: <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4j2-0005aq-3s
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbZHQQGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZHQQGN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:06:13 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:45112 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbZHQQGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:06:12 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so1252367pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2XU/10tthaWlua1OEdq6Gce4b0vc1e/qz2PO57rQ5Bc=;
        b=GSWjlq0ztS0aFEO8TI6vmH+H/pnJKRhh733L7L4g3RmOmMwcj7xPkPambkPCkHTNHo
         68/b6JJydZ15ur/23J9R+Mi8TkxcSnIsWUWaMZW2dIXowyvSvCjfbXQWwQOIjZ70wLNi
         c9ihypk3tggT9xW5NgQOXfhu357UtUGw0QWk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x+Z5+Qnz2f0PkmebnCLSHPoPg0LvH5WZtOOWHT9T/5Q+Qm2Ai0s0OvtJS5kaHEM+3y
         Ck5EMkpFpHM/T8au4CBYWpzTsMtk59GWtuPRCwsozkiixyf20KVD3o7JORyFKjYvUGeU
         bDkVkRkObRjPJSGf0efVGVsh72sxfn242i55c=
Received: by 10.115.99.18 with SMTP id b18mr3644603wam.88.1250525174271;
        Mon, 17 Aug 2009 09:06:14 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id n6sm10760783wag.4.2009.08.17.09.06.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:06:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126211>

Add unix head file, dirent.h, unistd.h  and time.h
Add MSVC special porting head file msvc.h and msvc.c.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/msvc.c                   |   33 ++++++++++
 compat/msvc.h                   |   95 +++++++++++++++++++++++++++++
 compat/vcbuild/include/dirent.h |  127 +++++++++++++++++++++++++++++++++++++++
 compat/vcbuild/include/unistd.h |   92 ++++++++++++++++++++++++++++
 compat/vcbuild/sys/time.h       |   21 +++++++
 git-compat-util.h               |   12 ++++-
 6 files changed, 379 insertions(+), 1 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/sys/time.h

diff --git a/compat/msvc.c b/compat/msvc.c
new file mode 100644
index 0000000..80afd4d
--- /dev/null
+++ b/compat/msvc.c
@@ -0,0 +1,33 @@
+#include "../git-compat-util.h"
+#include "win32.h"
+#include <conio.h>
+#include "../strbuf.h"
+
+DIR *opendir(const char *name)
+{
+	int len;
+	DIR *p;
+	p = (DIR*)malloc(sizeof(DIR));
+	memset(p, 0, sizeof(DIR));
+	strncpy(p->dd_name, name, PATH_MAX);
+	len = strlen(p->dd_name);
+	p->dd_name[len] = '/';
+	p->dd_name[len+1] = '*';
+
+	if (p == NULL)
+		return NULL;
+
+	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
+
+	if (p->dd_handle == -1) {
+		free(p);
+		return NULL;
+	}
+	return p;
+}
+int closedir(DIR *dir)
+{
+	_findclose(dir->dd_handle);
+	free(dir);
+	return 0;
+}
diff --git a/compat/msvc.h b/compat/msvc.h
new file mode 100644
index 0000000..6071565
--- /dev/null
+++ b/compat/msvc.h
@@ -0,0 +1,95 @@
+#ifndef __MSVC__HEAD
+#define __MSVC__HEAD
+
+#define WINVER 0x0500
+#define _WIN32_WINNT 0x0500
+#define _WIN32_WINDOWS 0x0410
+#define _WIN32_IE 0x0700
+#define NTDDI_VERSION NTDDI_WIN2KSP1
+#include <winsock2.h>
+
+/*Configuration*/
+
+#define NO_PREAD
+#define NO_OPENSSL
+#define NO_LIBGEN_H
+#define NO_SYMLINK_HEAD
+#define NO_IPV6
+#define NO_SETENV
+#define NO_UNSETENV
+#define NO_STRCASESTR
+#define NO_STRLCPY
+#define NO_MEMMEM
+#define NO_C99_FORMAT
+#define NO_STRTOUMAX
+#define NO_MKDTEMP
+#define NO_MKSTEMPS
+
+#define RUNTIME_PREFIX
+#define NO_ST_BLOCKS_IN_STRUCT_STAT
+#define NO_NSEC
+#define USE_WIN32_MMAP
+#define USE_NED_ALLOCATOR
+
+#define NO_REGEX
+
+#define NO_SYS_SELECT_H
+#define NO_PTHEADS
+#define HAVE_STRING_H 1
+#define STDC_HEADERS
+#define NO_ICONV
+
+#define inline __inline
+#define __inline__ __inline
+
+#define SNPRINTF_RETURNS_BOGUS
+
+#define SHA1_HEADER "mozilla-sha1\\sha1.h"
+
+#define ETC_GITCONFIG "%HOME%"
+
+#define NO_PTHREADS
+#define NO_CURL
+
+
+#define NO_STRTOUMAX
+#define REGEX_MALLOC
+
+
+#define GIT_EXEC_PATH "bin"
+#define GIT_VERSION "1.6"
+#define BINDIR "bin"
+#define PREFIX "."
+#define GIT_MAN_PATH "man"
+#define GIT_INFO_PATH "info"
+#define GIT_HTML_PATH "html"
+#define DEFAULT_GIT_TEMPLATE_DIR "templates"
+
+#define NO_STRLCPY
+#define NO_UNSETENV
+#define NO_SETENV
+
+#define strdup _strdup
+#define read _read
+#define close _close
+#define dup _dup
+#define dup2 _dup2
+#define strncasecmp _strnicmp
+#define strtoull _strtoui64
+
+#define __attribute__(x)
+
+static __inline int strcasecmp (const char *s1, const char *s2)
+{
+	int size1=strlen(s1);
+	int sisz2=strlen(s2);
+
+	return _strnicmp(s1,s2,sisz2>size1?sisz2:size1);
+}
+
+#include "compat/mingw.h"
+#undef ERROR
+#undef stat
+#define stat(x,y) mingw_lstat
+#define stat      _stat64
+#endif
\ No newline at end of file
diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
new file mode 100644
index 0000000..a6b6f4c
--- /dev/null
+++ b/compat/vcbuild/include/dirent.h
@@ -0,0 +1,127 @@
+/*
+ * DIRENT.H (formerly DIRLIB.H)
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ * No warranty is given; refer to the file DISCLAIMER within the package.
+ *
+ */
+#ifndef _DIRENT_H_
+#define _DIRENT_H_
+
+/* All the headers include this file. */
+//#include <_mingw.h>
+
+#include <io.h>
+
+#define PATH_MAX 512
+
+#define __MINGW_NOTHROW
+
+#ifndef RC_INVOKED
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct dirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	char		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ * dd_stat field is now int (was short in older versions).
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	struct _finddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct dirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+         * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	char			dd_name[PATH_MAX+3];
+} DIR;
+
+DIR* __cdecl __MINGW_NOTHROW opendir (const char*);
+struct dirent* __cdecl __MINGW_NOTHROW readdir (DIR*);
+int __cdecl __MINGW_NOTHROW closedir (DIR*);
+void __cdecl __MINGW_NOTHROW rewinddir (DIR*);
+long __cdecl __MINGW_NOTHROW telldir (DIR*);
+void __cdecl __MINGW_NOTHROW seekdir (DIR*, long);
+
+
+/* wide char versions */
+
+struct _wdirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	wchar_t		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	//struct _wfinddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct _wdirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+         * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	wchar_t			dd_name[1];
+} _WDIR;
+
+
+
+_WDIR* __cdecl __MINGW_NOTHROW _wopendir (const wchar_t*);
+struct _wdirent*  __cdecl __MINGW_NOTHROW _wreaddir (_WDIR*);
+int __cdecl __MINGW_NOTHROW _wclosedir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wrewinddir (_WDIR*);
+long __cdecl __MINGW_NOTHROW _wtelldir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wseekdir (_WDIR*, long);
+
+
+#ifdef	__cplusplus
+}
+#endif
+
+#endif	/* Not RC_INVOKED */
+
+#endif	/* Not _DIRENT_H_ */
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
new file mode 100644
index 0000000..a0f59e6
--- /dev/null
+++ b/compat/vcbuild/include/unistd.h
@@ -0,0 +1,92 @@
+#ifndef _UNISTD_
+#define _UNISTD_
+
+/* Win32 define for porting git*/
+
+#ifndef _MODE_T_
+#define	_MODE_T_
+typedef unsigned short _mode_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _mode_t	mode_t;
+#endif
+#endif	/* Not _MODE_T_ */
+
+#ifndef _SSIZE_T_
+#define _SSIZE_T_
+typedef long _ssize_t;
+
+#ifndef	_OFF_T_
+#define	_OFF_T_
+typedef long _off_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _off_t	off_t;
+#endif
+#endif	/* Not _OFF_T_ */
+
+
+#ifndef	_NO_OLDNAMES
+typedef _ssize_t ssize_t;
+#endif
+#endif /* Not _SSIZE_T_ */
+
+typedef signed char int8_t;
+typedef unsigned char   uint8_t;
+typedef short  int16_t;
+typedef unsigned short  uint16_t;
+typedef int  int32_t;
+typedef unsigned   uint32_t;
+typedef long long  int64_t;
+typedef unsigned long long   uint64_t;
+
+typedef long long  intmax_t;
+typedef unsigned long long uintmax_t;
+
+typedef int64_t off64_t;
+
+#define STDOUT_FILENO 1
+#define STDERR_FILENO 2
+
+/* Some defines for _access nAccessMode (MS doesn't define them, but
+ * it doesn't seem to hurt to add them). */
+#define	F_OK	0	/* Check for file existence */
+/* Well maybe it does hurt.  On newer versions of MSVCRT, an access mode
+   of 1 causes invalid parameter error. */ 
+#define	X_OK	0	/* MS access() doesn't check for execute permission. */
+#define	W_OK	2	/* Check for write permission */
+#define	R_OK	4	/* Check for read permission */
+
+#define	_S_IFIFO	0x1000	/* FIFO */
+#define	_S_IFCHR	0x2000	/* Character */
+#define	_S_IFBLK	0x3000	/* Block: Is this ever set under w32? */
+#define	_S_IFDIR	0x4000	/* Directory */
+#define	_S_IFREG	0x8000	/* Regular */
+
+#define	_S_IFMT		0xF000	/* File type mask */
+
+#define	_S_IXUSR	_S_IEXEC
+#define	_S_IWUSR	_S_IWRITE
+#define	_S_IRUSR	_S_IREAD
+#define	_S_ISDIR(m)	(((m) & _S_IFMT) == _S_IFDIR)
+
+#define	S_IFIFO		_S_IFIFO
+#define	S_IFCHR		_S_IFCHR
+#define	S_IFBLK		_S_IFBLK
+#define	S_IFDIR		_S_IFDIR
+#define	S_IFREG		_S_IFREG
+#define	S_IFMT		_S_IFMT
+#define	S_IEXEC		_S_IEXEC
+#define	S_IWRITE	_S_IWRITE
+#define	S_IREAD		_S_IREAD
+#define	S_IRWXU		_S_IRWXU
+#define	S_IXUSR		_S_IXUSR
+#define	S_IWUSR		_S_IWUSR
+#define	S_IRUSR		_S_IRUSR
+
+
+#define	S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
+#define	S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
+#define	S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
+
+#endif
\ No newline at end of file
diff --git a/compat/vcbuild/sys/time.h b/compat/vcbuild/sys/time.h
new file mode 100644
index 0000000..6ed82c0
--- /dev/null
+++ b/compat/vcbuild/sys/time.h
@@ -0,0 +1,21 @@
+#ifndef	_UTIME_H_
+#define	_UTIME_H_
+/*
+ * Structure used by _utime function.
+ */
+struct _utimbuf
+{
+	time_t	actime;		/* Access time */
+	time_t	modtime;	/* Modification time */
+};
+
+#ifndef	_NO_OLDNAMES
+/* NOTE: Must be the same as _utimbuf above. */
+struct utimbuf
+{
+	time_t	actime;
+	time_t	modtime;
+};
+#endif	/* Not _NO_OLDNAMES */
+
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..cb89294 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -77,8 +77,10 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#ifndef _MSC_VER
 #include <sys/param.h>
 #include <sys/types.h>
+#endif
 #include <dirent.h>
 #include <sys/time.h>
 #include <time.h>
@@ -86,7 +88,12 @@
 #include <fnmatch.h>
 #include <assert.h>
 #include <regex.h>
+
+#ifndef _MSC_VER
 #include <utime.h>
+#endif
+
+#ifndef _MSC_VER
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
@@ -114,7 +121,10 @@
 #else 	/* __MINGW32__ */
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
-#endif	/* __MINGW32__ */
+#endif  /* __MINGW32__ */
+#else   /* _MSC_VER */
+#include "compat/msvc.h"
+#endif	/* _MSC_VER */
 
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
-- 
1.6.4.msysgit.0
