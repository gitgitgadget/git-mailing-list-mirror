Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FCC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbiBDQq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbiBDQq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:46:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5CDC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 08:46:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so12378885wrg.12
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bEHvpikC436YHdw/hSBogWR7O9JdVkca2IKYpK3czL8=;
        b=W2P9YzY6UuqQUMIz4f8djoksAEcb907xkYzTvhuvPIIglMcShCI6f1vb6swkH9RV5y
         SMtVr0uWLjEtTyKYto1Yq54f8CHWwFBjMREYiMjigxBPJMxWofRie3uiJYMhkEquWueO
         4OSGrXATXMhUjWV2GVfc8ZAoqA3j0mMgsCy/9wWyh/8ukCWQjz0hm3BSwYT7teKcszWR
         MGh1cKZfM5MgLnsGLkG6o7GBM9o9Mk/KjluQWzZQdFVHxpdavw5uZdYZ9xyvxc1K+VqP
         ZR7xGusLZxr3DS29z03MsrQ5xeuSwuOUouPbPPoe7TJgnJCs17aI8R6I0m+wwY4A5c33
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bEHvpikC436YHdw/hSBogWR7O9JdVkca2IKYpK3czL8=;
        b=4QywWHXxB5LF0oP6cO9Iebs+JwcjNcUtzvf0LM07DneK90hS9vecU5b/mKrFCBNQwK
         1fsjiqi06pNn6DqaWBMbzWpVWKl82AAdrf/PiUR8P2xtnk9Q1d1lQwtRXfjxM766UKzY
         EygcRklZVWErW92wSycrE3isQezx7JkkECS0t2iKGnf3jKZB5++gbWboynAr77fZlw91
         ZYMhhs/T/q+BjKqeqLllzDMEP1TCaGa2tuXEXUuxOed9euNaV2LZkAzJ19m0dmRNEbfr
         qBdHgDLs6DOr0uHA/vqFk9KIf2rheNyt1HREiRLMdslNFaH5dQp4KXyYsabDqlYJXBeh
         qmkA==
X-Gm-Message-State: AOAM5339iABlrS9CJ2eQDZ4eGdOEd2auvY5pPqtKPZOTERtADo4i+2vb
        Th1uu9Cf8EFZZIO6zbtpCXA=
X-Google-Smtp-Source: ABdhPJzXYYavveVWTgiAjQMzdq/eHrzxHJtuHrl1JPk7Beyv30biJXK2EIaJeeXym17M0g4r/0SqFw==
X-Received: by 2002:a05:6000:2c1:: with SMTP id o1mr3175345wry.258.1643993217172;
        Fri, 04 Feb 2022 08:46:57 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id bh19sm4379303wmb.1.2022.02.04.08.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 08:46:56 -0800 (PST)
Message-ID: <767d5f5a-8395-78bc-865f-a39acc39e061@gmail.com>
Date:   Fri, 4 Feb 2022 16:46:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
Content-Language: en-GB-large
To:     John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
 <xmqqo83nsoxs.fsf@gitster.g> <74E01F50-D5B4-41F0-A6F0-BBCA462ED74A@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <74E01F50-D5B4-41F0-A6F0-BBCA462ED74A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 04/02/2022 04:11, John Cai wrote:
> Hi Junio, thanks for the review!
>  [...]
>> So, from that point of view,
>>
>>      begin <cmd>
>>      <parameter>
>>      <parameter>
>>      ...
>>      end
>>
>> may be a better design, no?
> 
> Good point. Now I'm wondering if we can simplify where commands get queued up
> and a "get" will execute them along with an implicit flush.
> 
> <cmd> <parameter>
> <cmd> <parameter>
> <cmd> <parameter>
> get

I think that would be an improvement (I'd suggest calling "get" "flush" 
instead), the begin ... get <cmd> sequence seems unnecessarily complex 
compared the the RFC of this series. If the user gives --buffer on the 
command line then we can buffer the input until we see a "flush" command 
and if the user does not give --buffer on the command line then we 
should flush the output after each command.

Best Wishes

Phillip
