Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439FC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 05:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjBOFUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjBOFUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 00:20:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2632528
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:20:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso3106696pju.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA/Iz9D7DpYNZmg5eWlYHqSEJPyS1rLXZmy5XotUxtY=;
        b=fXfbY47/nN+ksksfTTUnuD/g6N0apitR3G40aMQOrVYSawDFnORjxmdrCZJ3XARiEE
         zfXXqFsM+zErgcAueEM8ZWZx/Xfe55FVFv0yGWY/9Yts1w9ijQtuhgbBltvo3hQxwIQc
         dzsI8Vr8zlbqjBBhzSONP98R0293CAOSb7vRo7gVsIyFKL7lnzpYuhMUEHz82iAtjmcG
         bJ3gP4n4CtSPFdSoJzNmUwb/i1fOyTnPaYfxyLgELFmL7OzlNqbfzSVbPBtLyqqxSbiN
         m/Z2yF9hVIxE4KhjFVTQzQ4kO8sUfJPxnh3eUoyZWvxRNCkT2iX8hCrl0KvzIdVpxvV4
         TLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MA/Iz9D7DpYNZmg5eWlYHqSEJPyS1rLXZmy5XotUxtY=;
        b=Yan74H0V/QMhQgydY7o5fO+1+DD3w1IZTb/bUsfiZcTpcOGYfFJOeTXEqXooTuT/Vq
         GQU8vmivuNs+RDT5jmV3WU3TVr4xqGY7TN2fM2NSGQ3Zji2vYrd3bCGaiJiDHV8iv8fg
         hkUl10dG1P+QAO3ALQovoFdxgu/oIuM/y4lSRAhtjYPWjPBICcUaaVal3LkK0jXg96Cl
         LvUtkjMhOdPZrnf6MY41nhNGcFF3f+BhPvqxupEUnk3ot5aPWojHk8MJqAxypT1zsPcM
         j64i801HTWwwVtFevrndsmb2rrLbt1krLS2gD9puR4SWomgTVZ+ak6dP7v4UYasFpUry
         iKrg==
X-Gm-Message-State: AO0yUKXXq1HXqQz71xuSEnkUfN76L32FeVU9hHNA+YUSN7+p8aexxKsb
        iGjqUqRfXt9MlUN6rVHMnXM=
X-Google-Smtp-Source: AK7set8h/hYey6ymP+QDodwe6FPsDoMqCR16/59kDobNX8U1+iYGm/hreWDbOuMiV/qpbLIpOf9lBw==
X-Received: by 2002:a05:6a20:8e0f:b0:b8:7d27:2cbd with SMTP id y15-20020a056a208e0f00b000b87d272cbdmr801149pzj.43.1676438444336;
        Tue, 14 Feb 2023 21:20:44 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00588e0d5124asm10633878pfn.160.2023.02.14.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:20:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk,
        John Cai <johncai86@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
        <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
        <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
        <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
        <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
        <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
        <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
        <CABPp-BFnCzWH6Aai0ZYv1fR7GMfXqiAE3n8q1Gcrhh-Zv_wTjA@mail.gmail.com>
        <Y+xdvck3ZKZCewim@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 21:20:43 -0800
In-Reply-To: <Y+xdvck3ZKZCewim@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 23:21:17 -0500")
Message-ID: <xmqqo7pv1p3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >   git show 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f builtin/add.c
>> 
>> "fatal: bad object 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f"
>> 
>> Is that a local commit of yours?
>
> Oh, sorry. It's not my commit, but it may have been something I picked
> up off the list. The version from Junio is 20b813d7d3d.

$ git show -s --notes=amlog --format='%N %s' 20b813d7d3d
Message-Id: <patch-v2-1.3-71c7922b25f-20230206T225639Z-avarab@gmail.com>
 add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"

> FWIW, I coincidentally hit this case earlier today where patience does a
> _much_ better job than myers:
>
>   https://lore.kernel.org/git/Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net/
>
> So don't count me as an objection, but just a curious observer. ;)

Yeah, I know some people consider that Patience is the best thing
since sliced bread, and it does produce more readable diffs often.
I haven't used it often enough to cite/remember a bad case, though.
