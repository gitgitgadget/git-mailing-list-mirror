Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38736C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A161078
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhDYNRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 09:17:23 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:52142 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 09:17:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id DA37040CEF;
        Sun, 25 Apr 2021 15:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1619356600; x=1621171001; bh=x3SoHbJl2mQYZP2iRRE
        NTCsj3lxwU4UkCXhCEuU9434=; b=gl6B722yq+N9jCO1jvVw3ltWImsYIm/VTJp
        CT8u0m3oRutK/XjQcHb6+Jcsal3WAmxwbehzaCIMCr5X4BovZahnI3qGBURBOmmh
        eFBm+UIXWR5U+N9uMR2Cw0dMw2+6mNsNomln8EU4YeyM4UAfJ/0Hv3JBp5Yf/6Al
        qdvk2aFX//KJwzDGWxakeEaRUaBPCxAVUisCs8+HZMCEeS17koT4aNVi4bx+rDjU
        374eTIjQAz7DH5nh1pCFwTQ81ibx7iG3hoy1uFzmZLKu82ChE+sN2dOwI1q3P+n+
        3ceCucfW3u525XCyv+hrPiHsuFjLL7I6DEl36iDxjIXz2VV0YUwZMkeFE22wjQRg
        wHwofysnJ+7kLmW2wBXVh2XjLGxsB/ibEahYMALvmk3lD1dZQxFkQFZIi3sM15gm
        a/Vwyv5oVwywJ76intx5XIMhbmjxEC7Volmb/ohb9+XahV4CmXRqLsGa6SbfTsX0
        zMW6B0JOq4Prm0wZB0RxysIdC3XJh2JW4imC1L+FCStNx5VkBQfeHz6pv2yErce5
        HuAPbcDQg/9LovsyAZDi7S8U2KeAbd34Li5/KESuDMHXAo1P5s11tgFWM6fVDAX/
        o5PPnAOvOGDeyyTaEERl1CK4WRv3puqipIZTqPdVm0GALkGLcRYoYtpvM6ISieP0
        UH5OEOQU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BCm2FSakRqZn; Sun, 25 Apr 2021 15:16:40 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id F2F54403D1;
        Sun, 25 Apr 2021 15:16:38 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id B80222404;
        Sun, 25 Apr 2021 15:16:36 +0200 (CEST)
Subject: Re: [PATCH 03/12] ls-files: free max_prefix when done
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <beccdb1778697a2a46b81c85fc91c477c040397c.1617994052.git.gitgitgadget@gmail.com>
 <6a72a920-134f-541b-7caa-debe24658005@web.de>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <11ae3ce9-997b-32fc-7bc3-ee95a3d99153@ahunt.org>
Date:   Sun, 25 Apr 2021 15:16:34 +0200
MIME-Version: 1.0
In-Reply-To: <6a72a920-134f-541b-7caa-debe24658005@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/04/2021 10:12, René Scharfe wrote:
> Am 09.04.21 um 20:47 schrieb Andrzej Hunt via GitGitGadget:
>> From: Andrzej Hunt <ajrhunt@google.com>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index 60a2913a01e9..53e20bbf9cce 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -781,5 +781,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>>   	}
>>
>>   	dir_clear(&dir);
>> +	free((void *)max_prefix);
> 
> This cast is necessary to ignore the const attribute of the pointer.
> It's scary, but safe here because this function owns the referenced
> object.
> 
> I think the promise to not modify the string given at the top of the
> function is not worth having to take back that promise forcefully at
> the end to dispose of it.  Determining the correctness of this cast
> requires reading the whole function.  Removing the const from the
> declaration (and the cast) would improve readability overall.  Thoughts?

I agree - I'll change this in V2 V2. In fact, Peff already given the 
following explanation for why non-const is preferred in this scenario on 
a previous patch of mine (which I failed to heed when preparing this patch):

 > If a variable is meant to take ownership of memory, our usual
 > convention is to not declare it as "const"."
https://lore.kernel.org/git/YEZ0jLppB9wOg%2Faf@coredump.intra.peff.net/

> 
>>   	return 0;
>>   }
>>
> 
