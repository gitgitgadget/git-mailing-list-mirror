Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C7C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiBAVXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBAVXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:23:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714AC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:23:07 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so58360748ejf.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8eGsVzZi3q1ijHTulTfD3Ku1vMZRCLE8IHiEoqFUuUY=;
        b=ey8Mn/GaD22BYnUTFvwXcXj/JYaY/bab9GPYDVriDdv7nCClLjrnCD7boBliCrZImF
         ImO4PEms45Scd7oTKijoczKsd/vYRkRqLGmywmRdcv+ig6k5t81joIfDM0M7dP/VmbYF
         n35MvybEuEYqeuyP6uAmXbWfREe8CtT5ZJbL+eSdrZZCMoGbdEsqqvjQYK5H0ptXqxad
         exshtRtDTNm6Qnl1z1gb+2moSAzfBqBK9LHxhXPgTZMWa4/O1MBV3jXLc1Z3O+TBf1HB
         68SlHAwZIi2y/bIaae5MMUl5BwyxmxuAQhrrG9RVgPN0vobBLJq40cMEJjOjsns9wge1
         eKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8eGsVzZi3q1ijHTulTfD3Ku1vMZRCLE8IHiEoqFUuUY=;
        b=aTayNcK1clYRgTac7W9uWrt2YlF69/pQaBzh4pYuXYiEBN0NPQnpQIloBMl5YF4BmK
         1EtByY6xf86RTQWznq4wcPedEBZlbyoEYkBgYUBbs/1aoFHyj9+7Ny26sSkA/lb/mwyM
         le13twRimqXrcFeAfcsQHrkHqkTM0Y9pXZIyqvBfALft+lK/CvTsx8P17zDk1t8gggi+
         P/SaAA92fncZBg8l/yPGMvcBqThRPtzGn6oAQaONN6TvIKfRN5VYuFW5SsDzBbiWPgBU
         uSTpbMLaPtveDmcQ6txZQABKxUrQQX4Mc1D3oH5vaSiVbRB7NUGnfKhlXTR0bTLB8i2S
         II7Q==
X-Gm-Message-State: AOAM5310u0+ZnHjheMoYTf0mwjpBMGMFKmDWIriVr/XgdsVaoLel0bp7
        lNrf0o+7OHCUBJLVaprUPuI=
X-Google-Smtp-Source: ABdhPJz9aQvVQhZxx9w+KEmLBDF9pB1pKcGTuZE9c3Q056JJxt8t6YubJlsaghcBF4UYlQURYGYhsA==
X-Received: by 2002:a17:907:3e9c:: with SMTP id hs28mr22133714ejc.735.1643750585628;
        Tue, 01 Feb 2022 13:23:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qf6sm15027136ejc.49.2022.02.01.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:23:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nF0cC-004N5I-Gn;
        Tue, 01 Feb 2022 22:23:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
Date:   Tue, 01 Feb 2022 22:22:00 +0100
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        <xmqqa6facn9i.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqa6facn9i.fsf@gitster.g>
Message-ID: <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 01 2022, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>>> Because there is no generic reflog API that says "enable log for
>>> this ref", a test that checks this feature with files backend would
>>> do "touch .git/refs/heads/frotz".
>>
>> There is refs_create_reflog(), so the generic reflog API exists. The
>> problem is that there is no sensible way to implement it in reftable.
>
> Ah, yes, that's correct.
>
>> One option is (reflog exists == there exists at least one reflog entry
>> for the ref).
>
> Because the current callers of refs_create_reflog() does want a
> reflog created that does not give any entry when iterated, I agree
> with you that adding a "fake" reflog entry alone is not a sufficient
> emulation of the API.  I think these are all ...
>
>> This messes up the test from this patch, because it
>> creates a reflog, but because it doesn't populate the reflog, so we
>> return false for git-reflog-exists.
>>
>> It also turns out to mess up the tests in t3420, as follows:
>>
>> ++ git stash show -p
>> error: refs/stash@{0} is not a valid reference
>>
>> I get
>>
>>   reflog_exists: refs/stash: 0
>>
>> and "git stash show -p" aborts with "error: refs/stash@{0} is not a
>> valid reference".
>
> ... indications of hat.
>
> I wonder if it is simple and easy to add a new reflog entry type
> used as an implementation detail of the reftable.  If we can do so,
> then, the reftable backend integrated to the ref API can do these
> things:
>
>  - reflog_exists() can say yes when one reflog entry of any type
>    (internal to the reftable implementation) exists for the ref;
>
>  - create_reflog() can add a reflog entry of the "fake" type
>    (internal to the reftable implementation);
>
>  - for_each_reflog_ent() and its reverse can learn to skip such a
>    fake reflog entry.
>
> As there is no way to ask, via the API, the number of the existing
> reflog entries, the ref API callers would not be able to tell such
> an implementation detail that with reftable backend, create_reflog()
> does not create an empty reflog.  To them, a reflog created with the
> API call would truly be empty as iterators will not return anything.

We could surely add magic record types, but how would such a dance be
performed while keeping compatibility with existing JGit clients?
