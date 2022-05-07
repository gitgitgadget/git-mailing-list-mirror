Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EDC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 05:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiEGFol (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445662AbiEGFoG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 01:44:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E22C2
        for <git@vger.kernel.org>; Fri,  6 May 2022 22:40:20 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so6291537ots.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f7rGj+UkwVXXJNLAqxRopp32EFqacraWaPXbS+Bh888=;
        b=C17t1qoyf23ymio2KMejOOPa8i9/J8mT19TxtLYqb8lJPrBfW6S7E/xOLOxtEdPbNV
         5XDiXJHp52aAyaeHKBnleCtZiJuAfLbeQIym8+/Zo6ciz9IGcb4wKPoh7/6NZkH3DolB
         OnTTFgjGhf6Oij49SQPmhymVn/L+m8gRuj3mHoRmt8C8a2hgKgatDrKwvD48SxGSeXdc
         DYidl4EgMl+mp7M/bkcnwl3TYMdp2xVUDONFhw8TAWUvVbDcjvxioZpcrt4x7qP0S6h8
         DpB3A4tF6Ib3GHLeNV95H2A/+qvaY7vbh3uDKi2CV6Dx4AyvHmk+voJf61TgdeeGPCOO
         P5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f7rGj+UkwVXXJNLAqxRopp32EFqacraWaPXbS+Bh888=;
        b=7bqOTpop5jQ/FXIWL9SSbtOJQ7Rc8HEBp02avtZaStZkpwLgvf3a+27661f1YN43PK
         k0ovc3com5179cbGfHbyrHksg5Ftb8wLnERAErga1Twg7Wt9ZtPz7MpZfWKfS42H6A9k
         SUUJN0psuGIlI77zmd73YmtLYN+LQh1lCf/dqjyHqJ8tKSW4qTY5E7dGaU311yBww1X/
         V4dQbQ1jlAQFUvFYuE24dyd0Vd9DlAEFI0OFLUejLE4v8mNOo5Xkqa03SKQsoajMM03q
         YjSW4JDP0PYKzrnkMcuApJ38lKnCr0/xne7NvGsW6cA2cp9HziIYF0caZ4N8vaAFdDD6
         I+RQ==
X-Gm-Message-State: AOAM532CTDWj1aJz8gmoRdNQwC9yWR88ExhWfa/hp12XnDRxhoO/Q1nQ
        PrFtegdeHPDyaHH4iaXaOgjQF4dUarc=
X-Google-Smtp-Source: ABdhPJykZvLB4vnnE0rNvBi4+P7t5SohGSXF9377PyZSPKZWyxohFt/D9LMpd8jGT8CwV6D6rRNKxg==
X-Received: by 2002:a05:6830:1491:b0:606:103c:6680 with SMTP id s17-20020a056830149100b00606103c6680mr2244406otq.18.1651902019652;
        Fri, 06 May 2022 22:40:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f3-20020a9d7b43000000b00605da994088sm2404281oto.2.2022.05.06.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 22:40:19 -0700 (PDT)
Date:   Fri, 6 May 2022 22:40:17 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
Message-ID: <20220507054017.fnvb6xisr6s7m2l5@carlos-mbp.lan>
References: <cover.1651859773.git.git@grubix.eu>
 <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
 <xmqqtua2jtr0.fsf@gitster.g>
 <xmqqczgqjr8y.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqczgqjr8y.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 02:17:01PM -0700, Junio C Hamano wrote:
> diff --git a/http.c b/http.c
> index 229da4d148..85437b1980 100644
> --- a/http.c
> +++ b/http.c
> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +
> +	if (slot->finished == &finished)
> +		slot->finished = NULL;

I am not completely sure yet (since I looked at it long ago and got
sidetracked) but I think this might be optimized out (at least by gcc12)
since it is technically UB, which is why it never "fixed" the warning.

the "correct" way to implement this would be to make "finished" a thread
local static, which is finally one good reason to support C99, but the
syntax to do so with Windows broke my first attempt at doing so and now
I can even find the code I used then which required a per platform macro
and was better looking than the following

Carlo
--- >8 ----
Date: Wed, 20 Apr 2022 23:25:55 -0700
Subject: [PATCH] http: avoid using out of scope pointers

baa7b67d091 (HTTP slot reuse fixes, 2006-03-10) introduces a way
to notify a curl thread that its slot is finished by using a pointer
to a stack variable from run_active_slot(), but then gcc 12 was
released and started rightfully to complain about it (-Wdangling-pointer).

Use instead a thread storage static variable which is safe to use
between threads since C99 and doesn't go out of scope, while being
functionally equivalent to the original code, and also remove the
workaround from 9c539d1027d (config.mak.dev: alternative workaround
to gcc 12 warning in http.c, 2022-04-15)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 1 -
 http.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.mak.dev b/config.mak.dev
index c3104f400b..335efd4620 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -68,7 +68,6 @@ endif
 # https://bugzilla.redhat.com/show_bug.cgi?id=2075786
 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-error=stringop-overread
-DEVELOPER_CFLAGS += -Wno-error=dangling-pointer
 endif
 
 GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
diff --git a/http.c b/http.c
index 229da4d148..cb9acfca19 100644
--- a/http.c
+++ b/http.c
@@ -1327,7 +1327,7 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished = 0;
+	static __thread int finished;
 
 	slot->finished = &finished;
 	while (!finished) {
-- 
2.36.0.352.g0cd7feaf86f
