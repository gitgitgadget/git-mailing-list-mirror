Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B2CC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC51611AC
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhEFKGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFKGN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 06:06:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3AC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 03:05:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s20so1892894ejr.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XGvlbHTQEW5NxafU7NjtwU7wCZAQ8dN4BpE4JdPeRm4=;
        b=gZYATXBpMs3yiUkzAzI2c5lqJl/SyTnZvXBDchkLSaaOxafPNuout4a3LjP4H48ILX
         /aMPx1C3zlnzNPPgkUQYoEzTB8jMdZVD1rh+f3lLUkExeqwjoPn73zq97Bsk2jJMkbQd
         cbnnsoNhB7dQ48iRPZrKaMVnPzhoXv+MR2WEcGnxw1gwijucHgvhCP8l/c1Z/59UyoYF
         amMVExLZN5EpdXHm2fIgZSE9afcHFX0VKyuVR1psDuHj8iHrM/tQ6+A3DLCqIKOTabJQ
         2dTwS1EXG3rxeFeIAFHb5wZwQPQsYm6hVTq+qeihnPOYu4DnNY68x2LqlNITy9xvoRzl
         /jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XGvlbHTQEW5NxafU7NjtwU7wCZAQ8dN4BpE4JdPeRm4=;
        b=Arq2SAM+gMrFE/u9jdwQyu4Vm1ou4ZYqBosMbfpx3AzFdXyxbRJXEi7e13NXDTCn28
         cjfwTmM6JYPqpl3lQl2bon5d8UO6D/oDVebLOrx9Czz6oQl+/LoYp/Zk4ydEPqty6KIf
         hTx5DV7b5D9jeD45LFFGRmTW7B8ZVgFYq0kvj5p1j9EAQfj1IX4YxVEyQXmnXyfExQ4W
         azbul/e/c817piC5vQ80UNj2+L6wWb3xJXcx2+E2gzI+KJr7W1vWQA4sMavaSfQVd99o
         0lk9z0kvXWuHFL27raORV1FZ6jlxGGUbIMoTrhN8+aGROlbc6Y0DxMAMkLIsUAkCnZqL
         NKTw==
X-Gm-Message-State: AOAM533xO6f5fHpSphza/S7pSuyrEtv+OtwIqT5C8k5YZp4qsl0U5dMd
        mb/nTFg+rYKZbOluMJABcwLwOz8c8mE7poBV
X-Google-Smtp-Source: ABdhPJxqghojNAp7bwJFHP4mBfb7quFLetx07izLi95FytUMDP6KQnlZFoN5jtz/7C61B8cjidkPJA==
X-Received: by 2002:a17:906:8693:: with SMTP id g19mr3575753ejx.270.1620295513960;
        Thu, 06 May 2021 03:05:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j4sm1067680ejk.37.2021.05.06.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:05:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Thu, 06 May 2021 12:02:28 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com> <xmqq35v01ua3.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq35v01ua3.fsf@gitster.g>
Message-ID: <87pmy4uqhz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I mean, I see why. You don't want a typo of "master" as "maaster" to
>> create a new "maaster" branch, so really that's out. But it really
>> should be:
>>
>>     # -n or -N for --new / --new --force (the latter just in case of a
>>     # race, and just for consistency)
>>     git switch -n doesnotexist
>
> I do not see why --new is better than --create; we did choose not to
> reuse --branch from "checkout" and I remember that was a deliberate
> decision (i.e. once split into "switch" and "restore", "switch"
> becomes only about branches, so unlike in the context of "checkout",
> in the context of "switch", the word "branch" adds a lot less value,
> and certainly does not signal we are creating a branch and switching
> to it).

I don't think --new is better than --create when considered in
isolation. I happen to think --create is better.

What I'm arguing is that we should be aiming for some consistency in the
command-set. In this case the relatively small change of
s/--create/--new/ server so make the rest consistent. I.e. the branch
and switch commands can mirror each other in the ways that matter for
these common operations of create/copy/move.

> It would have been a stronger argument to favor --new if we had "git
> branch --new <branchname>", but that is not the case.

The argument is that switch's experimental design squats on 2x other
options, so changing -c to -n so we can make -c and -m do the same thing
is better.
