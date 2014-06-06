From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 5/5] Win32 dirent: improve dirent implementation
Date: Fri,  6 Jun 2014 22:15:44 +0200
Message-ID: <1402085744-15829-6-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
 <1402085744-15829-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:15:59 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YM-0005KJ-9S
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:54 +0200
Received: by mail-lb0-f187.google.com with SMTP id z11sf405009lbi.14
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=CxuAM7JF8fuxKLK5M9+v1U+IWakujbljf3kwVBvn3gs=;
        b=jqX/aaRDPLAVpVen8/ivUqXuYH7i0NKC8HFwKgeAm0dtC0PhivdTRuk/cOpYaLQFuh
         lKnB4cXlbZ6r8jC0GsNKJLXFcqz23zjbH8DSSTcfOTwpcXNLATNyjLTLqLG+W3lvoQz9
         e1V5iaxJDoufhL272qh9QIsgKG5uC47oN1uRg2hI1Q7rqfP03vq6NkTypfozA4pwWrXr
         RJbzwJysZz2fYq9aW/wF0nOiHj0bK6unxRq7d9UyYPKKt+a92SPPLDQLrw8SLI58kMk+
         HxDZjDy+4Ok6MfLF6L+H3qFB8T/Up2aGQR4WoZN+QcjWNm+RkrUugO8gDl/oT9b7afO7
         y+UA==
X-Received: by 10.152.37.5 with SMTP id u5mr46745laj.23.1402085754111;
        Fri, 06 Jun 2014 13:15:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.199.8 with SMTP id jg8ls169535lac.5.gmail; Fri, 06 Jun
 2014 13:15:53 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr2032568lbq.8.1402085753155;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id eh2si1419776wib.2.2014.06.06.13.15.53
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id C45DD1C00AF; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402085744-15829-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250963>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:57:02 +0100

Improve the dirent implementation by removing the relics that were once
necessary to plug into the now unused MinGW runtime, in preparation for
Unicode file name support.

Move FindFirstFile to opendir, and FindClose to closedir, with the
following implications:
- DIR.dd_name is no longer needed
- chdir(one); opendir(relative); chdir(two); readdir() works as expected
  (i.e. lists one/relative instead of two/relative)
- DIR.dd_handle is a valid handle for the entire lifetime of the DIR struct
- thus, all checks for dd_handle == INVALID_HANDLE_VALUE and dd_handle == 0
  have been removed
- the special case that the directory has been fully read (which was
  previously explicitly tracked with dd_handle == INVALID_HANDLE_VALUE &&
  dd_stat != 0) is now handled implicitly by the FindNextFile error
  handling code (if a client continues to call readdir after receiving
  NULL, FindNextFile will continue to fail with ERROR_NO_MORE_FILES, to
  the same effect)
- extracting dirent data from WIN32_FIND_DATA is needed in two places, so
  moved to its own method
- GetFileAttributes is no longer needed. The same information can be
  obtained from the FindFirstFile error code, which is ERROR_DIRECTORY if
  the name is NOT a directory (-> ENOTDIR), otherwise we can use
  err_win_to_posix (e.g. ERROR_PATH_NOT_FOUND -> ENOENT). The
  ERROR_DIRECTORY case could be fixed in err_win_to_posix, but this
  probably breaks other functionality.

Removes the ERROR_NO_MORE_FILES check after FindFirstFile (this was
fortunately a NOOP (searching for '*' always finds '.' and '..'),
otherwise the subsequent code would have copied data from an uninitialized
buffer).

Changes malloc to git support function xmalloc, so opendir will die() if
out of memory, rather than failing with ENOMEM and letting git work on
incomplete directory listings (error handling in dir.c is quite sparse).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.c | 113 ++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 59 deletions(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index fac7f25..82a515c 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -4,92 +4,88 @@ struct DIR {
 	struct dirent dd_dir; /* includes d_type */
 	HANDLE dd_handle;     /* FindFirstFile handle */
 	int dd_stat;          /* 0-based index */
-	char dd_name[1];      /* extend struct */
 };
 
+static inline void finddata2dirent(struct dirent *ent, WIN32_FIND_DATAA *fdata)
+{
+	/* copy file name from WIN32_FIND_DATA to dirent */
+	memcpy(ent->d_name, fdata->cFileName, sizeof(ent->d_name));
+
+	/* Set file type, based on WIN32_FIND_DATA */
+	if (fdata->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+		ent->d_type = DT_DIR;
+	else
+		ent->d_type = DT_REG;
+}
+
 DIR *opendir(const char *name)
 {
-	DWORD attrs = GetFileAttributesA(name);
+	char pattern[MAX_PATH];
+	WIN32_FIND_DATAA fdata;
+	HANDLE h;
 	int len;
-	DIR *p;
+	DIR *dir;
 
-	/* check for valid path */
-	if (attrs == INVALID_FILE_ATTRIBUTES) {
-		errno = ENOENT;
+	/* check that name is not NULL */
+	if (!name) {
+		errno = EINVAL;
 		return NULL;
 	}
-
-	/* check if it's a directory */
-	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
-		errno = ENOTDIR;
-		return NULL;
-	}
-
 	/* check that the pattern won't be too long for FindFirstFileA */
 	len = strlen(name);
-	if (is_dir_sep(name[len - 1]))
-		len--;
 	if (len + 2 >= MAX_PATH) {
 		errno = ENAMETOOLONG;
 		return NULL;
 	}
-
-	p = malloc(sizeof(DIR) + len + 2);
-	if (!p)
+	/* copy name to temp buffer */
+	memcpy(pattern, name, len + 1);
+
+	/* append optional '/' and wildcard '*' */
+	if (len && !is_dir_sep(pattern[len - 1]))
+		pattern[len++] = '/';
+	pattern[len++] = '*';
+	pattern[len] = 0;
+
+	/* open find handle */
+	h = FindFirstFileA(pattern, &fdata);
+	if (h == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : err_win_to_posix(err);
 		return NULL;
+	}
 
-	memset(p, 0, sizeof(DIR) + len + 2);
-	strcpy(p->dd_name, name);
-	p->dd_name[len] = '/';
-	p->dd_name[len+1] = '*';
-
-	p->dd_handle = INVALID_HANDLE_VALUE;
-	return p;
+	/* initialize DIR structure and copy first dir entry */
+	dir = xmalloc(sizeof(DIR));
+	dir->dd_handle = h;
+	dir->dd_stat = 0;
+	finddata2dirent(&dir->dd_dir, &fdata);
+	return dir;
 }
 
 struct dirent *readdir(DIR *dir)
 {
-	WIN32_FIND_DATAA buf;
-	HANDLE handle;
-
-	if (!dir || !dir->dd_handle) {
+	if (!dir) {
 		errno = EBADF; /* No set_errno for mingw */
 		return NULL;
 	}
 
-	if (dir->dd_handle == INVALID_HANDLE_VALUE && dir->dd_stat == 0) {
-		DWORD lasterr;
-		handle = FindFirstFileA(dir->dd_name, &buf);
-		lasterr = GetLastError();
-		dir->dd_handle = handle;
-		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
-			errno = err_win_to_posix(lasterr);
+	/* if first entry, dirent has already been set up by opendir */
+	if (dir->dd_stat) {
+		/* get next entry and convert from WIN32_FIND_DATA to dirent */
+		WIN32_FIND_DATAA fdata;
+		if (FindNextFileA(dir->dd_handle, &fdata)) {
+			finddata2dirent(&dir->dd_dir, &fdata);
+		} else {
+			DWORD lasterr = GetLastError();
+			/* POSIX says you shouldn't set errno when readdir can't
+			   find any more files; so, if another error we leave it set. */
+			if (lasterr != ERROR_NO_MORE_FILES)
+				errno = err_win_to_posix(lasterr);
 			return NULL;
 		}
-	} else if (dir->dd_handle == INVALID_HANDLE_VALUE) {
-		return NULL;
-	} else if (!FindNextFileA(dir->dd_handle, &buf)) {
-		DWORD lasterr = GetLastError();
-		FindClose(dir->dd_handle);
-		dir->dd_handle = INVALID_HANDLE_VALUE;
-		/* POSIX says you shouldn't set errno when readdir can't
-		   find any more files; so, if another error we leave it set. */
-		if (lasterr != ERROR_NO_MORE_FILES)
-			errno = err_win_to_posix(lasterr);
-		return NULL;
 	}
 
-	/* We get here if `buf' contains valid data.  */
-	strcpy(dir->dd_dir.d_name, buf.cFileName);
 	++dir->dd_stat;
-
-	/* Set file type, based on WIN32_FIND_DATA */
-	dir->dd_dir.d_type = 0;
-	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-		dir->dd_dir.d_type |= DT_DIR;
-	else
-		dir->dd_dir.d_type |= DT_REG;
-
 	return &dir->dd_dir;
 }
 
@@ -100,8 +96,7 @@ int closedir(DIR *dir)
 		return -1;
 	}
 
-	if (dir->dd_handle != INVALID_HANDLE_VALUE)
-		FindClose(dir->dd_handle);
+	FindClose(dir->dd_handle);
 	free(dir);
 	return 0;
 }
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
