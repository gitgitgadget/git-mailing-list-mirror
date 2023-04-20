Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC944C7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 22:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjDTWrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTWrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 18:47:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BAB26AE
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:47:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so1459715b3a.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682030849; x=1684622849;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0W7gwzaQNHn+jquSiwx8edK97kaQfmhORcl3ynLLXM=;
        b=ZctV5QR/TvLlJBrcT7jvWQ83JwGS1E2sunyO57B29tI+zYzPyqvQSHv72GKpAUb492
         cPDwPkai6E78cCGGjxP71+kvnM5ujQTSlq35RxYzFXs0boL5Wh+MoRywmMqgjY+PqMZJ
         8nVv6LCRvTsRtkd/QuYyB9P+HaghRAsA+GPMIciyvLbXeHkoxQ8HsIm1A65Z1xqge0PC
         9/0UO5DVt5SUaRGVoTqfX+8ylvqXNOuR1dNLBhHkFAvGNDArHnOERIjkcRvN5/K2tkJm
         mByh9yKGAt+D+qxIqI06bQ5yatVQPaUlE8wrdtSeoWDiiwRRWbulqvmEFFuMkTrZJXZn
         wvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030849; x=1684622849;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0W7gwzaQNHn+jquSiwx8edK97kaQfmhORcl3ynLLXM=;
        b=cmstgqoNO4MlQyNjaSgNJLNPr4KoI8uv4y5czC7cLXn5viXuCVAqN6zMGe3GzC86XI
         nPteB3yLBl4oxXs9dgVa4/tGGPXZY0hYQa5mTAuMWrpX9683fZ2Mg1+5xW5J4Srx/IOb
         xdzx7cc7BRlhVK+XpQ7AHGvb5gnWLQvIN/NVHmSB4qPg9rxpaqbg3UFPG9aIk2Yn4Xek
         oAxNzMf1zsUgu570Yi/IU8ELuOAT87Tamw1lWQaSpzqt1vCG9dQOEd96Ly+7PoTDIlhH
         F/uLBxkD7lAPUDdGAEejbAJnGAFeuk41ZFOd0gKnECtI5fZWUD2kOhjZ5JEmorEECUdq
         LjBg==
X-Gm-Message-State: AAQBX9d9Ss2yV8x4X16z4Z0AlWafFPCMh4mtoqPbZvrifsWrDBZkwlkU
        KCYMXOS8UhmczIki1qOyhYkViN2XT3uRaw==
X-Google-Smtp-Source: AKy350bJ7ixetISEwPr0veF6gz/y+0aQ37UkaRYKhVTv82kdX4CSqJ7r4liHXKsgakG0K0BCMBbZzA==
X-Received: by 2002:a05:6a00:1a86:b0:63b:62d1:d868 with SMTP id e6-20020a056a001a8600b0063b62d1d868mr3716257pfv.8.1682030849351;
        Thu, 20 Apr 2023 15:47:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d19-20020a056a0024d300b0063b488f3305sm1715121pfv.155.2023.04.20.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:47:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Koichi Murase <myoga.murase@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Subject: Re: [PATCH] completion: suppress unwanted unescaping of `read`
References: <CAFLRLk9aLXx-j=W++qqiu5-Z0TpqdnyfR35+QA5aMZM=YRZvGQ@mail.gmail.com>
        <20230420223800.1698197-1-myoga.murase@gmail.com>
Date:   Thu, 20 Apr 2023 15:47:28 -0700
In-Reply-To: <20230420223800.1698197-1-myoga.murase@gmail.com> (Koichi
        Murase's message of "Fri, 21 Apr 2023 07:38:00 +0900")
Message-ID: <xmqqjzy6p3wf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Koichi Murase <myoga.murase@gmail.com> writes:

> From: Edwin Kofler <edwin@kofler.dev>
>
> The function `__git_eread`, which reads the first line from the file,
> calls the `read` builtin without passing the flag option `-r`.  When
> the `read` builtin is called without the flag `-r`, it processes the
> backslash escaping in the text that it reads.  For this reason, it is
> generally considered the best practice to always use the `read`
> builtin with flag `-r` unless one intensionally processes the
> backslash escaping.  For the present case in git-prompt.sh, in fact,
> all the occurrences of the calls of `__git_eread` intend to read the
> literal content of the first lines.
>
> To make it read the first line literally, pass the flag `-r` to the
> `read` builtin in the function `__git_eread`.
>
> Signed-off-by: Edwin Kofler <edwin@kofler.dev>
> Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9c10690a22..49dd69bb84 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -298,7 +298,7 @@ __git_ps1_colorize_gitstring ()
>  # variable, in that order.
>  __git_eread ()
>  {
> -	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
> +	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
>  }
>  
>  # see if a cherry-pick or revert is in progress, if the user has committed a

Perfect.  Will queue.  Thanks.
