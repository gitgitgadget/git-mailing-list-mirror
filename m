Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB9C88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFLRxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjFLRxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 13:53:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D698
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:53:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so8157925ad.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592423; x=1689184423;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVhRWgTin1yl5PPU1UWgI0y4TUhuKwHPggRjMYIAbOw=;
        b=odFX88CzoTOHZddh5nlUkWPSvL/gqE2gDe/TR43t0Ll3ZiQEz9LzdIkjFE1k+Yq4M0
         2Hd4j8xFGSBooCeJgR52BYOfPft5QUyDSCtC0HuC7I1pDTP0BhBmDGGPzjs7Myb1RIAy
         tSD6yoRU7g9O8ZptDMNJ/1VWLaGXMyDx27qCXZNyxD/vqvghh6NnAjQuedz05jiZYlo/
         v36P1Ps7RxekZWlEncobOc3yLcDYSqwp9zCi+4+nA5iIn7NmlMtwpDRHRb1Htpb12uHk
         PJcnNWgLJJ8cOvJqXGvY6hJXFaaJXGtWSzqEtuJ09BQ0yzzdBZh9rTWRR9ZvknAustcS
         +T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592423; x=1689184423;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVhRWgTin1yl5PPU1UWgI0y4TUhuKwHPggRjMYIAbOw=;
        b=MMHCqJf7jnj18Fb77ZM+3DpoMQhTp3/7o/PTa2P+BBSxyOQhumJDOagOUP2V7w47OP
         hx/69q9u9UCMZ+9uGuIRwfFiQb5NwGZtql2KNMCJ/sQ/J5+fvq0bQpFykiDrYv73x6q0
         uhMKsAuvwwHNmBNibzCd5AyMMepUu7HLGs7rKncejhaQvoOw0gzFv3B9P9wbWepYN+Gq
         XBVem4EqYhd6GTVolm7bte+hsNoiYlFHRye9hU/rWy4jjQZbmyBZImVYvuxJoUVtuAQb
         VimNZC5pobiZOyFdDoP1UBX5cDDL29ajyMOjT65WfTnceCYZ/+9q3oN7QuuVP9Q7iCMb
         cHQA==
X-Gm-Message-State: AC+VfDyv/CUAcT90nNvyZdW61jHYXHnFrLAa/f9GdCW3rB14RegxLbs8
        uRT5g1TFRMM6ZFT15jJF0t8=
X-Google-Smtp-Source: ACHHUZ7o5zPlCHZdD9h3kG4dLG2mtanSrfr2pZG55aAH8bBbQLz4bFepT33ByodZP7AhTYWY4SWdsQ==
X-Received: by 2002:a17:903:2689:b0:1b3:e595:2e4f with SMTP id jf9-20020a170903268900b001b3e5952e4fmr402865plb.41.1686592422759;
        Mon, 12 Jun 2023 10:53:42 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902968300b001b0266579ebsm8494964plp.194.2023.06.12.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:53:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
References: <xmqq5y814aw8.fsf@gitster.g>
        <158e0823-3b1a-4b38-9dab-7b7ca8a93331@app.fastmail.com>
Date:   Mon, 12 Jun 2023 10:53:41 -0700
In-Reply-To: <158e0823-3b1a-4b38-9dab-7b7ca8a93331@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Tue, 06 Jun 2023 11:15:10 +0200")
Message-ID: <xmqqcz20bm8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jun 6, 2023, at 03:50, Junio C Hamano wrote:
>> * kh/use-default-notes-doc (2023-06-06) 2 commits
>>  - notes: move the documentation to the struct
>>  - notes: update documentation for `use_default_notes`
>>
>>  Will merge to 'next'?
>>  source: <cover.1685958731.git.code@khaugsbakk.name>
>
> Peff posted this a little bit after What’s Cooking https://lore.kernel.org/git/b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name/T/#m94bafe1b04d551130558c5d7aaf20b1a353cab46

Thanks, I've seen it but after sending "What's cooking" you are
responding to.

