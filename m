Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A011C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 23:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCTXFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCTXFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 19:05:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1336FD1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 16:05:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so3243826pjb.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 16:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsPnzw5XTdDGNnFOIVV0ubufNoNyVE5sWgf1aQFUbyQ=;
        b=pgIkIa3MgdGMdz3z8YlO1UcWkARAIp1IYiEHtnF5UhcDDeTuzAMJMBJV9x5x2O0dyl
         eCKKuVx2Lu1zAh0zU4MfmpzamzodlQW9Jyt5g/+20oUWhe9UXMFNZT+J1TyquooIih67
         HyMWdAWHC2PHPOatyO+pnTLCPjennreTbSY5OL6j6X2wA+L2C8eXPFLzqDgggTIhmNVn
         CZrPlGJpaO++pIOyWqDlzaqP0an0W0WhWIVnjsukcsLoDQ/sDZgzI8P33MOowO892EEI
         WTKuQOwb0L3wYSK/J2QGoX2dytkX4H1+pPWoYkVfSK1gmPkLbrBnZyWIrJSPRAB8VkFD
         1PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hsPnzw5XTdDGNnFOIVV0ubufNoNyVE5sWgf1aQFUbyQ=;
        b=FZhov91TSPntrdqmPVZVvPEAd8756hB73o0cTBzgXNuLP1LTT61cCtEeHbii0HPEEk
         NlPgE9X3FCOVOXnwTuaaJpDc7y3U/0TOSEAG0akhuJ72wOSncrpNXDAFt+eiUqHB9Stw
         WvRm7GQ0OY0gRwAuC47i1SDXWws4A7gg2RJeCMDbMMFlw9pHoY4qIgQFxKJyXCEbIAkQ
         ItymtT83qDPrD/0yC0+bsWLYACDZeUVETuoPXyruUjk4qOAZj91u99qdxFR0MJ11TXUQ
         GfWa2BCKIZk//ULS1PhuG2n6d2qIpGvu+5hdyuVz11i8uyjjqyI5aRJuKpiNLvCNE29e
         IINA==
X-Gm-Message-State: AO0yUKX5vvlJF27UyKDE2ehgW75ke0MEl2XJV6gk7GeFqQsv6WuKLMBF
        l3aWklFDT3fL/RV7pEA2U5I864ZkXsU=
X-Google-Smtp-Source: AK7set9bEz7AEgK2ccBGjDQgVv5n/PJNp1O2/jW7FcWVUNY/y/pNdLfp2Xrki/eNiHG9wAylE5eiEw==
X-Received: by 2002:a05:6a20:3543:b0:d5:73ad:87c2 with SMTP id f3-20020a056a20354300b000d573ad87c2mr99084pze.56.1679353508422;
        Mon, 20 Mar 2023 16:05:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm7070285pfo.141.2023.03.20.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:05:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Paul Eggert <eggert@cs.ucla.edu>, Eric Wong <e@80x24.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Date:   Mon, 20 Mar 2023 16:05:07 -0700
Message-Id: <20230320230507.3932018-1-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-115-ge25cabbf6b
In-Reply-To: <20230319064353.686226-1-eggert@cs.ucla.edu>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul Eggert <eggert@cs.ucla.edu>

Use gettimeofday instead of time(NULL) to get current time.
This avoids clock skew on glibc 2.31+ on Linux, where in the
first 1 to 2.5 ms of every second, time(NULL) returns a
value that is one less than the tv_sec part of
higher-resolution timestamps such as those returned by
gettimeofday or timespec_get, or those in the file system.
There are similar clock skew problems on AIX and MS-Windows,
which have problems in the first 5 ms of every second.

Without this patch, users can observe Git issuing a
timestamp T+1 before it issues timestamp T, because Git
sometimes uses time(NULL) or time(&t) and sometimes uses
higher-res methods like gettimeofday.  Although strictly
speaking users should tolerate this behavuior because a
superuser can always change the clock back, this is a
quality of implementation issue and users naturally expect
Git to issue timestamps in increasing order unless the
superuser has fiddled with the system clock.

This patch always uses gettimeofday(...) instead of time(...),
and I have verified that the resulting .o files never refer
to the name 'time'.  A trickier patch would change only
those calls for which timestamp monotonicity is user-visible.
Such a patch would require more expertise about Git internals,
though, and would be harder to maintain later.

Another possibility would be to change Git's documentation
to warn users that Git does not always issue timestamps in
increasing order.  However, Git users would likely be either
dismayed by this possibility, or confused by the level of
detail that any such documentation would require.

Yet another possibility would be to fix the Linux kernel so
that the time syscall is consistent with the other timestamp
syscalls.  I suppose this has not been done due to
performance implications.  (Git's use of timestamps is rare
enough that performance is not a significant consideration
for git.)  However, this wouldn't fix Git's problem on older
Linux kernels, or on AIX or MS-Windows.

Signed-off-by: Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This one is closer to v1 than my "how about" illustration, in
   that we use gettimeofday() everywhere, so I kept the authorship
   ident and timestamp from the original.

 git-compat-util.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4f0028ce60..d6fbe9311d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -339,6 +339,25 @@ static inline const char *precompose_string_if_needed(const char *in)
 int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 #endif
 
+#ifdef time
+#undef time
+#endif
+static inline time_t git_time(time_t *tloc)
+{
+	struct timeval tv;
+
+	/*
+	 * Avoid time(NULL), which can disagree with gettimeofday(2)
+	 * and filesystem timestamps.
+	 */
+	gettimeofday(&tv, NULL);
+
+	if (tloc)
+		*tloc = tv.tv_sec;
+	return tv.tv_sec;
+}
+#define time(x) git_time(x)
+
 #ifdef NO_STRUCT_ITIMERVAL
 struct itimerval {
 	struct timeval it_interval;
-- 
2.40.0-115-ge25cabbf6b

