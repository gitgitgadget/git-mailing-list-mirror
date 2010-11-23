From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 4/6] win32: dirent: handle errors
Date: Tue, 23 Nov 2010 19:38:27 +0100
Message-ID: <1290537509-360-5-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com Tue Nov 23 19:39:47 2010
Return-path: <msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com>)
	id 1PKxmM-0007Yx-FL
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:46 +0100
Received: by mail-ww0-f58.google.com with SMTP id 40sf3016877wwj.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Qyun2GUMb9vUUTLZk1Ag+XfPEpbss1s8ItBhmtmFpBQ=;
        b=WSsGo+pCj7w+PVoBzxScgSH484FHcy6zkG2OcXLl0T0HbeKdWVjJaRazUy+yGg79L4
         zG4ZJiuafaYIxZ/aJz1zN+tdo3a0ocWI41UULwA/CawJyDpPvsZgeJo0ApH0539v4y3i
         lgTQPTu5jt/qNBBcMxRMpb00x94nWukCT2G9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=kogMXonC3OmgCk8Z2hgDqIjkrq1EOAVleehUqIobQ3F3boBoO918KK1ZoCy3JPSAO4
         9KW4HvDFq+917fp8X6HkU6lq7L9kBpHTi+qxSZcdy1c2DVbkn6tuBuh1vOvKXou4zUnF
         PxtznU4clWetjVbB6fkKbBwRSWgtkb86WSLC8=
Received: by 10.216.12.7 with SMTP id 7mr267912wey.26.1290537556848;
        Tue, 23 Nov 2010 10:39:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.123.10 with SMTP id u10ls1430009eeh.2.p; Tue, 23 Nov 2010
 10:39:15 -0800 (PST)
Received: by 10.14.120.200 with SMTP id p48mr1043601eeh.13.1290537555058;
        Tue, 23 Nov 2010 10:39:15 -0800 (PST)
Received: by 10.14.120.200 with SMTP id p48mr1043600eeh.13.1290537555027;
        Tue, 23 Nov 2010 10:39:15 -0800 (PST)
Received: from mail-ey0-f178.google.com (mail-ey0-f178.google.com [209.85.215.178])
        by gmr-mx.google.com with ESMTP id r17si2079863eeh.7.2010.11.23.10.39.13;
        Tue, 23 Nov 2010 10:39:14 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.178 as permitted sender) client-ip=209.85.215.178;
Received: by eyh5 with SMTP id 5so4909278eyh.23
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:13 -0800 (PST)
Received: by 10.213.26.13 with SMTP id b13mr3699318ebc.90.1290537553793;
        Tue, 23 Nov 2010 10:39:13 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm6070767eeh.5.2010.11.23.10.39.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:13 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.178 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162008>

Previously all error conditions were ignored. Be nice, and set errno
when we should.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    2 +-
 compat/msvc.c  |   28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fdbf093..d8fd5d8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1584,7 +1584,7 @@ struct dirent *mingw_readdir(DIR *dir)
 	HANDLE handle;
 	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
 
-	if (!dir->dd_handle) {
+	if (!dir || !dir->dd_handle) {
 		errno = EBADF; /* No set_errno for mingw */
 		return NULL;
 	}
diff --git a/compat/msvc.c b/compat/msvc.c
index 88c6093..199eb22 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -5,8 +5,29 @@
 
 DIR *opendir(const char *name)
 {
-	int len = strlen(name);
+	DWORD attrs = GetFileAttributes(name);
+	int len;
 	DIR *p;
+
+	/* check for valid path */
+	if (attrs == INVALID_FILE_ATTRIBUTES) {
+		errno = ENOENT;
+		return NULL;
+	}
+
+	/* check if it's a directory */
+	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+		errno = ENOTDIR;
+		return NULL;
+	}
+
+	/* check that the pattern won't be too long for FindFirstFileA */
+	len = strlen(name);
+	if (len + 2 >= MAX_PATH) {
+		errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	p = malloc(sizeof(DIR) + len + 2);
 	if (!p)
 		return NULL;
@@ -21,6 +42,11 @@ DIR *opendir(const char *name)
 }
 int closedir(DIR *dir)
 {
+	if (!dir) {
+		errno = EBADF;
+		return -1;
+	}
+
 	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
 		FindClose((HANDLE)dir->dd_handle);
 	free(dir);
-- 
1.7.3.2.493.gc8738
