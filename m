Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DFC47089
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 21:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLAV5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiLAV5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 16:57:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57005C3FC0
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 13:56:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k5so3117954pjo.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axQ/mxs9js+At2Ct/fxwc0UMcKL4uADwB/yuzqd1+i8=;
        b=i6pdtBXg3me66VY1DTkB0mSh6xkPwsuI/WT5Y7NTFwea3Awn3i7nw/HgXNi34izdqE
         zW3t6v2tss83DqUCPcxvEiplozsPlKhhfU9XH32xhUMv8Mrkl1EEQ2Sus1EMSfPqw/Xz
         p5R/lhTbL6OWpakzlL8lLu51go+QDuc32uDD2MC9byceQElll1/nviWJnnggU6N9Xj8X
         fvmYIvowIa49SPZUgGclZG1BPbeaXI+RZlKFf5vXkoZkSfRosMmW6+U87nZtC7M+Pvlo
         l4A+eK+pv6YlDoW5X30YZ5lLQxHhPgtiB3pxORQg7okfkLIz4wxbopcVNmTzRORiZXZB
         aHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axQ/mxs9js+At2Ct/fxwc0UMcKL4uADwB/yuzqd1+i8=;
        b=ignH6dlH6iO3Z0coDd6nyuaXMt7pVwPTuJVC5wneAOpNeCG2jcSHAn+G3xTD6+tm9j
         uRZvRYT2AA/MCqKQqDa4fg1ZMqDQ3UrsgVqOZGJ6Htn/sy22bOhC2J5OxyqtcdinKj7v
         +OpI6gjZjIe/t1YF/KAPqbelxmn+aQc5s3LGVCQgZzY7gBO2jUz0W5JnBRWkoQPPJ0Sw
         WDfAPxYFDUsA0D/K9esV9z12q/Sq04P1fHWwMLAwgHMoTn5ussVfffSGxDTi8isbVxZa
         DsBRQtdD+Z2drdkk5cgfYr6FXGqGMj6iIeIIdNzkPM0I5uFQkBpuISdBVO+wssiay+kV
         tmEg==
X-Gm-Message-State: ANoB5pn5zN9W7BjCnm0OvxIZYh/y9Jnya8966yAh8NhFy4hwNxwxBGTS
        nFuZ/vnWF7cTunoRaw56wYH1tBZwgnBMig==
X-Google-Smtp-Source: AA0mqf5v/WgyXAd0tq2l3l9wqej5GAcgEGJJiqRdy8JT81w2Ju9SbU8zyLB8mb3iMYO8BwgzvtMJ5w==
X-Received: by 2002:a17:90b:2544:b0:20a:f341:4ed9 with SMTP id nw4-20020a17090b254400b0020af3414ed9mr77010857pjb.11.1669931788468;
        Thu, 01 Dec 2022 13:56:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709027fc300b00187022627d8sm4102155plb.62.2022.12.01.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:56:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: remove parseopts member of struct diff_options
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
        <d226d3bc-fb15-58a4-f516-bda51a912228@web.de>
        <xmqqcz93ud8o.fsf@gitster.g>
        <20b5d6d1-ec09-e09f-4f92-5925fb9c96f8@web.de>
Date:   Fri, 02 Dec 2022 06:56:27 +0900
In-Reply-To: <20b5d6d1-ec09-e09f-4f92-5925fb9c96f8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 1 Dec 2022 08:52:37 +0100")
Message-ID: <xmqqiliuss8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 01.12.22 um 02:25 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> repo_diff_setup() builds the struct option array with git diff's command
>>> line options and stores a pointer to it in the parseopts member of
>>> struct diff_options.  The array is freed by diff_setup_done(), but not
>>> by release_revisions().  repo_init_revisions() calls repo_diff_setup(),
>>> thus calling repo_init_revisions() then release_revisions() leaks it.
>>>
>>> We could free the array in release_revisions() as well to plug that
>>> leak, but there is a better way: Only build it when needed.  Move the
>>> get_diff_parseopts() calls to the two places that use the array, free it
>>> after use and get rid of the parseopts member.
>>>
>>> Signed-off-by: René Scharfe <l.s.r@web.de>
>>> ---
>>>  diff.c | 17 ++++++++---------
>>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> I think this hunk is missing?
>
> Yes. O_o

I did not see any other issue in the series, so if no further tweaks
are needed, I could just squash it in.

Thanks for working on this clean-up.  The way parse-options parser
was bolted on (eh, rather, the way the original parser of diff
command line options way predated the parse-options machinery) has
always disturbed me as being klunky.

>
>>
>>  diff.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git c/diff.h w/diff.h
>> index 5229f20486..6840499844 100644
>> --- c/diff.h
>> +++ w/diff.h
>> @@ -394,7 +394,6 @@ struct diff_options {
>>  	unsigned color_moved_ws_handling;
>>
>>  	struct repository *repo;
>> -	struct option *parseopts;
>>  	struct strmap *additional_path_headers;
>>
>>  	int no_free;
