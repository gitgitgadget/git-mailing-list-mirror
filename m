Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A6BC64E75
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7733221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 13:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H06+7htP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgKQN4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 08:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgKQN4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 08:56:19 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18E2C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 05:56:19 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id e14so3423450qve.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K78INMWCpHECOXkHLjPkvUWskFNvIor89ZrrxjGSK7I=;
        b=H06+7htPI184bqpsAtO6d/EAB/QuiF9iiftRnf6hH5+iGOFoI9bIz4aIpjmk5fmDdf
         jKS+jYztxrn2Y4dyHThy1cepD+1/fe31svCxj5PS6/wqQMDjdWmIx2SU5PEmpugGbxMN
         KeEVq9PRc3itMJmTrlWnP9cKF83yY9SdEvbUAdifQ3kSjTknsG+MSbpSzfH7+21W5bWa
         +HCtOpUrS+CtknDOAbcrxHSP0C95CYenJ46jC0Mw/K66iBEpwVwA6QlSsQZg5l9zpFOE
         27Wd1+yfIKrVO8ivk466TPxJEvWrqY5/uppn/AIhg1jy9fVPPkqG3Dh8Sj03ZGBz42z8
         gEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K78INMWCpHECOXkHLjPkvUWskFNvIor89ZrrxjGSK7I=;
        b=kcywozm0D+MzZsg/93X3W+Fyii82WvovLPIU8fhbVx37hAm0JWQKWy/HZwklWXgnhh
         k9BkaVvdyUvYiwUKDV9bmdSwWWm5L5tME+joEJih00A+HmOcRJTcMljK4IbFfC2kwMQ2
         QFhI+/LeWatv1Bi8vR160iDSuaN/JkVjFwWXBUI38k3pk0b+dqRmWQuISKeMrpN1Zzl8
         GAQSScwi6xJwbkFMR2/qqMrxmlPNqd51KtcU/3A0nzq2Z6tAXjzOB5TcTHtPOiW90vzk
         kz8/zI14Co0fDbvY09vcCgnIMRgxAu9skbN3nQ4pgX39BIwPL/zJqBoVdqpls1bifL2Z
         p39g==
X-Gm-Message-State: AOAM533GIobk+K4V5CvgzBzDl9oSqy7kB+4sPb3NY8XpYjv3DaHC70hc
        C2LHz3XghH0TBm9LEzmhHuBlQC4ZxBm1yg==
X-Google-Smtp-Source: ABdhPJzxuC17LkcDq7eTT/Sh2J2kNJvozMsCz0EKNFqheubcRO1Rh4jy1beLiTPhy9fSeMMxIZu+/Q==
X-Received: by 2002:a0c:f651:: with SMTP id s17mr21169611qvm.32.1605621378547;
        Tue, 17 Nov 2020 05:56:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d8ec:3b9c:1add:941c? ([2600:1700:e72:80a0:d8ec:3b9c:1add:941c])
        by smtp.gmail.com with UTF8SMTPSA id i4sm13720594qtw.22.2020.11.17.05.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 05:56:17 -0800 (PST)
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com> <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
 <20201117010709.GB15562@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
Date:   Tue, 17 Nov 2020 08:56:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201117010709.GB15562@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/16/2020 8:07 PM, Emily Shaffer wrote:
> On Mon, Nov 16, 2020 at 04:40:35PM -0800, Junio C Hamano wrote:
>>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>>> Because 'git maintenance unregister' spins a child process to call 'git
>>> config --unset maintenance.repo <cwd>', it actually fails if "cwd"
>>> contains a POSIX regular expression special character:
>>>
>>>   git config [<file-option>] --unset name [value_regex]
>>
>> Good find.  And it is even worse that value_regex uses ERE, not BRE,
>> which means even an otherwise innocuous letter like '+' cannot be
>> used without quoting.
> 
> I should have mentioned in the first letter than Jonathan Nieder was the
> one who made the jump from "this is breaking in the buildbot but not
> locally" to regular expression metachars. Credit where it's due.

Thank you for finding and reporting this bug.

Can I at least have a short moment of griping about anyone putting
regex characters into their directory names? ;)

>>> You can demo it for yourself like so:
>>>
>>>   git init repro+for+maintenance
>>>   git maintenance register
>>>   git maintenance unregister
>>>   echo $?	# returns '5'
>>>   git config --list --global
>>>
>>> I see two paths forward:
>>>
>>
>> 0. Quote the value_regex properly, instead of blindly using a value
>>    that comes from the environment.

Pulling the subcommand from my test enfironment using GIT_TRACE2_PERF=1
I see the following quotes being used:

git config --global --unset maintenance.repo "/repos/new+repo*test"

I'm guessing that what we really want is to _escape_ the regex glob
characters? This command works:

git config --global --unset maintenance.repo "/repos/new\+repo\*test"

The only place I see where we do that currently is in
builtin/sparse-checkout.c:escaped_pattern(). Please let me know if
you know of a more suitable way to escape regex characters.

>>> 1. Teach 'git config' to learn either which regex parser to use
>>> (including fixed), or at least to learn "value isn't a regex", or
>>>
>>> 2. Don't spin a child process in 'git maintenance [un]register' and
>>> instead just call the config API.
>>
>>> I'd suggest #2. The config API is very nice, and seems to have a simple
>>> way to add or remove configs to your global file in just a couple of
>>> lines. If there's a reason why it's not simpler to do it that way, it's
>>> my fault for missing the review :)
>>
>> My short-to-mid-term preference is to do #1 to allow a value to be
>> spelled literally (i.e. remove entry with _this_ value, and add this
>> one instead), and optionally do #2 as an optimization that is not
>> essential.  I do not offhand know how you can make #2 alone fly
>> without doing some form of #1, as I think the same value_regex that
>> ought to be ERE to specify entries to be replaced needs to be used
>> under the cover even if you use "config API" anyway.
> 
> Ah, right you are - I had figured the regex parsing was done earlier,
> but it indeed looks to happen in
> config.c:git_config_set_multivar_in_file_gently. Thanks.

So the "real fix" is to allow a command-line option to 'git config'
that makes the "value_regex" parameter a literal string? Of course,
this would either require wiring an option down into
git_config_set_multivar_in_file_gently() to treat the string as a
literal _or_ to escape the input string in builtin/config.c.

Am I understanding the intended plan here?

Thanks,
-Stolee
