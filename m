Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B08C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 08:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4223761CE6
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 08:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhGHIKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhGHIKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 04:10:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47EC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 01:07:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v1so7246343edt.6
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUBwvjQpKtu+PnerOKigMj+H5fPrLAT0xQQmq7gAhQU=;
        b=T1uQ3w7qg7s6i1eGmfnXonayyDXtDa7Usf0x6wJqIDeGpchirzsPlAvSbVfp6R4NF2
         tZ623e2/jzUr9Gjr3ubje6p8fFTHuQB445HuvPMLg7D0vTHA9t8TgiJMaIQws8iG6BdG
         tRY+yeR2pVtkO8ogsZXYdOVLW+zYr1iQhXNMeuQI3L+IYPx5wjzpiHzQODyat4NtydlF
         39M8W6ALPCNEDBUO3qb3/RYocKDM9EayqdyWX6ByzqIJFegkMrSrLb4yAz5IA2hb4gT6
         Zmc3ZvuQ0jymOv2CqeZgUZNEBAzTv5kZi2LQV9dO8w1l7K6Ufs4w+7djNtgEdAcBQUiU
         B2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUBwvjQpKtu+PnerOKigMj+H5fPrLAT0xQQmq7gAhQU=;
        b=f31IqErBOKduj/7i8w7clzxfOcaOWRhTvRe4tenGyovDf/ipJ9KjyRCmVotalURKd+
         b5j2H0+1TXZu6XW+g8kAH8B6ixH2ae5zpYEZn6aDYL7idSyhD691+XB/zheED6z4VwwT
         lBGjeitkEdzXHwkWDgu8lqW4HLVCdfsiltz5TY5FU3GqlU+l0DrF9Znfk+eaWeKSn1iY
         cRAyoWagFInYKcAL0hJnkME6wJMzNbRfOSFvOdQvN2QKvG6mILFJOjQnx1Caicc130Sd
         q6hq9NTAV2h1AHFgvek+gwub7NB0imTuCiYYx3fv4EOuxgiGDfWaNnjGNlbA7U/vdAAF
         67zQ==
X-Gm-Message-State: AOAM531zI8wzd3sj0AAEGDYw6pDO4eKJ5/eKIxvReOCUsWmZR/Y9q17h
        jPbX/aqz/ryaSiI9Ezc/Zq66R15Hwc+NVN2QTRktIg==
X-Google-Smtp-Source: ABdhPJxiaOeqKYxT2+sfgJ/RDJPQ+aETmKEB0Bkd+X1J3noAU2rUH7bvZfsJUUfdw1uEfF+7TWsuDA==
X-Received: by 2002:aa7:ccd2:: with SMTP id y18mr36584042edt.196.1625731654817;
        Thu, 08 Jul 2021 01:07:34 -0700 (PDT)
Received: from [10.4.18.9] ([212.102.35.134])
        by smtp.gmail.com with ESMTPSA id c3sm825714edy.0.2021.07.08.01.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 01:07:34 -0700 (PDT)
Subject: Re: [PATCH resend] help: convert git_cmd to page in one place
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
 <20210704153912.2742106-1-rybak.a.v@gmail.com>
 <87tul9706u.fsf@evledraar.gmail.com> <xmqqfswri4o6.fsf@gitster.g>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <93578e5a-c09b-14c2-8f87-eb354f4b576c@gmail.com>
Date:   Thu, 8 Jul 2021 10:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqfswri4o6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07/2021 22:11, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>> @@ -606,16 +604,17 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>>>   
>>>   	argv[0] = check_git_cmd(argv[0]);
>>>   
>>> +	page = cmd_to_page(argv[0]);
>>
>> Nit not requring a re-roll: I'd snuggle this with the argv[0], not the
>> switch statement, i.e. like the existing code.
> 
> Makes sense.
> 
>>>   	switch (help_format) {
>>>   	case HELP_FORMAT_NONE:
>>>   	case HELP_FORMAT_MAN:
>>> -		show_man_page(argv[0]);
>>> +		show_man_page(page);
>>>   		break;
>>>   	case HELP_FORMAT_INFO:
>>> -		show_info_page(argv[0]);
>>> +		show_info_page(page);
>>>   		break;
>>>   	case HELP_FORMAT_WEB:
>>> -		show_html_page(argv[0]);
>>> +		show_html_page(page);
>>>   		break;
>>>   	}

Is reusing "argv[0]" one more time instead of introducing the variable
"page" is a good idea? It could either be:

	argv[0] = cmd_to_page(check_git_cmd(argv[0]));

or

	argv[0] = check_git_cmd(argv[0]);
	argv[0] = cmd_to_page(argv[0]);

That way, the quoted hunk above (touching calls to show_*_page) wouldn't
be in the patch.
