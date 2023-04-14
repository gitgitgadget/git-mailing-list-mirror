Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6AAC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDNRaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjDNRac (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:30:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993F9ED7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:29:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5312bd4fso2423202b3a.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681493389; x=1684085389;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP+KreqbFMDeHjSLS/Sb0NzFVtkJsOjl0pz4ngIDnwk=;
        b=pv57Rs56vcNdCIp/PoCQYoAnC+xu9eO7HbzdrPzbdQ2vCHiRYBRuQh0FELs7qrzaVp
         PE5diHZr20yeIBHBNa55/fEvuXwjJgNOBgEFyhbt6n+c3+XzPEypgHpRlcsLyFBWefnN
         PPCITL9pGq40ToByF04SL3xjyhWv1VCzZqjjjvLM7JOf7lxdZDRdcEQmFNB4KKRrrg7v
         jfE505QzwcsKjCQYX8Eth35gWb01+sM8SJsUE0iT0PD6Xl+KG1G2PQfbd1hpp4Kaf8n3
         fjSw8MklVNX6Nj25dI0YKCPBPwgQByMlqydrlhwQeQAYIoyQU0mcv+bIKsEzvzAU2ftU
         4cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493389; x=1684085389;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sP+KreqbFMDeHjSLS/Sb0NzFVtkJsOjl0pz4ngIDnwk=;
        b=b5YxoKtmm7IX85HVHUjq0MCBK6QFU1D5AJlilHgYLxLzpDmNvPPHA8u+LuPsMYsnzb
         9t2ZN0e2sV6SByn5517rEJGcrv8T7JUwIzV33Vyso144tqbN8fgRXHvDovVEVneMbzo4
         4+vVbf9RBGnR8C9CYouL0hnS07EU9St+qZ0N9/b2FiZ+p6AEGjAO8r3ufV/oWIMZJF3z
         quvAlMXtRSv0QhOVry0CBNE5C2TCHYAk5VFcSgegojq5FQv3dBvoD/fNXXRu5wseXN6t
         ktE2d2GQxoDZ8YjPiVqSWM5ZASdcBCaOS0hjmxa+zjxMW5UbAQ+WSCVm/FUGQqVB79o4
         e9IA==
X-Gm-Message-State: AAQBX9ewcU5vzWHWCoS+Z/M7h+TEKjr9LHaX3icRtcHbuIofQZM9LJ86
        lgl0YIW9jhqLlSbTQEqJOPE=
X-Google-Smtp-Source: AKy350byTYBEcpIP+P1JIDrCqv7L+JkivRdrX6eR4sOOrsOU2eLAGFsX4VNAeFn1NqFXkgp6Vp9vjw==
X-Received: by 2002:a05:6a00:1386:b0:625:cf03:e8cb with SMTP id t6-20020a056a00138600b00625cf03e8cbmr6611761pfg.4.1681493388719;
        Fri, 14 Apr 2023 10:29:48 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7848d000000b0063b212638bdsm3265623pfn.220.2023.04.14.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:29:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v4 00/10] repack: fix geometric repacking with
 gitalternates
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
        <cover.1681452028.git.ps@pks.im>
        <15437c50-d3a1-1e34-b854-dc553e835cce@github.com>
Date:   Fri, 14 Apr 2023 10:29:48 -0700
In-Reply-To: <15437c50-d3a1-1e34-b854-dc553e835cce@github.com> (Derrick
        Stolee's message of "Fri, 14 Apr 2023 09:23:46 -0400")
Message-ID: <xmqqzg7aqsmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 4/14/2023 2:01 AM, Patrick Steinhardt wrote:
>> Hi,
>> 
>> this is the fourth version of my patch series to fix geometric repacking
>> with repositories connected to an alternate object database.
>> 
>> This version only addresses some issues with the tests, the actual logic
>> remains untouched:
>> 
>>     - The test added in t7700-repack.sh that verifies that `--local`
>>       causes us to disable generation of the bitmap index was failing in
>>       the linux-TEST-vars CI job. This was because it sets
>>       GIT_TEST_MULTI_PACK_INDEX=1, which causes us to disable the bitmap
>>       logic in git-repack(1). I've fixed this failure by explicitly
>>       overriding the environment variable like other tests in the same
>>       file do.
>> 
>>     - I've converted path checks to use `test_path_is_missing` and
>>       `test_path_is_file` instead of `test ! -f` and `test -f`.
>> 
>>     - I've fixed a typo in t7703-repack-geometric.sh and shifted code
>>       around a bit to make the test more readable, following Derrick's
>>       suggestion.
>
> Thanks for these updates. I'm happy with v4.

Yup, the changes since the previous round all look definite
improvement, and GIT_TEST_MULTI_PACK_INDEX=1 workaround looks fine,
too.

Thanks, all.  Will queue.  Hopefully we can merge it down to 'next'
soonish.

