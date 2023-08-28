Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB812C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjH1QbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjH1Qas (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 12:30:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE689D9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 09:30:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso31836415e9.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693240243; x=1693845043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QBugW+PGJXflO9XRCgvVq6d2bsRvjALaQFJobRsHRLQ=;
        b=IA22YywszXRBtNdQj9GnKttBRbe1BleZSI3JSJBNs6JOpcpx2JsViqOt1XMKeqMd0h
         yv/6qa10Kbu6OoXgj0IHIvn4DQEw/rP4Vhc8bh0XVE5eDILTYT7IsffKnKaeBuHkksG/
         B0SPUHErlYfg7UlzMBCUn00vubaV8k5Xhf2rhLCfthpgDAtSwHPsDkJPQOxcQHPSiqk/
         WCZLp+aUNddK8itO8GSaA4jy6OlFlPeLBe9GRX493/HVjftsmDzL0nnN+pe+51IG5PGz
         RK0yfZ2lJQucWaKwYPzjbVGYAS97lPqDP/hIBcbqd7qrLjJXUm6sar+IX3GXJsyeu5JT
         zBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240243; x=1693845043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBugW+PGJXflO9XRCgvVq6d2bsRvjALaQFJobRsHRLQ=;
        b=jvP4jP6QbdQY7ACzyYW4rQlwyYL0aPbGFp77sOX3BD17oWZ90O3Dblb8sKncJk17rr
         z4AL8sjYacA/F41mXTK9MINnQzGKpkznc7nUVajt32f/ucJdubEYODVUdh+/YZqi2o/f
         l9DsK/jcASeoOjZudHEugIxjs/nS9OQ1IXnUQfVLyk3mHy5YPvjMxWDnEH62drjbBucZ
         sGIJLbIzxa/tkooXtY3r6SuzXHOsuunpXadmYcbBfQ5App72rm19QtzgywlimvYcVMO3
         amWIi+4om9v2pK0EqF4YhaRQjSLiGF5PKvoB9mRJfrrCScTWMcowgps5YLF/ujFL6mzI
         Kr2w==
X-Gm-Message-State: AOJu0YyP77wSj2Q99R0pCmz27M0qDhd2SaWqkkPUxdCBQbgtZ56vbWUD
        bUJVbpxx0xlX8fv6tHWQsePehQGF4L4=
X-Google-Smtp-Source: AGHT+IEz6RZa4y65C2S891B4gTSJ2tfG6Ruwc+qmcEa/MldUbokMsEv5KlTMjC9xehNpFQ4VfplewQ==
X-Received: by 2002:a05:600c:211:b0:401:23fc:1f92 with SMTP id 17-20020a05600c021100b0040123fc1f92mr9351178wmi.25.1693240243013;
        Mon, 28 Aug 2023 09:30:43 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b003fe2b6d64c8sm8790371wmk.21.2023.08.28.09.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:30:42 -0700 (PDT)
Message-ID: <ae22b71b-73ea-4634-bd2a-4b64082be955@gmail.com>
Date:   Mon, 28 Aug 2023 17:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
References: <20230828125132.25144-1-sir@cmpwn.com>
 <20230828144215.GA2537587@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230828144215.GA2537587@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/08/2023 15:42, Jeff King wrote:
> On Mon, Aug 28, 2023 at 02:50:34PM +0200, Drew DeVault wrote:
> 
>> Rather than replacing the configured subject prefix (either through the
>> git config or command line) entirely with "RFC PATCH", this change
>> prepends RFC to whatever subject prefix was already in use.
>>
>> This is useful, for example, when a user is working on a repository that
>> has a subject prefix considered to disambiguate patches:
>>
>> 	git config format.subjectPrefix 'PATCH my-project'
>>
>> Prior to this change, formatting patches with --rfc would lose the
>> 'my-project' information.
> 
> This sounds like a good change to me. 

I agree it sounds like a good change but if we're going to change it 
than I think we should ensure

     git format-patch --subject-prefix=foo --rfc

and

     git format-patch --rfc --subject-prefix=foo

give the same result. That would mean dropping rfc_callback() and using 
OPT_BOOL() instead of OPT_CALLBACK_F(). We could add the "RFC " prefix 
just before we add the re-roll suffix.

Best Wishes

Phillip

It would be backwards-incompatible
> for anybody expecting:
> 
>    git format-patch --subject=foo --rfc
> 
> to override the --subject line, but that seems rather unlikely.

>> Implementation note: this introduces a small memory leak, but freeing it
>> requires a non-trivial amount of refactoring and some dubious choices
>> that I was not sure of for a small patch; and it seems like memory leaks
>> in this context are tolerated anyway from a perusal of the existing
>> code.
> 
> We do have a lot of small leaks like this, but we've been trying to
> clean them up slowly. There's some infrastructure in the test suite for
> marking scripts as leak-free, but t4014 is not yet there, so this
> won't cause CI to complain at this point.
> 
> It is tempting while we are here and thinking about it to put in an easy
> hack, like storing the allocated string in a static variable.
> 
>>   static int rfc_callback(const struct option *opt, const char *arg, int unset)
>>   {
>> +	int n;
>> +	char *prefix;
>> +	const char *prev;
>> +
>>   	BUG_ON_OPT_NEG(unset);
>>   	BUG_ON_OPT_ARG(arg);
>> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
>> +
>> +	prev = ((struct rev_info *)opt->value)->subject_prefix;
>> +	assert(prev != NULL);
>> +	n = snprintf(NULL, 0, "RFC %s", prev);
>> +	assert(n > 0);
>> +	prefix = xmalloc(n + 1);
>> +	n = snprintf(prefix, n + 1, "RFC %s", prev);
>> +	assert(n > 0);
>> +
>> +	return subject_prefix_callback(opt, prefix, unset);
>>   }
> 
> We try to avoid manually computing string sizes like this, since it's
> error-prone and can be subject to integer overflow attacks (not in this
> case, but every instance makes auditing harder). You can use xstrfmt()
> instead.
> 
> Coupled with the leak-hack from above, maybe just:
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index db3a88bfe9..579c3a2419 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1476,9 +1476,19 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
>   
>   static int rfc_callback(const struct option *opt, const char *arg, int unset)
>   {
> +	/*
> +	 * "avoid" leak by holding on to a reference to the memory, since we
> +	 * need the string for the lifetime of the process anyway
> +	 */
> +	static char *prefix;
> +
>   	BUG_ON_OPT_NEG(unset);
>   	BUG_ON_OPT_ARG(arg);
> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
> +
> +	free(prefix);
> +	prefix = xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_prefix);
> +
> +	return subject_prefix_callback(opt, prefix, unset);
>   }
>   
>   static int numbered_cmdline_opt = 0;
> 
> The rest of the patch (docs and tests) looked good to me.
