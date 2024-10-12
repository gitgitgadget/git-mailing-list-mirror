Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688654315F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714187; cv=none; b=Gs/0nIIv1GUHWivI1uaM7QFvdhUp8ScQ7cJQfOXmAA8SG2wOw9QoRE7j5nKGH14Ll0DwjwKC4HM5azU7HI5uB+OhXuusIHTSl+CoRQjUdWO/oKe60zzwUAPooGrxzhpZ3v6KizWzh8OC8G2CNn3NVic/rQzX2W13Q1wCnWpBJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714187; c=relaxed/simple;
	bh=B91HGzTMAgHDjE1gbBUJ2216gW+MtvEOVIgFuABvaBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2ViL36vSm3OC1KRmdUWdH5/MXFUaNKPeFQ9bVn9nmZ8yBaU0/I169KibRtHyHiJwABsunNGy5ezn1Zknx9V6htv2pHdkC54nvcZTc2mXV39HGLrfYFP7AOEpbwEMgov4Y0SXsummCi5+iryKg0WM0GJ8syagAcVUalAiTRonRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=VIe/ykIt; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="VIe/ykIt"
Received: from [195.4.92.124] (helo=sub5.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1szVWf-003Nto-7C; Sat, 12 Oct 2024 08:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k2a45Gng3tIZ2g+WQaR0egVq9gwWYfW0oGZDIAF2bs8=; b=VIe/ykItDerpNx1rXVxRbbzc08
	abs5SD9T9lNiRPZgyBxZa52YBT88yOEZScncAZ5YD1GTfa1NDs1h2USbv1+1AN1zNcIBYIz+r3U0c
	+rkMyJcSo6TKhDaVBtPq659Y4OLB727W0EprDfo9MQ6faf6wpXVTyIYRrA1ir7bs8YA56Br7qU2AL
	GHFLRHnFY5GY7V3zJTOCtWxuOsMBlE6sanJpy7R8dF2Oy4jS+Ib83y/14PS58mKb0os65qtKwNpQh
	rO8aPUzoP24nVAIlqJKKANQVcp5Oi4CqY1Z95fIOXXlX31y6ZvgqdGQ+D79xvxWVcvlJrzvBzf5xC
	DU9G4d6w==;
Received: from p200300e2e7083000dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e708:3000:dacb:8aff:fee0:ca63]:32840 helo=soren-pc.lan)
	by sub5.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1szVWe-006L8x-U0; Sat, 12 Oct 2024 08:22:52 +0200
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: tboegi@web.de,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v4] mingw.c: Fix complier warnings for a 64 bit msvc
Date: Sat, 12 Oct 2024 08:22:43 +0200
Message-Id: <20241012062243.3350-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010191939.GA17171@tb-raspi4>
References: <20241010191939.GA17171@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1728714172C3C58238CDA2O
X-Originated-At: 2003:e2:e708:3000:dacb:8aff:fee0:ca63!32840
X-Scan-TS: Sat, 12 Oct 2024 08:22:52 +0200

Remove some complier warnings from msvc in compat/mingw.c for value
truncation from 64 bit to 32 bit integers.

Compiling compat/mingw.c under a 64 bit version of msvc produces
warnings. An "int" is 32 bit, and ssize_t or size_t should be 64 bit
long. Prepare compat/vcbuild/include/unistd.h to have a 64 bit type
_ssize_t, when _WIN64 is defined and 32 bit otherwise.

Further down in this include file, as before,ssize_t is defined as
_ssize_t, if needed.

Use size_t instead of int for all variables that hold the result of
strlen() or wcslen() (which cannot be negative).

Use ssize_t to hold the return value of read().

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/compiler.h               |  4 ++--
 compat/mingw.c                  | 25 +++++++++++++++----------
 compat/vcbuild/include/unistd.h |  4 ++++
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/compat/compiler.h b/compat/compiler.h
index e9ad9db84f..e12e426404 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -9,7 +9,7 @@
 
 static inline void get_compiler_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 #ifdef __clang__
 	strbuf_addf(info, "clang: %s\n", __clang_version__);
 #elif defined(__GNUC__)
@@ -27,7 +27,7 @@ static inline void get_compiler_info(struct strbuf *info)
 
 static inline void get_libc_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 
 #ifdef __GLIBC__
 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
diff --git a/compat/mingw.c b/compat/mingw.c
index 0e851ecae2..0ff550cef3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
  */
 static int has_valid_directory_prefix(wchar_t *wfilename)
 {
-	int n = wcslen(wfilename);
+	size_t n = wcslen(wfilename);
 
 	while (n > 0) {
 		wchar_t c = wfilename[--n];
@@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
  */
 static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 {
-	int namelen;
+	size_t namelen;
 	char alt_name[PATH_MAX];
 
 	if (!do_lstat(follow, file_name, buf))
@@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *cmd)
 {
 	static char buf[100];
 	char *p, *opt;
-	int n, fd;
+	ssize_t n; /* read() can return negative values */
+	int fd;
 
 	/* don't even try a .exe */
 	n = strlen(cmd);
@@ -1339,7 +1340,7 @@ static char *path_lookup(const char *cmd, int exe_only)
 {
 	const char *path;
 	char *prog = NULL;
-	int len = strlen(cmd);
+	size_t len = strlen(cmd);
 	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
 
 	if (strpbrk(cmd, "/\\"))
@@ -1956,7 +1957,7 @@ char *mingw_getenv(const char *name)
 #define GETENV_MAX_RETAIN 64
 	static char *values[GETENV_MAX_RETAIN];
 	static int value_counter;
-	int len_key, len_value;
+	size_t len_key, len_value;
 	wchar_t *w_key;
 	char *value;
 	wchar_t w_value[32768];
@@ -1968,7 +1969,8 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	w_key = calloc(len_key, sizeof(wchar_t));
 	if (!w_key)
-		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
+		die("Out of memory, (tried to allocate %"PRIuMAX" wchar_t's)",
+			(uintmax_t)len_key);
 	xutftowcs(w_key, name, len_key);
 	/* GetEnvironmentVariableW() only sets the last error upon failure */
 	SetLastError(ERROR_SUCCESS);
@@ -1983,7 +1985,8 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	value = calloc(len_value, sizeof(char));
 	if (!value)
-		die("Out of memory, (tried to allocate %u bytes)", len_value);
+		die("Out of memory, (tried to allocate %"PRIuMAX" bytes)",
+			(uintmax_t)len_value);
 	xwcstoutf(value, w_value, len_value);
 
 	/*
@@ -2001,7 +2004,7 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	int size;
+	size_t size;
 	wchar_t *wide, *equal;
 	BOOL result;
 
@@ -2011,7 +2014,8 @@ int mingw_putenv(const char *namevalue)
 	size = strlen(namevalue) * 2 + 1;
 	wide = calloc(size, sizeof(wchar_t));
 	if (!wide)
-		die("Out of memory, (tried to allocate %u wchar_t's)", size);
+		die("Out of memory, (tried to allocate %" PRIuMAX " wchar_t's)",
+		    (uintmax_t)size);
 	xutftowcs(wide, namevalue, size);
 	equal = wcschr(wide, L'=');
 	if (!equal)
@@ -3085,7 +3089,8 @@ static void maybe_redirect_std_handles(void)
  */
 int wmain(int argc, const wchar_t **wargv)
 {
-	int i, maxlen, exit_status;
+	int i, exit_status;
+	size_t maxlen;
 	char *buffer, **save;
 	const char **argv;
 
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index 3a959d124c..a261a925b7 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -14,7 +14,11 @@ typedef _mode_t	mode_t;
 
 #ifndef _SSIZE_T_
 #define _SSIZE_T_
+#ifdef _WIN64
+typedef __int64 _ssize_t;
+#else
 typedef long _ssize_t;
+#endif /* _WIN64 */
 
 #ifndef	_OFF_T_
 #define	_OFF_T_

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.39.5

