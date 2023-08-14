Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19FC04A6A
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjHNN3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjHNN3k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 09:29:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A944DE77
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 06:29:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso43947305e9.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692019777; x=1692624577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8KtCCx7NokNbX0Hdydq6t3g3iyyeQBFNoJkwY4ae/gA=;
        b=YNEHIrsOJHw3wGV920ApcFeUMAkEWHhJARQbfR8RkCBBLJblBaYIy2NN+GEW3jx0OA
         DZPFID9wavYJrmr68wFGZtZXJahiWYBxwQoUDHC/6ct5NeyI4eZ2eQ6DWxuCPF7zfQnK
         mvG9h8EnTG+eRo+Kqg82ESllhwFdKmxS8Z7hoiTsgLzoMUzdcKJ0So8GHHExdeT05i5/
         tAjFGMuk1qs+sRTTD3r2vOQlN6kc33hBszL+kdZUU+ngMqcbr19t2jQFOc0k6YqVe9z2
         Gj24DFIbZ1+B51Pge9nTycOgLvAfqwXd42abtqu9fWLlFXBcgoorMrO9HwfMPY4vpJOa
         J83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019777; x=1692624577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KtCCx7NokNbX0Hdydq6t3g3iyyeQBFNoJkwY4ae/gA=;
        b=bpeD4bEvHM7LZzTmPAVo0NgdUgMwEBJ8p+wxekHiDLBF5sOByYsln/dcPMVij2qb2R
         fbbEXRJLmhCR3/7/CuRxGh37GFHeFk3hpKiFR/2BwHiLOvNy0MEs0vDtrMSrB2ZRo5rk
         /GN8bGsIaN+9qffOqbEIYck8D5lHT5aLRf5ZpItb8zIQgfIsqmoZETNEvDlft+WGDcUi
         HXf5FxiZQ1lEIsiIDgEmfMfH9scsK58TROp8EFGoPfjgH+BDrg3pMCB42sVwV4IGpnkc
         wtFqO5zORs7jZ8ifAdAMqX+4FU2nnj28Xbul2BY1HAFIts6NTx58hRfgbGlNO7UXbk04
         SdCg==
X-Gm-Message-State: AOJu0YxQXbpmexkrfklMI50J5S/UnKNu7Sn4gugg+8rG5NIPKOMgBek9
        wB5SQEw9pEUOcx1ZhUKTAGE=
X-Google-Smtp-Source: AGHT+IEFEmuRggWcYy5qL2G8oGoWqqL3x5CtDjPfrvEWN2RJ/Nfzv6MAJ9gQehpQ9c57IPBnq1a+/g==
X-Received: by 2002:a05:600c:2494:b0:3f8:fac0:ad40 with SMTP id 20-20020a05600c249400b003f8fac0ad40mr7843409wms.29.1692019776897;
        Mon, 14 Aug 2023 06:29:36 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id c14-20020a05600c0ace00b003fe4548188bsm17178567wmr.48.2023.08.14.06.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 06:29:36 -0700 (PDT)
Message-ID: <90651b2b-6a7a-2ed0-716a-fc87adc957ba@gmail.com>
Date:   Mon, 14 Aug 2023 14:29:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] unit tests: Add a project plan document
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, chooglen@google.com,
        gitster@pobox.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <c7dca1a805a16fd4fd68e86efeec97510e3ac4b8.1691449216.git.steadmon@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c7dca1a805a16fd4fd68e86efeec97510e3ac4b8.1691449216.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh

On 08/08/2023 00:07, Josh Steadmon wrote:
> 
> Reviewers can help this series progress by discussing whether it's
> acceptable to rely on `prove` as a test harness for unit tests. We
> support this for the current shell tests suite, but it is not strictly
> required.

If possible it would be good to be able to run individual test programs 
without a harness as we can for our integration tests. For running more 
than one test program in parallel I think it is fine to require a harness.

I don't have a strong preference for which harness we use so long as it 
provides a way to (a) run tests that previously failed tests first and 
(b) run slow tests first. I do have a strong preference for using the 
same harness for both the unit tests and the integration tests so 
developers don't have to learn two different tools. Unless there is a 
problem with prove it would probably make sense just to keep using that 
as the project test harness.

> TODOs remaining:
> - Discuss pre-existing harnesses for the current test suite
> - Figure out how to evaluate frameworks on additional OSes such as *BSD
>    and NonStop

We have .cirrus.yml in tree which I think gitgitgadget uses to run our 
test suite on freebsd so we could leverage that for the unit tests. As 
for NonStop I think we'd just have to rely on Randall running the tests 
as he does now for the integration tests.

> Changes in v5:
> - Add comparison point "License".
> - Discuss feature priorities
> - Drop frameworks:
>    - Incompatible licenses: libtap, cmocka
>    - Missing source: MyTAP
>    - No TAP support: µnit, cmockery, cmockery2, Unity, minunit, CUnit
> - Drop comparison point "Coverage reports": this can generally be
>    handled by tools such as `gcov` regardless of the framework used.
> - Drop comparison point "Inline tests": there didn't seem to be
>    strong interest from reviewers for this feature.
> - Drop comparison point "Scheduling / re-running": this was not
>    supported by any of the main contenders, and is generally better
>    handled by the harness rather than framework.
> - Drop comparison point "Lazy test planning": this was supported by
>    all frameworks that provide TAP output.

These changes all sound sensible to me

The trimmed down table is most welcome. The custom implementation 
supports partial parallel execution. It shouldn't be too difficult to 
add some signal handling to it depending on what we want it to do.

It sounds like we're getting to the point where we have pinned down our 
requirements and the available alternatives well enough to make a decision.

Best Wishes

Phillip

