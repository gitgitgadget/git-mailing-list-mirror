Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A7C433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiAKLNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiAKLNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:13:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F2C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:13:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s1so32287945wra.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHb9EzXcVBpMQBTYC7JZn+EmfaJSmKgox0ju+qoGAqY=;
        b=IygvZMAKi2Y9VzFE8MYXRheS/8A7CpTmrT0ivHWDiwjHUHBEBmTegFFUGu6gfTJa4C
         0WZeD1h0QNvAhCw5gLZAYQXybnE4iXWkE3v5n3RH8MBHvZYWPPwcEHU5+Qr7VcUudFYO
         QcDNGLX4CAadK5answZIc0TToraS7dT7CP902lNVy5uzzNo/JCcVLUW7ZoWl1QgvlXbR
         MJwOOdl+7ZIeQtndiBpnwA3aHurJ+/zDiNRzCGPUWoNTTdQb5i30awn0aYjoiR93ec7d
         euCZYldgVfrKzzct/PZYF9eMwfdRIXyMrhGXcNVGYUzZaeJ5lyt2nSqkl7p3DKQr2BQc
         n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHb9EzXcVBpMQBTYC7JZn+EmfaJSmKgox0ju+qoGAqY=;
        b=GsVbAQh2fp83RMQ26bPJpOq+6X5ZwrlqMU5KdtQIXMnltzX8DW4Kv1a4iuH5JiaPA6
         aeo1GZAAlN4lcy1SyJ9AR1nmiQIG2bWdhpglHChjieG+aHSSAIloAbOQC5QBBJGK9tXk
         byXT6QayWt4plitSI8/+iCBDKaRjlNPRhz4gFjS1NIGgrGxauDPO04Ycefy3vT1ZzF7K
         ZTC91tCut05TL3V0T/le+uG7QZE3LPNCkvP8xe60EK/M3cGeCKluVtMqfNTKe824mFs8
         4n+Rjxc5KnfJZDRqM7UrIMLmO2+0ae1A82f5E8Yt3OXu8EmsLtvVK4k2Kvt3IEj7YM1U
         4dTA==
X-Gm-Message-State: AOAM5326BWgRTG7oDpZgy6aaC9xvBIsVfSw6KVcjo2GbnEmNQKnoZDjh
        J6tRSvadz0rM7NwgfQvrR/4=
X-Google-Smtp-Source: ABdhPJxJ+kb5sBHOZ6JQoGfbMWTsug4yW59MKc3Hohd9rmQuzE2nVhzKBZcySy7+PE06ttYfRd6ggw==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr3298760wrk.606.1641899614731;
        Tue, 11 Jan 2022 03:13:34 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id x22sm1372452wmi.13.2022.01.11.03.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 03:13:34 -0800 (PST)
Message-ID: <23b6c237-5a95-7c3c-2bcd-567dbef5aafe@gmail.com>
Date:   Tue, 11 Jan 2022 11:13:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin add -p: fix hunk splitting
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
 <211220.86mtkvt7cy.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <211220.86mtkvt7cy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 20/12/2021 19:06, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> To determine whether a hunk can be split a counter is incremented each
>> time a context line follows an insertion or deletion. If at the end of
>> the hunk the value of this counter is greater than one then the hunk
>> can be split into that number of smaller hunks. If the last hunk in a
>> file ends with an insertion or deletion then there is no following
>> context line and the counter will not be incremented. This case is
>> already handled at the end of the loop where counter is incremented if
>> the last hunk ended with an insertion or deletion. Unfortunately there
>> is no similar check between files (likely because the perl version
>> only ever parses one diff at a time). Fix this by checking if the last
>> hunk ended with an insertion or deletion when we see the diff header
>> of a new file and extend the existing regression test.
>>
>> Reproted-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   add-patch.c                |  7 ++++++
>>   t/t3701-add-interactive.sh | 46 ++++++++++++++++++++++++++++++++++----
>>   2 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/add-patch.c b/add-patch.c
>> index 8c41cdfe39b..5cea70666e9 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -472,6 +472,13 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>>   			eol = pend;
>>   
>>   		if (starts_with(p, "diff ")) {
>> +			if (marker == '-' || marker == '+')
>> +				/*
>> +				 * Last hunk ended in non-context line (i.e. it
>> +				 * appended lines to the file, so there are no
>> +				 * trailing context lines).
>> +				 */
>> +				hunk->splittable_into++;
> 
> I wondered if factoring out these several "marker == '-' || marker ==
> '+'" cases in parse_diff() into a "is_plus_minus(marker)" was worth it,
> but probably not.

Yeah in the end I just factored out this hunk into a new function but I 
didn't add a function for "marker == '-' || marker ==
 > '+'"

>>   			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>>   				   file_diff_alloc);
>>   			file_diff = s->file_diff + s->file_diff_nr - 1;
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index 77de0029ba5..94537a6b40a 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -326,7 +326,9 @@ test_expect_success 'correct message when there is nothing to do' '
>>   test_expect_success 'setup again' '
>>   	git reset --hard &&
>>   	test_chmod +x file &&
>> -	echo content >>file
>> +	echo content >>file &&
>> +	test_write_lines A B C D>file2 &&
> 
> style nit: "cmd args >file2" not "cmd args>file2"
> 
>> @@ -373,8 +411,8 @@ test_expect_success 'setup expected' '
>>   test_expect_success 'add first line works' '
>>   	git commit -am "clear local changes" &&
>>   	git apply patch &&
>> -	test_write_lines s y y | git add -p file 2>error >raw-output &&
>> -	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>> +	test_write_lines s y y s y n y | git add -p 2>error >raw-output &&
>> +	sed -n -e "s/^([1-9]\/[1-9]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>>   	       -e "/^[-+@ \\\\]"/p raw-output >output &&
>>   	test_must_be_empty error &&
>>   	git diff --cached >diff &&
> 
> style/diff nit: maybe worth it to in 1/2 do some version of:
> 
>      test_write_lines ... >lines &&
>      git ... <lines .. &&
>      ...
>      sed -n \
>      	-e ... \
>          -e ... \
>          >output
> 
> Just to make the diff smaller, i.e. just the "test_write_lines" line
> would be modified here.

In the end I decided to leave this as is, while refactoring slightly 
simplifies this patch it makes the previous one bigger and means that 
would need to be reviewed again.


> The changes themselves & this series LGTM.

Thanks

Best Wishes

Phillip


