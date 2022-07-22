Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04598C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiGVXmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVXmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:42:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004BB5572
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:42:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so7480323edd.6
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMnSK8ntPAmxAXQrdAy+wSqCLC92+9Em6yrq5Q1pjBI=;
        b=Q0WHjg1yzmW/PBWqtB88ST5PFG1ujGPcUljpxglWJxo0PlTXpwXltzKIPP8z+76A59
         pOz52HqiR+WZywyBU3I3jdW0JPY+Yfy5oc7Jg4ivjTudPAgfjrbM5rbpN1E9prRR2zyV
         qpVFlYQuyJHh18GTUoNRQhcTaviUKraKajTyPIYSKn0T2Jxt7VrtLsZ4a7TsC6bFib+n
         dA/Nd7wrN5+pUqrPo7YSx4puOTuUpKXG7QnVDKnC8r8kJE6mRK6t9Yq27kGKJMgMxvM1
         AMot6nVCtO417IgD97t9ZcnIhmmdnIRoe15z4PasBQ5lK22/L+XihxfMP1m8gyNEhEXG
         8rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMnSK8ntPAmxAXQrdAy+wSqCLC92+9Em6yrq5Q1pjBI=;
        b=1PqFAD/F+tKCpTOU0Sx9kHXmupeMn5ZOCuIWR6JL8Ez/eZUGxlSEtZSSpKEzNc2sil
         GKnxw0AkthIdwDBOpbnqOUDH906HaU2P7pnZH8R3gNxuWHR6skkUkxUJn+3oH2qKAOx7
         18cWyLW2seIoAON3xkO1Uz3d5vyKrToBTu5I3KNNnl570LunR/Dea/CvsudvBLbME+DZ
         gNMsdc8T8uz+H1mgYKKoZ552IsLPWk4fFOK1w8HLDO6d9qPd9sEOCFqqbTfWxWJGKb8x
         Bdbv43zY1zlmP0HDPzCoI1zATZBLNvzZOKLszjmS1H31BeiXlQBz4QJyjKdx/qqbfpLG
         Cttg==
X-Gm-Message-State: AJIora+r3bL1kmQafEc1tNyHkxou5sAuGXE5juxDarYQxMpr8JZurDOA
        adxBZFFZ9l65xxEk94yOcbcemX9XrYo21e6/yEz7MZnt
X-Google-Smtp-Source: AGRyM1sQauTNNinYdB6gKJ2iPv7S2q1ZN7b+bB5iF6PmucnTDaYzDLRJ7Q6GFLWYZsB3Lu8/qW4dZX0sKGTDW3d4ag0=
X-Received: by 2002:aa7:db87:0:b0:43b:a0d5:8848 with SMTP id
 u7-20020aa7db87000000b0043ba0d58848mr2062775edt.60.1658533326342; Fri, 22 Jul
 2022 16:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658532524.git.me@ttaylorr.com> <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
In-Reply-To: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 22 Jul 2022 16:41:54 -0700
Message-ID: <CAPx1GvecmCD1bJDuEks0edu_dwcH92MN4A2Lyj_Tb5W=WtzKig@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with `-z`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 4:34 PM Taylor Blau <me@ttaylorr.com> wrote:
> The refactoring here is slightly unfortunate, since we turn loops like:
>
>     while (strbuf_getline(&buf, stdin) != EOF)
>
> into:
>
>     while (1) {
>         int ret;
>         if (opt->nul_terminated)
>             ret = strbuf_getline_nul(&input, stdin);
>         else
>             ret = strbuf_getline(&input, stdin);
>
>         if (ret == EOF)
>             break;
>     }
>
> It's tempting to think that we could use `strbuf_getwholeline()` and
> specify either `\n` or `\0` as the terminating character. ...

How about:

    int (*get)(struct strbuf *, FILE *);
    get = opt->nul_terminated ? strbuf_getline_nul : strbuf_getline;
    while (get(&buf, stdin) != EOF)

or similar?

Chris
