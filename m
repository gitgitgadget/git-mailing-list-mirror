Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DD720193
	for <e@80x24.org>; Wed, 26 Oct 2016 10:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbcJZK32 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 06:29:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33775 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbcJZK30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 06:29:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so22421124pfa.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oXTkiCSGmgRv7cpS9SvYbkfQDCvd8kA07HebzYr2yGo=;
        b=OP4nqDLz35eqFpzVQyGsIq12yf1ZCiP9z4skywoCZJRNoOh0L44CxmHJwX5p5Fcjg1
         SUyje0ud4ofhk+EPY2nTbPBqNyUHPOfGE7lg3P/e7PjTcPqwo3VdhAlpOxAfnbk7wdrT
         cLVKtPKGSuWwOR0fbBfcffMMIWsx5yOlYeUbbNSrLokUhOkSxdaprnokQP9b8eUckrcp
         ojmfoxYrXfVmQtL5bqxg0myBZ7gCeTXm+BV2yIvReb51j7sazAZcMmg26WEj0GC5Y+4r
         9TklKX53EHQsuiyYJDMEiNZyoBwXhbSnKv6LnMiEMb9ToHHK8nhbIMA2RVqEgVDVqoGv
         gRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oXTkiCSGmgRv7cpS9SvYbkfQDCvd8kA07HebzYr2yGo=;
        b=NB73BZK6mRQ+cEAjkqPDq1WG1VZcaiQhwEcKMSmzAVEzzYOBSNliF4y9bwR4iz4uQ0
         ye0o0FLszQrWxrFCkuohMgdw0teI3aZkxFDCu0U2Fx+Xag0vXaXwITL1MfC61ahWNBnn
         BSj2Dayo11/gnn1WDNIk1pW7DWLBwy2yIEU3Nz3xhOtoHQobxM7p90iOShldWtV5udtG
         7S9oCPlE6k2cecSDlFKqTSowi+MgwA8gKopVogdqPdYkdx8LPlrZRnQ5wOx1uTi7kU+N
         gaONx0/jZN7sqicKhzXl/ygctN8SyTYDr55mMdbQii9QunceAVXESEe3Gb3glkTeSJ6i
         4eKg==
X-Gm-Message-State: ABUngve+KUZc+ZeBP6vbTE41BWBQfSbP5AU1LW1py2wqdBC9GnXTBvamYxam1/hZvlSIXg==
X-Received: by 10.99.7.210 with SMTP id 201mr2380496pgh.51.1477477765956;
        Wed, 26 Oct 2016 03:29:25 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id o75sm3192296pfi.25.2016.10.26.03.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 03:29:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 26 Oct 2016 17:29:21 +0700
Date:   Wed, 26 Oct 2016 17:29:21 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161026102921.GA31311@ash>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
 <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 11:15:25AM -0400, Jeff King wrote:
> > The "once we've identified" part could be tricky though. This message
> > alone will not give us any clue where it's called since it's buried
> > deep in git_path() usually, which is buried deep elsewhere. Without
> > falling back to core dumps (with debug info), glibc's backtrace
> > (platform specifc), the best we could do is turn git_path() into a
> > macro that takes __FILE__ and __LINE__ and somehow pass the info down
> > here, but "..." in macros is C99 specific, sigh..
> > 
> > Is it too bad to turn git_path() into a macro when we know the
> > compiler is C99 ? Older compilers will have no source location info in
> > git_path(), Hopefully they are rare, which means chances of this fault
> > popping up are also reduced.
> 
> I think you could conditionally make git_path() and all of its
> counterparts macros, similar to the way the trace code works. It seems
> like a pretty maintenance-heavy solution, though. I'd prefer
> conditionally compiling backtrace(); that also doesn't hit 100% of
> cases, but at least it isn't too invasive.

OK, a more polished patch is this. There are warnings about
-fomit-function-pointers in glibc man page, at least in my simple
tests it does not cause any issue.

> But I think I still prefer just letting the corefile and the debugger do
> their job. This error shouldn't happen much, and when it does, it should
> be easily reproducible. Getting the bug reporter to give either a
> reproduction recipe, or to run "gdb git" doesn't seem like that big a
> hurdle.

There are other places where backtrace() support may come handy
too. If -rdynamic was not needed, I would push for this patch. Too bad
backtrace() is not a perfect magic wand.

-- 8< --
diff --git a/config.mak.uname b/config.mak.uname
index b232908..b38f62a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -40,6 +40,8 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
+	# for backtrace() support with glibc >= 2.1
+	BASIC_LDFLAGS += -rdynamic
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 43718da..3561ab9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -408,6 +408,7 @@ extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void BUG(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -709,6 +710,7 @@ extern int git_vsnprintf(char *str, size_t maxsize,
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
+#define HAVE_BACKTRACE
 #endif
 #endif
 
@@ -722,6 +724,23 @@ static inline char *gitstrchrnul(const char *s, int c)
 }
 #endif
 
+#ifdef HAVE_BACKTRACE
+#include <execinfo.h>
+static inline void dump_backtrace(FILE *fp)
+{
+	void *buffer[32];
+	int nptrs;
+
+	nptrs = backtrace(buffer, sizeof(buffer) / sizeof(*buffer));
+	fflush(fp);
+	backtrace_symbols_fd(buffer, nptrs, fileno(fp));
+}
+#else
+static inline void dump_backtrace(FILE *fp)
+{
+}
+#endif
+
 #ifdef NO_INET_PTON
 int inet_pton(int af, const char *src, void *dst);
 #endif
diff --git a/usage.c b/usage.c
index 17f52c1..b00603c 100644
--- a/usage.c
+++ b/usage.c
@@ -204,3 +204,16 @@ void warning(const char *warn, ...)
 	warn_routine(warn, params);
 	va_end(params);
 }
+
+void NORETURN BUG(const char *fmt, ...)
+{
+	va_list params;
+
+	va_start(params, fmt);
+	vreportf("BUG: ", fmt, params);
+	va_end(params);
+
+	dump_backtrace(error_handle ? error_handle : stderr);
+
+	exit(128);
+}
-- 8< --
--
Duy
