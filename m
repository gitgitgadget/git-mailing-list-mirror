From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 12/14] Fix pointer -> integer casts on IL32P64 systems
Date: Tue, 30 Sep 2014 11:02:41 +0400
Message-ID: <1412060563-22041-13-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB5NQVGQQKGQEVX2VFBI@googlegroups.com Tue Sep 30 09:15:05 2014
Return-path: <msysgit+bncBCE7TAPITACRB5NQVGQQKGQEVX2VFBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB5NQVGQQKGQEVX2VFBI@googlegroups.com>)
	id 1XYreK-0004n4-MM
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:15:04 +0200
Received: by mail-wi0-f185.google.com with SMTP id d1sf185020wiv.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=yJ35XM4TlWoBQ8abGqAiN/bTdbflRyb6e+IsxyiusVI=;
        b=bwgXC7ZuKqnLQu+05uy+r17VbeF5A2TVWLVGykbnoPeq1x0usxfVYK89OP4ZumZSAy
         fw45UmxH9t6k1n+l3cH4D2e5kw4oZmaFn5gl5A4V8V9P/uUuFJTlnrDuQMHHaGDIvwQf
         KsuasgvcbQ9h9ot78d9sTSlYeaN4NThjJ3MlE30h2g/0D7Omfg5Kjbjw7JAnY87/XpI8
         YzEr0CzvqkQ6wliT1XAxp3yoZVu7g18lFeze8CTyOgWYebHMoUK6dADlDGu78Y9tszh/
         NZYc9cmZJ8+Z57+XogpvXibEJvcY6iga8Z7g73wONc8EIMyQpjsQSURckczRTBEJHi+L
         1c0Q==
X-Received: by 10.152.4.165 with SMTP id l5mr3246lal.17.1412061304397;
        Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.230 with SMTP id r6ls2079lal.92.gmail; Tue, 30 Sep 2014
 00:15:01 -0700 (PDT)
X-Received: by 10.112.225.41 with SMTP id rh9mr3267692lbc.5.1412061301140;
        Tue, 30 Sep 2014 00:15:01 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id h1si748946wib.0.2014.09.30.00.15.01
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:15:01 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSu-0004X0-Pb; Tue, 30 Sep 2014 11:03:17 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257660>

This commit touches regcomp.c and poll.c from Gnulib,
both were fixed upstream in 2012 the same way.

Also, this commit touches regex_internal.h from Gnulib,
which was fixed upstream in 2005.

Wrt ShellExecute in winansi.c, quoting [1]:

  MSDN says you can cast the result to an integer and compare the result
  against 32... You could cast in the other direction, comparing the return
  value against (HINSTANCE)32... Or you could cast the result to an INT_PTR
  and compare the result against 32.

We use the third option: cast HINSTANCE to intptr_t.

[1]: http://blogs.msdn.com/b/oldnewthing/archive/2006/11/08/1035971.aspx

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.c                | 8 ++++----
 compat/poll/poll.c            | 2 +-
 compat/regex/regcomp.c        | 4 ++--
 compat/regex/regex_internal.h | 1 +
 compat/win32/pthread.h        | 2 +-
 compat/winansi.c              | 2 +-
 pack-revindex.c               | 2 +-
 sha1_file.c                   | 8 ++++----
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..27925d9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -674,13 +674,13 @@ int pipe(int filedes[2])
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
-	filedes[0] = _open_osfhandle((int)h[0], O_NOINHERIT);
+	filedes[0] = _open_osfhandle((intptr_t)h[0], O_NOINHERIT);
 	if (filedes[0] < 0) {
 		CloseHandle(h[0]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
+	filedes[1] = _open_osfhandle((intptr_t)h[1], O_NOINHERIT);
 	if (filedes[0] < 0) {
 		close(filedes[0]);
 		CloseHandle(h[1]);
@@ -1819,7 +1819,7 @@ void mingw_open_html(const char *unixpath)
 			const char *, const char *, const char *, INT);
 	T ShellExecute;
 	HMODULE shell32;
-	int r;
+	intptr_t r;
 
 	shell32 = LoadLibrary("shell32.dll");
 	if (!shell32)
@@ -1829,7 +1829,7 @@ void mingw_open_html(const char *unixpath)
 		die("cannot run browser");
 
 	printf("Launching default browser to display HTML ...\n");
-	r = (int)ShellExecute(NULL, "open", htmlpath, NULL, "\\", SW_SHOWNORMAL);
+	r = (intptr_t)ShellExecute(NULL, "open", htmlpath, NULL, "\\", SW_SHOWNORMAL);
 	FreeLibrary(shell32);
 	/* see the MSDN documentation referring to the result codes here */
 	if (r <= 32) {
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index a9b41d8..8941249 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -76,7 +76,7 @@
 
 #ifdef WIN32_NATIVE
 
-#define IsConsoleHandle(h) (((long) (h) & 3) == 3)
+#define IsConsoleHandle(h) (((intptr_t) (h) & 3) == 3)
 
 static BOOL
 IsSocketHandle (HANDLE h)
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 06f3088..d8bde06 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2577,7 +2577,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
     old_tree = NULL;
 
   if (elem->token.type == SUBEXP)
-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
+    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
 
   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
   if (BE (tree == NULL, 0))
@@ -3806,7 +3806,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 static reg_errcode_t
 mark_opt_subexp (void *extra, bin_tree_t *node)
 {
-  int idx = (int) (long) extra;
+  int idx = (int) (intptr_t) extra;
   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
     node->token.opt_subexp = 1;
 
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 4184d7f..da12670 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdint.h>
 
 #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC
 # include <langinfo.h>
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 8ad1873..6ccfb7b 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -77,7 +77,7 @@ extern pthread_t pthread_self(void);
 
 static inline int pthread_exit(void *ret)
 {
-	ExitThread((DWORD)ret);
+	ExitThread((DWORD)(uintptr_t)ret);
 }
 
 typedef DWORD pthread_key_t;
diff --git a/compat/winansi.c b/compat/winansi.c
index 0ac3297..ca4c295 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -452,7 +452,7 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	HANDLE hresult, hproc = GetCurrentProcess();
 	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
 			DUPLICATE_SAME_ACCESS))
-		die_lasterr("DuplicateHandle(%li) failed", (long) hnd);
+		die_lasterr("DuplicateHandle(%p) failed", hnd);
 	return hresult;
 }
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 5c8376e..df02e9f 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -21,7 +21,7 @@ static int pack_revindex_hashsz;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
-	unsigned long ui = (unsigned long)p;
+	uintptr_t ui = (uintptr_t)p;
 	int i;
 
 	ui = ui ^ (ui >> 16); /* defeat structure alignment */
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..a534fda 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1966,11 +1966,11 @@ static struct delta_base_cache_entry {
 	enum object_type type;
 } delta_base_cache[MAX_DELTA_CACHE];
 
-static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
+static uintptr_t pack_entry_hash(struct packed_git *p, off_t base_offset)
 {
-	unsigned long hash;
+	uintptr_t hash;
 
-	hash = (unsigned long)p + (unsigned long)base_offset;
+	hash = (uintptr_t)p + base_offset;
 	hash += (hash >> 8) + (hash >> 16);
 	return hash % MAX_DELTA_CACHE;
 }
@@ -1978,7 +1978,7 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 static struct delta_base_cache_entry *
 get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 {
-	unsigned long hash = pack_entry_hash(p, base_offset);
+	uintptr_t hash = pack_entry_hash(p, base_offset);
 	return delta_base_cache + hash;
 }
 
-- 
2.1.1

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
