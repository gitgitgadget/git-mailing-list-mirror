From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 6/7] MSVC: Windows-native implementation for 
	subset of Pthreads API
Date: Fri, 15 Jan 2010 21:12:20 +0100
Message-ID: <95ed251aecf3fb0a1095baf04582d3271e3550ba.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: 3hMxQSwMIB-wXuhYRPU.cfUagmgUWhUccUZSUfcidg.Qca@listserv.bounces.google.com Fri Jan 15 21:14:15 2010
Return-path: <3hMxQSwMIB-wXuhYRPU.cfUagmgUWhUccUZSUfcidg.Qca@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYe-0004w7-Tg
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 21:14:13 +0100
Received: by mail-yx0-f137.google.com with SMTP id 1sf1875742yxe.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 12:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe;
        bh=tQJGXjc3gc6EsZ4xfR15kVHXP7dAyvLuzKLjbdHRFxc=;
        b=t8+RCsnE7XREgmPEGU9+QClA8Yhzk0ovL0gxbbOuq+vqDSmEVLNFzKoDbd9p7tUcFg
         LZFzezkqyLvCyx61FzH8dP40tmoaOnJAXtB+laowqI1iMWYTUzi6Sr6PgG5Vi8i62A0A
         /PomFaCup7gJAkm3oNyV6fIssa10YVWNTpDZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=5h+VUuyMD3Lh0F7gSeifyb6u5PmQyLMrMJNCV87AzLaAHvgPb4Z5e7cTP7KQWABwH9
         YMLGdvGZrq9aO96yEmnAgUDVe3MmiKBWMv4hJiRvU/eITKix/BIGUkb2NG1wabk1UlGU
         iIzT9jvyXykKttnkhxHrWUO9XL4DQwRsEpz3c=
Received: by 10.100.83.4 with SMTP id g4mr68011anb.10.1263586436187;
        Fri, 15 Jan 2010 12:13:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.13.214 with SMTP id d22ls767273bka.0.p; Fri, 15 Jan 2010 
	12:13:54 -0800 (PST)
Received: by 10.204.24.78 with SMTP id u14mr94161bkb.2.1263586433963;
        Fri, 15 Jan 2010 12:13:53 -0800 (PST)
Received: by 10.204.24.78 with SMTP id u14mr94160bkb.2.1263586433933;
        Fri, 15 Jan 2010 12:13:53 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 18si138058bwz.5.2010.01.15.12.13.53;
        Fri, 15 Jan 2010 12:13:53 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4129F2C400A;
	Fri, 15 Jan 2010 21:13:53 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A009119F60D;
	Fri, 15 Jan 2010 21:12:56 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/89026b66486ea92e
X-Message-Url: http://groups.google.com/group/msysgit/msg/e7aced590181300d
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137114>

From: Andrzej K. Haczewski <ahaczewski@gmail.com>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for MSVC, msysgit and
Cygwin.

[J6t: If the MinGW build was built as part of the msysgit build
environment, then threading was already enabled because the
pthreads-win32 package is available in msysgit. With this patch, we can now
enable threaded code unconditionally.]

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This version uses Interlocked{Inc,Dec}rement and volatile waiters count.
 The change to the MinGW section is mine and was a separate patch.

 Makefile               |   13 +++---
 builtin-pack-objects.c |   31 ++++++++++++--
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/pthread.h |   67 +++++++++++++++++++++++++++++
 6 files changed, 217 insertions(+), 11 deletions(-)
 create mode 100644 compat/win32/pthread.c
 create mode 100644 compat/win32/pthread.h

diff --git a/Makefile b/Makefile
index 6933555..7f5814c 100644
--- a/Makefile
+++ b/Makefile
@@ -478,6 +478,7 @@ LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/win32/pthread.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -996,15 +997,15 @@ ifeq ($(uname_S),Windows)
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
-	NO_PTHREADS = YesPlease
 	BLK_SHA1 = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
@@ -1048,9 +1049,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
+		compat/win32/pthread.o
 	EXTLIBS += -lws2_32
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
@@ -1060,10 +1063,8 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS += /mingw/lib/libz.a
 	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 else
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
 endif
 endif
 
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4429d53..2fdabaa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1256,15 +1256,15 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 
 #ifdef THREADED_DELTA_SEARCH
 
-static pthread_mutex_t read_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
 #define read_unlock()		pthread_mutex_unlock(&read_mutex)
 
-static pthread_mutex_t cache_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
 #define cache_unlock()		pthread_mutex_unlock(&cache_mutex)
 
-static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t progress_mutex;
 #define progress_lock()		pthread_mutex_lock(&progress_mutex)
 #define progress_unlock()	pthread_mutex_unlock(&progress_mutex)
 
@@ -1591,7 +1591,26 @@ struct thread_params {
 	unsigned *processed;
 };
 
-static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t progress_cond;
+
+/*
+ * Mutex and conditional variable can't be statically-initialized on Windows.
+ */
+static void init_threaded_search()
+{
+	pthread_mutex_init(&read_mutex, NULL);
+	pthread_mutex_init(&cache_mutex, NULL);
+	pthread_mutex_init(&progress_mutex, NULL);
+	pthread_cond_init(&progress_cond, NULL);
+}
+
+static void cleanup_threaded_search()
+{
+	pthread_cond_destroy(&progress_cond);
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&cache_mutex);
+	pthread_mutex_destroy(&progress_mutex);
+}
 
 static void *threaded_find_deltas(void *arg)
 {
@@ -1630,10 +1649,13 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	struct thread_params *p;
 	int i, ret, active_threads = 0;
 
+	init_threaded_search();
+
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
 	if (delta_search_threads <= 1) {
 		find_deltas(list, &list_size, window, depth, processed);
+		cleanup_threaded_search();
 		return;
 	}
 	if (progress > pack_to_stdout)
@@ -1748,6 +1770,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			active_threads--;
 		}
 	}
+	cleanup_threaded_search();
 	free(p);
 }
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 7376247..74ffc18 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,7 +3,7 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-static int err_win_to_posix(DWORD winerr)
+int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
 	switch(winerr) {
diff --git a/compat/mingw.h b/compat/mingw.h
index afe12ea..e254fb4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -310,3 +310,8 @@ struct mingw_dirent
 #define readdir(x) mingw_readdir(x)
 struct dirent *mingw_readdir(DIR *dir);
 #endif // !NO_MINGW_REPLACE_READDIR
+
+/*
+ * Used by Pthread API implementation for Windows
+ */
+extern int err_win_to_posix(DWORD winerr);
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
new file mode 100644
index 0000000..631c0a4
--- /dev/null
+++ b/compat/win32/pthread.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ *
+ * DISCLAMER: The implementation is Git-specific, it is subset of original
+ * Pthreads API, without lots of other features that Git doesn't use.
+ * Git also makes sure that the passed arguments are valid, so there's
+ * no need for double-checking.
+ */
+
+#include "../../git-compat-util.h"
+#include "pthread.h"
+
+#include <errno.h>
+#include <limits.h>
+
+static unsigned __stdcall win32_start_routine(void *arg)
+{
+	pthread_t *thread = arg;
+	thread->arg = thread->start_routine(thread->arg);
+	return 0;
+}
+
+int pthread_create(pthread_t *thread, const void *unused,
+		   void *(*start_routine)(void*), void *arg)
+{
+	thread->arg = arg;
+	thread->start_routine = start_routine;
+	thread->handle = (HANDLE)
+		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
+
+	if (!thread->handle)
+		return errno;
+	else
+		return 0;
+}
+
+int win32_pthread_join(pthread_t *thread, void **value_ptr)
+{
+	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
+	switch (result) {
+		case WAIT_OBJECT_0:
+			if (value_ptr)
+				*value_ptr = thread->arg;
+			return 0;
+		case WAIT_ABANDONED:
+			return EINVAL;
+		default:
+			return err_win_to_posix(GetLastError());
+	}
+}
+
+int pthread_cond_init(pthread_cond_t *cond, const void *unused)
+{
+	cond->waiters = 0;
+
+	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
+	if (!cond->sema)
+		die("CreateSemaphore() failed");
+	return 0;
+}
+
+int pthread_cond_destroy(pthread_cond_t *cond)
+{
+	CloseHandle(cond->sema);
+	cond->sema = NULL;
+
+	return 0;
+}
+
+int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
+{
+	InterlockedIncrement(&cond->waiters);
+
+	/*
+	 * Unlock external mutex and wait for signal.
+	 * NOTE: we've held mutex locked long enough to increment
+	 * waiters count above, so there's no problem with
+	 * leaving mutex unlocked before we wait on semaphore.
+	 */
+	LeaveCriticalSection(mutex);
+
+	/* let's wait - ignore return value */
+	WaitForSingleObject(cond->sema, INFINITE);
+
+	/* we're done waiting, so make sure we decrease waiters count */
+	InterlockedDecrement(&cond->waiters);
+
+	/* lock external mutex again */
+	EnterCriticalSection(mutex);
+
+	return 0;
+}
+
+int pthread_cond_signal(pthread_cond_t *cond)
+{
+	/*
+	 * Access to waiters count is atomic; see "Interlocked Variable Access"
+	 * http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
+	 */
+	int have_waiters = cond->waiters > 0;
+
+	/*
+	 * Signal only when there are waiters
+	 */
+	if (have_waiters)
+		return ReleaseSemaphore(cond->sema, 1, NULL) ?
+			0 : err_win_to_posix(GetLastError());
+	else
+		return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
new file mode 100644
index 0000000..b8e1bcb
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,67 @@
+/*
+ * Header used to adapt pthread-based POSIX code to Windows API threads.
+ *
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ */
+
+#ifndef PTHREAD_H
+#define PTHREAD_H
+
+#ifndef WIN32_LEAN_AND_MEAN
+#define WIN32_LEAN_AND_MEAN
+#endif
+
+#include <windows.h>
+
+/*
+ * Defines that adapt Windows API threads to pthreads API
+ */
+#define pthread_mutex_t CRITICAL_SECTION
+
+#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
+#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_unlock LeaveCriticalSection
+
+/*
+ * Implement simple condition variable for Windows threads, based on ACE
+ * implementation.
+ *
+ * See original implementation: http://bit.ly/1vkDjo
+ * ACE homepage: http://www.cse.wustl.edu/~schmidt/ACE.html
+ * See also: http://www.cse.wustl.edu/~schmidt/win32-cv-1.html
+ */
+typedef struct {
+	volatile LONG waiters;
+	HANDLE sema;
+} pthread_cond_t;
+
+extern int pthread_cond_init(pthread_cond_t *cond, const void *unused);
+
+extern int pthread_cond_destroy(pthread_cond_t *cond);
+
+extern int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex);
+
+extern int pthread_cond_signal(pthread_cond_t *cond);
+
+/*
+ * Simple thread creation implementation using pthread API
+ */
+typedef struct {
+	HANDLE handle;
+	void *(*start_routine)(void*);
+	void *arg;
+} pthread_t;
+
+extern int pthread_create(pthread_t *thread, const void *unused,
+			  void *(*start_routine)(void*), void *arg);
+
+/*
+ * To avoid the need of copying a struct, we use small macro wrapper to pass
+ * pointer to win32_pthread_join instead.
+ */
+#define pthread_join(a, b) win32_pthread_join(&(a), (b))
+
+extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
+
+#endif /* PTHREAD_H */
-- 
1.6.6.218.g3e6eb
