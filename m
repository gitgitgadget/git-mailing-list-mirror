Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581C9C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7A3611BE
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhETFFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhETFFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 01:05:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF665C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 22:03:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso4000509pjq.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 22:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRstYsb3rmGTf4JdbjxgJ638OGZHx7hpq8b37WyjnqA=;
        b=Otxn5J6XjPiNv46o+QGZgY7cPZuBvZcPS+15988ppEWnxilsbfFZsc6R31xJt05CtE
         991Om+6HWThsTrSYZaCqgKMiMln7IkrIRChYs8tkSN6dNdCgF2WdJc/9Ev5uXJ/VoIVr
         D1gYEk3kCcA3FR1DDOYix3/znihMfK/SA9SC/qO8VHDqRccvckRAcifjVpeIAwfSJkqL
         LJ+knGhVCkbggzF1FfxZYOEIpTS2yXxPM/NR5AuJActpjmS2DsA0mag/kSKNsl645P1B
         NX9YdI/M5VwcKXtTBiFp8wyfFyLjheI/mZ17EDf/dV34yMnXJrpGZcq63pdzENZe/gOR
         PV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRstYsb3rmGTf4JdbjxgJ638OGZHx7hpq8b37WyjnqA=;
        b=i0roSgXXBBAA/3TfSftbdCh6Tg6WShycP/ILDyGztRAwRmsm+hUYjsXRrRErZhSyXh
         3WSQUZgDEcmrvG9QY5Jefb0UMZyAwgHjx443ryNyn0nxWlLscPMiAHZztjNaX48UdyE/
         Lzot+ALrCj1IM9l7oJZqD54iu19Ofl2YnbCXHYJJtFPh23xCQ1NAjeBoWQANVwh8enW8
         oHycJKHPIC6xNBQI4gbLk7jTWCGcwRMM5C3TGTT5t79LtKslZKMpquOe53CipJnw3jtW
         OfWaAWhsVBIE16HUVGf7sJgShZoAfGQsMX/TNe4miY/TU1CaeyQzaV+nzcf6IuQatIIS
         t6EA==
X-Gm-Message-State: AOAM5316KPy8+Zp3r4kEe1+381gkfAXQM03CSgvjcoIJYYwQi9y5X0u0
        sPtQfPzI5k70iBa93SqslUWd6zf+688ewg==
X-Google-Smtp-Source: ABdhPJx7a8yjNsZ1al8wOo4an+lRjxVRX22XM6N0OLCxqIkkZT/sUtEQ2z6VoSlGNWXkZoIh40SGNQ==
X-Received: by 2002:a17:90a:b294:: with SMTP id c20mr3131981pjr.236.1621487019445;
        Wed, 19 May 2021 22:03:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id w74sm797825pfd.209.2021.05.19.22.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:03:39 -0700 (PDT)
Subject: Re: [PATCH] fetch: improve grammar of "shallow roots" message
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20210518061855.57478-1-alexhenrie24@gmail.com>
 <626174ae-ff25-8f07-4d67-705bbe3f7d68@gmail.com>
 <CAMMLpeRxoakadrXUVGSkhP0K71GHXxt4sXvSKrB5rx8oFH60bw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <72f5226c-142a-f4a1-64c6-46ef647adbb5@gmail.com>
Date:   Thu, 20 May 2021 12:03:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAMMLpeRxoakadrXUVGSkhP0K71GHXxt4sXvSKrB5rx8oFH60bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/21 11.02, Alex Henrie wrote:
> On Wed, May 19, 2021 at 8:22 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 18/05/21 13.18, Alex Henrie wrote:
>>
>>> -                                     warning(_("reject %s because shallow roots are not allowed to be updated"),
>>> +                                     warning(_("rejected %s because shallow roots are not allowed to be updated"),
>>
>>   From descriptive to null-subject past tense, right?
> 
> I'm not sure what the best way is to describe the grammar here. I
> would say that the "ed" makes it clear that the message is a
> description of what did happen rather than an imperative command
> concerning what should happen.
> 
> -Alex
> 

Looks OK.

So the error had happened, and we needed to express the situation.
Because it happened on the past, using past tense was obviously the
right thing.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
