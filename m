Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF63C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949C7225AC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbhAGO6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 09:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGO6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 09:58:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA00CC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 06:57:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jx16so10011209ejb.10
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bGrKeCVNMDESpHBgqLHPofFL2MBoUW/fQZk08CbSxU0=;
        b=WPfK21s13NDQmXgDrslEnPlVqAo+tf3VzomSuhuf1b1cPVA7LPLTbqoVkmZ6WeSwRn
         SzU3f4uDhMYWnf4KcQlg41bIfZQf5dAQz4FRZZYM7hom/YaDLUDQBrnjw/dzDGtxJjku
         jRzC7Uvl89g0XgTEKdD3wZXKZ4NtXiii5fb6pjCoKGyeKANLU5MpvKvCJd2JhS3s8GJA
         kG8QHWglRNVZvFemaR/ErlKJAQwiYGTY+W27kcSlzn5+uWJQXw4KgngbwHWoIHprEr8H
         wBw0D5rqxcQAzzlk8yOrv8qO54wbAQVMrD2CXgiOVpg2OVji5dHb8r+ELNJ+xDul4Uy7
         3EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bGrKeCVNMDESpHBgqLHPofFL2MBoUW/fQZk08CbSxU0=;
        b=hyJ0l4gvfs0AcW5fiEO7PVJ1AqUfUaJI7lXUnKIimV+N2nKIlRHF5IIS72nDdjcIph
         vywicK7fWWAtmU+uQMsznhY5MQZOhrawe/1HpIs7ws+yBweqVJut5Hk78w8qF6WjBmkY
         +ScsqqUNj2mFYjvnUVilXW00i510NYAXq33J9HeXw6+Kp5HXBem0n2BxH0lEq58/sDkM
         Ua3R2yhBNtRYhGxH4ob5lAX294MdfpqNzmiZGwH2UpULmYFHMgYFcyb5Zo7+b1L4CHHm
         D0vQQ4cSx0qSjFU5RHQ3cPY2XcwlnLzG1nb6MzMPkp6V1DvSw5ImkpcF8CZB0gEtIB9Q
         +zNw==
X-Gm-Message-State: AOAM531KjdkxL5dXeRaWLl6QmptcJCBIn3MpUFiNr4Kj7IXvQ9aXzjBt
        +l9jYyZrCR6DvU5BXfy5w48=
X-Google-Smtp-Source: ABdhPJzrMGb1ZsLwFKff1/bZUkLbZqcdyLOasqn7f8RWEKiWj8cre9sUHo5sTyvPOSucHi4FePdc4A==
X-Received: by 2002:a17:906:971a:: with SMTP id k26mr6761510ejx.515.1610031475492;
        Thu, 07 Jan 2021 06:57:55 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id qp16sm2519459ejb.74.2021.01.07.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 06:57:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
 <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
 <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Jan 2021 15:57:54 +0100
Message-ID: <87wnwordzh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 07 2021, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 26 Nov 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> > Hmph, I wonder why this was sent my way.  How does GGG determine
>> >> > whom to send patches to?  I, like other reviewers, prefer not to see
>> >> > earlier rounds of patches sent directly to me unless they are about
>> >> > areas that I am mostly responsible for (other patches I'll see them
>> >> > and review them on the copies sent to the mailing list anyway).
>> >
>> > Oops, I forgot to address this. The reason why this is sent your way is
>> > that you are the Git maintainer, and as such, GitGitGadget sends _all_ Git
>> > patches your way (except the Git GUI ones).
>> >
>> > The reason for this is that this is the suggested way, as per
>> > https://git-scm.com/docs/SubmittingPatches#patch-flow:
>> >
>> >> 5. The list forms consensus that the last round of your patch is good. Send
>> >>    it to the maintainer and cc the list.
>>
>> Yeah, but as far as I can tell, this is the _first_ round the list
>> sees this topic, which by definition would not have any consensus
>> ;-)
>
> I thought about it for over a year and still have no clue how we could
> teach GitGitGadget to Cc: you when it is appropriate, not without putting
> the burden on any human being.

That message is from November 2019, didn't you later fix this in January
2020 here: https://github.com/gitgitgadget/gitgitgadget/commit/b2221f4 ?

I.e. now users need to explicitly add "cc: gitster@pobox.com" to the
description, no? So isn't in the same as for us who use the
format-patch/send-email flow in this regard?
