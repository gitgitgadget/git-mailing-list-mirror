Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBE0C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356ED61A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhCXTXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:23:55 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33693 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbhCXTXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:23:46 -0400
Received: by mail-ed1-f50.google.com with SMTP id w18so29000856edc.0
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 12:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ri06ekoj8yjqcKf/1mBKuTsXyoz0/RreDlK13k7/++A=;
        b=Q56fNv7oiyex97TkS9hZRKc5BLlbK+lcgJHtkcfikm3X0FHDju868AeI3dCGe4qPPP
         LH34ftFO7QQvsc4V+fgeCozF09nJlF4ioKbz9e1eD1Fb7mMZ1vLM9CjjO314Y6ws8J2g
         yNuytQXatSZCIfA8+sWRkB52hplj5WoNcGIfTQV45pGfg4MF0upY9cjvqHfMrpYQUXdk
         sLZSUewVfJA5x0xVxpzv9Py2rnvRiW0EUHwN4x3/zQbEV1TNqIJ99I7lRTwIuZxGtOId
         7bmzs4lR7aqFy1WnCeklNxXE4HYVMyVtvTQLRL+OaMZYmncC+hJ7akbqxxS9kg4EtL/e
         RqmA==
X-Gm-Message-State: AOAM530WbsV6NfYmK4LpsYrsI8Mfew12vXgd0iThP99KngIqLN8gkj9s
        hOrre9GrSG4ngwiDZ81cF6d7XEgWuBGSx6bm5xs=
X-Google-Smtp-Source: ABdhPJwtt1qRPbr5ylBcDa3b9NhyZq5gpL+SnwIzyKjCjmON1hit/e6YvJ1480GCq7U1R9npJ+96+fn0Ry5zpk8uvLU=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr5217242edc.94.1616613821217;
 Wed, 24 Mar 2021 12:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-5-emilyshaffer@google.com> <87lfashj03.fsf@evledraar.gmail.com>
 <YFt9MQsJAJsjWqo2@google.com> <xmqq1rc4z7ry.fsf@gitster.g>
In-Reply-To: <xmqq1rc4z7ry.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Mar 2021 15:23:30 -0400
Message-ID: <CAPig+cRcWUgM=c9k-P1hGZGJEZpSgHXK=_ribJeLVsiQWV3LnQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/37] hook: include hookdir hook in list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> Not just we do not want "hookdir" placed inside _(),
>
>                         printf("%s: %s\n",
> +                              (item->from_hookdir
> +                               ? "hookdir"
> +                               : config_scope_name(item->origin)),
>                                item->command.buf);
>
> we do not want the "%s: %s\n" to be placed inside _() and get munged
> into "%2$s: %1$s\n" for languages that want the order swapped, for
> example.
>
> So perhaps the comment should be about the entire output, i.e.
> "don't translate the output from this helper, as it is meant to be
> machine parseable", or something?

Having the word "translate" in the comment automatically implies
localization, which confuses the issue. It would be clearer to avoid
that word altogether. Perhaps something along the lines of:

    /* machine-parseable output; do not apply _() localization */
