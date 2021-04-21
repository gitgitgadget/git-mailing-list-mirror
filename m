Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A3C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7004261439
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhDUIXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhDUIXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:23:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2FDC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:22:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so62269481ejo.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BkKoMMbU5jUBpjPGAf6VzJQn//dNwn5yccAt486FF8g=;
        b=c1TSPGeELg1LlvcDj1ZK9tDK7A6YgR1lOKxojjT1BN5Ye7eUMVSo5GL5GszEi3W9Q8
         EXij5TpGoVtjhzBLe+PeFPUWUbtd8GHoZsYrw9q52pERme/+kBVpiep3NNnKEK13VQtK
         YeiLS5jdCN1In2DeW4h8HEIahY9DuvY3ncua/pE4l/qv8PPdUZooVfgwcBDtoWdGC088
         eiVSIKlv1b9cj3USW8WRPfwcIHg6XJY9nk07yfBdiOMyvO/U0UxCLKUZV7f57fnGKD6F
         W6TZnGPsqC3UlUZ9r1IFzbVdl7hy1LmCyot+V4G6+NeBgTO80ENOHgpl7hJWZ2mhxfR5
         4BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BkKoMMbU5jUBpjPGAf6VzJQn//dNwn5yccAt486FF8g=;
        b=Cbr+OBvXSnsLx18lEldTtn91k9VmidqQ7Ht+InIrIWSArGGnfWbmXXgYmrKunG2UCf
         e49qLRwq6lJZoCarugjQXjYXl8AA4uKoGadwfZIZK8um1t3vbZc5oZMpHbjR9uFCA2ct
         hFiq1s7Q2zciA3ThsS+3Q7xIgIE6CJEtOGZyh+F0fLi2nx1gISmq0UyJjuwiI4XDJirE
         /VzSbRgT+H8YFtwyvj0FOPPI0yIndOFhkPungo2/KjuvvSj86DToPJkQRMTTUXeDAQ5g
         bMGqJUt0ZVZh6goqTTB+aHICqhssI4PSLyQDDweFu7tC7i+17iguoxsbXRC8PCQrXZh5
         iGIg==
X-Gm-Message-State: AOAM532ZaMgv+3MNH5grr1bzcCa7K74qYl7Fg5x2HIGAIg/eKeKEMRgn
        zXSwNic/FKdITXpIMFJf2j9ptdC9LS446g==
X-Google-Smtp-Source: ABdhPJyEiQsmc6QiD/4XMJ2oeR8TbeNOKezkZdS+a1E9KW0mS7y7aAcRysNVEdfD9iQ7EeD/idNFsQ==
X-Received: by 2002:a17:906:8303:: with SMTP id j3mr31676552ejx.85.1618993345678;
        Wed, 21 Apr 2021 01:22:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v5sm2320333edx.87.2021.04.21.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:22:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
 <patch-2.3-67ddd821df-20210420T122706Z-avarab@gmail.com>
 <CAPig+cS31db=769dNZbADqCpkhR9PMuHv5x9knFvi=zSqoMF_Q@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cS31db=769dNZbADqCpkhR9PMuHv5x9knFvi=zSqoMF_Q@mail.gmail.com>
Date:   Wed, 21 Apr 2021 10:22:24 +0200
Message-ID: <87wnsw2gjj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 20 2021, Eric Sunshine wrote:

> On Tue, Apr 20, 2021 at 8:29 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> The goal here is to get rid of the verbosity of having e.g. a "test 2
>> -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
>> to intentionally feed the "test" operator too many arguments if the
>> functions are called with too many arguments, thus piggy-backing on it
>> to check the number of arguments we get.
>> [...]
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> @@ -756,41 +756,43 @@ test_external_without_stderr () {
>>  # debugging-friendly alternatives to "test [-f|-d|-e]"
>> +# The commands test the existence or non-existence of
>> +# a given argument.
>> +#
>> +# The pattern of using "$@" to "test" instead of "$1" is not a bug. We
>> +# are counting on "test" to error on too many arguments if more than
>> +# one is given. Checking "$#" explicitly would lead to overly verbose
>> +# -x output.
>>  test_path_is_file () {
>> +       if ! test -f "$@"
>
> Thanks. The new comment makes the intent of "$@" clear.
>
> If you do re-roll for some reason, it might make sense to move the new
> comment (the one starting "The pattern of...") into the function
> itself just before the use of "$@". The reasons I suggest this are:
> (1) the comment explains an implementation detail, thus is intended
> for people who might change this function, whereas all the text above
> the new paragraph is API documentation for callers of the function who
> need only the black-box description; (2) it places the comment closer
> to the relevant code, thus is less likely to be overlooked by someone
> changing the function.

I think moving it would be worse / wouldn't make sense.

The comment doesn't just apply to test_path_is_file(), but the next N
functions that use the "$@" pattern. Just like the existing
"debugging-friendly alternatives" comment does. I.e. test_path_is_file
is just the "-f" part of thta comment, the following test_path_is_dir is
the "-d" etc.
