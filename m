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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAF0C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 09:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119D160F12
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 09:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhIXJPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbhIXJPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 05:15:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88434C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 02:14:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b65so26901300qkc.13
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7uB1l/ZGzDM5Wr0ArS24Ht6xbADzHev+lMzj7PGik8w=;
        b=eV11Btzgq2dEFRCvoCXNnTjTRL4F4rpj5BboS3QyO7CsLk4notADUkH3EsznI5wK8h
         ZPU1MlgQKH6Vow7nqdU86eCF1Bzzej0LxCCtBkk5eJFw0Z2uO8GYuLBcxTS9tAziZmUG
         d55xEqh5Etf5DarxgXvicPs49ukvP/HjG+IbdnevXD1B9Nf5ug+CqsGWm1JMXzvyA8/t
         RlON6wJNSS5EG3heVPq7AowmZEHAtIu7kVZ0FxbAhkpvEkuGUMLLwHtitQXtsQlFsin0
         Qvv+rSWq2n7wo23GMEfCRuiKHOO+SRYFBiI9qiv8ZWLA3ccT5hnBMeKhG41rNszTKt9r
         fNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7uB1l/ZGzDM5Wr0ArS24Ht6xbADzHev+lMzj7PGik8w=;
        b=Cg2VnblrtExge315n2CfUBJXKfvfIQFLCm67cnh49Kzdv71xaAF37BQaty5S2Snc8b
         9EBg4MUPmMc6b0BP04fYQ/iLj1nV+i57OcWRiHo7wxmvJmHCTpp/6FVpuhHrJ0BqYHvy
         Zl126XmOiFdOBkOFzuUR4+TO8m1Un9OxD+Hs6AB8RMOqNPXSckinAPNxmj3muv2bCb2c
         rpcPzzsMkTa3tRs/Rhzqml9b/JlVk4xaoU6eWNGh3L8hxGWPCwksMa4NIWsSUYlQyfJt
         E/tPmjUdZ4TDrqhtqN1VjzRAQLEOvazpjBNUACKqf7LS55fxWUPIL5TM3FGXlL3kywH+
         nyVQ==
X-Gm-Message-State: AOAM532NVjEYz1vvlTkrWWNV+51nv3coskb/jXMxRfb4XfRIJhxLTT78
        WhwgkMEGIynDmHVGdMOTVxq2rGpVvn8=
X-Google-Smtp-Source: ABdhPJwFp3qRfHH73yiMnWjbnrnpQlDGfpoXhoBi392vFfJH0sR+QrSrt4xUIzel7cJ5ZRapY+vQhA==
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr9342326qky.207.1632474845533;
        Fri, 24 Sep 2021 02:14:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b65sm6129616qkc.46.2021.09.24.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:14:05 -0700 (PDT)
Date:   Fri, 24 Sep 2021 02:14:03 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: js/win-lazyload-buildfix (was Re: What's cooking in git.git (Sep
 2021, #07; Thu, 23))
Message-ID: <YU2W24RUaN4OHrcn@carlos-mbp.lan>
References: <xmqqa6k2yj1j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa6k2yj1j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 04:22:00PM -0700, Junio C Hamano wrote:
> 
> * js/win-lazyload-buildfix (2021-09-23) 2 commits
>  - lazyload.h: use an even more generic function pointer than FARPROC
>  - lazyload.h: fix warnings about mismatching function pointer types
> 
>  Compilation fix.
> 
>  Will merge to 'next'.

Sorry to hijack this thread with this minor point, but I was hoping[1]
from a reroll of this topic from Hannes.

Alternatively the patch below the scissors would be nice to squash or
it will be harder to fix later.

Carlo

CC: +Hannes
[1] https://lore.kernel.org/git/CAPUEspivB=07OponiMrfXFBrC+L7qjSUuZEV9q-Ug5Z_ShnFNA@mail.gmail.com/
----- >8 -----
Subject: [PATCH] fixup! lazyload.h: fix warnings about mismatching function
 pointer types

The original patch will require the declaration this macro creates
to be moved to the end of the local variables or will trigger
-Wdeclaration-after-statement because it will likely end in ";;" if
the macro call has one, as it is common.

Remove trailing ';' from macro definition, for easy of use.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/win32/lazyload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index c688e545ad..2b3637135f 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -29,7 +29,7 @@ struct proc_addr {
 	static struct proc_addr proc_addr_##function = \
 	{ #dll, #function, NULL, 0 }; \
 	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
-	static proc_type_##function function;
+	static proc_type_##function function
 
 /*
  * Loads a function from a DLL (once-only).
-- 
2.33.0.955.gee03ddbf0e

