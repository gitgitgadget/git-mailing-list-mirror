Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA4C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjEHRt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjEHRty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:49:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAD44A0
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:49:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e4f674356so4461394a91.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568193; x=1686160193;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsfH9amxT2pidIFjBsoQZ16lCcP93kQGm4Y4TCh98P0=;
        b=OEKEH2luVUATEt10RnI9LfO2PoashTMmtCxD12KjyOnZ2dtUkK2jDFxbsFR/wAnaGA
         bfJQFnE+YbiJ8eOG2MORxM40YTsKQQq6QVtSO+nLWPsrfR7zKF3837hUcY7Jig16o/u7
         D0SfryjEDZ9bd8tlxz2mxi/m1YdeJUNyUAr1ZZhU1rYZo3NYobU0CBjNiajJk+vH1UsI
         BvXJUJbmys+WxHTUfOHN6cvxBVK4xV/apSCHhWZBQ+4DD1TU9yrSnGuBsZ/jstLM83zY
         fPPnaJJwJAfMIgtElKJ97q97LaNA0V/vOr3aX/c3IKuTMLZ89klmuBaPtENVtywYtKQ2
         VoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568193; x=1686160193;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PsfH9amxT2pidIFjBsoQZ16lCcP93kQGm4Y4TCh98P0=;
        b=eT+hhsPF60Zn4iwE5uk9T8MdG41sLbVkM/4BcLQLZ9xufF0BIxT6EBEh6aWWQSce4f
         pKxIHg53pnIH8PLqYVfUqD4KaOklmQH0goBSeX5kjCB8vvy2coCswXWrC376NCPc37+Q
         yKwBX4hhq6jxH1fw9R25VtGh/S4XO/EXvHhDy7fhImlatcgawwAy/nXsG+78ViAcvYFG
         6+JNXpXoBpr+gNrzlJtrwNmUN71K7F1pDkBiBWw5Ui87KZ4BV07mJZzv0w4LhlHQbWte
         SJbddS2jlEzTv/RNCSXSj3+o57+QXkhnjVYN5QoRel9G3Ag55GNOopyWfZlHfk9EJfVY
         MnMQ==
X-Gm-Message-State: AC+VfDxn6DyNq8W8IpBDDl+FkcyBOA4YwHEwR2qKkC5QdVeFA9Qf81Aa
        /DaPHlTinFEyhNhnjEO6r0/S8L1eZBs=
X-Google-Smtp-Source: ACHHUZ5T0tZ9X7S12KzANUH8F01eXtBJ3KZpOm8Hy+oLotQETwiadjQ5kVXfNm38pT1wG4k1P3krEA==
X-Received: by 2002:a17:90a:4b07:b0:247:4c4b:f4eb with SMTP id g7-20020a17090a4b0700b002474c4bf4ebmr11593423pjh.21.1683568192536;
        Mon, 08 May 2023 10:49:52 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm12043722pjp.39.2023.05.08.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:49:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 00/11] docs: interpret-trailers: reword and add examples
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 10:49:51 -0700
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com> (Linus
        Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:39 +0000")
Message-ID: <xmqqy1lypvb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: making sure that the area expert is aware of the topic]

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series makes some small improvements to the docs for
> git-interpret-trailers. The intent is to make it easier to read for
> beginners who have never used this command before.
>
> Linus Arver (11):
>   doc: trailer: fix grammar
>   doc: trailer: swap verb order
>   doc: trailer: --no-divider: more precise language
>   doc: trailer: explain "commit mesage part" on first usage
>   doc: trailer: remove redundant phrasing
>   doc: trailer: trailer.<token>.cmd: add missing verb phrase
>   doc: trailer: use angle brackets for <token> and <value>
>   doc: trailer.<token>.command: refer to existing example
>   doc: trailer.<token>.command: emphasize deprecation
>   doc: trailer: mention 'key' in DESCRIPTION
>   doc: trailer: add more examples in DESCRIPTION
>
>  Documentation/git-interpret-trailers.txt | 62 +++++++++++++++---------
>  1 file changed, 40 insertions(+), 22 deletions(-)
>
>
> base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1506/listx/doc-trailer-v1
> Pull-Request: https://github.com/git/git/pull/1506
