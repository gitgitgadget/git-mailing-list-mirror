Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E0C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C96135F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhESByT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhESByS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:54:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1844EC06175F
        for <git@vger.kernel.org>; Tue, 18 May 2021 18:53:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y32so8299183pga.11
        for <git@vger.kernel.org>; Tue, 18 May 2021 18:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lXVA5Tz3Z30BfCHoHLJmbI10+caVi2m2LNFaYoEu1QU=;
        b=WqlMHn38ug5b4fNJ5vnP4ZNQh4GWtJgbtEsOUYECGREBUQEJNfEWmctEzlylPKXAsJ
         M+6vsGhZnkq+WtIsEFNnbEwy/mYsTcDjDMDxSCRhfc6GeIdIU27wC7621rOgRxkAu/DW
         0Lm4cKXU2/7WZKw9FjXDsdNnR14BHukYxKBMQT+pbUYLPSXqu4T/wus+/v3MXDfoUEs/
         1cH41XIHAqcXLIfmhTP8kEjCvoJXOj2N1nl+rLvSgZFbIuKHTxOAEjQm5bcXYeN4lcfR
         AbTa6y1VLVtbKSVD8zTgVe2+7cxs6k0m3qzm/94KBg2A3buYq/uzbsH+CLcXvDmeCDkj
         1QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lXVA5Tz3Z30BfCHoHLJmbI10+caVi2m2LNFaYoEu1QU=;
        b=gEqUxUAdFyUHNUza8pixMNVYKtro1S0Il/dsjhL9UADPhzbHNnkKo79joBpEBFPL50
         VJ3x1Db9GikDv+Ie0j8u3EpGMjoOvgca2jcmtg/zi09mdQKZ3zcvk7I0W2V2icYi3Mpn
         Jp7sTWxHM1acq4xNAhVKpAX5OC2j2Roxl/ZLKQpx9xvB7p0muNeQuApAKFZj74pPj1Kh
         qlMbqvzkmkzVP5qH2drdEmzFal1NlpZ5SYDhKOdesHLCunqxGYsfFbcbjGOt0gpeOlke
         5RvIsF+zWjduQ/duKZEKKRrNEadK1RYBU3vEkGJZUmKboL0d7P+k5Qp1HHKcDUHhrL3/
         Ci/g==
X-Gm-Message-State: AOAM531BXyjmoVNv2a477bXOmrhn4/ES76X7rp324yWWAPFdgD+q3fAm
        kfupsZK5xlWgZYPLQyysQOlsZJJM6XU=
X-Google-Smtp-Source: ABdhPJyR/jfUeG4w+eV0z2R8OQgzQbhvvvxkfOxFyJxWiFSNkN7jQKEeyTgq24Nn/ttGKHRQoPW6mQ==
X-Received: by 2002:aa7:88c8:0:b029:2de:7b37:7d23 with SMTP id k8-20020aa788c80000b02902de7b377d23mr5494839pff.59.1621389179475;
        Tue, 18 May 2021 18:52:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cb54:c639:7bcb:1c32])
        by smtp.gmail.com with ESMTPSA id v24sm10029295pfn.101.2021.05.18.18.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 18:52:58 -0700 (PDT)
Date:   Tue, 18 May 2021 18:52:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] xsize_t: avoid implementation defined behavior when len <
 0
Message-ID: <YKRveGhNqPMjmJs8@google.com>
References: <YKPXVMchtGbwDuue@google.com>
 <xmqqy2cbzeqx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2cbzeqx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xsize_t helper aims to safely convert an off_t to a size_t,
erroring out when a file offset is too large to fit into a memory
address.  It does this by using two casts:

	size_t size = (size_t) len;
	if (len != (off_t) size)
		... error out ...

On a platform with sizeof(size_t) < sizeof(off_t), this check is safe
and correct.  The first cast truncates to a size_t by finding the
remainder modulo SIZE_MAX+1 (see C99 section 6.3.1.3 Signed and
unsigned integers) and the second promotes to an off_t, meaning the
result is true if and only if len is representable as a size_t.

On other platforms, this two-casts strategy still works well (always
succeeds) for len >= 0.  But for len < 0, when the first cast succeeds
and produces SIZE_MAX + 1 + len, the resulting value is too large to
be represented as an off_t, so the second cast produces implementation
defined behavior.  In practice, it is likely to produce a result of
true despite len not being representable as size_t.

Simplify by replacing with a more straightforward check: compare len
to the relevant bounds and then cast it.  (To avoid a -Wsign-compare
warning, after checking that len >= 0, we explicitly convert to a
sufficiently-large unsigned type before comparing to SIZE_MAX.)

In practice, this is not likely to come up since typical callers use
nonnegative len.  Still, it's helpful to handle this case to make the
behavior easy to reason about.

Historical note: the original bounds-checking in 46be82dfd0 (xsize_t:
check whether we lose bits, 2010-07-28) did not produce this
implementation-defined behavior, though it still did not handle
negative offsets.  It was not until 73560c793a (git-compat-util.h:
xsize_t() - avoid -Wsign-compare warnings, 2017-09-21) introduced the
double cast that the implementation-defined behavior was triggered.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -	if (len != (off_t) size)
>> +	if (len < 0 || len > SIZE_MAX)
>>  		die("Cannot handle files this big");
>
> OK, so negative offset or offset that cannot be represented as size_t
> are rejected.  That is much easier to read than the original ;-)
>
> SIZE_MAX is associated with size_t so it presumably is an unsigned
> constant; would it again trigger a sign-compare warning?

Alas, on platforms with sizeof(size_t) == sizeof(off_t), I believe it
does:

	$ gcc --version
	gcc (Debian 10.2.1-6+build2) 10.2.1 20210110
	Copyright (C) 2020 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

	$ cat sign-compare-test.c
	#define X (1U)

	extern int signed_int();

	int main(void)
	{
	  int v = signed_int();
	  return v < 0 || v > X;
	}
	$ gcc -c -Wall -W -Wsign-compare sign-compare-test.c
	sign-compare-test.c: In function ‘main’:
	sign-compare-test.c:8:21: warning: comparison of integer expressions of different signedness: ‘int’ and ‘unsigned int’ [-Wsign-compare]
	    8 |   return v < 0 || v > X;
	      |                     ^

That can be worked around by reintroducing a cast, to an unsigned type
this time, like this.

Thanks,
Jonathan

 git-compat-util.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..fb6e9af76b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -986,11 +986,9 @@ static inline char *xstrdup_or_null(const char *str)
 
 static inline size_t xsize_t(off_t len)
 {
-	size_t size = (size_t) len;
-
-	if (len != (off_t) size)
+	if (len < 0 || (uintmax_t) len > SIZE_MAX)
 		die("Cannot handle files this big");
-	return size;
+	return (size_t) len;
 }
 
 __attribute__((format (printf, 3, 4)))
-- 
2.31.1.818.g46aad6cb9e

