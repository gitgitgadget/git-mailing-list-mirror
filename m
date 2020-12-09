Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF908C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF423B7E
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgLIJa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgLIJa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 04:30:26 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1CC061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 01:29:45 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id bo9so1071426ejb.13
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=+LpgyCcCDeIvhRmGrN0eT7FjzeFwXLkWiw+NS11Y1x0=;
        b=d9zF6Gxvkx9sanMnHJuoLf6w79CRTJ5UIOw2ujm7wAMYq1NirrRXFa234v7M59Y184
         dqfjwnUivhF2DbbrRBAhlB+gYfcRzhVswtUiZwVYKTm+blvYXWxOmisEFlzX/9lfcq5H
         EvL9A2sRNqD+bQm9Rcoq3uln9U0hpLVTzQCzZ6VfIzU+eOc9EIZSa+85sICniKcdJirR
         gIUIIFEhoPAslz4XFaOSmCiDo6ys82no3DZ5qrhJ3OJwgz0cvIADKYJCaBxFmFsDcylp
         aMWBjq4KfunqZBvmy/ut7AwWwP87EUGhobQkAAjiLbBgPYLSSYn86LEuI5zCpDmHJDKo
         q8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=+LpgyCcCDeIvhRmGrN0eT7FjzeFwXLkWiw+NS11Y1x0=;
        b=TvDHaViBDY5XWR9sQ5ayIk688mpNid5lClB0NU5180k4Px9CAtnLlQY1PkvlzlupDD
         9QlEK3L8Dw8IckBhliq9oF6qR5pUZNGw8hCSssmxlgwmmYXiAf5J9JRWMEkqBCCfq5+G
         Dd3jSZeZeaYBaCMuB9j1V8UVi2xneTetJxMzr8+HkX2ZeLEHFlwe26euPvcE1VMzJ2bD
         9HZIu8FVnhgfBSFDzw8DnYfQPMaiXouMUGn0CHQXofcyBuY1J75WDDRb8xgwddVmlqnp
         pwMzMwXlpdQVFqoo4+EEuTuv4Jq/SA6AG0sLMEJnPNQOTAkwEZi+y2U5ok19v8qtba+y
         O5Mg==
X-Gm-Message-State: AOAM533/gTHySabU3bOAx7AApU6dR3+ZI3VtncKFMOKmHMQ2lcbv71iy
        HBfHsipwKxSlDKE4At/BwvY=
X-Google-Smtp-Source: ABdhPJxZm10ke83twwZeGPefEJPmQkkxZ3RVh7WZy2RDJJsXTgAs4DbBKEBnB7B3F2dOETJUwnzWOg==
X-Received: by 2002:a17:906:1a19:: with SMTP id i25mr1271130ejf.206.1607506184574;
        Wed, 09 Dec 2020 01:29:44 -0800 (PST)
Received: from cpm12071.local ([212.86.35.58])
        by smtp.gmail.com with ESMTPSA id f13sm918641ejf.42.2020.12.09.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:29:43 -0800 (PST)
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
 <20201208201256.GK36751@google.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
Message-ID: <gohp6kmtynuzdy.fsf@gmail.com>
In-reply-to: <20201208201256.GK36751@google.com>
Date:   Wed, 09 Dec 2020 10:29:06 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Josh Steadmon writes:

> On 2020.11.26 20:41, Rafael Silva wrote:
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index d9e68bb2bf..ae5c29b0ff 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -441,4 +441,12 @@ test_expect_success 'register preserves existing strategy' '
>>  	test_config maintenance.strategy incremental
>>  '
>>  
>> +test_execpt_success 'fails when running outside of a repository' '
>> +	nongit test_must_fail git maintenance run &&
>> +	nongit test_must_fail git maintenance stop &&
>> +	nongit test_must_fail git maintenance start &&
>> +	nongit test_must_fail git maintenance register &&
>> +	nongit test_must_fail git maintenance unregister
>> +'
>> +
>>  test_done
>
> Caught a typo here, sending this as a squash patch since it's already in
> next:
>

Ufff. For some reason I completely missed the test error message when
working on the v2.

Thank you Josh, for the catch and quick patch.

Apologize guys for such mistake.

-- 
Thanks, Rafael
