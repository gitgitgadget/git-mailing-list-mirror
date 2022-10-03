Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE6C4332F
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJCQNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJCQNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:13:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F131ED4
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:13:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 129so10061744pgc.5
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQFaDKrdUsUOmtnBIuB2jNCVxauFtatTAdj65hbfzPw=;
        b=KrCtyYVyWpc5Rsr464IkZNg3+C6Z8Vpr1mWjuVCQsiYEEYJrWUplTjpwLIRCd/aNst
         K4OXc4seAqBxe8G03h0QFpD6HwgLndpTIrvI8+UJB9JZ3FUZV1TDqJaZR30EXq9C2oIU
         jGEC9EPSm5yPGRQiAiXk7iRpFLevCVYmA3rtUAd4MUUcINSLBiLPS3tzJo3c3O2sgt6+
         atVa8X0yvwzczsjTkMQibKYide/+yNmp3MgWFOMuOcOI+EQhhCbBnXivvAnfSj6DnKaa
         a1v5cmPVN5xH7D+vz0wPGeYyU0qkiAnJAM+B9QXtc6NNDVhCg2f0Hf0vSc/OC9UDZh6t
         QO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQFaDKrdUsUOmtnBIuB2jNCVxauFtatTAdj65hbfzPw=;
        b=DLlNCnYunLxtqJKdS9bDw19xwmdv0nOehPQ66NdcrbvrjPSiR4gsgx3OaA9Pv/6TJ1
         WxuXkHOckYsbJB/tVILsIFCCNVppq7qYMDgOPozJR1wuprcDLsRXDXz1xAKKCsMnsi78
         /Lj01tjcOum65zsHnUZPPmmY8IMTzTLvxDWOF/2JykqVJYruNaihIbw7utGJtCarmydU
         dFkxHU4pICd0Zqu8rD+WaKFWoX3yaashzGiMrnfpTo9oDol8QmDW42wN/ab1x1yW20Ue
         TMIhQsvTDo/qVaLAv9GW1FnANPURjdogc6T7hd5KdpvI9cdboGnKHIB8VdkdSCN/yTS+
         bnoA==
X-Gm-Message-State: ACrzQf3SZjnphZntkVS5U6AALlhYOudl0WO0ypUeux3OOfr64dqJbJ+o
        dwvooyofJJdJpICpFj2sSlY=
X-Google-Smtp-Source: AMsMyM7cjsHwKL9EjwsjSeao8pUoYQjZUOQaAFFklW0MvGj3EweeJApKqm9Lr+XMbRL71bAAENmRVw==
X-Received: by 2002:a05:6a00:1412:b0:557:d887:2025 with SMTP id l18-20020a056a00141200b00557d8872025mr23010570pfu.39.1664813617071;
        Mon, 03 Oct 2022 09:13:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0017d12d86901sm5805968plh.187.2022.10.03.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:13:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] ssh signing: return an error when signature cannot be read
References: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
Date:   Mon, 03 Oct 2022 09:13:36 -0700
In-Reply-To: <pull.1371.git.1664789075343.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Mon, 03 Oct 2022 09:24:35 +0000")
Message-ID: <xmqq1qroyjf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the signature file cannot be read we print an error message but do
> not return an error to the caller. In practice it seems unlikely that
> the file would be unreadable if the call to ssh-keygen succeeds. If we
> cannot read the file it may be missing so ignore any errors from
> unlink() when we try to remove it.

OK.  Not removing may help diagnose what the problem is, but going
that route needs to add code to report what file is deliberately
left for inspection.  I do not know how valuable that would be to
help human debuggers --- the user presumably have the original
material (e.g. a signed tag object) anyway, and the human debugger
probably needs to have access to both the original material and what
is fed to the gpg-interface API.  If they are chasing a reproducible
bug, the latter should be recreatable by the human debugger from the
former, so removing would not hurt the debuggability that much.

On the other hand, we can still report if the reason we cannot
remove is not ENOENT, though.

Thanks.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     ssh signing: return an error when signature cannot be read
>     
>     This patch is based on maint. In the longer term the code could be
>     simplified by using pipes rather than tempfiles as we do for gpg.
>     ssh-keygen has supported reading the data to be signed from stdin and
>     writing the signature to stdout since it introduced signing.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1371%2Fphillipwood%2Fssh-signing-return-error-on-missing-signature-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1371/phillipwood/ssh-signing-return-error-on-missing-signature-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1371
>
>  gpg-interface.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 947b58ad4da..d352bc286b6 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -1043,9 +1043,11 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
>  	strbuf_addstr(&ssh_signature_filename, ".sig");
>  	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
> -		error_errno(
> +		ret = error_errno(
>  			_("failed reading ssh signing data buffer from '%s'"),
>  			ssh_signature_filename.buf);
> +		unlink(ssh_signature_filename.buf);
> +		goto out;
>  	}
>  	unlink_or_warn(ssh_signature_filename.buf);
>  
>
> base-commit: a0feb8611d4c0b2b5d954efe4e98207f62223436
