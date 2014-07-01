From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 12/16] trace: add high resolution timer function
 to debug performance issues
Date: Wed, 02 Jul 2014 01:02:42 +0200
Message-ID: <53B33E12.30100@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBEX4ZSOQKGQE4E63WSI@googlegroups.com Wed Jul 02 01:02:44 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBEX4ZSOQKGQE4E63WSI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBEX4ZSOQKGQE4E63WSI@googlegroups.com>)
	id 1X274V-0004qq-Gv
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:02:43 +0200
Received: by mail-lb0-f191.google.com with SMTP id c11sf1077966lbj.18
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=EsTm4H2QVdiqT3977VFkq1zy5mDzoFJmz/duQG3bbQE=;
        b=B373Ab/J8h4+cyR0+E5IoAqpCKXa5KpRN6xaRZYL5wxweGsD4piBYXaBNl2HbgQlut
         AU7KBlwDOKKUUkRHx8bzpZ0WdcLto6vrI91WCdZuG+ErXRuV2PcsU4O2qO1LT+FWk1bA
         zG3X0V+PeJf19VtgRLkXWZuVtjcmEEzK0qPFSCJ7FqeLRoNDdfSs2CIqtls4i3uJsX1d
         yiGlaVVCqIOVMT8AyINQlUNPY4FdyQncQhrLJYN2cFBioaiuDa5SvvfDTir9QwFRZ3FK
         nw6Jgfw8yg8R4WOo1DYAJEpE6DougkeLqcrfYb0Eoq40qpGYXDxJBS+69KzHJfR+mXYv
         0/hQ==
X-Received: by 10.152.198.170 with SMTP id jd10mr39449lac.20.1404255763329;
        Tue, 01 Jul 2014 16:02:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.4.2 with SMTP id ca2ls366444lad.94.gmail; Tue, 01 Jul 2014
 16:02:42 -0700 (PDT)
X-Received: by 10.112.126.196 with SMTP id na4mr687576lbb.17.1404255762014;
        Tue, 01 Jul 2014 16:02:42 -0700 (PDT)
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com [2a00:1450:400c:c00::22e])
        by gmr-mx.google.com with ESMTPS id gc5si880621wic.1.2014.07.01.16.02.41
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:02:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e as permitted sender) client-ip=2a00:1450:400c:c00::22e;
Received: by mail-wg0-f46.google.com with SMTP id y10so10443492wgg.29
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:02:41 -0700 (PDT)
X-Received: by 10.180.83.200 with SMTP id s8mr536205wiy.2.1404255761911;
        Tue, 01 Jul 2014 16:02:41 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u10sm51002562wjz.43.2014.07.01.16.02.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:02:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252761>

Add a getnanotime() function that returns nanoseconds since 01/01/1970 as
unsigned 64-bit integer (i.e. overflows in july 2554). This is easier to
work with than e.g. struct timeval or struct timespec. Basing the timer on
the epoch allows using the results with other time-related APIs.

To simplify adaption to different platforms, split the implementation into
a common getnanotime() and a platform-specific highres_nanos() function.

The common getnanotime() function handles errors, falling back to
gettimeofday() if highres_nanos() isn't implemented or doesn't work.

getnanotime() is also responsible for normalizing to the epoch. The offset
to the system clock is calculated only once on initialization, i.e.
manually setting the system clock has no impact on the timer (except if
the fallback gettimeofday() is in use). Git processes are typically short
lived, so we don't need to handle clock drift.

The highres_nanos() function returns monotonically increasing nanoseconds
relative to some arbitrary point in time (e.g. system boot), or 0 on
failure. Providing platform-specific implementations should be relatively
easy, e.g. adapting to clock_gettime() as defined by the POSIX realtime
extensions is seven lines of code.

This version includes highres_nanos() implementations for:
 * Linux: using clock_gettime(CLOCK_MONOTONIC)
 * Windows: using QueryPerformanceCounter()

Todo:
 * enable clock_gettime() on more platforms
 * add Mac OSX version, e.g. using mach_absolute_time + mach_timebase_info

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |  7 +++++
 config.mak.uname |  1 +
 trace.c          | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 trace.h          |  1 +
 4 files changed, 91 insertions(+)

diff --git a/Makefile b/Makefile
index 07ea105..80f4390 100644
--- a/Makefile
+++ b/Makefile
@@ -340,6 +340,8 @@ all::
 #
 # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
 # return NULL when it receives a bogus time_t.
+#
+# Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1497,6 +1499,11 @@ ifdef GMTIME_UNRELIABLE_ERRORS
 	BASIC_CFLAGS += -DGMTIME_UNRELIABLE_ERRORS
 endif
 
+ifdef HAVE_CLOCK_GETTIME
+	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
+	EXTLIBS += -lrt
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 1ae675b..dad2618 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -34,6 +34,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	HAVE_CLOCK_GETTIME = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/trace.c b/trace.c
index f013958..b9d7272 100644
--- a/trace.c
+++ b/trace.c
@@ -275,3 +275,85 @@ int trace_want(struct trace_key *key)
 {
 	return !!get_trace_fd(key);
 }
+
+#ifdef HAVE_CLOCK_GETTIME
+
+static inline uint64_t highres_nanos(void)
+{
+	struct timespec ts;
+	if (clock_gettime(CLOCK_MONOTONIC, &ts))
+		return 0;
+	return (uint64_t) ts.tv_sec * 1000000000 + ts.tv_nsec;
+}
+
+#elif defined (GIT_WINDOWS_NATIVE)
+
+static inline uint64_t highres_nanos(void)
+{
+	static uint64_t high_ns, scaled_low_ns;
+	static int scale;
+	LARGE_INTEGER cnt;
+
+	if (!scale) {
+		if (!QueryPerformanceFrequency(&cnt))
+			return 0;
+
+		/* high_ns = number of ns per cnt.HighPart */
+		high_ns = (1000000000LL << 32) / (uint64_t) cnt.QuadPart;
+
+		/*
+		 * Number of ns per cnt.LowPart is 10^9 / frequency (or
+		 * high_ns >> 32). For maximum precision, we scale this factor
+		 * so that it just fits within 32 bit (i.e. won't overflow if
+		 * multiplied with cnt.LowPart).
+		 */
+		scaled_low_ns = high_ns;
+		scale = 32;
+		while (scaled_low_ns >= 0x100000000LL) {
+			scaled_low_ns >>= 1;
+			scale--;
+		}
+	}
+
+	/* if QPF worked on initialization, we expect QPC to work as well */
+	QueryPerformanceCounter(&cnt);
+
+	return (high_ns * cnt.HighPart) +
+	       ((scaled_low_ns * cnt.LowPart) >> scale);
+}
+
+#else
+# define highres_nanos() 0
+#endif
+
+static inline uint64_t gettimeofday_nanos(void)
+{
+	struct timeval tv;
+	gettimeofday(&tv, NULL);
+	return (uint64_t) tv.tv_sec * 1000000000 + tv.tv_usec * 1000;
+}
+
+/*
+ * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
+ * (i.e. favoring high precision over wall clock time accuracy).
+ */
+inline uint64_t getnanotime(void)
+{
+	static uint64_t offset;
+	if (offset > 1) {
+		/* initialization succeeded, return offset + high res time */
+		return offset + highres_nanos();
+	} else if (offset == 1) {
+		/* initialization failed, fall back to gettimeofday */
+		return gettimeofday_nanos();
+	} else {
+		/* initialize offset if high resolution timer works */
+		uint64_t now = gettimeofday_nanos();
+		uint64_t highres = highres_nanos();
+		if (highres)
+			offset = now - highres;
+		else
+			offset = 1;
+		return now;
+	}
+}
diff --git a/trace.h b/trace.h
index c3ca47c..6ad29dd 100644
--- a/trace.h
+++ b/trace.h
@@ -16,6 +16,7 @@ struct trace_key {
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
+extern uint64_t getnanotime(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
2.0.0.406.ge74f8ff

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
