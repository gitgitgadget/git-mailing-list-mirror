Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0D1E49B
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817619; cv=none; b=HxxxLaY9F9LAHmYXWzKywJYeh95hnF8Kkjl/GWCKvZdSv/eAVhTgY5KvtRPr3zLBW9MHnEIOqQQt1GtEcfez64QFoaf3KeoLHe1HNkkkWKG3s+Ld1UMrijulYYIlaSLhzEEnkAxUmMvhf6ImYl72SSbmLoqheAr8e+MsLhWCSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817619; c=relaxed/simple;
	bh=h0zle88VVKCYdJ/ACgykx9YpiTI08BPDf07XhVSrtyo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeafAx4qhUBGMDSNDmUqt/yaDUlpJjRCSvlZo+vYkLs+ij54WZ1dQEBLGxuiHrVedGNkvKfhlUOaceQrfOvyoH1gsZZlGmc1cc4xES8qbV8aOSXlvJcYBuPqtGEtID9R84xZmNDr1fDo5IbBmScBZURlfoOQYU+kRCqcCSgozwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20547 invoked by uid 109); 28 Aug 2024 04:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 04:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23103 invoked by uid 111); 28 Aug 2024 04:00:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 00:00:20 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 00:00:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 5/6] compat: mark unused parameters in win32/mingw functions
Message-ID: <20240828040016.GE3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

The compat/ directory contains many stub functions, wrappers, and so on
that have to conform to a specific interface, but don't necessarily need
to use all of their parameters. Let's mark them to avoid complaints from
-Wunused-parameter.

This was done mostly via guess-and-check with the Windows build in
GitHub CI. I also confirmed that the win+VS build is similarly happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/mingw.c         | 15 ++++++++-------
 compat/mingw.h         | 18 +++++++++---------
 compat/stub/procinfo.c |  2 +-
 compat/win32/pthread.c |  2 +-
 compat/win32/pthread.h |  4 ++--
 compat/win32/syslog.c  |  2 +-
 compat/win32mmap.c     |  2 +-
 compat/winansi.c       |  2 +-
 8 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 29d3f09768..eb13c02a76 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -243,7 +243,8 @@ static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 static char *unset_environment_variables;
 
 int mingw_core_config(const char *var, const char *value,
-		      const struct config_context *ctx, void *cb)
+		      const struct config_context *ctx UNUSED,
+		      void *cb UNUSED)
 {
 	if (!strcmp(var, "core.hidedotfiles")) {
 		if (value && !strcasecmp(value, "dotgitonly"))
@@ -453,7 +454,7 @@ static int set_hidden_flag(const wchar_t *path, int set)
 	return -1;
 }
 
-int mingw_mkdir(const char *path, int mode)
+int mingw_mkdir(const char *path, int mode UNUSED)
 {
 	int ret;
 	wchar_t wpath[MAX_PATH];
@@ -597,7 +598,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
-static BOOL WINAPI ctrl_ignore(DWORD type)
+static BOOL WINAPI ctrl_ignore(DWORD type UNUSED)
 {
 	return TRUE;
 }
@@ -1085,7 +1086,7 @@ int mkstemp(char *template)
 	return git_mkstemp_mode(template, 0600);
 }
 
-int gettimeofday(struct timeval *tv, void *tz)
+int gettimeofday(struct timeval *tv, void *tz UNUSED)
 {
 	FILETIME ft;
 	long long hnsec;
@@ -2252,7 +2253,7 @@ char *mingw_query_user_email(void)
 	return get_extended_user_info(NameUserPrincipal);
 }
 
-struct passwd *getpwuid(int uid)
+struct passwd *getpwuid(int uid UNUSED)
 {
 	static unsigned initialized;
 	static char user_name[100];
@@ -2304,7 +2305,7 @@ static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static unsigned __stdcall ticktack(void *dummy)
+static unsigned __stdcall ticktack(void *dummy UNUSED)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		mingw_raise(SIGALRM);
@@ -2352,7 +2353,7 @@ static inline int is_timeval_eq(const struct timeval *i1, const struct timeval *
 	return i1->tv_sec == i2->tv_sec && i1->tv_usec == i2->tv_usec;
 }
 
-int setitimer(int type, struct itimerval *in, struct itimerval *out)
+int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 {
 	static const struct timeval zero;
 	static int atexit_done;
diff --git a/compat/mingw.h b/compat/mingw.h
index 27b61284f4..ebfb8ba423 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -122,27 +122,27 @@ struct utsname {
  * trivial stubs
  */
 
-static inline int readlink(const char *path, char *buf, size_t bufsiz)
+static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
 { errno = ENOSYS; return -1; }
-static inline int symlink(const char *oldpath, const char *newpath)
+static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
 { errno = ENOSYS; return -1; }
-static inline int fchmod(int fildes, mode_t mode)
+static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
 { errno = ENOSYS; return -1; }
 #ifndef __MINGW64_VERSION_MAJOR
 static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
 #endif
-static inline unsigned int alarm(unsigned int seconds)
+static inline unsigned int alarm(unsigned int seconds UNUSED)
 { return 0; }
 static inline int fsync(int fd)
 { return _commit(fd); }
 static inline void sync(void)
 {}
 static inline uid_t getuid(void)
 { return 1; }
-static inline struct passwd *getpwnam(const char *name)
+static inline struct passwd *getpwnam(const char *name UNUSED)
 { return NULL; }
-static inline int fcntl(int fd, int cmd, ...)
+static inline int fcntl(int fd UNUSED, int cmd, ...)
 {
 	if (cmd == F_GETFD || cmd == F_SETFD)
 		return 0;
@@ -151,17 +151,17 @@ static inline int fcntl(int fd, int cmd, ...)
 }
 
 #define sigemptyset(x) (void)0
-static inline int sigaddset(sigset_t *set, int signum)
+static inline int sigaddset(sigset_t *set UNUSED, int signum UNUSED)
 { return 0; }
 #define SIG_BLOCK 0
 #define SIG_UNBLOCK 0
-static inline int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
+static inline int sigprocmask(int how UNUSED, const sigset_t *set UNUSED, sigset_t *oldset UNUSED)
 { return 0; }
 static inline pid_t getppid(void)
 { return 1; }
 static inline pid_t getpgid(pid_t pid)
 { return pid == 0 ? getpid() : pid; }
-static inline pid_t tcgetpgrp(int fd)
+static inline pid_t tcgetpgrp(int fd UNUSED)
 { return getpid(); }
 
 /*
diff --git a/compat/stub/procinfo.c b/compat/stub/procinfo.c
index 12c0a23c9e..3168cd5714 100644
--- a/compat/stub/procinfo.c
+++ b/compat/stub/procinfo.c
@@ -6,6 +6,6 @@
  * Stub. See sample implementations in compat/linux/procinfo.c and
  * compat/win32/trace2_win32_process_info.c.
  */
-void trace2_collect_process_info(enum trace2_process_info_reason reason)
+void trace2_collect_process_info(enum trace2_process_info_reason reason UNUSED)
 {
 }
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 85f8f7920c..58980a529c 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -21,7 +21,7 @@ static unsigned __stdcall win32_start_routine(void *arg)
 	return 0;
 }
 
-int pthread_create(pthread_t *thread, const void *unused,
+int pthread_create(pthread_t *thread, const void *attr UNUSED,
 		   void *(*start_routine)(void *), void *arg)
 {
 	thread->arg = arg;
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index cc3221cb2c..e2b5c4f64c 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -18,7 +18,7 @@
  */
 #define pthread_mutex_t CRITICAL_SECTION
 
-static inline int return_0(int i) {
+static inline int return_0(int i UNUSED) {
 	return 0;
 }
 #define pthread_mutex_init(a,b) return_0((InitializeCriticalSection((a)), 0))
@@ -70,7 +70,7 @@ static inline void NORETURN pthread_exit(void *ret)
 }
 
 typedef DWORD pthread_key_t;
-static inline int pthread_key_create(pthread_key_t *keyp, void (*destructor)(void *value))
+static inline int pthread_key_create(pthread_key_t *keyp, void (*destructor)(void *value) UNUSED)
 {
 	return (*keyp = TlsAlloc()) == TLS_OUT_OF_INDEXES ? EAGAIN : 0;
 }
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 0af18d8882..4e4794743a 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -2,7 +2,7 @@
 
 static HANDLE ms_eventlog;
 
-void openlog(const char *ident, int logopt, int facility)
+void openlog(const char *ident, int logopt UNUSED, int facility UNUSED)
 {
 	if (ms_eventlog)
 		return;
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 519d51f2b6..a4ab4cb939 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -40,7 +40,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	return MAP_FAILED;
 }
 
-int git_munmap(void *start, size_t length)
+int git_munmap(void *start, size_t length UNUSED)
 {
 	return !UnmapViewOfFile(start);
 }
diff --git a/compat/winansi.c b/compat/winansi.c
index 575813bde8..1b3f916b9f 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -340,7 +340,7 @@ enum {
 	TEXT = 0, ESCAPE = 033, BRACKET = '['
 };
 
-static DWORD WINAPI console_thread(LPVOID unused)
+static DWORD WINAPI console_thread(LPVOID data UNUSED)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
-- 
2.46.0.754.g24c813f009

