Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F056C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDCD21E92
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 15:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAAPng (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbhAAPnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 10:43:35 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D00C0613C1
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 07:42:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id p12so10061864qvj.13
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFaXzI8htGmZTfT4pMBotmnCxnmee/wKU686BnAz8K4=;
        b=ntkUKqOcIhu58+OS961zvG3242PAOzM8k5M0DicqY1xv9u+LfrR8jPPvQPv/3hCG1c
         xh9TE7n3AkXl8QaCBfyYdtohY101AdDminN3xSXqLd9J1ugTiLdsXtVGxTTI2uMgfd3O
         3gm98wJMpF34aLY8kSRRlscvCk4snmRPF+tqqliJSrbAS2rdJwchl35EMAI+oYhBz8qh
         V3SbVIQDfnppiHOW9mcGTVCO65XgJqKdYXPXL7LzXtwvTcQHoTqUGPLUuiRejNlT+vbL
         /4REEb8BlsjF7HlHzBoEDsV6LMUssDjRdf1sJ+bSUwtLCQPuz8xcvUIPP24MqEc/W04C
         kbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFaXzI8htGmZTfT4pMBotmnCxnmee/wKU686BnAz8K4=;
        b=nuSWztfYolS1omAbSShH8RwNSDQv/VyOHeYjVXwkDdOBRlu8S6M7vX8if4sGF21zVE
         FoS85sEFvkZfhITZ1Zv5hRU4RLDJzdr7EjYH8vjQ+vdpGAQaBea5uwDON+COUMDibeQ0
         ZuiucXi/AmKTsmogerG71XHgg6uSpIJSqkRXo9kD6hi/heAHoX83yYIwh6OtLeDfggwL
         L/2HezI3WSaWxQNEVmgzxkQKDKBb3KHuUzd9WVKw4yCQoF8/28gS7fv2BT3GooMAwOKM
         GhhMiX4BZmTLVDv6NS9EhPiS+G/KeNa9eOQiiO+LYSulO3Jv5WrLAeVJe2QdXVuoHfg3
         MKrA==
X-Gm-Message-State: AOAM5324olbkw8pspyvz6ktbPlYqR5wyE2iSKAwfkgT9b8HQ3NEp9gWP
        ZvmiZjXY50l8PX5BNPpNd2Iygyj3LKWsgWXl
X-Google-Smtp-Source: ABdhPJygTp8thQafsEa7+JHW9WtNvJx5QoFQgAaEK88wqX7+7UvsoLGD9DQU6sQxu7TUTaQzZj2SzA==
X-Received: by 2002:a0c:fdec:: with SMTP id m12mr66544774qvu.11.1609515774265;
        Fri, 01 Jan 2021 07:42:54 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q6sm22261354qkd.41.2021.01.01.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 07:42:53 -0800 (PST)
Subject: Re: Issue: "Could not access submodule" error when pulling
 recursively with Git 2.22.0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Aleksey Mikhaylov <almikhailov@plesk.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM5PR0902MB1953988602B657C3D0BB9B17A36B0@AM5PR0902MB1953.eurprd09.prod.outlook.com>
 <20191023100449.GH4348@szeder.dev>
 <nycvar.QRO.7.76.6.1910251415560.46@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a12b4c26-3844-694f-d16d-4d5299a20503@gmail.com>
Date:   Fri, 1 Jan 2021 10:42:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910251415560.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes, Gábor, Aleksey,

Le 2019-10-25 à 08:41, Johannes Schindelin a écrit :
> Hi Gábor,
> 
> On Wed, 23 Oct 2019, SZEDER Gábor wrote:
> 
>> On Wed, Oct 23, 2019 at 07:22:12AM +0000, Aleksey Mikhaylov wrote:
>>> "Could not access submodule" error when pulling recursively with Git 2.22.0.
>>> This issue causes if there is submodule in submodule.
>>
>>> Please use my simple test repository to reproduce the problem:
>>> https://github.com/agmikhailov/example2361.git
>>>
>>> It is just an empty repository with one submodule (https://github.com/agmikhailov/example2361M1.git)
>>> and one submodule of submodule (https://github.com/agmikhailov/example2361M2.git):
>>>
>>> git clone https://github.com/agmikhailov/example2361.git
>>> cd example2361/
>>> git submodule init
>>
>> According to the docs of 'git submodule init', it "initializes the
>> submodules recorded in the index".  Therefore, it can only initialize
>> the submodule in 'example2361M1', because at this point we have no
>> idea that there is a nested submodule in there.
>>
>>    $ git submodule init
>>    Submodule 'example2361M1' (https://github.com/agmikhailov/example2361M1.git) registered for path 'example2361M1'
> 
> Indeed, `git submodule init` is not recursive.
> 
>>> git submodule update
>>
>> This command clones 'example2361M1':
>>
>>    $ git submodule update --recursive
>>    Cloning into '/tmp/example2361/example2361M1'...
>>    Submodule path 'example2361M1': checked out '6a9be24a1c0ebd44d91ae4dcf1fd62580b936540'
>>
>> Only at this point can we finally see that there is a nested
>> submodule, and can initialize and clone it with:
>>
>>    $ cd example2361M1
>>    $ git submodule init
>>    Submodule 'example2361M2' (https://github.com/agmikhailov/example2361M2.git) registered for path 'example2361M2'
>>    $ git submodule update
>>    Cloning into '/tmp/example2361/example2361M1/example2361M2'...
>>    Submodule path 'example2361M2': checked out '9ed39cf1fe0a8cf34e72d2e7ebff1ea9d4a63ac1'
> 
> I concur.
> 
>>> git pull --recurse-submodules=true
>>
>> And after that:
>>
>>    $ cd ../..
>>    $ git pull --recurse-submodules=true
>>    Fetching submodule example2361M1
>>    Fetching submodule example2361M1/example2361M2
>>    Already up to date.
> 
> Yes, I agree that _probably_ what the user wanted is to initialize the
> submodules recursively.
> 
> Having said that, I vaguely remember that e.g. Boost has this insane
> forest of submodules, and I am almost certain that no sane person wants
> to clone them all. _I_ wouldn't.
> 
>>> ACTUAL RESULT
>>>
>>> "git --recurse-submodules=true" command fails with message "Could not access submodule":
>>>
>>> $ git --recurse-submodules=true
>>> Fetching submodule example2361M1
>>> Could not access submodule 'example2361M2'
>>>
>>> EXPECTED RESULT
>>>
>>> All submodules are successfully updated by "git --recurse-submodules=true" command.
>>>
>>> ADDITIONAL INFORMATION
>>>
>>> Git version 2.20.1 does not have this problem.
>>> So we had to downgrade Git to work with submodules.
>>
>> The behavior was indeed different with v2.20.1, but that version
>> didn't show the behavior you expected.  When running your commands
>> with v2.20.1 I get:
>>
>>    $ ~/src/git/bin-wrappers/git pull --recurse-submodules=true
>>    Fetching submodule example2361M1
>>    Already up to date.
>>    $ find example2361M1/example2361M2/
>>    example2361M1/example2361M2/
>>
>> So while that 'git pull' didn't error out, it didn't even look at the
>> nested submodule, which is still uninitialized and empty.
> 
> I would actually argue that this is what is expected: the entire _point_
> of submodules is that they can be inactive.
> 
> Coming back to the Boost example, what I would want Git to do when only
> a fraction of the submodules is active is to skip the inactive ones
> during a `git pull --recurse-submodules=true`.
> 
> Which v2.20.1 apparently did, and I would call the current behavior a
> regression.

I agree, and this regression was fixed recently by Peter Kaestle.
This bug was in fact reported twice recently ([1], [2]) and fixed
earlier this month [3] (full threads: [4], [5]). The patch series is currently cooking
in the 'next' branch [6]. You can check out just the fix from [7].
It should be included in Git 2.31.

Cheers,

Philippe.

[1] https://lore.kernel.org/git/op.0vvmwohypvqxoc@damia/
[2] https://lore.kernel.org/git/1604413399-63090-1-git-send-email-peter.kaestle@nokia.com/
[3] https://lore.kernel.org/git/20201209105844.7019-1-peter.kaestle@nokia.com/
[4] https://lore.kernel.org/git/CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com/t/#u
[5] https://lore.kernel.org/git/1604413399-63090-1-git-send-email-peter.kaestle@nokia.com/t/#u
[6] https://github.com/git/git/blob/730f2a8a60960c30a79e00ebe034836f60befbf0/whats-cooking.txt#L765-L771
[7] https://github.com/gitster/git/tree/pk/subsub-fetch-fix-take-2
