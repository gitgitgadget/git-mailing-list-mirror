From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/3] Win32: Unicode file name support (except dirent)
Date: Tue, 15 Jul 2014 15:43:15 +0200
Message-ID: <1405431797-20899-2-git-send-email-kasal@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com Tue Jul 15 15:43:32 2014
Return-path: <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>)
	id 1X730y-00077R-6F
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 15:43:28 +0200
Received: by mail-wi0-f187.google.com with SMTP id ho1sf433464wib.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=YoApwTMzZbD4m2tC/5ev7ZlRZEY/sQLFiip5mvafsjk=;
        b=PBbVEftHdJGcEAba6wBE4N38GRLdKWXbFhCmhaAL+ILavd/bvWP61r2h07ePYQ/lY4
         nomACUd/eyUq5WNWmCL/UO7Gj9k6eZ9IMz8XUXXQYjnZAtIxctzzr7nxzxnyKykCopKm
         +wp34BjVMIX0Txntdk9erepPmn0y9CmROsBOYT6bUickGNau826d1bwUfvFfbKo+FUXJ
         mkvuAKVNYrg6NU6rxR8nPsNBU7Ii0MLbmLu91CMNjezr3Gg6i+RwA9cGEOR0SxNjimbJ
         Uhd63PIKIXDH75SGprRiC1/9/xnlOuk1hn2dJAeKxYtD9zsJeOhkVbaoH+pwL43W1FJe
         mQDA==
X-Received: by 10.152.43.68 with SMTP id u4mr14574lal.12.1405431807952;
        Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.20.3 with SMTP id j3ls44412lae.99.gmail; Tue, 15 Jul 2014
 06:43:26 -0700 (PDT)
X-Received: by 10.112.93.33 with SMTP id cr1mr371512lbb.14.1405431806760;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r13si650345wib.0.2014.07.15.06.43.26
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 86A041C014F; Tue, 15 Jul 2014 15:43:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405431797-20899-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253559>

From: Karsten Blees <blees@dcon.de>
Date: Thu, 15 Mar 2012 18:21:28 +0100

Replaces Windows "ANSI" APIs dealing with file- or path names with their
Unicode equivalent, adding UTF-8/UTF-16LE conversion as necessary.

The dirent API (opendir/readdir/closedir) is updated in a separate commit.

Adds trivial wrappers for access, chmod and chdir.

Adds wrapper for mktemp (needed for both mkstemp and mkdtemp).

The simplest way to convert a repository with legacy-encoded (e.g. Cp1252)
file names to UTF-8 ist to checkout with an old msysgit version and
"git add --all & git commit" with the new version.

Includes a fix for bug reported by John Chen:
On Windows XP (not Win7), directories cannot be deleted while a find handle
is open, causing "Deletion of directory '...' failed. Should I try again?"
prompts.

Prior to this commit, these failures were silently ignored due to
strbuf_free in is_dir_empty resetting GetLastError to ERROR_SUCCESS.

Close the find handle in is_dir_empty so that git doesn't block deletion
of the directory even after all other applications have released it.

Reported-by: John Chen <john0312@gmail.com>
Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 198 ++++++++++++++++++++++++++++++++++++++++++---------------
 compat/mingw.h |  18 ++++--
 2 files changed, 160 insertions(+), 56 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3baaa4d..c19e3d9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <conio.h>
+#include <wchar.h>
 #include "../strbuf.h"
 #include "../run-command.h"
 
@@ -198,14 +199,16 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
-#undef unlink
 int mingw_unlink(const char *pathname)
 {
 	int ret, tries = 0;
+	wchar_t wpathname[MAX_PATH];
+	if (xutftowcs_path(wpathname, pathname) < 0)
+		return -1;
 
 	/* read-only files cannot be removed */
-	chmod(pathname, 0666);
-	while ((ret = unlink(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	_wchmod(wpathname, 0666);
+	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
 			break;
 		/*
@@ -221,45 +224,45 @@ int mingw_unlink(const char *pathname)
 	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
 	       ask_yes_no_if_possible("Unlink of file '%s' failed. "
 			"Should I try again?", pathname))
-	       ret = unlink(pathname);
+	       ret = _wunlink(wpathname);
 	return ret;
 }
 
-static int is_dir_empty(const char *path)
+static int is_dir_empty(const wchar_t *wpath)
 {
-	struct strbuf buf = STRBUF_INIT;
-	WIN32_FIND_DATAA findbuf;
+	WIN32_FIND_DATAW findbuf;
 	HANDLE handle;
-
-	strbuf_addf(&buf, "%s\\*", path);
-	handle = FindFirstFileA(buf.buf, &findbuf);
-	if (handle == INVALID_HANDLE_VALUE) {
-		strbuf_release(&buf);
+	wchar_t wbuf[MAX_PATH + 2];
+	wcscpy(wbuf, wpath);
+	wcscat(wbuf, L"\\*");
+	handle = FindFirstFileW(wbuf, &findbuf);
+	if (handle == INVALID_HANDLE_VALUE)
 		return GetLastError() == ERROR_NO_MORE_FILES;
-	}
 
-	while (!strcmp(findbuf.cFileName, ".") ||
-			!strcmp(findbuf.cFileName, ".."))
-		if (!FindNextFile(handle, &findbuf)) {
-			strbuf_release(&buf);
-			return GetLastError() == ERROR_NO_MORE_FILES;
+	while (!wcscmp(findbuf.cFileName, L".") ||
+			!wcscmp(findbuf.cFileName, L".."))
+		if (!FindNextFileW(handle, &findbuf)) {
+			DWORD err = GetLastError();
+			FindClose(handle);
+			return err == ERROR_NO_MORE_FILES;
 		}
 	FindClose(handle);
-	strbuf_release(&buf);
 	return 0;
 }
 
-#undef rmdir
 int mingw_rmdir(const char *pathname)
 {
 	int ret, tries = 0;
+	wchar_t wpathname[MAX_PATH];
+	if (xutftowcs_path(wpathname, pathname) < 0)
+		return -1;
 
-	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
 			errno = err_win_to_posix(GetLastError());
 		if (errno != EACCES)
 			break;
-		if (!is_dir_empty(pathname)) {
+		if (!is_dir_empty(wpathname)) {
 			errno = ENOTEMPTY;
 			break;
 		}
@@ -276,16 +279,26 @@ int mingw_rmdir(const char *pathname)
 	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
 	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
 			"Should I try again?", pathname))
-	       ret = rmdir(pathname);
+	       ret = _wrmdir(wpathname);
+	return ret;
+}
+
+int mingw_mkdir(const char *path, int mode)
+{
+	int ret;
+	wchar_t wpath[MAX_PATH];
+	if (xutftowcs_path(wpath, path) < 0)
+		return -1;
+	ret = _wmkdir(wpath);
 	return ret;
 }
 
-#undef open
 int mingw_open (const char *filename, int oflags, ...)
 {
 	va_list args;
 	unsigned mode;
 	int fd;
+	wchar_t wfilename[MAX_PATH];
 
 	va_start(args, oflags);
 	mode = va_arg(args, int);
@@ -294,10 +307,12 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	fd = open(filename, oflags, mode);
+	if (xutftowcs_path(wfilename, filename) < 0)
+		return -1;
+	fd = _wopen(wfilename, oflags, mode);
 
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
-		DWORD attrs = GetFileAttributes(filename);
+		DWORD attrs = GetFileAttributesW(wfilename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
 	}
@@ -332,17 +347,28 @@ int mingw_fgetc(FILE *stream)
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
+	FILE *file;
+	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
-	return fopen(filename, otype);
+	if (xutftowcs_path(wfilename, filename) < 0 ||
+		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		return NULL;
+	file = _wfopen(wfilename, wotype);
+	return file;
 }
 
-#undef freopen
 FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 {
+	FILE *file;
+	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
-	return freopen(filename, otype, stream);
+	if (xutftowcs_path(wfilename, filename) < 0 ||
+		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		return NULL;
+	file = _wfreopen(wfilename, wotype, stream);
+	return file;
 }
 
 #undef fflush
@@ -367,6 +393,31 @@ int mingw_fflush(FILE *stream)
 	return ret;
 }
 
+int mingw_access(const char *filename, int mode)
+{
+	wchar_t wfilename[MAX_PATH];
+	if (xutftowcs_path(wfilename, filename) < 0)
+		return -1;
+	/* X_OK is not supported by the MSVCRT version */
+	return _waccess(wfilename, mode & ~X_OK);
+}
+
+int mingw_chdir(const char *dirname)
+{
+	wchar_t wdirname[MAX_PATH];
+	if (xutftowcs_path(wdirname, dirname) < 0)
+		return -1;
+	return _wchdir(wdirname);
+}
+
+int mingw_chmod(const char *filename, int mode)
+{
+	wchar_t wfilename[MAX_PATH];
+	if (xutftowcs_path(wfilename, filename) < 0)
+		return -1;
+	return _wchmod(wfilename, mode);
+}
+
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
@@ -392,10 +443,12 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
  */
 static int do_lstat(int follow, const char *file_name, struct stat *buf)
 {
-	int err;
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
+	wchar_t wfilename[MAX_PATH];
+	if (xutftowcs_path(wfilename, file_name) < 0)
+		return -1;
 
-	if (!(err = get_file_attr(file_name, &fdata))) {
+	if (GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata)) {
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
@@ -408,8 +461,8 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
-			WIN32_FIND_DATAA findbuf;
-			HANDLE handle = FindFirstFileA(file_name, &findbuf);
+			WIN32_FIND_DATAW findbuf;
+			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
 			if (handle != INVALID_HANDLE_VALUE) {
 				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
 						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
@@ -428,7 +481,23 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 		}
 		return 0;
 	}
-	errno = err;
+	switch (GetLastError()) {
+	case ERROR_ACCESS_DENIED:
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_LOCK_VIOLATION:
+	case ERROR_SHARING_BUFFER_EXCEEDED:
+		errno = EACCES;
+		break;
+	case ERROR_BUFFER_OVERFLOW:
+		errno = ENAMETOOLONG;
+		break;
+	case ERROR_NOT_ENOUGH_MEMORY:
+		errno = ENOMEM;
+		break;
+	default:
+		errno = ENOENT;
+		break;
+	}
 	return -1;
 }
 
@@ -516,16 +585,20 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 {
 	FILETIME mft, aft;
 	int fh, rc;
+	DWORD attrs;
+	wchar_t wfilename[MAX_PATH];
+	if (xutftowcs_path(wfilename, file_name) < 0)
+		return -1;
 
 	/* must have write permission */
-	DWORD attrs = GetFileAttributes(file_name);
+	attrs = GetFileAttributesW(wfilename);
 	if (attrs != INVALID_FILE_ATTRIBUTES &&
 	    (attrs & FILE_ATTRIBUTE_READONLY)) {
 		/* ignore errors here; open() will report them */
-		SetFileAttributes(file_name, attrs & ~FILE_ATTRIBUTE_READONLY);
+		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
 	}
 
-	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0) {
+	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
 		rc = -1;
 		goto revert_attrs;
 	}
@@ -548,7 +621,7 @@ revert_attrs:
 	if (attrs != INVALID_FILE_ATTRIBUTES &&
 	    (attrs & FILE_ATTRIBUTE_READONLY)) {
 		/* ignore errors again */
-		SetFileAttributes(file_name, attrs);
+		SetFileAttributesW(wfilename, attrs);
 	}
 	return rc;
 }
@@ -559,6 +632,18 @@ unsigned int sleep (unsigned int seconds)
 	return 0;
 }
 
+char *mingw_mktemp(char *template)
+{
+	wchar_t wtemplate[MAX_PATH];
+	if (xutftowcs_path(wtemplate, template) < 0)
+		return NULL;
+	if (!_wmktemp(wtemplate))
+		return NULL;
+	if (xwcstoutf(template, wtemplate, strlen(template) + 1) < 0)
+		return NULL;
+	return template;
+}
+
 int mkstemp(char *template)
 {
 	char *filename = mktemp(template);
@@ -617,17 +702,18 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 	return result;
 }
 
-#undef getcwd
 char *mingw_getcwd(char *pointer, int len)
 {
 	int i;
-	char *ret = getcwd(pointer, len);
-	if (!ret)
-		return ret;
+	wchar_t wpointer[MAX_PATH];
+	if (!_wgetcwd(wpointer, ARRAY_SIZE(wpointer)))
+		return NULL;
+	if (xwcstoutf(pointer, wpointer, len) < 0)
+		return NULL;
 	for (i = 0; pointer[i]; i++)
 		if (pointer[i] == '\\')
 			pointer[i] = '/';
-	return ret;
+	return pointer;
 }
 
 /*
@@ -1485,33 +1571,36 @@ int mingw_rename(const char *pold, const char *pnew)
 {
 	DWORD attrs, gle;
 	int tries = 0;
+	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
+	if (xutftowcs_path(wpold, pold) < 0 || xutftowcs_path(wpnew, pnew) < 0)
+		return -1;
 
 	/*
 	 * Try native rename() first to get errno right.
 	 * It is based on MoveFile(), which cannot overwrite existing files.
 	 */
-	if (!rename(pold, pnew))
+	if (!_wrename(wpold, wpnew))
 		return 0;
 	if (errno != EEXIST)
 		return -1;
 repeat:
-	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+	if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
 		return 0;
 	/* TODO: translate more errors */
 	gle = GetLastError();
 	if (gle == ERROR_ACCESS_DENIED &&
-	    (attrs = GetFileAttributes(pnew)) != INVALID_FILE_ATTRIBUTES) {
+	    (attrs = GetFileAttributesW(wpnew)) != INVALID_FILE_ATTRIBUTES) {
 		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
 			errno = EISDIR;
 			return -1;
 		}
 		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
-		    SetFileAttributes(pnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
-			if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
+			if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
 				return 0;
 			gle = GetLastError();
 			/* revert file attributes on failure */
-			SetFileAttributes(pnew, attrs);
+			SetFileAttributesW(wpnew, attrs);
 		}
 	}
 	if (tries < ARRAY_SIZE(delay) && gle == ERROR_ACCESS_DENIED) {
@@ -1757,11 +1846,16 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef BOOL (WINAPI *T)(LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
+	wchar_t woldpath[MAX_PATH], wnewpath[MAX_PATH];
+	if (xutftowcs_path(woldpath, oldpath) < 0 ||
+		xutftowcs_path(wnewpath, newpath) < 0)
+		return -1;
+
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
-			GetModuleHandle("kernel32.dll"), "CreateHardLinkA");
+			GetModuleHandle("kernel32.dll"), "CreateHardLinkW");
 		if (!create_hard_link)
 			create_hard_link = (T)-1;
 	}
@@ -1769,7 +1863,7 @@ int link(const char *oldpath, const char *newpath)
 		errno = ENOSYS;
 		return -1;
 	}
-	if (!create_hard_link(newpath, oldpath, NULL)) {
+	if (!create_hard_link(wnewpath, woldpath, NULL)) {
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
diff --git a/compat/mingw.h b/compat/mingw.h
index 8dac6f9..405c08f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -118,10 +118,7 @@ static inline int fcntl(int fd, int cmd, ...)
  * simple adaptors
  */
 
-static inline int mingw_mkdir(const char *path, int mode)
-{
-	return mkdir(path);
-}
+int mingw_mkdir(const char *path, int mode);
 #define mkdir mingw_mkdir
 
 #define WNOHANG 1
@@ -192,6 +189,19 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
 int mingw_fflush(FILE *stream);
 #define fflush mingw_fflush
 
+int mingw_access(const char *filename, int mode);
+#undef access
+#define access mingw_access
+
+int mingw_chdir(const char *dirname);
+#define chdir mingw_chdir
+
+int mingw_chmod(const char *filename, int mode);
+#define chmod mingw_chmod
+
+char *mingw_mktemp(char *template);
+#define mktemp mingw_mktemp
+
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
 
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
