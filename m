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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB69C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A860F6D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhIKC15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKC14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:27:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375EC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:26:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q3so5208013edt.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YUNKEPntphJ4mptMexSAtwgg5sZln3VvO7PgucliCO8=;
        b=OTlVFFaL/Q8F9Xh2nno/FTo9NSIzWq4395+5boVTctq817dsgq/TZlPdNbpCKZEJx+
         HCgLHUzQ3WwM5yPVvFyN7bSnJbWIEQkx6r/H8xyO7matOkjE21ZLzPUHjEvo1EUHK2GJ
         319pfuOBdC0HezjOp6O8F/mBkdpVeo8WB/kC58KAMB/t6hxc9PjiIENDblxglrQJdfNi
         2HybSqSUW62dYb3l6xB0NnGUkD0yus8nafrk/ZQ2n+y5l+Q2LveFxcfDug8epRMOza94
         IkhpqM2Vn7+qSX+7k9wgupuFTjG0FXQzc/dQ5PfQypIsE25dQ+R9f0rTk9ufdbFuOWKs
         zrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YUNKEPntphJ4mptMexSAtwgg5sZln3VvO7PgucliCO8=;
        b=RXJJkSzcw/wnNY2+XLgvH6hQpFIdVhSO/Z+0S1oQ1vvgJLwQZAfEKmgNNNZ2c1AgYm
         qdz1rNdoapDeSSc3EoUFdfs6vp0+/TakcsnlGi/rDqdUL/m3EedF5rIA8LkvVqcXwjtE
         UB33ApUtZnK2NMrZZlUsaV7L7mK3fJTpXE1qLRz7AGnaxRJWyxciEYwNdXzXf9Oh/yho
         noRxqM7vejYxImJ1cSO8V8IkGIEH1SuZPb3srnbDA9m+bORaiKjLiwXjxdxiwIFm3xG7
         LMwil2J/A2Lu/9b0ANFQMtjoR1njfv8IdmjIhcFpsGjCBmy3tsqIWCF9HVjhwgrodhkg
         3rIg==
X-Gm-Message-State: AOAM531BJoxkacXGkjb1yU4LpCJmiv6SByAxxiz1RtwktPLuXG4QP7Ad
        ldUmQ4FgndzQJ3k5kbARhsql/DopszsUhQ==
X-Google-Smtp-Source: ABdhPJy6ptfXrMfIMEmx3CH3MG3edghoZZIW0y6fbus1++omkBVXB3pOf9hfXFMEqUz7iJHtHGIN0Q==
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr967010edo.167.1631327203593;
        Fri, 10 Sep 2021 19:26:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w3sm174187edc.42.2021.09.10.19.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:26:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] help tests: add test for --config output
Date:   Sat, 11 Sep 2021 04:25:53 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
 <patch-v2-3.5-258282095de-20210910T112545Z-avarab@gmail.com>
 <xmqq8s03oq0t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8s03oq0t.fsf@gitster.g>
Message-ID: <874karc0f1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a missing test for checking what the --config output added in
>> ac68a93fd2 (help: add --config to list all available config,
>> 2018-05-26) looks like. We should not be emitting anything except
>> config variables and the brief usage information at the end here.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t0012-help.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>> index c3aa016fd30..595bf81f133 100755
>> --- a/t/t0012-help.sh
>> +++ b/t/t0012-help.sh
>> @@ -77,6 +77,19 @@ test_expect_success 'git help -g' '
>>  	test_i18ngrep "^   tutorial   " help.output
>>  '
>>=20=20
>> +test_expect_success 'git help -c' '
>> +	git help -c >help.output &&
>> +	cat >expect <<-\EOF &&
>> +
>> +	'"'"'git help config'"'"' for more information
>
> 	'\''git help config'\'' for more information
>
> is a tad shorter.

Thanks.

>> +	EOF
>> +	grep -v -E \
>> +		-e "^[^.]+\.[^.]+$" \
>> +		-e "^[^.]+\.[^.]+\.[^.]+$" \
>
> I have to question if there is much value in this test, especially
> the latter pattern.  A configuration variable with three-level name
> can have any byte, including a dot, in its second level, so
> rejecting a name with more than three dots in it can over-filter,
> depending on what new keys we'll document in the future.

This is from what we extract from the headers in the documentation, so
it's all strings like:

    foo.<name>.bar

In cases where there's some three-level arbitrary string key. That seems
unlikely to change.
