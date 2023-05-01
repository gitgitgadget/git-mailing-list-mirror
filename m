Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A55BC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjEAWZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjEAWZd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:25:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3C26BC
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:25:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so508165a91.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682979932; x=1685571932;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dR5xuRld8djT47ou+rJYZhkdC43vUrv9bIWA5uEnmIU=;
        b=F47NYRmoo4bp40bQbQPmyS0xeRX0Julw3qPaqoG945RbskR+oOA7kF2FYbcYKLEo3f
         PNR+XmdQ1KettrwAPiJTucneh2kZ/rAyNFx5cLbYGj4GZFE1bG5uatVr+3a5Fw5X22if
         x4WT+M40K36h524VylIyi6Oe97/TXVHs93wCubHoKaNbHofHe/z7Pya4XMM2waoH9HFv
         dbiXYvMq/6Zt3c9IFvV9yRfjiHKpPWqF11lx03xr9juAgLhsfDj5NMnuwZU61UV4MWMJ
         HOpwo+14FuD8ADmmUJ0+AbVDVPvBiTHqqAkhWTVQfu3HEAKe6dPWG+8fKsBuYbFf6jJq
         5PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682979932; x=1685571932;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR5xuRld8djT47ou+rJYZhkdC43vUrv9bIWA5uEnmIU=;
        b=b6x14szfwImEKoWflOMfYTOi3RdOfCMKo0EjaYqaMxUQrC+P1aErTQAP52LFIGhoV1
         S7Yt4s2U2tL7iIzuqt2667M6k9u1HsGzgsWgXLzIggyXO2S6YIJtiSxege448DFAY7gf
         YYhWqOL67/vmy/M8iVm42v5p6jYQ/CX8WL8aJTbBGLWBgVYNDNWyNCibOLbjokb7Vj8G
         s9o9CLQ7SzvURPvse79ZuNZCJDiyyqCsvVFwVDKSBIi4IFm3annZICnbMf9CuEBIQkEC
         KldqYY29TE295pTP76OoEtf4+t8+eYu/4XOh8QThSMC3cUo6Ik6slQ4pqlNlEyqS/S2o
         PdUw==
X-Gm-Message-State: AC+VfDzMmIqH0ulbpmUKTBW0y++QcX+okJAk57knSKncGe8ofCaxxPYw
        N1nuzVwCRFJqKqQ4Qjx+KE0=
X-Google-Smtp-Source: ACHHUZ6/z861BckJdoWfnge4dKvC6l4nDWuw1hHiMMj/UcGfKItZLj7EDiXu25y3dcYLITyoH8Iyag==
X-Received: by 2002:a17:90a:9f94:b0:24e:109a:94e with SMTP id o20-20020a17090a9f9400b0024e109a094emr3135808pjp.7.1682979931783;
        Mon, 01 May 2023 15:25:31 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a304400b0024e2230fdafsm273283pjl.54.2023.05.01.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:25:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        Jakub =?utf-8?B?QmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
        <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
        <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
Date:   Mon, 01 May 2023 15:25:31 -0700
In-Reply-To: <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
        (M. Hickford's message of "Thu, 30 Mar 2023 06:50:30 +0100")
Message-ID: <xmqqa5yn3d0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

> Thanks Johannes for the review and the fix. I'll include it in any patch v2.
>
>> But I have to wonder: why even bother with `git-wincred`? This credential
>> helper is so ridiculously limited in its capabilities, it does not even
>> support any host that is remotely close to safe (no 2FA, no OAuth, just
>> passwords). So I would be just as happy if I weren't asked to spend my
>> time to review changes to a credential helper I'd much rather see retired
>> than actively worked on.
>
> git-credential-wincred has the same capabilities as popular helpers
> git-credential-cache, git-credential-store, git-credential-osxkeychain
> and git-credential-libsecret. Any of which can store OAuth credentials
> generated by a helper such as git-credential-oauth [1]. This is
> compatible with 2FA (any 2FA happens in browser). Example config:
>
>     [credential]
>         helper = wincred
>         helper = oauth
>
> This patch to store password_expiry_utc is necessary to avoid Git
> trying to use OAuth credentials beyond expiry. See
> https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
> for background (I'll add to commit message v2).

So, even though earlier Dscho sounded negative on extending wincred
helper, are we now on track of enhancing its capabilities?  The v3
is now queued in my tree and nobody who knows Windows seem to have
made any comments on either v2 or v3---I am wondering if the lack
of comments is a good news or no interest.

Thanks.
