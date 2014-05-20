From: Karsten Blees <karsten.blees@gmail.com>
Subject: [RFC/PATCH v4 1/3] add high resolution timer function to
 debug performance issues
Date: Tue, 20 May 2014 21:11:13 +0200
Message-ID: <537BA8D1.1090503@gmail.com>
References: <537BA806.50600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBUOR52NQKGQEDK6JGWQ@googlegroups.com Tue May 20 21:11:15 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBUOR52NQKGQEDK6JGWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBUOR52NQKGQEDK6JGWQ@googlegroups.com>)
	id 1WmpRS-00081S-8j
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:11:14 +0200
Received: by mail-wi0-f192.google.com with SMTP id z2sf124447wiv.29
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=7daX/wpD6oiyZpzbeLKpVdUBcXQqRN03xLLRczgWxsI=;
        b=sEL8TKzcZB4vyyx9uGMM/SCQzaJ0ROZfeNRrx1hFk+Y769eCNypqLFqcfKB5MIKb5A
         W/k96IFUaxGBMG+QlPnA1I121+NC27spOyfjE9xz7956qL27jDzVVhXAYsY1t9IpCR6X
         GIPbch57GrsUOjAoQW7ctLIRY6rqThPObFIWE7W1s8qIq+a46UZQBoIg5td1BCeqN+o3
         MOnfNsiHMdXziAMzFlReoiQjGnngzndPcXxD/deUFy6OGjMOioIy7qJUmea4raF6n/vc
         XUjZfTcirF3arN4lfm/DPgZJhiWymafcpt3QYrY+Bw3G4hwWj+lPFuzJlYQNg8DYMZC+
         VNrg==
X-Received: by 10.180.188.73 with SMTP id fy9mr30457wic.10.1400613074036;
        Tue, 20 May 2014 12:11:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.136 with SMTP id y8ls174530wij.28.gmail; Tue, 20 May
 2014 12:11:12 -0700 (PDT)
X-Received: by 10.15.35.134 with SMTP id g6mr1265705eev.3.1400613072778;
        Tue, 20 May 2014 12:11:12 -0700 (PDT)
Received: from mail-ee0-x230.google.com (mail-ee0-x230.google.com [2a00:1450:4013:c00::230])
        by gmr-mx.google.com with ESMTPS id r49si995077eep.0.2014.05.20.12.11.12
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::230 as permitted sender) client-ip=2a00:1450:4013:c00::230;
Received: by mail-ee0-f48.google.com with SMTP id e49so886216eek.21
        for <msysgit@googlegroups.com>; Tue, 20 May 2014 12:11:12 -0700 (PDT)
X-Received: by 10.14.173.194 with SMTP id v42mr6678780eel.84.1400613072697;
        Tue, 20 May 2014 12:11:12 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id p9sm5920209eeg.32.2014.05.20.12.11.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537BA806.50600@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::230
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249731>

Add a getnanotime() function that returns nanoseconds since 01/01/1970 as
unsigned 64-bit integer (i.e. overflows in july 2554). This is easier to
work with than e.g. struct timeval or struct timespec.

The implementation uses gettimeofday() by default; supports high precision
time sources on the following platforms:
 * Linux: using clock_gettime(CLOCK_MONOTONIC)
 * Windows: using QueryPerformanceCounter()

Todo:
 * enable clock_gettime() on more platforms
 * implement Mac OSX version using mach_absolute_time

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Makefile         |  7 +++++
 cache.h          |  1 +
 config.mak.uname |  1 +
 trace.c          | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/Makefile b/Makefile
index a53f3a8..3c05f8c 100644
--- a/Makefile
+++ b/Makefile
@@ -341,6 +341,8 @@ all::
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
diff --git a/cache.h b/cache.h
index 107ac61..48fc616 100644
--- a/cache.h
+++ b/cache.h
@@ -1362,6 +1362,7 @@ extern int trace_want(const char *key);
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(const char *key, const char *fmt, ...);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
+extern uint64_t getnanotime(void);
 
 void packet_trace_identity(const char *prog);
 
diff --git a/config.mak.uname b/config.mak.uname
index 23a8803..5e3b1dd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	HAVE_CLOCK_GETTIME = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
diff --git a/trace.c b/trace.c
index 08180a9..3d72084 100644
--- a/trace.c
+++ b/trace.c
@@ -187,3 +187,85 @@ int trace_want(const char *key)
 		return 0;
 	return 1;
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
-- 
1.9.2.msysgit.0.493.g47a82c3

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
