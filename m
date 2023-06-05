Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjFEPqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjFEPqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C8196
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 08:45:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39aa8a055ecso1205937b6e.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685979901; x=1688571901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOX5kWAcdbwjfL90awDd9+kCjClAvXfOKRis9MrmHjQ=;
        b=GEYgI6LljVVcwQR4r6xK5iuiD55//pmeEHTyoaKNArwxUxvkTMz0oUG1qL3tNEUORP
         oiO9d7s6LEViGv8hLG1A9h0u2Jrds5CzkXoZIFiqL+WyC9s+lIbgcyPKx+bGHLQpmgeF
         xg9t8hs4L69sNE//AR0H3V0Tda8LE3RF/TIY5d3BOykBKR+mnkNt0PJsQ/mnRLaE6dDX
         53E1vprCqA9tBUHE8hzf8tgNCb2BpTmGEvJygBCi9gFc1ChjJYKK2kNGC1ksiDBrPYb7
         /Uy+2U03h+wA2fNCXqhXPvowk25NqzrbwBNLL8P71njW+vzxmH/jP5335GOe4l4OLt9v
         pQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979901; x=1688571901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOX5kWAcdbwjfL90awDd9+kCjClAvXfOKRis9MrmHjQ=;
        b=COqLGWmCT3h5xDzTkdDnZCVncYk77N+0pGJfBDd5iOI47PK0ThebRI8EPGvETU/ovD
         Mf6OcB1mno800ZsXWyjWqJDmB36Jyh6wP76DMeMqvY2kaGQx+XvMqwfQGtohCJpAX0ta
         9bnOTngWbLZdJca/2y+QTATV3bEcpOvBPD3fO1oGc8IhMs8ICtHl8ewLZ/rplGCcHK7h
         apbjhpKhHXv2Zcr+0ffMsZ8See9r+ZjvCp9ybg76yP5XUtpxwO4XPFYWgfsnGsJQD/Vp
         xSSBO7x9LnqJC9X6fv/a+1hx43RU1dhC6Oh5WwgWjCB/Sil7rfjM3pMojNaL4tJKYRNC
         0tUA==
X-Gm-Message-State: AC+VfDzRPWGWiNtKijGLn5TXHAPYXtfSECXt8G+uDKUuUnN2zH5Xg5fq
        yw/1OJ8E3mOaOwpY85tCxvfWdzPzTLeFCYy0Gw==
X-Google-Smtp-Source: ACHHUZ5+kS+Wss+7GNE97H0xLGOOj22cGBJKcRd/vRhqGD/ASXtpdnFOtupdcnQFFvYYUeDTgA830w==
X-Received: by 2002:aca:d943:0:b0:399:ed2a:f4b5 with SMTP id q64-20020acad943000000b00399ed2af4b5mr4246981oig.24.1685979901526;
        Mon, 05 Jun 2023 08:45:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6cc2:3d2c:f002:d37d? ([2600:1700:e72:80a0:6cc2:3d2c:f002:d37d])
        by smtp.gmail.com with ESMTPSA id k6-20020a05680808c600b0039aab5cee6csm1552965oij.11.2023.06.05.08.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:45:01 -0700 (PDT)
Message-ID: <4e22c11a-32e5-8121-84e2-e79a1f14e498@github.com>
Date:   Mon, 5 Jun 2023 11:44:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] replace-objects: create wrapper around setting
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
 <49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com>
 <72fb4420-2492-e644-58cc-b9b3dbfb8037@github.com>
 <CABPp-BGjUXhvd9sWe7YAzbSi5WYscM=9qt5BZQujbdnVRVFtYA@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGjUXhvd9sWe7YAzbSi5WYscM=9qt5BZQujbdnVRVFtYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2023 9:47 PM, Elijah Newren wrote:
> On Thu, Jun 1, 2023 at 12:50 PM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 6/1/2023 12:35 PM, Victoria Dye wrote:
>>> Derrick Stolee via GitGitGadget wrote:
>>>> From: Derrick Stolee <derrickstolee@github.com>
>>
>>>> diff --git a/replace-object.h b/replace-object.h
>>>> index 7786d4152b0..b141075023e 100644
>>>> --- a/replace-object.h
>>>> +++ b/replace-object.h
>>>> @@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
>>>>  const struct object_id *do_lookup_replace_object(struct repository *r,
>>>>                                               const struct object_id *oid);
>>>>
>>>> +
>>>> +/*
>>>> + * Some commands disable replace-refs unconditionally, and otherwise each
>>>> + * repository could alter the core.useReplaceRefs config value.
>>>> + *
>>>> + * Return 1 if and only if all of the following are true:
>>>> + *
>>>> + *  a. disable_replace_refs() has not been called.
>>>> + *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
>>>> + *  c. the given repository does not have core.useReplaceRefs=false.
>>>> + */
>>>> +int replace_refs_enabled(struct repository *r);
>>>
>>> Since the purpose of this function is to access global state, would
>>> 'environment.[c|h]' be a more appropriate place for it (and
>>> 'disable_replace_refs()', for that matter)? There's also some precedent;
>>> 'set_shared_repository()' and 'get_shared_repository()' have a very similar
>>> design to what you've added here.
>>
>> That's an interesting idea that I had not considered. My vague sense
>> is that it is worth isolating the functionality to this header instead
>> of lumping it into the giant environment.h header, but I've CC'd
>> Elijah (who is leading a lot of this header organization stuff) to see
>> if he has an opinion on this matter.
> 
> I haven't really formed much of an opinion on the sea of globals in
> environment.h and elsewhere beyond "I sure wish we didn't have so many
> globals".  Maybe I should have an opinion on it, but there was plenty
> to clean up without worrying about all of those.  :-)

Thanks for chiming in (even with "I haven't thought about it too much").

Thinking back on this with some time since the initial question, I think
the grouping "global state" into environment.h isn't the right goal.
Using replace-object.h collects all _functionality related to the feature_
in a single place, and it just so happens to include some global state due
to the needs of the feature.

I plan to keep these methods in replace-object.h. With that, we have only
20 files that include that, as opposed to 141 including environment.h.

Thanks,
-Stolee
