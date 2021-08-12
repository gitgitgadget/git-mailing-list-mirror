Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A2C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D41160EE2
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhHLKwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHLKwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 06:52:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8AC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:52:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso10049339pjy.5
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yoUfVuJdj5LXO/rn/qcgFR0RK0AWlwUJ+Ya5ByE5YJ4=;
        b=sZeDDkq9pSR0vpBlo3kH6NMP0RhuWRf7zQPoWs3rHKCRdIQwADbd30uY8gc8RljJnY
         c3U0yisKVpZ0T7/q/He9N2lmFw7wQ4R8FWrTbQpCoknJBjc2KJIdsmkq0DSwmxEinJNI
         JNqdPb/yTXEdDYW+XRMgsO7Doj5zV0LUFIcztYcdSz8z6KnveYvhQUaK2TG14fTJoRvX
         vonGkW8TLl+oBuJoCeURCz+VFB94Ua7xuQA6hzFGnEkANNRgTu9BmPfUY2sHfkkVpn8e
         NCmqPIZKFM48TZhc2Syjn1EZJ3Z+AsJ0sFdQ3IrFIth8cQrPRNziebNtZGKOinZAu3t+
         E37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yoUfVuJdj5LXO/rn/qcgFR0RK0AWlwUJ+Ya5ByE5YJ4=;
        b=VDl4q4uVJ8/K0rj43nyb4IKFG8bvWqlKGggmUuzIXA5NGGz/iM+4lc5fgxj9UJcIz+
         yYoF7xBDkly/igpUV/TiGwYBfJQGTERUG4t1zkRytcKg+bJBLXHX3HvgGlCFv9F5q+v4
         6sRByeaExvLv8CNDPJbGrpYHe2jE85hd1Tf442Ycv/2Gx11LBj7YpMBXLu8bjvll1MI/
         la8CL95p8NRh0cLMxjr8OMxw79DulsmP4grTKFP1l0dw0c0yXqxnUf80fhTaCdqFfpTo
         dtRPLffhrqM+cpxHqbUwDPZECLExKaXDRtvxnWATy9J7WnCIODxdveGZwlRYvuaB6WUx
         6n1w==
X-Gm-Message-State: AOAM531r9tCWpDr3YAXV+d/fM3exUdvJECae/Rkj4oduQx527SYx9R+U
        Agt1WYv6DSFu30zBBfYzb7A=
X-Google-Smtp-Source: ABdhPJx3FpkBTuH9ijkYxVJE5WHs3Co4rS7DAfL/VcoIJBHS+W4ivyIQdarSakQbvGG0eFw7UR3t8w==
X-Received: by 2002:a17:90a:14e4:: with SMTP id k91mr12407759pja.3.1628765531621;
        Thu, 12 Aug 2021 03:52:11 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id b20sm2819882pfl.9.2021.08.12.03.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 03:52:11 -0700 (PDT)
Subject: Re: [PATCH] help.c: help.autocorrect=prompt waits for user action
To:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     David Barr <b@rr-dav.id.au>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4f72cd3d-bcc7-a9b0-cc11-f0d7c5650365@gmail.com>
Date:   Thu, 12 Aug 2021 17:52:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/21 07.15, Azeem Bande-Ali via GitGitGadget wrote:
>   help.autoCorrect::
>   	If git detects typos and can identify exactly one valid command similar
> -	to the error, git will automatically run the intended command after
> -	waiting a duration of time defined by this configuration value in
> -	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
> -	will be shown, but not executed. If it is a negative integer, or
> -	"immediate", the suggested command
> -	is run immediately. If "never", suggestions are not shown at all. The
> -	default value is zero.
> +	to the error, git will try to suggest the correct command or even
> +	run the intended command.
> +	If this config value is 0, then the suggested command will be shown.
> +	If it is positive, the suggested command will automatically
> +	run after waiting for that many deciseconds (0.1 sec).
> +	If it is "immediate", the suggested command will be
> +	run immediately.
> +	If it is "prompt", then the user will be shown the
> +	suggestion and will be prompted for confirmation before the command
> +	is run.
> +	If it is "never", then no suggestion will be shown and no command
> +	will be run.
> +	0 is the default value for this config.

I think it's better to use bullet lists, e.g.:

```
If git detects typos and ...
<skip>
... git will try to suggest the correct command or even run the intended 
command. Possible values are:
     - 0 (default): show the suggested command
     - positive number: run the suggested command after specified 
deciseconds (0.1 sec).
     - "immediate": run the suggested command immediately
     - "prompt": show the suggestion and prompt for confirmation to run 
the command
     - "never": don't show any suggestions nor run them
```

-- 
An old man doll... just what I always wanted! - Clara
