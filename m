Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A5E728CB
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 16:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2Q7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2Q7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 12:59:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7592CB4
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 09:59:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77acb04309dso510428139f.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696006774; x=1696611574; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sbKNng6roJEP0ngCLomh/YjThHJdY4PEmnsSoWbePc=;
        b=XSzkfcdC7Cw40NrThoA1KVaj2x8qd1Y4fiYW9OtsZhZ8Q2ErSQq7Gh0U8eAnRjxH/u
         xBDkwlyK4wc5I8MMRaYfquFtwMLBMJHUT0QfU0WpJ+8x1IHWesx0i/zNs1VvIybl6JNb
         WQOEF2+sqHh0wKtOoAXfpLZqUemLW9J2OhpL9Inz+OreIHgqoOHInaUSvnz4ZSnYnKP+
         0gpZsDZkabIQRkr/mgv6ngiP3Pras1yfZ+r2jGHHC8Qug8GKmlQHKK+74hhCpgA/nZ2j
         bNJJMiFEJRPRjiciE/ExJkzIotWOoNR2Jkretsf+fRGBkPHSX1oq1JqpcjFzq+x06piV
         m5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006774; x=1696611574;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sbKNng6roJEP0ngCLomh/YjThHJdY4PEmnsSoWbePc=;
        b=kXJ3ObuDyM5K1DyewwH1p3/dlV2W6/dFbqjw4gMOeE8n1qvVnT5FrzCUxr1ZFyVFMu
         unRkccxQ9Zj2F6LDetLqWBUBvsTQG1G93WZS0HNn3aUiTZxXa39E0FdhC6Xa5Yq0yfGf
         6dNPPvdnnWzzSHMOO12jc1JU9Dqy+Mzk803xQXl9ECFTJCaizuq9xKJqVINogDBQoEgS
         uvb+e7MCFOSVSfs6uIlcnvC6pAwNaEvLCkyvIHiGHtn4lfZiJa8ss9LbgQygZSFeYT4P
         3NIkaGnU1ijXFnvinbKXTaPkoHDInI6cv+s60d1FEoXO6EGoFfykdskokvs4TlwsH+R6
         MPCg==
X-Gm-Message-State: AOJu0YzU1gp0Hgl6gY5bgS4dS1ZX151skzK/vB7pAx0OQzKGf9ZvgbZ1
        6/a7+xCXBzrTQbl4aXfyYTY9NStMPNk=
X-Google-Smtp-Source: AGHT+IFq1L96MnLM2D8jZIBqD2rZl8iINgWc31yh8KA7ZjkM22FAP9RWp+SkXF1ZBlOdaNVCSMA7bQ==
X-Received: by 2002:a05:6e02:1ca8:b0:34f:75eb:f81 with SMTP id x8-20020a056e021ca800b0034f75eb0f81mr6252849ill.5.1696006773602;
        Fri, 29 Sep 2023 09:59:33 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id eh24-20020a056638299800b0041d73d0a412sm5395296jab.19.2023.09.29.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:59:33 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
        <xmqqfs2zl2iy.fsf@gitster.g> <xmqqbkdmjbkp.fsf@gitster.g>
Date:   Fri, 29 Sep 2023 11:59:31 -0500
In-Reply-To: <xmqqbkdmjbkp.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        28 Sep 2023 13:18:46 -0700")
Message-ID: <87bkdkhq4s.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>>
>>> diff --git a/setup.c b/setup.c
>>> index deb5a33fe9e1..87b40472dbc5 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -598,6 +598,25 @@ static enum extension_result handle_extension(const char *var,
>>>  		}
>>
>> This line in the pre-context needed fuzzing, but otherwise the
>> series applied cleanly on top of v2.42.0.
>>
>>> Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
>>
>> "Implement" -> "implement" (many other patches share the same
>> problem, none of which I fixed while queueing).
>
>
> The topic when merged near the tip of 'seen' seems to break a few CI
> jobs here and there.  The log from the broken run can be seen at
>
>     https://github.com/git/git/actions/runs/6331978214
>
> You may have to log-in there before you can view the details.

Did you have any manual merge conflicts you had to resolve?
If so it is possible to see the merge result you had?

There is a static failure in commit.c of oidcpy because it thinks the
array is zero size.  That is weird, but once I get a test environment
setup I expect I can figure out what it is talking about.

There in linux-leaks it lists a bunch of test failures, and unless I see
what code is actually failing I am not certain I can figure it out.

Thanks,
Eric

