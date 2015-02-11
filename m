From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 3/3] Win32: implement nanosecond-precision file times
Date: Thu, 12 Feb 2015 00:53:00 +0100
Message-ID: <54DBEB5C.5070804@gmail.com>
References: <54DBEAA5.6000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBW6W56TAKGQEBQ43EBA@googlegroups.com Thu Feb 12 00:53:01 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBW6W56TAKGQEBQ43EBA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBW6W56TAKGQEBQ43EBA@googlegroups.com>)
	id 1YLh5Y-0008I1-DJ
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 00:53:00 +0100
Received: by mail-wi0-f191.google.com with SMTP id n3sf70506wiv.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Feb 2015 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=c7qkjtkaeWcUQl6ftuYSKLkhIZDWcI5t4I21Cd/+C2A=;
        b=YcikbrY3yRZpuiEMBNajS2AlHpLBvFYKz8Ijh+LKO5nlqcZr3noYEb7rVJg5PR562t
         B5U5+QkxkPtqk3XOXy6Oxmi8EmIp1V2DmMRHDQFI/7kJl3/qqJUTI32KFFanjRbu7wqg
         tKd2ODzLaem4bqcsIPGjYu87XEvNUUwMNXmkj5nU/PN0CMScfojB4KUzcaDxST5B52a0
         BlA09jhq40W2PvOJh+JOH9C89HMgnK2gXHnCgQ5ey1GMXWSxen43lmry2H0mO4YlhiUH
         kdZqkmLG20tvM6pNTUxReaROIco+ySznb7wa+h3YuNCPJZb1k3i2Rxd4lkiVaQHj4RZY
         nxIg==
X-Received: by 10.152.9.202 with SMTP id c10mr22103lab.10.1423698780081;
        Wed, 11 Feb 2015 15:53:00 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.199 with SMTP id u7ls131450lau.63.gmail; Wed, 11 Feb
 2015 15:52:58 -0800 (PST)
X-Received: by 10.112.180.167 with SMTP id dp7mr143158lbc.14.1423698778669;
        Wed, 11 Feb 2015 15:52:58 -0800 (PST)
Received: from mail-wg0-x236.google.com (mail-wg0-x236.google.com. [2a00:1450:400c:c00::236])
        by gmr-mx.google.com with ESMTPS id o9si35994wiw.0.2015.02.11.15.52.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:52:58 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::236 as permitted sender) client-ip=2a00:1450:400c:c00::236;
Received: by mail-wg0-x236.google.com with SMTP id y19so6690819wgg.13
        for <msysgit@googlegroups.com>; Wed, 11 Feb 2015 15:52:58 -0800 (PST)
X-Received: by 10.180.20.226 with SMTP id q2mr880676wie.28.1423698778578;
        Wed, 11 Feb 2015 15:52:58 -0800 (PST)
Received: from [10.1.116.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fw5sm3307924wjb.14.2015.02.11.15.52.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:52:57 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54DBEAA5.6000205@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::236
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263705>

We no longer use any of MSVCRT's stat-functions, so there's no need to
stick to a CRT-compatible 'struct stat' either.

Define and use our own POSIX-2013-compatible 'struct stat' with nanosecond-
precision file times.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.c   | 12 ++++++------
 compat/mingw.h   | 43 +++++++++++++++++++++++++++++++------------
 config.mak.uname |  4 ++--
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6d73a3d..e4d5e3f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -442,9 +442,9 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 		buf->st_size = fdata.nFileSizeLow |
 			(((off_t)fdata.nFileSizeHigh)<<32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
-		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
+		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
+		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
 			WIN32_FIND_DATAW findbuf;
 			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
@@ -550,9 +550,9 @@ int mingw_fstat(int fd, struct stat *buf)
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
 		buf->st_size = fdata.nFileSizeLow |
 			(((off_t)fdata.nFileSizeHigh)<<32);
-		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
+		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
+		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		return 0;
 
 	case FILE_TYPE_CHAR:
diff --git a/compat/mingw.h b/compat/mingw.h
index f2a78b4..8dee9c9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -293,22 +293,48 @@ static inline long long filetime_to_hnsec(const FILETIME *ft)
 	return winTime - 116444736000000000LL;
 }
 
-static inline time_t filetime_to_time_t(const FILETIME *ft)
+struct timespec {
+	time_t tv_sec;
+	long tv_nsec;
+};
+
+static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
 {
-	return (time_t)(filetime_to_hnsec(ft) / 10000000);
+	long long hnsec = filetime_to_hnsec(ft);
+	ts->tv_sec = (time_t)(hnsec / 10000000);
+	ts->tv_nsec = (hnsec % 10000000) * 100;
 }
 
 /*
- * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
+ * Use mingw specific stat()/lstat()/fstat() implementations on Windows,
+ * including our own struct stat with 64 bit st_size and nanosecond-precision
+ * file times.
  */
 #define off_t off64_t
 #define lseek _lseeki64
 
-/* use struct stat with 64 bit st_size */
+struct mingw_stat {
+    _dev_t st_dev;
+    _ino_t st_ino;
+    _mode_t st_mode;
+    short st_nlink;
+    short st_uid;
+    short st_gid;
+    _dev_t st_rdev;
+    off64_t st_size;
+    struct timespec st_atim;
+    struct timespec st_mtim;
+    struct timespec st_ctim;
+};
+
+#define st_atime st_atim.tv_sec
+#define st_mtime st_mtim.tv_sec
+#define st_ctime st_ctim.tv_sec
+
 #ifdef stat
 #undef stat
 #endif
-#define stat _stati64
+#define stat mingw_stat
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_stat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
@@ -321,13 +347,6 @@ int mingw_fstat(int fd, struct stat *buf);
 #endif
 #define lstat mingw_lstat
 
-#ifndef _stati64
-# define _stati64(x,y) mingw_stat(x,y)
-#elif defined (_USE_32BIT_TIME_T)
-# define _stat32i64(x,y) mingw_stat(x,y)
-#else
-# define _stat64(x,y) mingw_stat(x,y)
-#endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
diff --git a/config.mak.uname b/config.mak.uname
index b64b63c..a18a4cc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -346,7 +346,7 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	NO_NSEC = YesPlease
+	USE_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	# USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
@@ -498,7 +498,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	NO_NSEC = YesPlease
+	USE_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
-- 
2.3.0.3.ge7778af


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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
