Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434FC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1046613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhGPFWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:22:08 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:7172 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhGPFWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:22:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 2D738BD3;
        Fri, 16 Jul 2021 07:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1626412749; x=1628227150; bh=vwJoiWyUQzhwcrDfZic
        a3zGkAcrqAIuoQHsCNtmRP14=; b=EqCA4GhX0v+f1LJs2c5rCXrN6Q41e8GP5BF
        jwb1sz7TIKCRpH4POE7UMo61z5MEeT/S8myPcKuQ5hdGlgT8cRlHk7PIH0VWFPEP
        EIX8odbF1pwtPRrW+I9UKQumN3Xk7HN5VizL5TvBSZObH5kFis7Z0knTBAfctrwc
        3lzvDgXRtKv5OGaouRYgg4VEEG8/OVxIbU5xagZc6kqEYCEIQMfk8QGj6ojyEj5i
        l3eyKcmjJTbd07uHtbKEr6cEgIjin2dEka0yblLXdi5xCNTHtLZtXaKLe+B5A7UQ
        AKC/eP5TmO4Wjkg+3NzmWqjoNZ42Y/k6KIBxpQCWGPDyWjzNk3idJXcRckO9tif7
        R4CMiwjgURi1B0p/+s5V6kB1zRzUsAg0wCq87FkEpK57piTWLIYT4VQ1vbpBxCaK
        S46dPghHxmAA1M91oGpptA1VLU25QE5FQO8ZIRO7GGL4yVHI3iA6AeN+3R2p3gE6
        ypsdvUE+BGSjAD4GF7+nmhhwaaQTfDcWsN506JfTeET+cgQBzKKCBV+o7m1Nju68
        d4gTETjXJVsiCrhyx88JQmK44Kz8U10Y9CT8EBoifj1hyMT0orWivRBW3AMsf5ib
        sjU//XCAFaXDgwGZg8itoRLbWp8SO5/TDAYecwU3p96822kWz/AXvQO2M0zgMntn
        odeGIZjU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Azu6TKSyG1GS; Fri, 16 Jul 2021 07:19:09 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 34FE4499;
        Fri, 16 Jul 2021 07:19:08 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A829D4CA1;
        Fri, 16 Jul 2021 07:19:03 +0200 (CEST)
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <07624f34-2c0d-d577-e4bc-ab8ebe146ffe@ahunt.org>
Date:   Fri, 16 Jul 2021 07:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/07/2021 23:42, Jeff King wrote:
> On Wed, Jul 14, 2021 at 08:57:37PM +0200, Andrzej Hunt wrote:
> 
>>> @@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>>>    	if (!strcmp(var, "core.attributesfile"))
>>>    		return git_config_pathname(&git_attributes_file, var, value);
>>> -	if (!strcmp(var, "core.hookspath"))
>>> +	if (!strcmp(var, "core.hookspath")) {
>>> +		UNLEAK(git_hooks_path);
>>>    		return git_config_pathname(&git_hooks_path, var, value);
>>> +	}
>>
>> Why is the UNLEAK necessary here? We generally want to limit use of UNLEAK
>> to cmd_* functions or direct helpers. git_default_core_config() seems
>> generic enough that it could be called from anywhere, and using UNLEAK here
>> means we're potentially masking a real leak?
>>
>> IIUC the leak here happens because:
>> - git_hooks_path is a global variable - hence it's unlikely we'd ever
>>    bother cleaning it up.
>> - git_default_core_config() gets called a first time with
>>    core.hookspath, and we end up allocating new memory into
>>    git_hooks_path.
>> - git_default_core_config() gets called again with core.hookspath,
>>    and we overwrite git_hooks_path with a new string which leaks
>>    the string that git_hooks_path used to point to.
>>
>> So I think the real fix is to free(git_hooks_path) instead of an UNLEAK?
>> (Looking at the surrounding code, it looks like the same pattern of leak
>> might be repeated for other similar globals - is it worth auditing those
>> while we're here?)
> 
> This is a common leak pattern in Git. We do something like:
> 
>    static const char *foo = "default";
>    ...
>    int config_cb(const char *var, const char *value, void *)
>    {
>            if (!strcmp(var, "core.foo"))
> 	          foo = xstrdup(value);
>    }
> 
> So we leak if the variable appears twice. But we can't just call
> "free(foo)" here. In the first call, it's pointing to a string literal!
> 
> In the case of git_hooks_path, it defaults to NULL, so this works out
> OK. But it's setting up a trap for somebody later on, who assigns it a
> default value (and the compiler won't help; it's a "const char *", so
> the assignment is fine, and the free() would already be casting away the
> constness).

Ah, right. I didn't think about the risk of future breakages.

> 
> I see a few possible solutions:
>  [...]
> I can't say I _love_ any of that, but I think it would work (and
> probably we'd adapt our helpers like git_config_pathname() to take a
> def_string. Or I guess just have a def_string_free() which can be called
> before writing into them).

Is it worth sidestepping the whole globals issue by migrating 
core.hookspath (and other string config values) to be fetched via 
git_config_get_pathname() and equivalents at the point of use instead?

I looked at the commit below which introduced git_config_get* which 
suggests that these methods were indeed intended to be an improvement 
over the callback based API, and IIUC switching over should have a bunch 
of advantages:
  - Removes some potential bugs that can happen if git_config() was never
    called with the right callback.
  - Potentially reduces the number of times we have to iterate over the
    config in the first place (assuming we migrate *all* config access
    and not just strings).
  - Fewer globals - which reduces potential for such leaks (and probably
    makes it easier to read the code in the first place).
OTOH I'm not familiar enough with this code to know what the 
disadvantages of such a migration might be (it's definitely going to be 
a lot of work... but that's going to apply to any of the approaches we 
can choose to fix these leaks).

git_config_get* were introduced in:
   3c8687a73e (add `config_set` API for caching config-like files, 
2014-07-28)
