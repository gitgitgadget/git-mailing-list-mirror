Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860DCD8CAC
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbjJJR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJJR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:58:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D98B4
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:58:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so55297725e9.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696960725; x=1697565525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbZmWTb2LhVLjr0/zISTN1sxe0OQI8uYXVM7QhY1fsk=;
        b=kGtV+7bmmHBkJPosD2E3wUQ4OoJPh2UNBxvtEbYmHtpTpLkZ8T8lhq7SnMBxPL5ucW
         0RRXMOtYvJJ2fGRpzMWAa/Z0w0veMEnc4OJknKrsRNEsQnQgieJQko2hp7tujwjmVK5z
         LVnkX8HXrmwTEllH8WSlPZ/xdS8h6Wx1C5da4YiNl3o+zynuoXa+6oc1EZ0tRd9G2W+D
         KCHnx5NaZA8OUgzwmh/y8vNPyVkIA+Tq9M2l+33k+qxDBlYD368zIkbq0w+yxHjrSf96
         4+thMLEzaCpsk7X88Alw0ErDLz6e5gXgXCrViIZDIGvGDNt8xoqglRKF5I0dcNUsU4i1
         uakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960725; x=1697565525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbZmWTb2LhVLjr0/zISTN1sxe0OQI8uYXVM7QhY1fsk=;
        b=Ht19b2LtLUBBJ9xCZ1tmXt7k/TR4ejuEQQC5iGIMxOvKdm7M8AOqA/FWXZY71wAcrx
         l5bbKjwC1gLyXDHGQCiH436wHkLuWF3fHpSTho+a6EKP7gVnGS7xNwNuFAJKN4kxNgQf
         jQ3M0zxi6iG0N8zFHVwA7D8FMouMKX+xBHhMmxVFaXHsr8AKS1ImF/EjJaWbXFH8Aqax
         7OnKQe+cYVl395xA2O63zAHQSEHz7Bw5N2nD4x9VJmmnqWBDTnJwFMqvBiDTo9GDtwtB
         i+vwoCqjCgIE0YeM/+SVjWcaBwhi4oix4j/lyfuc4bIwsX7eY3n5ZDXOxstjkvGBe4K8
         FSQg==
X-Gm-Message-State: AOJu0Yxt/ZZzEr5UfqmZa7YdYAgM2VAk7tQJFnpU/MdwIGMyoXv9kXjY
        QsbJ4Hh6W31Ez28lAiv1z/Sf2bNO99c=
X-Google-Smtp-Source: AGHT+IHLbasFEtg8EsU6RzjtAqT4OF1NdtRh9DV32LiSr1mPWAJBXIpQk6M+moDmLVA8hYJsf3txIA==
X-Received: by 2002:a05:600c:2195:b0:406:53aa:7a5f with SMTP id e21-20020a05600c219500b0040653aa7a5fmr17223988wme.10.1696960724723;
        Tue, 10 Oct 2023 10:58:44 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm17060249wmj.38.2023.10.10.10.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 10:58:44 -0700 (PDT)
Message-ID: <87c16c09-784f-4818-9231-8023fc2c5a02@gmail.com>
Date:   Tue, 10 Oct 2023 18:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] parse: separate out parsing functions from
 config.h
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20231010174348.2150150-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231010174348.2150150-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2023 18:43, Jonathan Tan wrote:
> phillip.wood123@gmail.com writes:
>> Hi Jonathan
>>
>> On 29/09/2023 22:20, Jonathan Tan wrote:
>>> diff --git a/parse.h b/parse.h
>>> new file mode 100644
>>> index 0000000000..07d2193d69
>>> --- /dev/null
>>> +++ b/parse.h
>>> @@ -0,0 +1,20 @@
>>> +#ifndef PARSE_H
>>> +#define PARSE_H
>>> +
>>> +int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
>>
>> Previously this function was private to config.c, now it needs to be
>> public because it is still called by
>> git_config_get_expiry_date_in_days(). As this is essentially an internal
>> helper for git_parse_int() and friends it is a bit unfortunate that it
>> is now public. Perhaps we should change
>> git_config_get_expiry_date_in_days() to call git_parse_int() instead.
>> Then we can keep git_parse_signed() and git_parse_unsigned() private to
>> parse.c.
> 
> It could be argued also that it fits in with the rest of
> the parsing functions - this one parses intmax, and we have
> others of various signedness and size.

This one differs from the others because it expects the caller to pass a 
maximum value, the intmax_t equivalent to git_parse_int() would be

int git_parse_intmax(const char*, intmax_t*);

We now expose git_parse_int64() which covers a similar case.

> I'm open to changing
> git_config_get_expiry_date_in_days() too, though...we probably don't
> need so many days.

Indeed, the existing code passes maximum_signed_value_of_type(int) as 
the third argument to limit it to INT_MAX already.

>>> +/**
>>> + * Same as `git_config_bool`, except that it returns -1 on error rather
>>> + * than dying.
>>> + */
>>> +int git_parse_maybe_bool(const char *);
>>> +int git_parse_maybe_bool_text(const char *value);
>>
>> This used to be private to config.c and now has callers in parse.c and
>> config.c. We should make it clear that non-config code is likely to want
>> git_parse_maybe_bool() rather than this function.
>>
>> Best Wishes
>>
>> Phillip
> 
> The difference between these 2 functions here is that bool_text supports
> only the textual forms (used, for example, in git_config_bool_or_int()
> which accepts both boolean strings and integers), which might be useful
> elsewhere too. But it could be better documented, yes.
> 
> Looking at "What's Cooking", this series is about to be merged to
> master. We could hold off merging that, but I think we don't need to
> - it could be argued that git_parse_maybe_bool_text() could be better
> documented, but even if we wrote it from scratch, I would probably put
> the extra documentation in its own patch anyway (so one patch for moving
> the code, and another for adding documentation).

I agree it's not worth re-rolling just to add some documentation here.

Best Wishes

Phillip
