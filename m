Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE30C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDQQ3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQQ3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:29:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C0BF
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:29:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id sj1-20020a17090b2d8100b00247bd1a66d4so695587pjb.5
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748957; x=1684340957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUKN5scbqCSSNiN6DWjkZhngt8p0GdaIrAbaZJZ7KY4=;
        b=TQV7aygDeTaAhSl0I1ZgRPYO6COaTuBBIQ2fhNMDFtkOxVyrKqa6wBkS7nc7tNDfTv
         83KQNr9P3BEs0qs0GDURI+E6BrLs7aowD8VUUSv/p4zvEP09B1BEIyq6m1nOx8lumPiW
         nCRylA3ocmuE5jvvG4UcjoG2FLVetN+4lpsX7eCM4RyUZcQSE/dlxbsNOkrk+LNF2QUn
         zG9PgsApmEiHyPI8ZAcHr5c6fClQZ20s8XrwvH1ppCPoUnniyVPUDSGPmKt97rFUdOgM
         JlXwsV99BxPySvt0PAS/fTLlTbfbYD7jqNT/dd4eEMEnOL233+7RYQ9gcwMhNPCwNA6U
         st/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748957; x=1684340957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUKN5scbqCSSNiN6DWjkZhngt8p0GdaIrAbaZJZ7KY4=;
        b=gtFbpSLmOskFdqqjNDwVpJ6Zoe0jz7lP7FNJ/M57lUJ3Utfs8/PzSge7cdLYfn9gGI
         B8oD3OUxmYnYDB0dLCO6LeLva2Lw3G+aChPax2zJSLR7fyMkLKNcSoOPr78Vd+NdCONM
         Tzg4irkj4Eb6BOOS3TxYoWaCcdfzUTqQ+dhp/cauwo9ZEQO1nbH2OEMnZjq3q6Rw6Bmi
         Hbi4i21rc6gI7JD5AuubSGW4hn/Q1O9JvylqGxEjZL0Ow7k763mCvFpaLvFxnVSrEtng
         EeHpa442yq1MmlZPbrIv59FMdPGbXFmc9Se4s3xmPq/XgPob2nx5qT7TLfE4rm7Ng2gp
         3Jog==
X-Gm-Message-State: AAQBX9cthy5LmCzrk+0rQSzixS/wklZ8WAoaW0a3GX6updrei3VhORMi
        PGalydDOcE07+2LTVNDtqoM=
X-Google-Smtp-Source: AKy350bRfas6HztE9lxcuIHCfZQEf2u4evTUAPwx9VFOc0oB+02LW0nbs260EDlBbKdM+4iyp3JvOg==
X-Received: by 2002:a17:902:ced0:b0:1a6:b1a2:5f21 with SMTP id d16-20020a170902ced000b001a6b1a25f21mr11253207plg.8.1681748957472;
        Mon, 17 Apr 2023 09:29:17 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902849500b001a6f0e81ec9sm1057674plo.95.2023.04.17.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:29:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
Date:   Mon, 17 Apr 2023 09:29:16 -0700
In-Reply-To: <20230416054735.3386065-1-newren@gmail.com> (Elijah Newren's
        message of "Sat, 15 Apr 2023 22:47:35 -0700")
Message-ID: <xmqq5y9uo4kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> 5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04-11)
>> broke connections via git protocol because it removed the inclusion of
>> the default port macro. While some may consider this transport to be
>> deprecated, it still serves some purpose.
>
> In particular the problem is that
>
> 	const char *port = STR(DEFAULT_GIT_PORT);
>
> translates now to
>
> 	const char *port = "DEFAULT_GIT_PORT";
>
> instead of
>
> 	const char *port = "9418";

Wow, that is a bad one.  If people do want "DEFAULT_GIT_PORT", they
would never write STR(DEFAULT_GIT_PORT).  I wonder if we can have a
bit more clever STR() macro that catches this kind of mistake at the
compile time.

If this is worth fixing, the fix would probably be worth protecting
with a test or two, but the networking test with fixed port is not
something we can easily do without a sealed environment, so...

Thanks Michael for catching this.

> I've got a patch that does precisely this that I just submitted as
> part of my follow-on to the en/header-split-cache-h series.  I've included
> that patch below in case Junio wants to advance it faster than the rest of
> that series.

Yeah, burying it in a 24-patch series is a bit unfortunate.


> -- >8 --
> Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from cache.h
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  cache.h    | 21 ---------------------
>  daemon.c   |  1 +
>  protocol.h | 21 +++++++++++++++++++++
>  3 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2f21704da9e..71e2fe74c4f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -39,27 +39,6 @@
>  #define S_DIFFTREE_IFXMIN_NEQ	0x80000000
>  
>  
> -/*
> - * Intensive research over the course of many years has shown that
> - * port 9418 is totally unused by anything else. Or
> - *
> - *	Your search - "port 9418" - did not match any documents.
> - *
> - * as www.google.com puts it.
> - *
> - * This port has been properly assigned for git use by IANA:
> - * git (Assigned-9418) [I06-050728-0001].
> - *
> - *	git  9418/tcp   git pack transfer service
> - *	git  9418/udp   git pack transfer service
> - *
> - * with Linus Torvalds <torvalds@osdl.org> as the point of
> - * contact. September 2005.
> - *
> - * See http://www.iana.org/assignments/port-numbers
> - */
> -#define DEFAULT_GIT_PORT 9418
> -
>  /*
>   * Basic data structures for the directory cache
>   */
> diff --git a/daemon.c b/daemon.c
> index db8a31a6ea2..75c3c064574 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -4,6 +4,7 @@
>  #include "config.h"
>  #include "environment.h"
>  #include "pkt-line.h"
> +#include "protocol.h"
>  #include "run-command.h"
>  #include "setup.h"
>  #include "strbuf.h"
> diff --git a/protocol.h b/protocol.h
> index cef1a4a01c7..de66bf80f84 100644
> --- a/protocol.h
> +++ b/protocol.h
> @@ -1,6 +1,27 @@
>  #ifndef PROTOCOL_H
>  #define PROTOCOL_H
>  
> +/*
> + * Intensive research over the course of many years has shown that
> + * port 9418 is totally unused by anything else. Or
> + *
> + *	Your search - "port 9418" - did not match any documents.
> + *
> + * as www.google.com puts it.
> + *
> + * This port has been properly assigned for git use by IANA:
> + * git (Assigned-9418) [I06-050728-0001].
> + *
> + *	git  9418/tcp   git pack transfer service
> + *	git  9418/udp   git pack transfer service
> + *
> + * with Linus Torvalds <torvalds@osdl.org> as the point of
> + * contact. September 2005.
> + *
> + * See http://www.iana.org/assignments/port-numbers
> + */
> +#define DEFAULT_GIT_PORT 9418
> +
>  enum protocol_version {
>  	protocol_unknown_version = -1,
>  	protocol_v0 = 0,
