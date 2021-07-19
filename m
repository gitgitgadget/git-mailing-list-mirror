Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC60C636C8
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 02:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F272610A5
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 02:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhGSDBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 23:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 23:01:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F80C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 19:58:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a127so15149968pfa.10
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zMRfriQ9b5LWAcE47wivIE01D7Yz3Ndacwf6od1i7SQ=;
        b=rabamPFke9d9AORgffUW9CMTXs84CQ1SMaK7TptmCJ9A4yc8zX17GIGi92goZT3v6x
         JdgdoeMLieuVvElJvC3z66S0C6GzsOJdyXS5pzzSRg81flBa/dmMoxBXER5ma8eaUKoG
         uu9+g63WamJrPSRv/IbjE88CTwaQYYJ/Fg6mH3MeEkad2Ksk7eVoqOEXQpW2tL2FH2HS
         Jx67P5gqX596lpI6u4DNZj+pZiUNf04dm3LWoyJ3ZCsH2o6U6EesJInxiFWqUWHa6zg0
         6C+vIn/RQbydLspd5PQ6WZ3/J1zEgyx9CjAXcDHTas/StNhrVuC9va2FQhJW/OuxtT3r
         CCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zMRfriQ9b5LWAcE47wivIE01D7Yz3Ndacwf6od1i7SQ=;
        b=RlBZN5hATwXfHotF8us6W+LBryvG0wCbn6o0E1saGe2TYydU/igJ2Qc6EIty9y/PBQ
         JdmS6cNR0WaFBfOe3VYuxxoq/IaLPSPnyNyPUGujzut0ufCJH92J5Tkq4YZbKO1I35dP
         Ds0FTiIHjKAofgYoOo8TledBEQEcTm5LYIVWkcux5lHLP26rMpXzXfNso3Vx1MGKdv2n
         mLoJ8qJ99/8yPCXppx/lgz+kEahxm+6deq4wWlnLqI7aRmAFiV11ewZ2hIdI5tGDYYWg
         emJY4Ffp65Yx1Wbu1Wt/5aEbnVzKfUwdXHyZD/f2lqUhsIZzyG0VHAgs736y8lFE6P0N
         ACQA==
X-Gm-Message-State: AOAM5320NiFbNRgoeu+QkLsgkI1ljOoQEPhS51av2q2/l64tw/ec4iFp
        vM2xEdIuAKbDhE2RZjD7xXQ=
X-Google-Smtp-Source: ABdhPJyP+f/UwWG2M7PM4BIM4eGCuiHfB1WLWNrEcnnJ0UfHDDPKU46qsxQvPJ+JwTKT8q+KAZrLsQ==
X-Received: by 2002:a05:6a00:2282:b029:32e:37d2:d35b with SMTP id f2-20020a056a002282b029032e37d2d35bmr23322048pfe.54.1626663525649;
        Sun, 18 Jul 2021 19:58:45 -0700 (PDT)
Received: from [192.168.193.232] ([106.195.41.101])
        by smtp.gmail.com with ESMTPSA id i25sm17565490pfo.20.2021.07.18.19.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 19:58:45 -0700 (PDT)
Subject: Re: My Git Dev Blog - Week 9
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
 <09edd920-e9ef-f8f9-79e6-d27badd2e5a6@gmail.com>
Message-ID: <a8122438-8d8b-9e7d-d66a-dc6eff7a0817@gmail.com>
Date:   Mon, 19 Jul 2021 08:28:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <09edd920-e9ef-f8f9-79e6-d27badd2e5a6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva and all,

On 19/07/21 12:49 am, Kaartic Sivaraam wrote:
> 
> On 18/07/21 5:29 pm, Atharva Raykar wrote:
> 
>> Passing the superprefix explicitly
> 
> My gut instinct tells me we could get away without having to go this way but
> I haven't yet been able to figure out how. How 'prefix', 'super-prefix' and
> 'recursive-prefix' is still puzzling me. In case anyone has knowledge about
> this please chime in and enlighten us. It would be very helpful.
>

I just noticed I was short and unhelpful here. To expand on what information would be
helpful on this respect, here's a snippet of a private e-mail I sent which I've
tweaked a little to make it relevant for the list audience:

-- 8< --
>> Problem:
>> -------
>> I cannot get 'submodule update --init --recursive' to work properly.
>> 
>> Cause:
>> -----
>> The paths get malformed in my first implementation[1] because I am not able
>> to transfer the git 'superprefix' to the 'init_submodule_cb' callback with the
>> current interface. The superprefix is required by the
>> 'get_submodule_displaypath()' function to create the correct display path.
>>
>> Thus, t406.5 fails.
>> 
>> For more details on this and the exact error,
>> cf.: https://atharvaraykar.me/gitnotes/week8#path-pains
>>
>> [ snip ]
>>
>> The link at [1] is the one where it fails only one test in my machine.
>>
>> [ snip ]
>>
>> This version does *not* start a subprocess for running init before the
>> update. The relevant lines for this are here:
>> https://github.com/tfidfwastaken/git/blob/7ad995f465072b60a8c33e51c4f91d08ee3d2484/builtin/submodule--helper.c#L3325-L3344
>>
>> [1]: https://github.com/tfidfwastaken/git/commits/submodule-helper-update-1b
>>

I took a look at this. I'm not able to find the exact issue but my gut instinct tells me
it has something to do with how prefix, super-prefix and recursive-prefix
are handled before and after the conversion. To be more specific, I'm having doubts
about whether the following code snippet[4] in shell ...

     prefix=$(git submodule--helper relative-path "$prefix$sm_path/" "$wt_prefix")
     wt_prefix=
     sanitize_submodule_env
     cd "$sm_path" &&
     eval cmd_update

... has been properly converted to C. Particularly, the fact that recursive calls to
'cmd_update' is made in the existing shell implementation in case '--recusive' is
passed needs to be observed well. This would subsequently result in multiple calls to
'cmd_init' with different 'prefix' and 'wt_prefix' values. So, that needs to be
observed well too.

I have not been able to get a complete picture of this myself. I'll try to take better
look later and see if I could get anything.

Note that this could also be me just not being able to get a proper picture of it.
Just wanted to share it in case others are able to get any ideas or able to think of a
possible cause.

[4]: https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/git-submodule.sh#L654-L658
-- >8 --

I hope that gives a better idea about what kind of information would be helpful.
Kindly let me know if it doesn't.

Atharva,

In the meanwhile, I think you could continue polishing your attempted solution
and preparing to send it to the list. I'll try to dig more on my gut instinct
and let you know if I get anything. If you have some free time left after
polishing your series, you could try digging into it too :)

-- 
Sivaraam
