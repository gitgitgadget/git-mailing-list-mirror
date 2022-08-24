Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02CC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 18:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiHXS44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiHXS4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 14:56:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437087C1D7
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:56:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso2434481pjd.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=aV01swQ01+3azCIPw/GSGTBdkrT/nvUqMCW0Z8HTMYw=;
        b=L9HdrRarOMheg9GMkV/rZCgEiun00bfwLqxwcawlxB8pEQ2mirMkX2r4hDFWYfSoCk
         VebOXnuBBr8VwYmWyVq0bfRr4siBTl0O8SXfGDSqlBQw6I8krWLlFLjo5aURiv6G2eEb
         P1yQOB3Afaz3t4lvyUipnsUECir7Si8oGcKZhC3kQCdvkPvKznU0wCDYno4FjUtQFO+P
         bbIJeINMsiviYAOzl/U7fiekx7kxZnMeDXGEp4H2C8SPcMqq2t38hs00JJdEDePSytNy
         nC6ybBBie17Lg+K+IBNHps4KlY/2RR3zrxURFy2gAWM1c+Punx3oNsRQ9zxhRnIFvtYh
         YEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=aV01swQ01+3azCIPw/GSGTBdkrT/nvUqMCW0Z8HTMYw=;
        b=icIdUCjfWf9iHZKDK1Ku1947nbnqE6jOkmQDOq1QKAJNfpTNNNmLp4IHD8Jrj01kKz
         cY9KLgJz3to/Us3TBwYmIJffvv/vLSkeUzLS9f+6Z6r948QfuZMe+akMkv2P6ktWOb+P
         rjALgNnn1/a5jxdjiWRr3t4ePxDQ5D4x33rUdyp8NiL/lQek9e4YQiqmWLzcNDrdhq1b
         1ZSc0gT0ZUhg2Vt7DviV4iFwPBqCWGJ7rB7nW/HMfSla0V4R8kv9QDl8w/KAGnIn8SFj
         Z0GDlIryy+4HkYTfx6jRcmwxPi5MCTWIoEL+FnVrUCzrjAXB+c4BrfjNlrO7geNOVxSB
         BiqQ==
X-Gm-Message-State: ACgBeo1KVYkV6rD46yXspx2z7/+p+9Y84g9L07pzqLFzxaBg+5QHRd7G
        ViFBIZAF24QUVfvzY72Pceg/BCLSOp0=
X-Google-Smtp-Source: AA6agR6beA0/GN9Yreh3rqV0nRWzaOk9iP9URPzlDT13l3ezdYPdKjjko9Xbq2AhiFZyij735cMDPg==
X-Received: by 2002:a17:902:d2c1:b0:16e:ea4e:36d3 with SMTP id n1-20020a170902d2c100b0016eea4e36d3mr376659plc.98.1661367412661;
        Wed, 24 Aug 2022 11:56:52 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm12700046plt.297.2022.08.24.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:56:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Diomidis Spinellis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Diomidis Spinellis <dds@aueb.gr>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] grep: fix multibyte regex handling under macOS
References: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
        <pull.1313.v2.git.git.1661289990205.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 11:56:51 -0700
In-Reply-To: <pull.1313.v2.git.git.1661289990205.gitgitgadget@gmail.com>
        (Diomidis Spinellis via GitGitGadget's message of "Tue, 23 Aug 2022
        21:26:30 +0000")
Message-ID: <xmqq5yih79n0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Diomidis Spinellis via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Diomidis Spinellis <dds@aueb.gr>
>
> The 2013 commit 29de20504e9 fixed t0070-fundamental.sh under Darwin
> (macOS) by adopting Git's regex library.  However, this library is
> compiled with NO_MBSUPPORT, which causes git-grep to work incorrectly
> on multibyte (e.g. UTF-8) files.  Current macOS versions pass
> t0070-fundamental.sh with the native macOS regex library, which
> also supports multibyte characters.

Very nice to see the last sentence in that paragraph.

> Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
> ---

This part, from here ...

>     grep: fix multibyte regex handling under macOS
>     
>     The 2013 commit 29de20504e9 fixed t0070-fundamental.sh under Darwin
>     (macOS) by adopting Git's regex library. However, this library is
>     compiled with NO_MBSUPPORT, which causes git-grep to work incorrectly on
>     multibyte (e.g. UTF-8) files. Current macOS versions pass
>     t0070-fundamental.sh with the native macOS regex library, which also
>     supports multibyte characters.
>     
>     Adjust the Makefile to use the native regex library, and call
>     setlocale(3) to set CTYPE according to the user's preference. The
>     setlocale(3) call is required on all platforms, but in platforms
>     supporting gettext(3), setlocale(3) is called as a side-effect of
>     initializing gettext(3).
>     
>     To avoid running the new tests on platforms still using the
>     compatibility library, which is compiled without multibyte support,
>     store the corresponding NO_REGEX setting in the GIT-BUILD-OPTIONS file.
>     This makes it available to the test scripts. In addition, adjust the
>     test-tool regex command to work with multibyte regexes to further test a
>     platform's support for them.
>     
>     Signed-off-by: Diomidis Spinellis dds@aueb.gr

... up to here does not need a separate sign-off.  It is primarily
to describe what got changed between v1 and this version.  The
changes can be seen in range-diff, and in some cases what the
range-diff shows is sufficient to understand the difference, but it
is better to either (1) supply explanation in your own words, or (2)
omit almost duplicate description.

> diff --git a/Makefile b/Makefile
> index 04d0fd1fe60..d1a98257150 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1427,7 +1427,6 @@ ifeq ($(uname_S),Darwin)
>  		APPLE_COMMON_CRYPTO = YesPlease
>  		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>  	endif
> -	NO_REGEX = YesPlease
>  	PTHREAD_LIBS =
>  endif

I notice that this is the ONLY conditional section in our primary
Makefile that switches upon the value of $(uname_<anything>).  After
the dust settles, we should move this whole part to config.mak.uname
as an unrelated clean-up.

Alternatively, you can choose to do that (without losing NO_REGEX)
as a preliminary clean-up patch and then build this "recent Darwin
has usable regexp library" change on top of it.  I do not have a
preference either way, other than that we do not want to see that
done as part of this change "while we are at it".

> diff --git a/grep.c b/grep.c
> index 82eb7da1022..c31657c3da3 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -10,6 +10,8 @@
>  #include "quote.h"
>  #include "help.h"
>  
> +#include <locale.h>

Don't ever include system headers in generic *.c files.  The system
headers on different platforms have subtle ordering restrictions
among include files and definitions of feature test macros, and all
those subtleties are supposed to be handled in one central place, in
the "git-compat-util.h" file.

A source file specific only to a particular platform is a different
matter; they can include system headers that exist or are needed
only on those systems directly.

So far, "grep.c" has been successfully used for everybody (except
Darwin), and if it needs touching, that means something is still
wrong with Darwin.

Is is because you are not using gettext()?  I thought our
gettext.[ch] did consider some folks/platforms do not use system
gettext() but perhaps its support for such build environment is
slightly lacking and does not make necessary setlocale() calls.

If that is why you are mucking with this file, the right place to
add changes like this is not here specific to grep.c, but to the
start-up sequence that happens before cmd_main() inside
common-main.c or somewhere around there, I think.  Let me summon the
author of 5e9637c6 (i18n: add infrastructure for translating Git
with gettext, 2011-11-18) by Cc'ing.
