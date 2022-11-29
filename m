Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FC0C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 05:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiK2FLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 00:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiK2FLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 00:11:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F94D5CA
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:11:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so20749434lfi.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uqduv/YowPXLGKUNU0aJeRlwVpM4i7GIyhzTb5IK0=;
        b=HAo/RB8pu+PyJ+9RrRSKUfdLNIVoU0fN5hpbYe+a/1/Gx8015idLuGpilghWLD7a9/
         wFmoFTUnVafRhVqyEVIhotMH0ZZheVJdXieI5zbjfA5xyEoI4FX9ZLEIOpwZo/7czifO
         FDKkDOkw4yQCsFB8IgVG2wlgFR2Ov1nfaIBbeMkjSqzQdxEx1gHDD1AbytsPaX99I9UC
         QJZNL2DRki8MdY1txausDoOjqqTJ77WFeDqa5eE4zSpubO/nDUDZtYqyqh/R2oEENyK1
         H42c333PTlWZyf8i43+/Us1n/tOCGXZS01KeCqQqwyb+auT3olfSuhodEgJ/hC1zzAy0
         rMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3Uqduv/YowPXLGKUNU0aJeRlwVpM4i7GIyhzTb5IK0=;
        b=y7A6xgSKyikz/pP/pJKwqtuDQ9INt4IU/yDxo4iHcxvPoKEbRaQZYmrN+ivu/SsVWU
         IbmJLOTZWTCleeO/CaQj1rYpGxL/aMcLLcGHf4DQml+W7QC7gYcy689Q7XN3UQZB9lUn
         5sj5jrcjStvR2qLNLWDcy1/M1MMCOoyjVYUOZ+FQg8QfmTrcnMn/CzVIs6a6fJeIYQOK
         4S8QdydC2ZR6nD1x0xau4wSYk7pa0zMp4zX/P/jPMLzbD4/9AbWIn/qX0fjC4pMPassK
         KS7oMIyBRwvf+aMFIoRO3qZ50FUtLU9r1PktfREy4qTO3gsvJy7klVwb14tzTbucBgXe
         A7WA==
X-Gm-Message-State: ANoB5pl2nSURZ6ZdCbK8Jq2sawobe+E5kz/0ERrSMJ4uJrUCFeR0D8up
        VSdTB4jEHH/giC9S+63Yn5kzXU+kYlnr0iYi890=
X-Google-Smtp-Source: AA0mqf7Yp+ofvR8sTdx4Qc+M3oWRVw4jajAb6JTsPzq0XOYzMGJpG3d1Jq8mqFqHlF+4aevtHZeOw4+2/+47wZVp2Tg=
X-Received: by 2002:a05:6512:1681:b0:4a2:683d:3ba4 with SMTP id
 bu1-20020a056512168100b004a2683d3ba4mr21498441lfb.238.1669698680358; Mon, 28
 Nov 2022 21:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-2-calvinwan@google.com>
In-Reply-To: <20221108184200.2813458-2-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Nov 2022 21:11:07 -0800
Message-ID: <CABPp-BE7jNcNvF50rqJdSBr2ptwsicUwqtcjZcAV=YDKjNB-vA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2022 at 11:11 AM Calvin Wan <calvinwan@google.com> wrote:
>
> Add duplicate_output_fn as an optionally set function in
> run_process_parallel_opts. If set, output from each child process is
> copied and passed to the callback function whenever output from the
> child process is buffered to allow for separate parsing.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
[...]
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3ecb830f4a..40dd329e02 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
>         return 0;
>  }
>
> +static void duplicate_output(struct strbuf *process_out,
> +                       struct strbuf *out,
> +                       void *pp_cb,
> +                       void *pp_task_cb)

Should the last two parameters have an "UNUSED" annotation?
