Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0956C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhLPOXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhLPOXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 09:23:14 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55834C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:23:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m6so36704266oim.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QFeaygRXSwXJxTvq9KAoqZYkqS6v5GeJMnHlAdU1i3k=;
        b=mO6INxxoagCxuhDgVqBClSCbOG6Kw44RWFg7+nfsszUAZ9P0T36Ej1J9YadiOxHVSc
         kJFFgjVZ/s91pM6/3V/gwE1x6LGmOmzH/dp0K54CVN/WV4wfS/o88/48bNUyI+QZZ8YL
         iOPKtK7jwfGm0I05eHwuumpuosEELFCgmRBor+C7SSYtsMB0+yzuV7zIfTQ+DUQznPm8
         c/som0n1RcAc4vo4ClhzMl+PT2NDnWVdRe/BbFueWo5Q15PslXMVuTz0xjvGEpcJpD9r
         a5wfv6uAvjU6Ps0We2ZtHXCvUid+viqRCuzLT9LgjmWTe1UW24BQ/BvSi5za5pSV3TrM
         QLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QFeaygRXSwXJxTvq9KAoqZYkqS6v5GeJMnHlAdU1i3k=;
        b=ZdxLtyGDw5CBn4I3P41JqKmUTR4t71tXCgmF9QY+wnFfugxtwCwCXTAeXupmRRMRrw
         1YBmpNskllBJfocTLPIdS7p3AH6ba1ZNiDqK24bch8oVKhaLMirDXKazDUD4R0BRgAES
         tN0MHncV/44amD9skpUaPgp3fGqpvMYjZB3vmZgm8pIaLvtKNwRr0Pex3ER6eU7ajGrZ
         ZkJcHkIAOI4ACsXDVU8GwyUT/LOHgpd8oNTOoxVOTwF+cUbxC0QvWPglq2d0DdPaNCv8
         mfmLdZCBYGBhrqup8KOCz6D6TKfRTz6V8pOzVr4uX4OkTIC31sMzjmMUd4D2X09rwqnj
         45HQ==
X-Gm-Message-State: AOAM531eCXggxlgNehU/Ez6ois+pkbypmhTw54wWdIg+CP5GzNsqP8W3
        BS5fHHsjMPv9hIk2ndJe45o=
X-Google-Smtp-Source: ABdhPJyGR1EjCZHM564zSnfidnZe5EGKJlBqG3t5ZYE8SmXbh5TMB4aoLvprPx19sn5lqbgWOhb3zA==
X-Received: by 2002:a05:6808:2181:: with SMTP id be1mr4085529oib.147.1639664592492;
        Thu, 16 Dec 2021 06:23:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f174:15fc:4a5c:9d45? ([2600:1700:e72:80a0:f174:15fc:4a5c:9d45])
        by smtp.gmail.com with ESMTPSA id a16sm1048338otj.79.2021.12.16.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:23:11 -0800 (PST)
Message-ID: <55dee0a3-5a55-1af9-74b3-296426458f5c@gmail.com>
Date:   Thu, 16 Dec 2021 09:23:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/3] sparse-checkout: fix segfault on malformed
 patterns
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
 <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
 <1744a26845fbe4d7dbc80f387be1d842b5f8fe94.1639575968.git.gitgitgadget@gmail.com>
 <xmqqv8zp4mfm.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv8zp4mfm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2021 3:56 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
>> used to populate two hashsets that accelerate pattern matching. If the user
>> modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
>> then strange patterns can happen, triggering some error checks.
>>
>> One of these error checks is possible to hit when some special characters
>> exist in a line. A warning message is correctly written to stderr, but then
>> there is additional logic that attempts to remove the line from the hashset
>> and free the data.
> 
> Makes sense.
> 
>> This leads to a segfault in the 'git sparse-checkout
>> list' command because it iterates over the contents of the hashset, which is
>> now invalid.
> 
> Understandable.
> 
>> The fix here is to stop trying to remove from the hashset. Better to leave
>> bad data in the sparse-checkout matching logic (with a warning) than to
>> segfault.
> 
> True, as long as it won't make the situation worse by depending on
> that bad data to further damage working tree data or in-repo data
> when damaged working tree data gets committed.  And "list segfaults
> with freed/NULLed data---so leave the bad ones in to print these bad
> ones" feels OK-ish.  
> 
> As long as the user is not transporting the listed output to another
> repository, which may fall into "making the situation worse"
> category by spreading an existing breakage, that is.
> 
> In other words, this may paper over the segfault, and it may be safe
> only for "sparse-checkout list", but is it safe for other operations
> that actually use this bad data to further affect other things in
> the repository?  If not, I wonder if we want to hard die to lock the
> repository down before the issue is fixed to avoid spreading the
> damage?

You're right. I should do what we do elsewhere in this method and
disable cone mode pattern matching, reverting to the old matching
algorithms. This will clear the hashsets and avoid using them anywhere
else.

>> +test_expect_success 'malformed cone-mode patterns' '
>> +	git -C repo sparse-checkout init --cone &&
>> +	mkdir -p repo/foo/bar &&
>> +	touch repo/foo/bar/x repo/foo/y &&
>> +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
>> +	/*
>> +	!/*/
>> +	/foo/
>> +	!/foo/*/
>> +	/foo/\*/
>> +	EOF
>> +	cat repo/.git/info/sparse-checkout &&
> 
> Stray debugging output?

Thanks.

>> +	git -C repo sparse-checkout list
> 
> And we are happy as long as the command does not segfault, and we do
> not care what the output is.

And I'll be able to test that the 'list' subcommand changes behavior
when cone mode is disabled, in addition to checking stderr for the
correct warnings.

Thanks,
-Stolee
