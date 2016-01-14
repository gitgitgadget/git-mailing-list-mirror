From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/5] compat/mingw: support MSys2-based MinGW build
Date: Thu, 14 Jan 2016 17:51:59 +0100 (CET)
Message-ID: <ed8e411fc0447058bba75a4bdce1b8519813e10b.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:52:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl89-000595-6y
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbcANQwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:52:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:58404 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbcANQwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:52:07 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LtrKX-1a9Q2E3WQn-011EJO; Thu, 14 Jan 2016 17:51:59
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YUkD3eR4J2UcvR8AMxW+qNBPw4KjA4WqBtAC6I4PGu+xURgLbnx
 DarfO3Ai8MvCrZQLKYQ918WKRqKwdUoayfDWuEZiV7GKSlde5SyGeP5t5uuhd7LAIrNdlzT
 62HSN2R71si5UsYgHP8KIM5EU/I6QsuFM4boRiv+zZeAIGjTS+OlMPZUP9Xb2KXqGrTinkL
 NzcyG8wXRr5DbjTNHFYnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ctv+asbXQOc=:ZmsYiBQVgOT67yzQkMxo0c
 B0KTBTO9rQMFFCJyaqfHJ9oJ5JO9pMNya5d6ShOWDc3mGmnxA9HL+ep0Yu8hbl9rx9sTgLCm1
 C3YoVZCAQKAeZnwUJzVIZcX+xXge1DIRhl7uZV77HxJAgrv1vcdNa5A94ytLSdtAJ5n5dAo12
 yQJFzOpL1JXqatNJa/y3bfET5Vv1+onVn36jQeNNZo6nEl0c/LBS1v3rfxXtic+DDoWgT50lq
 yTfv9eF5Ygt+8XZSeq6+xV2ZNsUJogEuFY/GWSSRcND7gHxjqhQSZeRpxV+XR/84p9puHd2oK
 MZskn+6nCdTdzky7FCyzMUCSgnGfH+h7njadF1oQCP4EApjEyjaqJ76PI2w/BIiKDgxtaFlGb
 voZS9h80Nc22DwTNsIc30ixD9QmrfvcEBHpwWZRyODcqh2kXuxp2CIGFNAo4XaeoExZaUc8J3
 ATiNbBtM6qzPncOgnM6LSuug/gYvOajXqYaUs1h0pW6qF+jnJWzjdHMEg9AGIzBpZA/iIAy0F
 4CyZcBDu2XIeFxY9Xrps24M0Hk8P3VrxuBYGhhB/er8egDW0ZNHBKCNo14oaxax0HKW8G5+So
 OhAJRgyR4jOiUBNgG9B5zBSknAhAYC/zdC6BTqpOHQMX7WBi30M/x3zor/H+D+We4NRbZcvra
 7GA/QctvFjmiVIxr96ePJcu4nvi6WJBhrXIHEuZtsZZFyj0Dwbd9jySpVqfSLIuoAzhOrcXx+
 +DExpGe7MbDoCyk2W7ijktJNPDJvYpJDZbNb2M9Cdjmcdq6YC4O4hzz72aXrO3bidYtQkRcm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284061>

The excellent MSys2 project brings a substantially updated MinGW
environment including newer GCC versions and new headers. To support
compiling Git, let's special-case the new MinGW (tell-tale: the
_MINGW64_VERSION_MAJOR constant is defined).

Note: this commit only addresses compile failures, not compile warnings
(that task is left for a future patch).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index b3e5044..a2da783 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,14 +1,26 @@
+#ifdef __MINGW64_VERSION_MAJOR
+#include <stdint.h>
+#include <wchar.h>
+typedef _sigset_t sigset_t;
+#endif
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
+/* MinGW-w64 reports to have flockfile, but it does not actually have it. */
+#ifdef __MINGW64_VERSION_MAJOR
+#undef _POSIX_THREAD_SAFE_FUNCTIONS
+#endif
+
 /*
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
+#ifndef __MINGW64_VERSION_MAJOR
+typedef int pid_t;
 #define hstrerror strerror
+#endif
 
 #define S_IFLNK    0120000 /* Symbolic link */
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
@@ -100,8 +112,10 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
+#ifndef __MINGW64_VERSION_MAJOR
 static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
+#endif
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
@@ -176,8 +190,10 @@ int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
+#ifndef __MINGW64_VERSION_MAJOR
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
+#endif
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
 struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
@@ -301,8 +317,10 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 /*
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
+#ifndef __MINGW64_VERSION_MAJOR
 #define off_t off64_t
 #define lseek _lseeki64
+#endif
 
 /* use struct stat with 64 bit st_size */
 #ifdef stat
@@ -383,8 +401,12 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
+#ifndef __MINGW64_VERSION_MAJOR
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
+#else
+#include <inttypes.h>
+#endif
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
-- 
2.7.0.windows.1.7.g55a05c8
