From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 08/12] Add MSVC porting files.
Date: Wed, 19 Aug 2009 23:52:43 +0800
Message-ID: <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV7-0002JE-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZHSPyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZHSPyf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:54:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:42860 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZHSPye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:54:34 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1311212rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+tymKmwekUyNbQJrIZbmhXWy+UAOBBzie4ftGiOc3jA=;
        b=OH6n3bxbpf8LJiJhOzgFe9QCDOS602P+Gsa3vaHg5wHTnpKqJdakFq2pJ4inWuIGIP
         LTHXQhbrF92ORw5fmeNcP7TsbMw0IhCFZvaH5VdRo/2tSi+zVjra/XngrpSJHWvYXZZd
         GKJmI2J8JKlQR9cQgedI08QGiS1TWXWbXiDcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wZuIY89mSiOu1Wy0RwJygdQnsA9KyHW6+BvkkEWAwRrBc91u+/3tWgXzF+Oh2eFTgr
         6IdxOR50y/CwK2ggD5+1Ke2Mfj3mMGxQl9fVhYtTOAJ1MtpkR5XZ0i4diyFMIfiAqnY3
         83mDTgYdaZMWnCuxQlFr+0NJEVX4tvrbq1Tyo=
Received: by 10.140.203.18 with SMTP id a18mr3623481rvg.217.1250697276146;
        Wed, 19 Aug 2009 08:54:36 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id f42sm47993rvb.32.2009.08.19.08.54.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:54:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126557>

Add msvc.c and msvc.h to build git under MSVC

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/msvc.c |   33 ++++++++++++++++++++++
 compat/msvc.h |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h

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
index 0000000..76cc6e5
--- /dev/null
+++ b/compat/msvc.h
@@ -0,0 +1,86 @@
+#ifndef __MSVC__HEAD
+#define __MSVC__HEAD
+
+/*Define minimize windows version*/
+#define WINVER 0x0500
+#define _WIN32_WINNT 0x0500
+#define _WIN32_WINDOWS 0x0410
+#define _WIN32_IE 0x0700
+#define NTDDI_VERSION NTDDI_WIN2KSP1
+#include <winsock2.h>
+
+/*Configuration*/
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
+#define NO_ST_BLOCKS_IN_STRUCT_STAT
+#define NO_NSEC
+#define NO_REGEX
+#define NO_SYS_SELECT_H
+#define NO_PTHEADS
+#define NO_ICONV
+#define NO_PTHREADS
+#define NO_CURL
+#define NO_STRTOUMAX
+#define NO_STRLCPY
+#define NO_UNSETENV
+#define NO_SETENV
+
+#define USE_WIN32_MMAP
+#define USE_NED_ALLOCATOR
+#define HAVE_STRING_H 1
+#define STDC_HEADERS
+#define SNPRINTF_RETURNS_BOGUS
+#define RUNTIME_PREFIX
+#define REGEX_MALLOC
+
+/*Git runtime infomation*/
+#define ETC_GITCONFIG "%HOME%"
+#define SHA1_HEADER "mozilla-sha1\\sha1.h"
+#define GIT_EXEC_PATH "bin"
+#define GIT_VERSION "1.6"
+#define BINDIR "bin"
+#define PREFIX "."
+#define GIT_MAN_PATH "man"
+#define GIT_INFO_PATH "info"
+#define GIT_HTML_PATH "html"
+#define DEFAULT_GIT_TEMPLATE_DIR "templates"
+
+/*porting function*/
+#define strdup _strdup
+#define read _read
+#define close _close
+#define dup _dup
+#define dup2 _dup2
+#define strncasecmp _strnicmp
+#define strtoull _strtoui64
+#define inline __inline
+#define __inline__ __inline
+#define __attribute__(x)
+#define va_copy(dst, src)     ((dst) = (src))
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
+#define stat(x,y) mingw_lstat(x,y)
+#define stat      _stat64
+#endif
\ No newline at end of file
-- 
1.6.4.msysgit.0
