Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CB9C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKSMIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKSMI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:08:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E510C8
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:08:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ft34so18861294ejc.12
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aj8Yv6ywLmjf3GLe8ASzWdQPKEBIoC4+GnVogz6TObs=;
        b=iu5lk6zeitwWIBJXhF1/pPKZULlUFgaamVTk0MvrEKELdSxPoDlRCmzUEWnlILJIc6
         I81s5MCFp3xGfzrYWQ96vAYYZheVucz0eXGo/ym6ADd/LSQXxM73hWzbYWscyMOMHocN
         3N9PO6F1diD0D21HFMFCmFI6GsGdAWxVaodK2/j3AFkm2nqWNJxpcmN1trx8H+lFaGWu
         TUt8D18xQF4L1iGwTHBYwtWQwWbQ2qzRDjOLqPc0IalB7rUB71zRvxKpg9xZEGopDtec
         axEGsHVHglw52jlW/KrHsBxOEAHwOAn4nau9o2ZLcMGgru2ckWp/tt2GvoC/nhS97u9n
         Bjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj8Yv6ywLmjf3GLe8ASzWdQPKEBIoC4+GnVogz6TObs=;
        b=wmRyvILbk+UKws2KQZBs7oxO7GNs4B9k1ugqzie1LMvsPLYF6FIBc2tn5xHB3Jv8m0
         PYvR7TFxyyt35FT6uZgZW2kFVT6JgFHAagey8fc59otqb8Fp6KTITttWyW4KAVBBYGOB
         8e2QlFJHDqbgwPGB34FuRClH4BjjaPNobBpgDIjfzvvlh5dpaTBGNtKcNRTrTuZmsfCl
         5hlRDtBECzfIgDwH9rkIeKIMX6fybY9y1DedBBC6Abkppkugt+7yaXfsUwlO/hym/Gkt
         2+O8dwT3QUH//ymDnta2vptMBA0dvjlbjPFypEx0o/8p/FKrEpd5HUauO3kFD+qiDHs1
         v/OQ==
X-Gm-Message-State: ANoB5pk/xyqN+egmCkPz8hMkT7gDIcCLoopLRC0W9OGuHBRQgeJ/1uhI
        oAbCKVto23l/n7rxXNohUic=
X-Google-Smtp-Source: AA0mqf52lSTNjvvRFkgEdFpLRCLSytv2Z2eryk2Cvuo4mnH4ileEyo9B0N9RmSKI/rWvazmPqz939g==
X-Received: by 2002:a17:906:3c4d:b0:78d:f2d8:4623 with SMTP id i13-20020a1709063c4d00b0078df2d84623mr9612615ejg.274.1668859705724;
        Sat, 19 Nov 2022 04:08:25 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x7-20020aa7d6c7000000b004623028c594sm2897861edr.49.2022.11.19.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:08:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1owMe0-006BWq-2Q;
        Sat, 19 Nov 2022 13:08:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Date:   Sat, 19 Nov 2022 13:03:03 +0100
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local> <xmqqv8nbkg77.fsf@gitster.g>
 <Y3hFITt+8VUubC8v@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3hFITt+8VUubC8v@nand.local>
Message-ID: <221119.86sfifdu4n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 03:15:08PM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > One thing that the commit message doesn't allude to (that is covered in
>> > the earlier discussion) is why it is important to pass
>> > `--ignore-cr-at-eol`. I think that is worth mentioning here.
>>
>> Isn't it because Git on the platform is expected to use CRLF in
>> certain places, unlike on other platforms where LF is used, but the
>> platform port hasn't adjusted tests to match that expectation?  And
>> vice versa, where Git is expected to produce LF terminated text
>> everywhere but the expected output is not "ported" to force LF
>> termination and instead produces CRLF terminated text on platforms
>> whose native line ending is CRLF?
>
> Yes, I think that's right. My suggestion to Johannes was to (a) make
> sure that your and my understanding is correct, and (b) to memorialize
> that understanding in the commit message itself.

It's not right, but mostly right. I.e. the "--ignore-cr-at-eol" is
surely needed to avoid a deluge of errors on Windows, but as I noted in
[1] you'll also find that the tests don't pass on a *nix box without it.

Which is apparently because "--ignore-cr-at-eol" is also conflating "is
binary?" with "should I replace \r\n", or something.

>> Use of "ignore-cr-at-eol" may allow such tests that are not ported
>> correctly to prepare expected output with a "wrong" line ending and
>> still pass, and I do think it may be an expedite way to make tests
>> appear to pass.
>>
>> But I worry that it may not be a good thing for the health of the
>> Windows port in the longer term.
>
> I share your concerns, too.

I don't really care about that, and would tend to defer to one or more
Johannes in this thread on that question.

But as noted in [1] the upthread patch seems to be replacing some
existing newline munging with not-quite-the-same "diff" behavior.

Which I think is something that needs addressing, either by the commit
explaining why that's desired & OK.

Which is also a good reason to pick one of our *nix CI jobs and run it
with "git diff --no-index", but without "--ignore-cr-at-eol", as I
suggested. It would tease out exactly that difference, both for current
and future tests.

1. https://lore.kernel.org/git/221114.86pmdplbs5.gmgdl@evledraar.gmail.com/
