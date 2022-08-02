Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F52C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 16:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiHBQ0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiHBQ0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 12:26:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1B39BAD
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 09:26:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f192so4582238pfa.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=17sxkjHQ0aKAB7M7KbtOBtlM8rL5gsX+d0NjBq6n818=;
        b=HPELOL+Jp3cQa12lHKLcboVvHzWP8iemhi2xO0ois1trWk/fkxWf8Ybuo+TEyJppvZ
         H41Ir8ps0K9Mp0CA7faC+rHCGu9IBteYpqiuXR0EWVp2Tvab8RUqdPoSqU+lyFLXzBhQ
         TfD4co9uMjTW3V+KQZUa8YsjSm74WffmXUr9VJwbFbWdTrrdRLjVIFch5Y6OQSLwJDhC
         ctVbpqROphonqlyo2b8g1KHS/BLS1JrXBbyNL0czSZBj5CpW3Sf+UtCWKi/LUz2ylW28
         72O+Nglb8+KAdhQdouaMBm5H+xRSvLr814etPAoFOssqR7AzJOsDfyaJr67YGH0JUcKk
         8Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=17sxkjHQ0aKAB7M7KbtOBtlM8rL5gsX+d0NjBq6n818=;
        b=jZ1i1mPjjV7VVtQI0YhtUT2F9rJeJGDoOIL2FPfSrVDuZ1rdyHWeEx7jwE9C8JRCck
         PL0xtnVX45B7j1BIJfybzVSRRucd0uuUwcUOLIAeNc0R2rmfc5OtuGSdeJyAyMG1j3/J
         NLQIFNHkKJRaM/srfp1FrUZ/tGmZDIZiy3EWfyy4jJ2WkGXmaXh2criAweFGfJLO66+i
         kGHCvwHOVbPtgV4EW9zVWm/sGTH4uvhlHBJ8KWdP3LWddBKeapK+poo/dwpXdduFlAzW
         u9R3YZedkg50cWG9vb1MbA3mYpBSe2Ot+ZsgHeAW7dTB9A9u4yc04OSLItXYdbSpnJOk
         BlQA==
X-Gm-Message-State: ACgBeo30cUsI35lLJOZAFEHnSwWwSLDAAbj9uUurs7STGU63Lzk6A+yP
        8pJ2l/8zFhDRUYvNNOW02UuP
X-Google-Smtp-Source: AA6agR7RQmuaJunGFXtgzJnYwBwSsuAJEtNrZH8be7ZPPqeJQIOWF1En/ey9ozT5VlcrgV0FQKJPog==
X-Received: by 2002:a63:1c65:0:b0:41c:86b0:59e4 with SMTP id c37-20020a631c65000000b0041c86b059e4mr1030805pgm.382.1659457598890;
        Tue, 02 Aug 2022 09:26:38 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w127-20020a623085000000b0052df34124b4sm1333218pfw.84.2022.08.02.09.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 09:26:38 -0700 (PDT)
Message-ID: <c075e483-6e00-5de4-b923-af8983ba384e@github.com>
Date:   Tue, 2 Aug 2022 09:26:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
 <xmqqpmhjmwu4.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqpmhjmwu4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Avoid size_t overflow when reporting the available disk space in
>> 'get_disk_info' by casting the block size and available block count to
>> 'uint64_t' before multiplying them. Without this change, 'st_mult' would
>> (correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
>> bytes of available space.
> 
> Sane.  But shouldn't the cast be to off_t, which is what
> strbuf_humanise_bytes() takes anyway?
> 

I chose 'uint64_t' to mimic 'throughput_string()' [1], but the signed
'off_t' is a better choice given its use in 'strbuf_humanise_bytes()'.

On a related note, while writing this I made the (unsubstantiated)
assumption that 'off_t' would be a 64-bit int, even on 32-bit systems. Your
comment prompted me to confirm that assumption; while 'off_t' is not always
guaranteed to be an int64 by default [2], Git is compiled with '#define
_FILE_OFFSET_BITS 64' [3] so 'off_t' is equivalent to 'off64_t'.

I'll update the casts to 'off_t' in V2. Thanks!

[1] https://lore.kernel.org/git/20171110173956.25105-4-newren@gmail.com/
[2] https://www.gnu.org/software/libc/manual/html_mono/libc.html#index-off_005ft
[3] https://lore.kernel.org/git/7vr6smc1de.fsf@assigned-by-dhcp.cox.net/

>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/bugreport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
>> index 35b1fc48bf1..720889a37ad 100644
>> --- a/builtin/bugreport.c
>> +++ b/builtin/bugreport.c
>> @@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
>>  	}
>>  
>>  	strbuf_addf(out, "Available space on '%s': ", buf.buf);
>> -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
>> +	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);
>>  	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
>>  	strbuf_release(&buf);
>>  #endif

