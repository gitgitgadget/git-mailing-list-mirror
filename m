Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE3C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D6B613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFJNSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJNSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:18:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA7C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:16:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so3300311wms.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZPJBQfrcKA5jItPYdeU/AtJv+b+x9OTvdMUMS5oAKlM=;
        b=nogMPSggkVQsKbEd3yLjPnD0qUAYjESWKgrvRtsGPUeHfT2oU4DQovDgFhTZptm2tb
         lu0OzgnFnuj42rshCGYFMqS8tIA1RaFHtFzo6FygYiBVwBK8M+iEsjXUmSKlp9AGMFMV
         0VtF8UK98i05wH31+uGijOm8iD6/o1jjsfCfH3DrC+MDcSCZAoJbHwaPWyPU3s2LzcAD
         q3Q6AUpDzQ0Y6cBFgH5T6UEsfpTFWUodKt9ckCOAgh1j81yqpKAzyAzRpbr5No/NHLyv
         wU2EyLTYu8dmdcEbMTd2jr2llJShdU178IZ57ZAsBBQHzfETlMoRH7IbYPFbr1E+65aJ
         pzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZPJBQfrcKA5jItPYdeU/AtJv+b+x9OTvdMUMS5oAKlM=;
        b=fIzNc4omfpvJhkpq9jqK/J6Dfc1RIOL9uZaVMqn2YMU4NQSOZzNOZkPDj++bp+aDPR
         ej/eEWVmjtAWe9pNAxtJF4f3IAL1bsWqNbK9jFEg0nlEnSHP3pLXfR6KWdjEXj7TLxiH
         Lv2nu36H6MWMlX94W8qeEJk5k0HaaIhC4QPgziRwEahlbVnKz1s4U2xZkx9QCEV8sg6m
         cHmYx+y9cug5yMFAIgCAcTIeIqqSjW0f32iII0efPq3if3C+CR9zOXC2sk8ZNQrK7LiR
         jmoAprkZHu//162DyBz3eILBQkjQwoclaPpTP7Zbz2Iv+CEg8+ZDaCw5+a+EwHwzdwmu
         Eu3Q==
X-Gm-Message-State: AOAM530nczWqySuY/CQXuIvaorIHZrMP8zwhpOBA7jE9BkU59zZcEw5V
        1aAOXPzs500sJbBBO9+LwCw=
X-Google-Smtp-Source: ABdhPJxyXuqKAtuKq5Pn6G/SD5Ljjh8ymiMo/9y4BC5Bez4XbkrSZesXMbjzQRv0MGS9D87izNiKXw==
X-Received: by 2002:a1c:146:: with SMTP id 67mr15403494wmb.61.1623330999749;
        Thu, 10 Jun 2021 06:16:39 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id q4sm4794146wma.32.2021.06.10.06.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 06:16:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] builtins + test helpers: use return instead of exit() in
 cmd_*
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
 <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <71775f7d-eb60-7fdc-731e-d370f620735e@gmail.com>
Date:   Thu, 10 Jun 2021 14:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/06/2021 07:49, Jeff King wrote:
> On Mon, Jun 07, 2021 at 01:12:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> Change various cmd_* functions to use "return" instead of exit() to
>> indicate an exit code. On Solaris with SunCC the compiler legitimately
>> complains about these, since we'll e.g. skip the cleanup (e.g. closing
>> fd's, erroring if we can't) in git.c's run_builtin() when we exit()
>> directly like this.
> 
> Each of these cases looks like a simple and obvious conversion, and I
> certainly don't mind us doing it.
> 
> But I do wonder what SunCC is complaining about exactly. Calling exit()
> means you don't have to worry about cleanup anymore. Does the compiler
> not have any notion of NORETURN or equivalent? If so, I'd expect many
> more complaints in general that we probably _won't_ want to silence,
> because it will be awkward to do so.

It is curious that is only complaining abut exit() calls and not die(), 
maybe that is just a coincidence though if it is not complaining about 
all calls to exit()

Best Wishes

Phillip

>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>> index 89334b77fb..6a9242a803 100644
>> --- a/builtin/difftool.c
>> +++ b/builtin/difftool.c
>> @@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *prefix,
>>   		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
>>   		NULL
>>   	};
>> -	int ret = 0, i;
>> +	int i;
>>   
>>   	if (prompt > 0)
>>   		env[2] = "GIT_DIFFTOOL_PROMPT=true";
>> @@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *prefix,
>>   	strvec_push(&args, "diff");
>>   	for (i = 0; i < argc; i++)
>>   		strvec_push(&args, argv[i]);
>> -	ret = run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>> -	exit(ret);
>> +	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>>   }
> 
> This one I'm not surprised that a compiler would complain about. The
> function returns an int, but there are no return paths from the
> function (and hence the caller doing "return run_diff_files()" likewise
> could not ever return there. Which is not quite what you said it
> complained about above, hence my curiosity. :)
> 
> -Peff
> 
