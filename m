Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C51C77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDQQeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQQd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:33:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1033102
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:33:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hg12so11698657pjb.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681749238; x=1684341238;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9zWAx1wSuelXpxRzuk6EzafkvlzkvQpNeqmVLpZur4=;
        b=aUOaRImKeAySpP7E4gRp2M+QNZeIaTVAc28LtVE2BP02nrQL0z+fKRnj1S4/hUcrhR
         orKSgK1403vMkZZ1wYI/KEvArUPqYJtJCSundU4YbIfOxYcjk2x9Rp3kmzBa+9XcWPf/
         usJWvbisYHa8aTEIm3LQLRYs0OJsYro3QdO1qA8No9VXkFikrLP51hSxlg0DPpcTupin
         N0jQRK8vEYOeF9V5SPftpub7ZtzVl0qlqUH2dV+Vf0VRPY8ZVDnluVppT5eUBRMHVUHH
         TftO0CJIc7FqXfZmiaY706FaCQHeXMZIFMcgdFDKF2WVHZp4X8g7IcMQzm3j+eHBBBP1
         Tbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681749238; x=1684341238;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X9zWAx1wSuelXpxRzuk6EzafkvlzkvQpNeqmVLpZur4=;
        b=YzY6P9Evmspf0TNLUX1bMtg+g7DzjAcY6t74MpjTiRqG/4c8rWclSkl9pd1pB8mMsz
         qGAPZ3lpZRtxgK8AvSQJN94Rbkv1jow05fc1toAboqJ28JOQC5BYte3iFoNoWWOWAktK
         33oVzcJMiUH5BYYS6qCze8DDeyBFtn5gkMd4rZpUOC72DQ787WjZgpblacz5oG/x6AA7
         BDWJkPUOEAjcPynHfm5QvYruRfbUczzNmM2ptVDYwRbTPpZrNLcabtIcN6HUaP6yGi2M
         9RZ+Yp2k2+9GMr+V2OXyMn3bDIqn2J/b8ZU7RHEY1bJOjQ4Ntshd/y6nGzVeuie4yESi
         dwcw==
X-Gm-Message-State: AAQBX9csM//opl3RCn7xNOu2h6+bzHyhstpb+K30RInsZQw+oxjO5u4g
        oQ+kSuvhBjbYdPc6JQzNhpQDmxBZ09I=
X-Google-Smtp-Source: AKy350Y2ioPlIvtZTFG5xN1oKaU/ot9Bg35DtfuYM+gtFnSvRrKFIM/nrwbqEzKp0ChxFwG5/2Ix9g==
X-Received: by 2002:a17:902:dac2:b0:1a6:3af1:9c3a with SMTP id q2-20020a170902dac200b001a63af19c3amr15502702plx.22.1681749238091;
        Mon, 17 Apr 2023 09:33:58 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b002473c9c8d92sm5375368pjb.44.2023.04.17.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:33:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
        <20230417073827.GA39931@coredump.intra.peff.net>
Date:   Mon, 17 Apr 2023 09:33:57 -0700
In-Reply-To: <20230417073827.GA39931@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 17 Apr 2023 03:38:27 -0400")
Message-ID: <xmqq1qkio4cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The preprocessor doesn't know that we'll be confused if "s" isn't
> resolved, and by the time the compiler sees it, it's a string already.
>
> Obviously we could add a test that catches this at run-time, but we
> should be able to do better (catch it earlier, and with less code).

Ah, great minds think alike.  I am glad you have already thought it
through.

> My first thought was: why can't we just treat the port as an "int" in
> the first place? The answer is mostly that getaddrinfo() expects it as a
> string. It could even be a non-numeric service like "http" in theory
> (and looked up in /etc/services; Debian's even has "git" in it!), but
> our get_host_and_port() refuses to allow that. But even if we didn't
> want to ever support non-numeric service names, it makes the code more
> awkward (we have to format the port into an extra buffer).
>
> This would work:
>
> diff --git a/connect.c b/connect.c
> index fd3179e545..1eba71e34c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -753,7 +753,7 @@ static char *host_end(char **hoststart, int removebrackets)
>  }
>  
>  #define STR_(s)	# s
> -#define STR(s)	STR_(s)
> +#define STR(s) (STR_(s) + BUILD_ASSERT_OR_ZERO(s))

OOoooh.  Clever.  A pointer plus N indexes into an array, but if the
offset is N then the pointer is left intact so the caller does not
see the difference.

> ... But the
> BUILD_ASSERT doesn't seem too bad to me.

Indeed.
