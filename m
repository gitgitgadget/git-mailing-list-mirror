Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C75C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiKVW0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiKVW0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:26:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92937818D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:26:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b8so11775176edf.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jh/3JWBa2XQOwYBJlO+8K2cA0b320GTvtz1FsaqQF0=;
        b=j3usXv9+hBq8cNtUSUTeRybPjfBY7nWjiAponvIBfbB2aK0nY2SmUl0CorTLk84Zyn
         FSx8jXI0+bSWs4cpLDBBPfD+CqD1eVhMvG7EeO5Qvu0iOACFsxT7Ad/Srl6kg33WBGr8
         /zRNllK5/ZnRMSZQ2ZYm0bdj5uaMz8NHYNcZ4vAJwd1S9onCuHo7O4/g82f0lXsGqrTw
         z1NNiFxJ0HmleHzecWTwGyAfoWmky2O6NBvjU5R6iku/I9KAkPADlh9h1EgMsyX/+9on
         0ifCMicpn/iszRWHfSslq8fsWr498v5fGwfeqjsF2JbXdGv+xN1Ts6jDWNnOrTzc17Uy
         7+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jh/3JWBa2XQOwYBJlO+8K2cA0b320GTvtz1FsaqQF0=;
        b=EVXPHZm5piRogFCItOOm6ltA0agPCu2P91UiXaIzFrcBVpy3/5ufYqWoLLYFp+E1Dk
         1G4LKICiPRU8cV2Z54+xG7D+J3G/tBG08LniJKepWvVSIvzdDjEzbsVSo4LTZrYiSsxf
         UfZjkkWjPmqhDC6+9jGpsxEXjftyBHXxauKrdDX2q5xpjMj4f9UaXTHPzQxuEDUPQ3Bk
         w26ZK1VCdkNZlQ/IQsXL4adJBWpOJ08KW7FMhQFHoLdrcBnA204t1IdK3dLRGUy+c4Xz
         TbdIcFZsEfgDfG8eMt/q0Gqf0e7kXtt4dN9SwCPhL+1V3EU1FtR2U6SrckFTlYBOt22N
         UvsA==
X-Gm-Message-State: ANoB5pmb3rKvPvBknJufoXPU+NJfZag1LTKwk1RXojd+tTSUU0j8sVmf
        cadY0WyxSM35lpFhdx6ttlo=
X-Google-Smtp-Source: AA0mqf5aRiILlMhHVLvC8ZPCVoJ8V9NSWrRgmnDRSkJCfxigwXB90qiz4z4RyLx3l4tgIDC73uVWeQ==
X-Received: by 2002:aa7:d7cc:0:b0:45b:4a4b:478c with SMTP id e12-20020aa7d7cc000000b0045b4a4b478cmr5565686eds.317.1669156005158;
        Tue, 22 Nov 2022 14:26:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709063d5100b007b7b7600d3dsm1694961ejf.88.2022.11.22.14.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:26:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxbj2-000o5u-0V;
        Tue, 22 Nov 2022 23:26:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command
 with `|| true`
Date:   Tue, 22 Nov 2022 23:24:36 +0100
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Message-ID: <221122.86mt8iaamz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Johannes Sixt wrote:

> It is customary to write `A || true` to ignore a potential error exit of
> command A. But when we have a sequence `A && B && C || true && D`, then
> a failure of any of A, B, or C skips to D right away. This is not
> intended here. Turn the command whose failure is to be ignored into a
> compound command to ensure it is the only one that is allowed to fail.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 4c661d4d54..a58522c163 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
> +	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
>  	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
>  	test_tick &&
>  	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&

Any reason not to make this:

	-       grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
	+       sed -ne '/Body/p' <.crlf-message-$branch.txt >.crlf-body-$branch.txt &&

?

We usually use that for "grep when we don't care about the exit
code". But maybe some CRLF concerns in this code don't allow it (I only
tested this on *nix).
