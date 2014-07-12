From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 12/17] trace: add high resolution timer function
 to debug performance issues
Date: Sat, 12 Jul 2014 02:05:42 +0200
Message-ID: <53C07BD6.5010008@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBVHXQGPAKGQEQAMT7XI@googlegroups.com Sat Jul 12 02:05:41 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBVHXQGPAKGQEQAMT7XI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBVHXQGPAKGQEQAMT7XI@googlegroups.com>)
	id 1X5kov-00063n-3o
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:05:41 +0200
Received: by mail-wi0-f184.google.com with SMTP id n3sf958wiv.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=0NHZ6rbxMp2EHsuRumyTA8MKctcQfvauU6KhAY0QlCg=;
        b=V8DEV2wfBkWqh5t6QFgSkM/sQe+3nX+riA+LGXjdYAHTzC3p5wz0X0FD7bXQG0pE1w
         UGdi0HFwooGG3GhU3DEn7XHWCQKfSJ087cTSf0wtd4W1B2u/Y9hDH/fQaLMmnV9Hm1u2
         0+LtmgnZuZDb8pR2t/WOf/2yAkyK8ygbK/dBgSQ7U1smuhECQocEgb5IHOP5iJef4c63
         KDoU+e4hFZ3rXWcgxt9Rg/N+0ksMdh3RzX/GhXTvn+mGmaqbuFSLMoVHqZ1TK+dOgOl5
         1mBa/6Jd8WPDY8+QR/1VNe8lZ5zPJie6K0OylF271FvF01l8014+jSttWr5By7EnrBKy
         BH5w==
X-Received: by 10.180.184.129 with SMTP id eu1mr30818wic.14.1405123540848;
        Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.45 with SMTP id eb13ls158631wic.27.gmail; Fri, 11 Jul
 2014 17:05:40 -0700 (PDT)
X-Received: by 10.180.89.199 with SMTP id bq7mr806187wib.3.1405123540146;
        Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com [2a00:1450:400c:c03::22f])
        by gmr-mx.google.com with ESMTPS id iz18si2183wic.3.2014.07.11.17.05.40
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f as permitted sender) client-ip=2a00:1450:400c:c03::22f;
Received: by mail-we0-f175.google.com with SMTP id k48so1799087wev.34
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
X-Received: by 10.194.7.36 with SMTP id g4mr2724090wja.37.1405123540066;
        Fri, 11 Jul 2014 17:05:40 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ex4sm388789wic.2.2014.07.11.17.05.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:05:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253367>

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
index 7a5ba2e..4b893a5 100644
--- a/trace.h
+++ b/trace.h
@@ -16,6 +16,7 @@ struct trace_key {
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
+extern uint64_t getnanotime(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
2.0.0.406.g2e9ef9b

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
