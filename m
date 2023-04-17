Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC6C77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 18:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDQSqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQSqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 14:46:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772635BA1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 11:46:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p8so26833018plk.9
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681757210; x=1684349210;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJkOn8HaK3ayZvBCqPs0ZQW9OmfELGqrqtpQt9Mclwg=;
        b=C1pFAU9jlGAfnTBNRLLUbpAH7icsfyvTzCA+i7O/ZPse+B58IXU4VpWPFF5bR7n7J9
         iFHlDQley0/kQe4p8Pb7Al3PzjJYD72YRvz/EPZqqZ/nKrnx3IzATlPLtCZpdfkw8zO3
         08nq/wlxIQ98KPqWTKnQgNq3wBZjBbKvEHZvXOwePf8gtYCYtvOhoiFWkK6HTmCL1/xx
         Ov8Z9xCwDi/uP8OIHsOnGrfTOq/CjvqVX2OjBk6ke5G7NHCo3UJJnlcwPoOf8TC9Gagy
         Z8j26TF093kW3xjepgV4sfMWUnbDp1p/K9iC4kcxtua0b00VufwlQfvMA1MgQCB/GN1r
         yqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681757210; x=1684349210;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJkOn8HaK3ayZvBCqPs0ZQW9OmfELGqrqtpQt9Mclwg=;
        b=jMvPg7JwMF0GmRkrSCKs7d52EvcylRz27is/meEHtDh7E4dI3rqgRO1ROKtKzmYRel
         d51WsQyahV0aeDmvj75nfqw2Ph24IBADPTlHlgnh/lpN01zFPfdEoqzUlivs7sEjDbW0
         JiNkTGjFj73Ivxa2GIRv4RykovNPZyWyfNiQNifcDBlMewh+jU9YecC0k+54s4kWoBSB
         Vh94pIrAEwuJVATQIz1LmnDcndx+o7Ie2WGoHXGO9jVI/NaHzF6bONdf4DQFJiqGHF9X
         QFazSVE/Yp7v9bGXenQ3eO8gfTS032AZUORhLfWfFDP7AR6TU9edQaPs5lb/mPC56272
         yoww==
X-Gm-Message-State: AAQBX9cLO4G+XB9DOZDjVGkQYPqlVlbgWPGmg+wSzT31iy2oQhpGnv0C
        v70unHfUwWRAJy3t3gyF57JTqYMTokw=
X-Google-Smtp-Source: AKy350bPgrnnqBc3zfzRuN0INbZMyiNBWya0sb/7qn05lhGJ71Wj0zSgjmXam1ubQVnVZ0N24ZSPJQ==
X-Received: by 2002:a17:90a:df91:b0:246:9c75:351a with SMTP id p17-20020a17090adf9100b002469c75351amr17294663pjv.12.1681757209816;
        Mon, 17 Apr 2023 11:46:49 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b00192aa53a7d5sm6059168plw.8.2023.04.17.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 11:46:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Ferencik <sferencik@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
        <xmqqk03jcwxz.fsf@gitster.g>
        <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
Date:   Mon, 17 Apr 2023 11:46:49 -0700
In-Reply-To: <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
        (Samuel Ferencik's message of "Mon, 17 Apr 2023 09:04:25 +0200")
Message-ID: <xmqq7cuamjmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Ferencik <sferencik@gmail.com> writes:

>>>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
>>>> system name, i.e. the output of `uname -s`.
>
> The discussion about https://github.com/gitgitgadget/git/pull/1429 seems to
> have stalled on several points. I'll try to summarise; let's see if we can move
> forward.
>
> (I am the reporter of https://github.com/git-for-windows/git/issues/4125, which
> led to this PR. I am vested in making progress here.)
>
> 1. name of the setting (`os` vs `uname-s` vs `sysname`)

I do not think it is a good idea to squat on too generic a name like
'os', especially when there are multiple layers people will care
about.  But I think the original thread discussed this to death, and
I do not see a point bringing it up again as the first bullet point.

> 2. casing (use of `/i`)

My preference is to do this case sensitively (in other words, start
stupid) and if somebody wants to use "/i", add it later after the
dust settles.

> 3. handling Windows (MinGW, WSL)

This comes back to the reason why "os" is a horrible choice.  Is WSL
a Windows?  Is WSL a Linux?  The same question can be asked for Cygwin.

The answer depends on which layer you care about.  The underlying
kernel and system may be Windows, and some characteristics of the
underlying system may seep through the abstraction, but these
systems aim to give user experience of something like GNU/Linux.

And this is not limited to Windows.  There may be similar issue for
systems like PacBSD.  Is it a Linux?  Is it a BSD?

> 6. what's the use-case?

I think that this is the most important question to ask, and from
here, we'd see how #3 above should be resolved (I suspect that you
may want to have at least two layers to allow WSL to be grouped
together with MinGW and Cygwin at one level, and at the same time
allow it to be grouped together with Ubuntu at a different level).
And after we figure that out, we'll have a clear and intuitive
answer to #1.
