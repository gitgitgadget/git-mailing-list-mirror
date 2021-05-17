Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A2C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64656117A
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhEQNBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhEQNBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 09:01:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575E3C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:59:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v9so7301905lfa.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mf1Q510AUptc+XUkDRIDNufTpixt5cPiNrpnT4nwp1A=;
        b=sOHjgGiIZQp32il0V1jnLNieDyrlq1ELAYrDQj2crIM8/Kn6ClfjrBEJ7YOVbCJzB2
         AFR6DBQzA3geuys/xgwtYP3FPI5+EQtnMyewiYzcJ6XYvPwgK/L+UXTKaDTIdDR49g0S
         99389b2Ec8qMqFyQnxRFjLR9kmXx/ZuXFFQvCGWDblaJv7Nu6sgZvPoYtzyqxQM86GRg
         eTdcxmL6C71GX4ISzisGWygFq8iHt5XlFkXrUFai7qD5rRRQ+UJHtji2YnFYluQOCQjx
         3F+/+bP/rb2ix4swMkhj3nxTqABi/Vkeqcxn2jRH+aQ5QhpCpflI8FnNmaxhHcS0Kp5p
         AxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=mf1Q510AUptc+XUkDRIDNufTpixt5cPiNrpnT4nwp1A=;
        b=rs/XCJ8HNXeXx0cYDJ3q4TMH2kG1wcHwkmjo3P5bu9hRaYqrmDT1K6MmylqL2YSOgD
         yE/4SWoMu+XjZch+ZQDsqSqyW0bs5w4qh6dIPuTg3GNWtToUTl67cHXhYJRwTqSGDZwS
         9cvKBUESfy6YPMxgKrV19R3JPHm4wqEpwrfzQpBKk/oIVnejRS/8eNBusvJTJoRhWimy
         hfEgRcQH+wgSJHg8ra1xenG3A1uhcUDqn2xglwnoNVbuokXYSGWysCg/eMR5nMn6m0wR
         UwAH3tjQSQpM24Iik8fnDVOa7QpcCfJIkvIPGG148acqTPy7bt6vqeG/JQSj8NNCQV7x
         EydQ==
X-Gm-Message-State: AOAM5332u3LZKTG3xLRgoIvNOp81H+qJ0RG/TxO7Yh1hhdZT7vzSst/r
        P1KNQ9wNQ1Ql688FDEyXc9DppRKWFJU=
X-Google-Smtp-Source: ABdhPJx+ajB9ovUS9sebjESj0lEiHZz4jAitqYfQMVOvVSvz/XczBte7ZvBPitvUdxdN9AJWjGl7Rg==
X-Received: by 2002:a19:c7c8:: with SMTP id x191mr3087669lff.60.1621256390658;
        Mon, 17 May 2021 05:59:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u21sm1965044lfc.68.2021.05.17.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:59:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
References: <87r1iakbyn.fsf@osv.gnss.ru>
        <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
        <YJ3LJ++lsAuSkCUJ@danh.dev> <875yzlu8gt.fsf@osv.gnss.ru>
        <87zgwtr7i4.fsf@evledraar.gmail.com> <87k0nxv8tt.fsf@osv.gnss.ru>
        <YKJkmws18M6oJZXy@danh.dev>
Date:   Mon, 17 May 2021 15:59:49 +0300
In-Reply-To: <YKJkmws18M6oJZXy@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Mon, 17 May 2021 19:42:03 +0700")
Message-ID: <87a6otv7lm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:

> On 2021-05-17 15:33:18+0300, Sergey Organov <sorganov@gmail.com> wrote:
>> >> Probably add generic cmd.<cmd>.opts config support, so that I can say:
>> >>
>> >>   git -c cmd.rebase.opts="--no-fork-point --empty=keep" pull --rebase
>> >>
>> >> Thoughts?
>> >
>> > It's been discussed before (but I did not dig up the discussions,
>> > sorry). It's been considered a bad idea, because our commands are a
>> > mixture of plumbing/porcelain commands and switches, so we want to be
>> > able to reliably invoke say ls-tree with some switches internally,
>> > without config tripping us up.
>> >
>> > Of course we could make this sort of thing work by selectively ignoring
>> > the config, but such a thing would be equal in complexity to the effort
>> > of assering that it's safe to introduce new rebase.* config in the
>> > codebase for every switch it has now, but with a less friendly interface
>> > both for git itself and users.
>> 
>> I don't see much complexity here. We'd then just need to effectively
>> invoke ls-tree internally like this:
>> 
>>    git -c 'cmd.ls-tree.opts=' ls-tree
>> 
>> Not a big deal.
>
> It's a big deal.
>
> Scripts was written with plumbing command and expect stable output.
> If such change can be accepted, a lot of scripts will begin to fail.

Makes sense. Then simply don't do it for plumbing?

Thanks,
-- Sergey Organov
