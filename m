Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FBC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbiBSKmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 05:42:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242023AbiBSKmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 05:42:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEDF36E30
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d27so18601517wrb.5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2gagW1GzwHJh2hBLD6js+aOtPfRcu3iOaziezH8Fg8=;
        b=AvkTrrVTeRPCi8RmeNNSgeERYyNHNA+Vyt+nbA6TvjUmCE4pb3bmo2eEfkOXoEumHR
         3fDIR/IF0pnJhX4Tsv0MTVARgpN1yfWXG3s6pAGrW9IxpdoPRM2st2szo9PV6QexTMMn
         73JKPzuCDx+WAQZy9CZNP50TfojR2DJccCXUh5RvRY3lE4lx8/LBem5wmN2gyD5NvCcz
         wE1jpUOdaE2hujARqOsLldRsUUskRx1SbI6+fJNnjJ7WKb1M7PgiX2KtJGT9dwSyIgXs
         IDiQGut2lijmUCsu4Vus5TOIyh/R3ZCRtzjkl8W7YHREd7gzoEjWpw19b21w8HRVGAra
         cK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2gagW1GzwHJh2hBLD6js+aOtPfRcu3iOaziezH8Fg8=;
        b=Kc4/+JMkDupDzpjn+3vdLBm4BiF9FW9B3Gi/wDDxx5SPh7b4cApVWGmbID3GDfzWJg
         2ViIvSBNhQzj37DgoooZl8FO6qHNYISyL7DbycUmC99peifiVpcT6nCD9S9/tcn0poRz
         qR+/4AphSRPAqqhujTybeqfMJyUt3CjWzmRgrna347mXJ3IaldqyPY2cc92KKDcIjJKZ
         sqze+Q52feqGFwgjVE8UmVbzJ0n2mfEohyBk5cOXj2m6AyiMNn9Ly8dawtZhG2YgIcVM
         deYhNauNj29M3/B7yjRZs4HkC1/qQnC8S2Pu+xQTYCa0j4EcSQ5nB0BRoMCYPrmpyfFc
         Irog==
X-Gm-Message-State: AOAM532J5oE3J6Ujcp0gVQGzUedOJkKWn/7BRVfd/tpwAtqDo6RyGRuy
        /1JIc8u6xyJvMKSJybrjjy+Rfp2ghucAoQ==
X-Google-Smtp-Source: ABdhPJxotvAg4DEHQ/YcCZJob18rfPgmXEHRobB3rclZHmT6gNPNeFcZcNr4XNXIMDgizoMDT1rzRA==
X-Received: by 2002:adf:fa82:0:b0:1e6:34fe:9bf with SMTP id h2-20020adffa82000000b001e634fe09bfmr8602080wrr.43.1645267306821;
        Sat, 19 Feb 2022 02:41:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1sm21623928wrz.75.2022.02.19.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:41:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] trace.h: remove never-used TRACE_CONTEXT
Date:   Sat, 19 Feb 2022 11:41:10 +0100
Message-Id: <patch-v3-3.3-27ea260bbea-20220219T103752Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1129.g03fd99ecb8d
In-Reply-To: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definition of "TRACE_CONTEXT" as "__FILE__" added in
e05bed960d3 (trace: add 'file:line' to all trace output, 2014-07-12)
appeared between v6[1] and v7[2] of the series that added it.

It does not appear to have been something anybody asked for, and
doesn't seem to have been used by anyone since then to override it to
something other than the default __FILE__.

When trace2 was added in ee4512ed481 (trace2: create new combined
trace facility, 2019-02-22) it added no such "configuration", and
we're unlikely to ever want to configure this through these means.

I.e. I have considered (and probably will) make the usage.c macros
support optional __FUNCTION__ at some point, that would need to have
them passed as "mandatory" parameters (which might default to NULL) to
the underlying function, for the reasons explained in the comment
being removed here.

So let's just remove this indirection in favor of using __FILE__
directly.

1. https://lore.kernel.org/git/53A4A2CD.8010003@gmail.com/
2. https://lore.kernel.org/git/53B33DED.3030809@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace.h | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/trace.h b/trace.h
index 4e771f86ac2..5b52c1e23fd 100644
--- a/trace.h
+++ b/trace.h
@@ -126,19 +126,6 @@ void trace_command_performance(const char **argv);
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 uint64_t trace_performance_enter(void);
 
-/*
- * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
- * default is __FILE__, as it is consistent with assert(), and static function
- * names are not necessarily unique.
- *
- * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
- * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
- * the compiler as a string constant.
- */
-#ifndef TRACE_CONTEXT
-# define TRACE_CONTEXT __FILE__
-#endif
-
 /**
  * Macros to add the file:line of the calling code, instead of that of
  * the trace function itself.
@@ -171,7 +158,7 @@ uint64_t trace_performance_enter(void);
 #define trace_printf_key(key, ...)					    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
-			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
+			trace_printf_key_fl(__FILE__, __LINE__, key,	    \
 					    __VA_ARGS__);		    \
 	} while (0)
 
@@ -183,7 +170,7 @@ uint64_t trace_performance_enter(void);
 #define trace_argv_printf(argv, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_default_key))			    \
-			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
+			trace_argv_printf_fl(__FILE__, __LINE__,	    \
 					    argv, __VA_ARGS__);		    \
 	} while (0)
 
@@ -196,7 +183,7 @@ uint64_t trace_performance_enter(void);
 #define trace_strbuf(key, data)						    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
-			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
+			trace_strbuf_fl(__FILE__, __LINE__, key, data);	    \
 	} while (0)
 
 /**
@@ -220,7 +207,7 @@ uint64_t trace_performance_enter(void);
 #define trace_performance(nanos, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
-			trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos,\
+			trace_performance_fl(__FILE__, __LINE__, nanos,	    \
 					     __VA_ARGS__);		    \
 	} while (0)
 
@@ -239,7 +226,7 @@ uint64_t trace_performance_enter(void);
 #define trace_performance_since(start, ...)				    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
-			trace_performance_fl(TRACE_CONTEXT, __LINE__,       \
+			trace_performance_fl(__FILE__, __LINE__,	    \
 					     getnanotime() - (start),	    \
 					     __VA_ARGS__);		    \
 	} while (0)
@@ -250,7 +237,7 @@ uint64_t trace_performance_enter(void);
 #define trace_performance_leave(...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
-			trace_performance_leave_fl(TRACE_CONTEXT, __LINE__, \
+			trace_performance_leave_fl(__FILE__, __LINE__,	    \
 						   getnanotime(),	    \
 						   __VA_ARGS__);	    \
 	} while (0)
-- 
2.35.1.1129.g03fd99ecb8d

