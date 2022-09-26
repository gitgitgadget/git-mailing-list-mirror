Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B8C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiIZJNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiIZJNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:13:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18163DF31
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:13:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z13so8031263edb.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=RM1AMTzzQh25eguqSTU9d1amCgdY2alZ60PDgw9RMPQ=;
        b=KviUn/x9Kxk9QZV8IW6AtpfF0uYStRq8+D6LDUG0pfRnVQvc25woqMmqMIwhwa2b8o
         UYKJcgjn8ff+RXwyYmXIw1lRt98R/pLe6/Mawu/lpbCPlEjZY0tzQSFBAUk1f+nMDZYi
         T4WxW7d72+K8II7YXN7UH4UjLW6ybiIDzvVhMESAw5kfUCx8gfvGTNbUoDM+PxpqqenG
         3LZhqevEEccx0NBgijObrvQEJKsO+gVYochSoCU843NVIxu+Frh99X9FGUYAUjNM/IIx
         oNW5guqis2bmfRf64VGSp7lTDBM3UCiN/3SES32cwYvkwF+QTcp9ZSjifKIYgqBRXyK/
         9m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RM1AMTzzQh25eguqSTU9d1amCgdY2alZ60PDgw9RMPQ=;
        b=tgFIJKm9Nm2q0xjvn0XsDGi9vGyQWjV8eKk6/u/nVh1mWKCyv1ULzqllykqvImrm0p
         bRrsrxmveImuLxTv/ba9qyo4twDVXrCY4boOmeNGLrJMAZ8IGzDj+wxGytPQRNM88YUr
         KT0r1cL8Hc7lJoPGpUNXxFoTAeyuq7JXRL/lMOvNfi8/X0sHixQMQS7bCfFN5HkjgphC
         DKiK/0LfjUVXXV33xUIb8mj1iSSvj+7Ytte2LDr47iumW3HkuFDuj8kH4Ix15+d12GE7
         ntYhY5Tg42NXpjetdbfGPUdgyHPo2TEdmO1rHXmYRZHLMbxWejlm2SbYXExZJgl1y5zm
         4sBA==
X-Gm-Message-State: ACrzQf0Z8hs4SnHtEhLOdTf3/7BrIC+D+S1t7uGFkM3z98WvDDEbLlOp
        Nf17N7FAPyMsox3K2RYXl8TQYB1vIMI=
X-Google-Smtp-Source: AMsMyM7zFNcgtJjF1ZgMdZC6Tht+NPeo1+JO/5kIonLWdnpzjijYFb0kBKZmaI3MSQu8/SGGbZGhSQ==
X-Received: by 2002:a05:6402:3784:b0:453:9d2a:771b with SMTP id et4-20020a056402378400b004539d2a771bmr21409861edb.353.1664183616355;
        Mon, 26 Sep 2022 02:13:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kw12-20020a170907770c00b0076ff600bf2csm8038178ejc.63.2022.09.26.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:13:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ockBC-003nx6-2n;
        Mon, 26 Sep 2022 11:13:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
Date:   Mon, 26 Sep 2022 11:08:55 +0200
References: <20220920105407.4700-1-szeder.dev@gmail.com>
 <20220920201619.40972-1-szeder.dev@gmail.com> <xmqqv8pg399k.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8pg399k.fsf@gitster.g>
Message-ID: <220926.86pmfi33cx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 21 2022, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> The 't/test-results' directory and its contents are by-products of the
>> test process, so 'make clean' should remove them, but, alas, this has
>> been broken since fee65b194d (t/Makefile: don't remove test-results in
>> "clean-except-prove-cache", 2022-07-28).
>
> What I find more disturbing is this is part of "leak check" topic,
> and I see no reason why we need to futz with "make clean" rule in
> the makefile while extending SANITIZE=3Dleak support.  We really
> should yell louder when we see topics that tries to do too much
> "while at it" and reject them to minimize the risk of introducing
> this kind of breakage.

FWIW this wasn't a "while at it", it was critical to making another part
of that topic work at all.

It adds a "check" mode, which I use to check that the
TEST_PASSES_SANITIZE_LEAK=3Dtrue markings are correct.

Intrinsic to how that works (and [1] has more details) is that we "pass"
all tests, when some of them really failed under SANITIZE=3Dleak. I.e. a
failure of a test not opted in to TEST_PASSES_SANITIZE_LEAK=3Dtrue is
considered OK.

Without fee65b194d that combined with GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue
added in the same topic would make post-test leak analysis I do useless,
because before fee65b194d the Makefile made the assumption that
"test-results" directories were only need in case the tests failed.

1. e92684e1a26 (test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck
   mode, 2022-07-28)
