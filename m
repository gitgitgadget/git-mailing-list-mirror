Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D3EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjF3KBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjF3KA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 06:00:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972F35A5
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 03:00:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e0fbd742so196149566b.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688119254; x=1690711254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXtFqOYsEshefWxNQTr3ZZS+Z2anRyuIUAP/n0cTPHQ=;
        b=alpXvIm43dcOO0Hl8tFhp03cm07eTvW5f34Rvgoa7rQvm+PqLi+9HtDA1A6ar/0y2f
         F20C5Fm8Hmk3riDYySDdGKPKucEZCetM2BoRpj2x1dIl1sXEO6Q8s1/42Sh5670w+HoD
         9Ar2BtG+a+jZOoGhhC3VG2hIbe/jgWQitbNI3ceOPwxoWwWxcVG6jDF+j+80fBmIGIv9
         A97E91ZV2PV45xJ0+mLnTNCQsIcjfteuDA/BGg4YIxTRUqpeqgL71pDvJnFshyDCJes6
         zHstgf4YK4GVFK0sJpUL8Fb2Sav6/NL8Afv85HGbo1qnmkH+Si8G4ijk7f/lXoygQLkS
         6kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688119254; x=1690711254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXtFqOYsEshefWxNQTr3ZZS+Z2anRyuIUAP/n0cTPHQ=;
        b=FHWpjijdFoUmoZnP7jz0iObQtZARMYV6PIaOIkOAw/UiGfRk6x8FNhrG0mgxWhoPxK
         jwIQxEcLSTWu4gwqS4A/L0Uqxh/OGejsgozdgyF7oFnxzkFXfO/DgyCzjfp93Fox1nAk
         sD9kMRNsmhyQhuMJpjOH1S72zzMYbI5KC+8bX1qBMGTSLbfqHwoRaWv3gVSv8/zkw51J
         VTGeskE2d0koHH/AjWAdl8B0yp2Nbf6SkHcIdVPDCdwJlv+kUdQ3ToGBI0ZMPaTCmJ+B
         PVp3eMmPxfTwKaWha9KX+Dfo1Mr+YiOC2yP4MWK5LqUWiNtkm8tiwfQlbjeGVHsLDlue
         odzw==
X-Gm-Message-State: ABy/qLYo/wFLdKxs5mJ0MRrT1VilC/7HeT0CWNRmGdqpTbX8nsS+RTYX
        uVSsPBOdFckUcohJhMR22+k=
X-Google-Smtp-Source: ACHHUZ5vdDC1VZzuvJryzAnR5hGsbD6T7EpGamP1AMf1lUjxMglegugKFZ3RTvSDeIe9L9RT8qVVZw==
X-Received: by 2002:a17:906:3955:b0:992:3ac7:a2da with SMTP id g21-20020a170906395500b009923ac7a2damr1465337eje.30.1688119253906;
        Fri, 30 Jun 2023 03:00:53 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id s2-20020a170906960200b0098d2261d189sm7977023ejx.19.2023.06.30.03.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 03:00:53 -0700 (PDT)
Message-ID: <3029e4c8-5b42-5193-f9ce-7f4bb22fccab@gmail.com>
Date:   Fri, 30 Jun 2023 11:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 7/8] git-std-lib: introduce git standard library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-8-calvinwan@google.com>
 <d77f99df-f50a-39fa-a7c5-1bb958f196fb@gmail.com>
 <CAFySSZBMng9nEdCkuT5+fc6rfFgaFfU2E0NP3=jUQC1yRcUE6Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAFySSZBMng9nEdCkuT5+fc6rfFgaFfU2E0NP3=jUQC1yRcUE6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 28/06/2023 22:15, Calvin Wan wrote:
>> On 27/06/2023 20:52, Calvin Wan wrote:
>>> The Git Standard Library intends to serve as the foundational library
>>> and root dependency that other libraries in Git will be built off of.
>>> That is to say, suppose we have libraries X and Y; a user that wants to
>>> use X and Y would need to include X, Y, and this Git Standard Library.
>>
>> I think having a library of commonly used functions and structures is a
>> good idea. While I appreciate that we don't want to include everything
>> I'm surprised to see it does not include things like "hashmap.c" and
>> "string-list.c" that will be required by the config library as well as
>> other code in "libgit.a". I don't think we want "libgitconfig.a" and
>> "libgit.a" to both contain a copy of "hashmap.o" and "string-list.o"
> 
> I chose not to include hashmap and string-list in git-std-lib.a in the
> first pass since they can exist as libraries built on top of
> git-std-lib.a. There is no harm starting off with more libraries than
> fewer besides having something like the config library be dependent on
> lib-hashmap.a, lib-string-list.a, and git-std-lib.a rather than only
> git-std-lib.a. They can always be added into git-std-lib.a in the
> future. That being said, I do find it extremely unlikely that someone
> would want to swap out the implementation for hashmap or string-list
> so it is also very reasonable to include them into git-std-lib.a

Finding the right boundary for git-std-lib is a bit of a judgement call. 
We certainly could have separate libraries for things like hashmap, 
string-list, strvec, strmap and wildmatch but there is some overhead 
adding each one to the Makefile. I think their use is common enough that 
it would be continent to have them in git-std-lib but we can always add 
them later.

>>> diff --git a/Makefile b/Makefile
>>> index e9ad9f9ef1..255bd10b82 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -2162,6 +2162,11 @@ ifdef FSMONITOR_OS_SETTINGS
>>>        COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>>>    endif
>>>
>>> +ifdef GIT_STD_LIB
>>> +     BASIC_CFLAGS += -DGIT_STD_LIB
>>> +     BASIC_CFLAGS += -DNO_GETTEXT
>>
>> I can see other projects may want to build git-std-lib without gettext
>> support but if we're going to use git-std-lib within git it needs to be
>> able to be built with that support. The same goes for the trace
>> functions that you are redefining in usage.h
> 
> Taking a closer look at gettext.[ch], I believe I can also include it
> into git-std-lib.a with a couple of minor changes.

That's great

> I'm currently
> thinking about how the trace functions should interact with
> git-std-lib.a since Victoria had similar comments on patch 1. I'll
> reply to that thread when I come up with an answer.

One thought I had was to have a compile time flag so someone building 
git-std-lib for an external project could build it with

	make git-std-lib NO_TRACE2=YesPlease

and then we'd either compile against a stub version of trace2 that does 
nothing or use some #define magic to get rid of the calls if that is not 
too invasive.

Best Wishes

Phillip

