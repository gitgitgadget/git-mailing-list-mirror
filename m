Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD7E1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeKCR7l (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37262 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeKCR7k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4-v6so3738288lja.4
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOrJk/bklnW/yeksfRirv+6A+Y2dqd3zhyRXgtJR194=;
        b=spuWBae+0LY+syBXMEDfYu4aFt63jRCHCovA3HPsvkY4kspG9WwkLJEs5oU8nUFHEH
         YNgl60xJU134xNTYq4yaagV4o0OZ4lbsn6ea9aqoXPRUHKHZjUFYvnFllyMPb6jbIdm+
         fzPkB7pvX6i+IWtWneRj/FnIi6pU0fM7o6gUOP5tNv9E7Ps//9G59VcyC1wnsFLvXvuB
         lM5fjIV0YkqrKGUb7v6lWP5STp2bSgOXhzwTTUwC05N4dDLtEhFYYUOL9PXjAnBBe7px
         Ax4oi89l6T0ZOppNPGKECfYlujfTNFfNMyk91Ne4e6VnMQTQKKencdgZTTUBPsKXiMV8
         4IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOrJk/bklnW/yeksfRirv+6A+Y2dqd3zhyRXgtJR194=;
        b=apYKFI2+zG4SnLM45E01ll8AGOlPJcp4YAr2lJX1Uke+szomI3cNpGbeHPRxnHRdsK
         Thx0CbIItgyLwlHWmohYDF3Ff4ZS6gmm1AxBPepdZpEJSJUkQIFbLsZqaQj50rQ1PbZL
         0022RaRAUufExuQ8ygLtBZdw4GVJlKwk8WTAba0fYF3oqU3xanNvkEBgUbGkbLmhI7LL
         slB++TZXPVqJLE43oh/U0r7zlPCEaAneFBRaGv/fXtOKjuA12itNIi8tQg5MHQglha0P
         D3hzavmXvvbtEzQUfJkWFkkiZ/FsI3byY8/kAm14XS2MkMU7G1mpG3Vfhnoyoa8OTgIx
         wo/w==
X-Gm-Message-State: AGRZ1gLTR8IzwZCGS3NBVr5HE+fcKzShOGCg/fBpnWNJwqOxktleYYnr
        TdPbgEaz3Tsu5wyawsBlXZo=
X-Google-Smtp-Source: AJdET5cnSZ180wPWNcBUJMhetGpFDH+8CFG9l1NRihRGQxMJjB70oTAKC7ryEiC65gIwMWqKhiBsgQ==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr2090455lju.116.1541234942513;
        Sat, 03 Nov 2018 01:49:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 01/14] thread-utils: macros to unconditionally compile pthreads API
Date:   Sat,  3 Nov 2018 09:48:37 +0100
Message-Id: <20181103084850.9584-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When built with NO_PTHREADS, the macros are used make the code build
even though pthreads header and library may be missing. The code can
still have different code paths for no threads support with
HAVE_THREADS variable.

There are of course impacts on no-pthreads builds:

- data structure may get slightly bigger because all the mutexes and
  pthread_t are present (as an int)

- code execution is not impacted much. Locking (in hot path) is
  no-op. Other wrapper function calls really should not matter much.

- the binary size grows bigger because of threaded code. But at least
  on Linux this does not matter, if some code is not executed, it's
  not mapped in memory.

This is a preparation step to remove "#ifdef NO_PTHREADS" in the code
mostly because of maintainability. As Jeff put it

> it's probably OK to stop thinking of it as "non-threaded platforms
> are the default and must pay zero cost" and more as "threaded
> platforms are the default, and non-threaded ones are OK to pay a
> small cost as long as they still work".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile       |  2 +-
 thread-utils.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea258..321540a736 100644
--- a/Makefile
+++ b/Makefile
@@ -991,6 +991,7 @@ LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
+LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
@@ -1674,7 +1675,6 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
diff --git a/thread-utils.c b/thread-utils.c
index a2135e0743..5329845691 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -20,6 +20,9 @@
 
 int online_cpus(void)
 {
+#ifdef NO_PTHREADS
+	return 1;
+#else
 #ifdef _SC_NPROCESSORS_ONLN
 	long ncpus;
 #endif
@@ -59,10 +62,12 @@ int online_cpus(void)
 #endif
 
 	return 1;
+#endif
 }
 
 int init_recursive_mutex(pthread_mutex_t *m)
 {
+#ifndef NO_PTHREADS
 	pthread_mutexattr_t a;
 	int ret;
 
@@ -74,4 +79,47 @@ int init_recursive_mutex(pthread_mutex_t *m)
 		pthread_mutexattr_destroy(&a);
 	}
 	return ret;
+#else
+	return 0;
+#endif
+}
+
+#ifdef NO_PTHREADS
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis and avoid -Wunused-variable false warnings.
+	 */
+	return ENOSYS;
+}
+
+int dummy_pthread_init(void *data)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis or it may realize that functions like
+	 * pthread_mutex_init() is no-op, which means the (static)
+	 * variable is not used/initialized at all and trigger
+	 * -Wunused-variable
+	 */
+	return ENOSYS;
 }
+
+int dummy_pthread_join(pthread_t pthread, void **retval)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis and avoid -Wunused-variable false warnings.
+	 */
+	return ENOSYS;
+}
+
+#endif
diff --git a/thread-utils.h b/thread-utils.h
index d9a769d190..4961487ed9 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -4,12 +4,54 @@
 #ifndef NO_PTHREADS
 #include <pthread.h>
 
-extern int online_cpus(void);
-extern int init_recursive_mutex(pthread_mutex_t*);
+#define HAVE_THREADS 1
 
 #else
 
-#define online_cpus() 1
+#define HAVE_THREADS 0
+
+/*
+ * macros instead of typedefs because pthread definitions may have
+ * been pulled in by some system dependencies even though the user
+ * wants to disable pthread.
+ */
+#define pthread_t int
+#define pthread_mutex_t int
+#define pthread_cond_t int
+#define pthread_key_t int
+
+#define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
+#define pthread_mutex_lock(mutex)
+#define pthread_mutex_unlock(mutex)
+#define pthread_mutex_destroy(mutex)
+
+#define pthread_cond_init(cond, attr) dummy_pthread_init(cond)
+#define pthread_cond_wait(cond, mutex)
+#define pthread_cond_signal(cond)
+#define pthread_cond_broadcast(cond)
+#define pthread_cond_destroy(cond)
+
+#define pthread_key_create(key, attr) dummy_pthread_init(key)
+#define pthread_key_delete(key)
+
+#define pthread_create(thread, attr, fn, data) \
+	dummy_pthread_create(thread, attr, fn, data)
+#define pthread_join(thread, retval) \
+	dummy_pthread_join(thread, retval)
+
+#define pthread_setspecific(key, data)
+#define pthread_getspecific(key) NULL
+
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data);
+int dummy_pthread_join(pthread_t pthread, void **retval);
+
+int dummy_pthread_init(void *);
 
 #endif
+
+int online_cpus(void);
+int init_recursive_mutex(pthread_mutex_t*);
+
+
 #endif /* THREAD_COMPAT_H */
-- 
2.19.1.1005.gac84295441

