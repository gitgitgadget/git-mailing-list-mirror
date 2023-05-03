Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B0C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjECTf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:35:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A2CE
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:35:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad6f2be8eso49575995ad.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683142557; x=1685734557;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4iYGdUO08shTakHUGvUJ0LHu1shq28CfHMfmnsebpU=;
        b=YbbFT+VhAct/6lAN6XxFuW7Bs151P86zUud8Pb0NNKx2KKD5ens9N8uA2GUwrTPTMF
         OWFKAFEMj81+9eTyidPXEiBTZ2mGR6S/W7Zimbkr8DZPO2jKgDIUW1TPTxP0v9Pmg4Ln
         Hnrp8HmTNiCkdYeaP2q7M7BD3yIiGigPG9L9biDUHZcG48bczmi5/Z5SPIfip006khQ9
         VW4hmD/g6grzebXs0/1r8tEj5X+avjHp9Uiv2Hk9GF4GUjBmd7vflWXlRi6limxHpp3y
         6OxJpms1VTed9rb52IEZKlVNl14L5GN8knQeNn2Uqaqs4MUvBYtulHbmtWo2sGt+p67g
         nF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142557; x=1685734557;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T4iYGdUO08shTakHUGvUJ0LHu1shq28CfHMfmnsebpU=;
        b=er/og3D3AwbVubx9MeQPdnbdxG9Sfk4pABu4i+NXSD1xXnxZ1qqkyf/3YIIaOiKdGJ
         E5Mthea8WyvNYECM7/FxfWihUX3BPnveft24T+Yt8lQ2DaL/UvJOs/IVD9Tom/sBt5x7
         EMhWyvjD9ohlzB/KW0CSd2eDvgF6LoPualGoXiMLKsxe3DEQ0UuJ3t7fEvphQ0rLgx0U
         +CgKmDX0WfEOFCWNMaYj6ah9R/8IfKm2GxKcWJmV7ODGq3LcHjX7stGXQc1NCICQrRIu
         iDh8aL2PaIOLLhN3CNvduIYk7PB0YdD8+OH7eyaw5QjnTlpI3GyVvn3NrDDhatcZjuiJ
         fsjQ==
X-Gm-Message-State: AC+VfDyQSPvNvpXU1V+IdVmmTnQu5GQpk58m14LfHhjt2qgZHgbDpzgN
        B0xTBP3UhKQblKC9aWGwcvg=
X-Google-Smtp-Source: ACHHUZ6CPX3e24Vvev8HQX8gk52qiHKpvEtpblwPLJR9Jcf8Z5Silkq0uQ7zInBVceyDk2dqY+o6Dw==
X-Received: by 2002:a17:903:190:b0:1a2:a8d0:838e with SMTP id z16-20020a170903019000b001a2a8d0838emr1257798plg.61.1683142556548;
        Wed, 03 May 2023 12:35:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902700800b001a674fb0dd8sm3195338plk.247.2023.05.03.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:35:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Ushey <kevinushey@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep -E doesn't accept \b word boundaries?
References: <CAJXgQP1j6JYbtikMuWGFn44+FVb3PfmuwiFrxDGLQAYgr92Wfw@mail.gmail.com>
Date:   Wed, 03 May 2023 12:35:55 -0700
In-Reply-To: <CAJXgQP1j6JYbtikMuWGFn44+FVb3PfmuwiFrxDGLQAYgr92Wfw@mail.gmail.com>
        (Kevin Ushey's message of "Wed, 3 May 2023 12:04:47 -0700")
Message-ID: <xmqq1qjxqkbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Ushey <kevinushey@gmail.com> writes:

> I'm seeing the following, which I believe is unexpected. I have a file
> with contents:
>
> $ cat hello.txt
> WholeWord
> Whole Word
> Whole
>
> I can use `git grep` to search with word boundaries; e.g.
>
> $ git grep --untracked '\bWhole\b'
> hello.txt:Whole Word
> hello.txt:Whole
>
> However, if I add `-E` to use extended regular expressions, the same
> invocation finds no search results.
>
> $ git grep --untracked -E '\bWhole\b'

Does not seem to reproduce for me.  In a randomly picked repository
(the source to git itself), I did

    $ cat >hello.txt
    WholeWord
    Whole Word
    Whole
    ^D

and "git grep --untracked -E '\bWhole\b' hello.txt" with or without
the "-E" option shows the same two lines as hits.

Without the pathspec hello.txt, the output includes one line from
unpack-trees.c as well, but the hits from the untracked hello.txt
are the same.

The tip of 'master', v2.40.0, v2.38.4, v2.37.4, v2.35.4 (they are by
no means significant milestones---just some random versions I picked
to test) all behave the same way.
