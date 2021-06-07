Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B34FC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254A160FF2
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFGRO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGRO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:14:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA5C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 10:12:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so21233150edt.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yh8TG2ZQWaV19ZeT+9LszP+GB3nheKCwM+Xh5f5KzbI=;
        b=qLZbSReiN1VwNEWr8qpZPIfX5HUve3WJlnH9W8jvLKUx1tqSKYu4R+3jQWQyEUPCvy
         br/MXudssmB4R5u8ThsiAKUZ0zuB4Xa7muoUdTJI6JEKZm8zfDRN1TAMhzMVT99Ky8AO
         ftnl/rIBEcER6/5MfvCD1cE1a3vFGWYnG5ZRc4OokA0+jfdNWSNCLEeLbRe7tc5w3RKk
         DTq9ible0MHiJ33+iDgxnur+eZqcW2irVobR7of0N0DOt2lUVLL2XWSqpojsfagjx1AW
         f5hVUcDHJtHwp0uCc6rcHmM9MrhC4wZRNUy6/MO4mGmeSnzwg+BoaKtHk/6tT6p+glOs
         UF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yh8TG2ZQWaV19ZeT+9LszP+GB3nheKCwM+Xh5f5KzbI=;
        b=qzUrKfXoEfkWEu1L76tO5nPNuBSllMrd/SzwDPbBVFjYVDP25+o80xgk7OrN/4/0ua
         MID2q/oIiYoFwIRiY/I8PHou1kaLQ+wnwxHSTDUzMZdNW5DS+el1/MWJM/ENBvBUCvWG
         dVkq239ZEFdHI8QyxOGmfc+xyt+szdLNU5SrSK/sFdvXoeQFhEUaQTr6A385LGivLuSc
         bmMrUMrtUlEEWT2CkP9XvTi2hTRuo0Pum21Z1wiwkfIuXaqVdhVc6UjqXIDTorpe9CoU
         YqVoIoR+RXCOYNfHgzy49GswndB/UZdgAzVnciok6hhquXoLWKwva94B3NbUUQvx9Qha
         uwZA==
X-Gm-Message-State: AOAM530cAfrADHYcNjp9vy1+PD2o5F5eWsUbCoP9iw+Pss9hus5mDzYV
        YRDXXRAo4uaqBZOM8MJA8f+T+VSIQbiCAA==
X-Google-Smtp-Source: ABdhPJyrGZXalufxaO9Js80UBx822xoYoUzOgq+KWfG+J9s408R2y1Td3cLSKZMFisrzC6nOuXuP8g==
X-Received: by 2002:a50:fd0a:: with SMTP id i10mr21342640eds.78.1623085967257;
        Mon, 07 Jun 2021 10:12:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cq7sm3109201edb.77.2021.06.07.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:12:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] *: use singular they in comments
Date:   Mon, 07 Jun 2021 19:12:12 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
Message-ID: <87bl8h4n01.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Several comments in our code refer to an anonymous user with "he/him" or
> "she/her" pronouns, and the choice between the two is arbitrary.
>
> Replace these uses with "they/them" which universally includes all
> potential readers.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c                                 | 2 +-
>  config.h                                 | 2 +-
>  contrib/hooks/multimail/git_multimail.py | 4 ++--

We should not change upstream projects we pull in like that, see
README.Git in that directory +
https://github.com/git-multimail/git-multimail.
