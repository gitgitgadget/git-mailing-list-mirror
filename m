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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17112C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E594360EE4
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhHHS1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHS1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 14:27:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4043C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 11:26:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b1-20020a17090a8001b029017700de3903so17250091pjn.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsUDPBm3L6VctkeQX8SP/HRrfJpV/dh+piQEXTiqG2Q=;
        b=cI56+bZ9JOyjAkKyMfvbj5BdqOGT4nNIPwwLrBbaAvxJh+kJf18YE4a2MD0SkmMN6t
         3lNRdwCPBYU5VHQUweQ+BYkaG1los/oOUjsFz8jWJwvbxM9ChcnFrSl9zXJzywRmUrky
         /UCpIGPt6JQQQQ0w3YQQIovGOg4EyavmI4aDYrK144BKq/D/sOMfyf3c3DUxpmMqwU7H
         N+iUazQSK6DXXhGSYfhn7H1hAkqVGof6G5zCLDdHMhA1jwcak1RxEnM2J9Ta95h6A3OR
         sIrkF1A5tf8BxlBcfsAPVKuWYE/lIcqnSzAa0oktCD5fc3CqjeZvIErVQviS+UBPGIcM
         179g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsUDPBm3L6VctkeQX8SP/HRrfJpV/dh+piQEXTiqG2Q=;
        b=RAOd6zReurp0fTMAszjK8fJbZsYsai+69mES50FSjdeGUcjvEJBHQIlXqWEs+gBueB
         F4tb5R60+YtM6q6dfeBSEvuw4Hi1JFWOPZ30soILaIcjnzmgJl3i6bDx8QJZDuHSIhg5
         aIxdFB+dwn117Yj4z6EQRZu2FsZNzZjFAqtvtVVPmmSz0iz9411Ut77OLQwAWsW3PZEf
         CfNwilv5RrBmT7fT1T2NfdCuPUVyfS0gXabzJEdy/DwoQh49j6lIDcqG9EaW7rG/SGDP
         x90R5TMvYRbYcbmypJq2D4Mc1HPPLUJzcaCPbYqKKR5gxacITAfCQm7ANePeEh4S6LtD
         64+g==
X-Gm-Message-State: AOAM531+lylRrRMc9wf9PFm8DWQjpF5v6eeP3ZJsWnfZUKI+MOMVFNnv
        W8oR/OdjaxMQOO8xyMkpsqI=
X-Google-Smtp-Source: ABdhPJwfKJY6AYP07nZCJoXC4JJG0l/ts8urQG3ppfnCqjERz5Fc43WCkmDFCptjAz2hMyM3bhpf8g==
X-Received: by 2002:a17:90b:1bca:: with SMTP id oa10mr22272026pjb.177.1628447213125;
        Sun, 08 Aug 2021 11:26:53 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.169])
        by smtp.gmail.com with ESMTPSA id bb14sm8806537pjb.14.2021.08.08.11.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 11:26:52 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 1/8] submodule--helper: add options for
 compute_submodule_clone_url()
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-2-raykar.ath@gmail.com>
 <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
Message-ID: <187083ab-a2e3-0933-5bff-9b409b2946ea@gmail.com>
Date:   Sun, 8 Aug 2021 23:56:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/21 11:11 pm, Kaartic Sivaraam wrote:
> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>> Let's modify the interface to `compute_submodule_clone_url()` function
>> by adding two more arguments, so that we can reuse this in various parts
>> of `submodule--helper.c` that follow a common pattern, which is--read
>> the remote url configuration of the superproject and then call
>> `relative_url()`.
>>
>> This function is nearly identical to `resolve_relative_url()`, the only
>> difference being the extra warning message. We can add a quiet flag to
>> it, ...
> 
> It took me a while to figure what "it" meant in the above sentence. Does it
> refer to `compute_submodule_clone_url` or `resolve_relative_url`. After one
> sees the patch and takes a look at `resolve_relative_url`, it's clear the "it"
> indeed does refer to `resolve_relative_url`. But it might worth clarifying this
> in the commit message itself.
> 
> Certainly not worth a re-roll on its own. May be Junio could amend this while queing ?
> 
Actually, I just noticed two other things which might be re-roll worthy. Read on ...

> -static char *compute_submodule_clone_url(const char *rel_url)
> +static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
>  {
>  	char *remoteurl, *relurl;

I know this isn't new code. But there's already an argument names
'rel_url'. So, a variable named 'relurl' in the same scope is making it
hard to distinguish between these two. Could you also try distinguishing
these better by renaming 'relurl' to 'res' or something else?

>  	char *remote = get_default_remote();
> @@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
>  
>  	strbuf_addf(&remotesb, "remote.%s.url", remote);
>  	if (git_config_get_string(remotesb.buf, &remoteurl)) {
> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> +		if (!quiet)
> +			warning(_("could not look up configuration '%s'. "
> +				  "Assuming this repository is its own "
> +				  "authoritative upstream."),
> +				remotesb.buf);
>  		remoteurl = xgetcwd();
>  	}
> -	relurl = relative_url(remoteurl, rel_url, NULL);
> +	relurl = relative_url(remoteurl, rel_url, up_path);

After reading 2/8 of the series, I just noticed that 'remoteurl' is always
initialized in 'resolve_realtive_url'. It is either initialized to the return
value of 'xgetcwd' or retains its assigned value of 'NULL'. But it looks
like that's not the case here. 'remoteurl' could be used uninitialized
when the above if block does not get executed which in turn could result in
weird behaviour in case 'remoteurl' gets a value of anything other than 'NULL'
at runtime.

This again has nothing to do with the change done in this patch. Regardless, it
looks like something worth correcting. Thus, I thought of pointing it out.

>  
>  	free(remote);
>  	free(remoteurl);
> @@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
>  		if (starts_with_dot_dot_slash(url) ||
>  		    starts_with_dot_slash(url)) {
>  			char *oldurl = url;
> -			url = compute_submodule_clone_url(oldurl);
> +			url = compute_submodule_clone_url(oldurl, NULL, 0);
>  			free(oldurl);
>  		}
>


-- 
Sivaraam
