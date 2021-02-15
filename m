Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11144C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D670164E2B
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBOStd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBOSt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:49:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92506C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:48:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g5so9410951ejt.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ljdhb8C73ML1u6zjvdZjGnmK6XJ8ZwSzULeoP2S7Oa8=;
        b=NW/31S1ijiZIc9mzfK51JCcwrUgGRTmFB6ExnoaGWYdpanFS5s1tJuCC2vFzXa3+VY
         5XncuZAvZqb6S5MT9KLSrscBe5PlcgeSDlzekIOQtp5zpaMIe5QG+VEsSX7R0D8k0Mms
         k+Dzi975UtuwMfhyQzkm7RHxnGLjVGzZi9LRSYYoQEww2KdlKZckZaH4W4HYG5go28LZ
         Dkhx310uH3VcBMo5+MZSYMJtgeQXq7n/yTRmONaksAEIUCcUvXH/KaUtuDSbqnbkohO7
         pywKX4UDQXMCidoUr8mMT55qOhwD1dIwDHhWkLj3NFXGOZislKxfgkB92ccmtZpEFMYw
         hPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ljdhb8C73ML1u6zjvdZjGnmK6XJ8ZwSzULeoP2S7Oa8=;
        b=Ff3qyBxbKdFb/vYrhxelzpQAqTsLE58FA3nbo11tOZSBb9DfonmgY99tUcMuKx06VE
         QzsPydI9qLUn2+BKam1Yu2YemXI8pN5pweHZ1Kctbfzv0WiSfQjNXY2ZsQLRKJj09DV0
         1gzM0WxCn41CMKliy2ya8KAjS+XkRMcdj6yQrBvKSQn2+awBp1iBm8KtZeBmkFVpC52z
         bEE3hO2L86PT6+C1xlL/y9lGaXcfU5xeCY1ZyXH+7k8dM3oTNnQrr/2QP5ompAQAaHrt
         tL5AtWjxZUyRThYrz1LemREyLtFcwnulFnrPRJbYOV2ZF5djR80ebJy85uDTFgI6YVsk
         XQJw==
X-Gm-Message-State: AOAM53338zmXuVD2LwKc6B4+hNxE2GQuR1WN/pgQ/n0n6hwoIvGt8kjT
        lnd1qabcixp6a3GdAcDW+xs=
X-Google-Smtp-Source: ABdhPJyQrrtO6tw3sg0WmBJsY2BFfCLWEIyfUDfOeQxeamvDE+/yrR72RZiBsnUQL3lqX1tfZ1tmzQ==
X-Received: by 2002:a17:906:c00c:: with SMTP id e12mr16942328ejz.103.1613414926280;
        Mon, 15 Feb 2021 10:48:46 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ks13sm4055897ejb.69.2021.02.15.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:48:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
Date:   Mon, 15 Feb 2021 19:48:44 +0100
Message-ID: <87o8glb20j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Johannes Sixt wrote:

> Am 15.02.21 um 16:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Fix a regression in the test framework for userdiff added in
>> bfa7d01413 (t4018: an infrastructure to test hunk headers,
>> 2014-03-21).
>> The testing infrastructure added in that change went overboard with
>> simplifying the tests, to the point where we lost test coverage.
>> Before that we'd been able to test the full context line, or ever
>> since the feature was originally added in f258475a6e (Per-path
>> attribute based hunk header selection., 2007-07-06).
>> After bfa7d01413 all we cared about was whether "RIGHT" appeared on
>> the line. We thus lost the information about whether or not "RIGHT"
>> was extracted from the line for the hunk header, or the line appeared
>> in full (or other subset of the line).
>> Let's bring back coverage for that by adding corresponding *.ctx
>> files, this has the added advantage that we're doing a "test_cmp", so
>> when we have failures it's just a non-zero exit code from "grep",
>> we'll actually have something meaningful in the "-v" output.
>> As we'll see in a follow-up commit this is an intermediate step
>> towards even better test coverage. I'm structuring these tests in such
>> a way as to benefit from the diff.colorMove detection.
>> The "sed -n -e" here was originally a single 's/^.*@@\( \|$\)//p'
>> pattern, but the '\( \|$\)' part had portability issues on OSX and
>> AIX.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   t/t4018-diff-funcname.sh                      |  7 +++---
>>   t/t4018/README                                | 22 +++++++++----------
>>   t/t4018/README.ctx                            |  1 +
>>   t/t4018/bash-arithmetic-function.ctx          |  1 +
>>   t/t4018/bash-bashism-style-compact.ctx        |  1 +
>>   [...and so on...]
>
> This is what I meant by "without burdening test writers with lots of
> subtleties".
>
> I'm not a friend of this change :-(
>
> I think you are going overboard with required test precision. To have
> useful tests for userdiff patterns that demonstrate its features,=20
> authors should write *many* tests. The right balance should be on the
> coverage of userdiff pattern features, not on the subtle details of
> each and everyone of it. Requiring that many additional context files
> makes it *really hard* to comply.

I agree that this change sucks when viewed in isolation. I think it has
value as part of the larger series, since (as noted in the commit
message) the point here is to allow the reviewer to see the the test
content & semantics aren't different.

I suppose I could do some version of squashing this and 12/27, but then
I'd be introducing the full testing of the context line at the same
time.

By doing it this way I split the change in test semantics from the test
structure change itself in 12/27.
