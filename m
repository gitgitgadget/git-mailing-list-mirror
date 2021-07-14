Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241EBC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D0261370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhGNAFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhGNAFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:05:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BFC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:02:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso278081pjp.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UQACpo0o5u6IEKURFn+JdxSiER3h0KlXuZiGKdzgmvY=;
        b=O7VO3XpQ6mIaPsQEp/Qc2UFSBUPIkmshKss0LZgYFJMdA1JY/de0xN8ZXNM3vlQW0L
         PwrkSIMNvO8FxTyn6Vag+DbX9+HD2PH2qGtP8PVPn04ZfuohQyeQDDrFAofmcaoMkEBS
         uftMzpAkenxjI0e/d+R+Q3pNDEIOyRvRGrTaPiOWoqw0bHed6BpSoIYvAvWyA3sI/iH/
         ONk0UY/W5OIKXHNs1dRgdxtInoVVP/jblvI1nsBUeId2QkbQSv9h52Tp8kc6aTLPus0g
         VzFCRd+XDBq4ITbvKjZ9ysnYzO9hj2I6RGzt77NkbLLViXt21ARrOxPd9U2sWXRLV9Hi
         ARqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UQACpo0o5u6IEKURFn+JdxSiER3h0KlXuZiGKdzgmvY=;
        b=CahrGqs9TWMrACjTDCQ/zkDmQYOLWkkzTeEDcdVX0ysWea8ynfDhYKidQZzE3Lspf/
         Hbq7iFOdQ7i04R2hdyiasaE3OeE8fJ849z0VRyIx9TacfaLe4r61R5/002LFYSpch6pE
         tHXd/SUEJW4YWG07eSaZeGchM5mJLY7MrUjrHBHF9uB8X4BQj4ZyKGQrlsNNjdX01Uy1
         xSqLMPeRec2xZ+8pHWcvo9DDB2MvxuxP4bA54Dlhe0WcuSlMGToPNaT9mu/sclvkSjtb
         tBfCISMBsvVRmDk7HbyA/SP6KgYrQU/tXuKNAly0pR3QoW75zDQtih48d+VUfAbVyDf5
         cuXw==
X-Gm-Message-State: AOAM531SdLSkUmmGm89E4fc9bORfVY8qdAnQjrdqvlIj8vthdvUWQElx
        bf+cJ6ZcU6nk6AO4fD2X3NM=
X-Google-Smtp-Source: ABdhPJwyV/Qsx3bNbowVhjMaz6GZf+iOn7JJ/xfWNAZj7gluDRkDNz6bjNoKDQfjLJF0AuvIi2/TwQ==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr6727675pjb.28.1626220971542;
        Tue, 13 Jul 2021 17:02:51 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id w22sm276325pfn.188.2021.07.13.17.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 17:02:50 -0700 (PDT)
Subject: Re: [PATCH v8 03/15] t1092: replace incorrect 'echo' with 'cat'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
 <05981e30b97a3e668b3a9675508135d42f15450f.1626112556.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <06de6811-0d04-c39f-589f-d5563b3149cf@gmail.com>
Date:   Wed, 14 Jul 2021 07:02:46 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <05981e30b97a3e668b3a9675508135d42f15450f.1626112556.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/21 00.55, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> This fixes the test data shape to be as expected, allowing rename
> detection to work properly now that the 'larger-content' file actually
> has meaningful lines.
> 

What's the connection with s/echo/cat/ ?

> @@ -40,7 +40,7 @@ test_expect_success 'setup' '
>   		done &&
>   
>   		git checkout -b rename-base base &&
> -		echo >folder1/larger-content <<-\EOF &&
> +		cat >folder1/larger-content <<-\EOF &&
>   		matching
>   		lines
>   		help
> 

OK, because to write multi-line file in scripts one must use cat, while 
echo can only write single line.

-- 
An old man doll... just what I always wanted! - Clara
