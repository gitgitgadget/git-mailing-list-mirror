Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE45C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E3664ED1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCSNAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCSNAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 09:00:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A84C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:00:12 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v70so2693173qkb.8
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kczkwtoVkz5aCzka28zqP5FGQ2g/ngUQ28wV5C3zbH8=;
        b=Bi44sSzcFm2Y3FoS0xIpk+OlYdXqfenUjB0vQ/o+N/Et+HkVW72bNnJiTvGF4m6NqG
         ZgSpMz9NoCcktfJtBOZHH02BnOV/xPd+PyMsRnTic9vhwNN1ZgZDaiB9rUktrZ12LY1+
         pom13UPxwmYocivhBkfFgo798gIbO7UTBcWXoS9x0ZXHmmABlXmbgRIuBq/DdEJqi+4Q
         5X/1kbeA0r4gNKWJEj4J87bFnVxd/69CFBhQtcKg8xeL0MR9X1Em3YkZ9/fO3lv8UNp3
         2w8JtxEw8V+rTbdeNpsAwSqyRw4MBPwXy+EHakpBYbLk0BXg+EtaZt9nD68EF4HW2qfG
         /kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kczkwtoVkz5aCzka28zqP5FGQ2g/ngUQ28wV5C3zbH8=;
        b=sIGCh+ZLXR7ii7J62Q6/jNZuOuefSz/Aj1xapmUQJNvQ/yJt1UWwTSro+oEFtPNfq3
         pNWHkEJxMdSHrB762D68pwz3fshmr6zshO6mHwQSb8cw3IzpDWhMHpFnlOstA/gyIIFo
         +UCP+BckeZXpNu26ng6Yt6yFFpDI5WWyKcMQQqtiRkKZSIldGmSSOZHs3tSrR9jNIXQn
         once8uhkBtkK7EIIR12wOFefMulNokZS92GLzfVLa3brIcAW7xTbBOoUpscPXDUna/xO
         aBA7TI07QeaHQAjpuvOX8fOJFskveXoCv36deMO862NJEPgAA/WKE51L822Pxdblappg
         4s7g==
X-Gm-Message-State: AOAM531kC5NxPvqP+HrmmKHacTRVtppol8LrQkuK9ZBi9V7qnpYQXHPH
        4BeZ01riyopeZ3W2Y+aNsUM=
X-Google-Smtp-Source: ABdhPJzqAHlU+l+iygL6TOCdr2LUp523nDkFdJReT1v7SII1bwvO1wtZTisLlWshidoNTODn8lBocw==
X-Received: by 2002:a37:a643:: with SMTP id p64mr8840438qke.276.1616158812033;
        Fri, 19 Mar 2021 06:00:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7c62:2958:a423:b37b? ([2600:1700:e72:80a0:7c62:2958:a423:b37b])
        by smtp.gmail.com with ESMTPSA id f12sm3669815qti.63.2021.03.19.06.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:00:11 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Sparse Index: Design, Format, Tests
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <xmqqzgz0qghd.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bbb87aa6-5e81-2528-39bd-461c3537bb1a@gmail.com>
Date:   Fri, 19 Mar 2021 09:00:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqzgz0qghd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/18/2021 5:50 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> For this version, I took Ævar's latest patches and applied them to v2.31.0
>> and rebased this series on top. It uses his new "read_tree_at()" helper and
>> the associated changes to the function pointer type.
>>
>>  * Fixed more typos. Thanks Martin and Elijah!
>>  * Updated the test_sparse_match() macro to use "$@" instead of $*
>>  * Added a test that git sparse-checkout init --no-sparse-index rewrites the
>>    index to be full.
> 
> Thanks.  I expect ab/read-tree would be rerolled at least one more
> time, if only to straighten out the "oops #5 was screwy, let's patch
> it up on top with three more steps", but I do not expect the end
> state would be all that different, so tentatively I'll queue these
> patches on top of the latest iteration of the topic for now and
> hope that the other topic will be updated soonish.

Thanks. I'm grateful that it can spend some time in 'seen' if only
to avoid these conflicts in the meantime.

I'm waiting for that reroll of ab/read-tree before updating this
version with the feedback from v3.

Thanks,
-Stolee
