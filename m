Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC479C7EE43
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjFLTbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbjFLTau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 15:30:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA11BDC
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:30:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3b974fffeso14801745ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686598245; x=1689190245;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdgJJPp4JSTC/fITQ12s9Ldh15G5tLlB0Y9pxKOhwRM=;
        b=gkKn9Ju8l6nk8qJrrPmkunUiIQZDJWpI9o7YdCNu87rJ2aWqdUbLS83ogW5kAY9iaA
         DQRJC/kRA5Tfj2XJa/XLFK9QMGzXpf13qzAaakkhoAuH8EgVaJmPteRE3U3QMtl4Of6i
         CFDQUy5SOMmvEdG1dsA/2IdrD5teOrFDpsnfUuk95o//qiKqtGARFZuAjs9OKr83JCfm
         Y1Q8YJ7LoF3aX3FEPXShbKucT1daBO1yuM/NSOXFVMoRjUIndc4sbLXCFOhdfE6niEuv
         vnbfSw4cSpBDPsIijwDEFXaasH+8TKSwMkd50lJALydPcYQEDPLBNVGBId1mvVcoVnw9
         gr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686598245; x=1689190245;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdgJJPp4JSTC/fITQ12s9Ldh15G5tLlB0Y9pxKOhwRM=;
        b=eldPiNM2SGHXxRCcgtZ8CNk5YbjEsoFg7NNSYCC3u8jKiyGrEcoYXfXQb+kywMKnm7
         1p0GxXisVX43uvoqPyR4UlZm6tA+BfHfXDeagNDyoqapEjGZKaYyukZLXEkVWiRBPGKg
         dtIZo/+qLaMVJVprc0RJ5jH8+zKy9quwODbe7QjyxfCr24ugR9nGwLxPZryZbm6HjHPY
         LxGU8AOhTrv/s7znu8xDiXKjxOjke9X7XHho36J++/JZmszRiqn1dmZz2lFyG03UaAPY
         ZjDV6K3wWVh15zDbeT1EBajMXTd41LFhRSXla3chot5QyxCB/2rScMT+iyDXV6X3ifhV
         rvqw==
X-Gm-Message-State: AC+VfDyKG+UWGzgApW1waNSZBJ9GFq2Oy9NzL1G+ZJnyg/SxKwDo1vWX
        Owf8UlDLgcOak0NbOBJAHTw=
X-Google-Smtp-Source: ACHHUZ7qA3x3Y8T2RzlDxcPbyFL46GLIVtO8ie4YM1bRYDfOzQmmHH2ieZtBwbhED/VCLxNEXUnuCA==
X-Received: by 2002:a17:902:b714:b0:1b1:9218:6bf9 with SMTP id d20-20020a170902b71400b001b192186bf9mr7177649pls.43.1686598244771;
        Mon, 12 Jun 2023 12:30:44 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001a6d4ea7301sm8583049plc.251.2023.06.12.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:30:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Use lowercase includes for some Windows headers
References: <20230604211934.1365289-1-mh@glandium.org>
Date:   Mon, 12 Jun 2023 12:30:43 -0700
In-Reply-To: <20230604211934.1365289-1-mh@glandium.org> (Mike Hommey's message
        of "Mon, 5 Jun 2023 06:19:34 +0900")
Message-ID: <xmqqmt14a36k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> When cross-compiling with the mingw toolchain on a system with a case
> sensitive filesystem, the mixed case (which is technically correct as
> per the contents of MS Visual C++) doesn't work (the corresponding mingw
> headers are all lowercase for some reason).
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  compat/win32/trace2_win32_process_info.c | 4 ++--
>  wrapper.c                                | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I can guess that this will not break the primary target audience of
the source, who build from the source on case insensitive
filesystems.  The only possible breakage I can think of is if
different versions of mingw toolchain have these header files in
different cases---those who have been happily using header files
like <tlHelp32.h> on their case sensitive filesystem now will find
their build to fail.  Theoretically, those who _corrected_ their
header files to mixed case themselves (as it is "technically correct
as per the contents of MS Visual C++") will be broken the same way,
but they should be capable of diagnosing and recovering from such a
breakage, so I'm not worried about that.

Appreciate input from those who builds with mingw toolchain, but in
the meantime let me queue it on 'seen' so that we won't forget.

Thanks.





> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
> index a4e33768f4..438af8f818 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -3,8 +3,8 @@
>  #include "../../repository.h"
>  #include "../../trace2.h"
>  #include "lazyload.h"
> -#include <Psapi.h>
> -#include <tlHelp32.h>
> +#include <psapi.h>
> +#include <tlhelp32.h>
>  
>  /*
>   * An arbitrarily chosen value to limit the size of the ancestor
> diff --git a/wrapper.c b/wrapper.c
> index 67f5f5dbe1..5dc48e815a 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -17,7 +17,7 @@ static intmax_t count_fsync_hardware_flush;
>  #ifdef HAVE_RTLGENRANDOM
>  /* This is required to get access to RtlGenRandom. */
>  #define SystemFunction036 NTAPI SystemFunction036
> -#include <NTSecAPI.h>
> +#include <ntsecapi.h>
>  #undef SystemFunction036
>  #endif
