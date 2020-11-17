Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0BC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847F9241A6
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OasHW8gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKQVMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgKQVMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:12:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F35C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:12:11 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t5so17007807qtp.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0iPAxQ8q2spIM1meO0ZqJA1tdqD648FsJ/6p1w45PuM=;
        b=OasHW8gl2fGbX5g+T8Z66XOG9Q61FW7pTdV60PX0RppMExMjDDlI4uYaDrODW6c9PZ
         ESXjyyzmcIjdwIkktpJ16UAQDSs+cJ/hToeo0zH3bjwayUL2Onnj0vjs4bMYAPYV7Yry
         9K/fkJBGTwUKk4sRrCpLGDxJJAAjnPvb2zLqgPk+LEkt0Ml6cjbxRKDCA251QUfpG9z4
         s03Bz2oab9QahPgfAnzOtJPzCangvFHH8/13EUH+qzLUR/jgWlarfIDwFgiPhxj1CsMo
         zeIgYWv6W6Ue+83NR2aeChIeB4yJzivZOwMzsCh939BpaPXedclsrhqkmn3xhGdWqOQT
         qJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iPAxQ8q2spIM1meO0ZqJA1tdqD648FsJ/6p1w45PuM=;
        b=a4+STqVnMDBapJxhq2qLmT5yf5f91SoRIrl3WA/5Z15JzcURixudiTuM/yTxcCpJH3
         rKjxYllvCMUkhr5lsDnncI7CdSYeAD2pnAPN22pkbPNHw9/+lz0PYZZKWBJRiATfbwZi
         j52JLF114p/+kXjakA2C2I0Moi0lPvaqxiGM2rUgnTN4q9VHNLTZDxHWAr4g7vaygabn
         hr3xS3sbp0W5GtcTX6+Drc41pJB96xONHwPN+hBMX26GwVakrKzA89mToGp4ChH93IZc
         sEN7BhjuLAXwRQGeVhJPf1NMW/SvWoOsR0wyjS+JQr9QOcNQZ+4I7oY1AJLPkxf8X9PH
         +hCA==
X-Gm-Message-State: AOAM533RKqG6jG409EaYNVqGcRQPy+xdMSnkz+esWrSPUSE0PWMDtJJA
        lJM1ZP06OW+wmrhT3P5n6E967+Ght5PkYg==
X-Google-Smtp-Source: ABdhPJzhLIwHuLzGapVt+xmMkSul2EaQp77ChqX+FPq6aIbmwtgtpzjxTQ8CSAD4i8v444bUNWUGFQ==
X-Received: by 2002:ac8:4a99:: with SMTP id l25mr1639142qtq.27.1605647530543;
        Tue, 17 Nov 2020 13:12:10 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:dc5a:1896:d146:4b2c? ([2600:1700:e72:80a0:dc5a:1896:d146:4b2c])
        by smtp.gmail.com with UTF8SMTPSA id z88sm13445971qtd.46.2020.11.17.13.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 13:12:10 -0800 (PST)
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com> <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
 <20201117010709.GB15562@google.com>
 <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
 <xmqqlfez6alb.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfez6alb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2020 2:34 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> Thank you for finding and reporting this bug.
>>
>> Can I at least have a short moment of griping about anyone putting
>> regex characters into their directory names? ;)
> 
> Sure, but the blame mostly lies in the one who thought using ERE was
> a good idea ('+' is very often used).

Yes, the example provided is not nearly as problematic as it could
be. I also appreciate finding this in 'next' instead of in a release!

>>>> 0. Quote the value_regex properly, instead of blindly using a value
>>>>    that comes from the environment.
...
>> The only place I see where we do that currently is in
>> builtin/sparse-checkout.c:escaped_pattern(). Please let me know if
>> you know of a more suitable way to escape regex characters.
> 
> If we wanted to go that route, yes, we need to prevent random input
> taken from the end user or the environment to be regexes, when they
> are literal strings.  But I think we should just bite the bullet and
> say "git config --unset --literal-value-pattern vari.able va+l+ue", etc.
> 
> This is not a suggestion for the option name, but a suggestion to do
> this with a new option and not with a special value-pattern syntax.
> 
> 	Side note.  It is tempting to declare that something like
> 
> 	    git config --unset vari.able "!!$end_user_value"
> 
> 	is the syntax to use literal/fixed pattern, and that way we
> 	do not have to touch the callchain from builtin/config.c
> 	leading down to git_config_set_multivar_in_file_gently().
> 	It is backward incompatible change that is unlikely hurt
> 	real people.  If a script is feeding "$end_user_value"
> 	without cleansing as the value_regex already, it is already
> 	broken (e.g. if $end_user_value happens to being with '!',
> 	this will unset everything that does not match the regexp)
> 	anyway.  And users already know to say '[!]some-pattern'
> 	when they mean the pattern begins with a literal '!' and not
> 	"does not match some-pattern", so reserving '!!' prefix does
> 	not sound too bad.

This is very clever. However, I fear it is _too_ clever.

>>>>> 1. Teach 'git config' to learn either which regex parser to use
>>>>> (including fixed), or at least to learn "value isn't a regex", or
>>>>>
>>>>> 2. Don't spin a child process in 'git maintenance [un]register' and
>>>>> instead just call the config API.
>>>> ...
>>>> My short-to-mid-term preference is to do #1 to allow a value to be
>>>> spelled literally (i.e. remove entry with _this_ value, and add this
>>>> one instead), and optionally do #2 as an optimization that is not
>>>> essential.  I do not offhand know how you can make #2 alone fly
>>>> without doing some form of #1, as I think the same value_regex that
>>>> ought to be ERE to specify entries to be replaced needs to be used
>>>> under the cover even if you use "config API" anyway.
>>>
>>> Ah, right you are - I had figured the regex parsing was done earlier,
>>> but it indeed looks to happen in
>>> config.c:git_config_set_multivar_in_file_gently. Thanks.
>>
>> So the "real fix" is to allow a command-line option to 'git config'
>> that makes the "value_regex" parameter a literal string? Of course,
>> this would either require wiring an option down into
>> git_config_set_multivar_in_file_gently() to treat the string as a
>> literal _or_ to escape the input string in builtin/config.c.
>>
>> Am I understanding the intended plan here?
> 
> Yup, if people cannot poke holes with the wishful thinking that the
> breaking of backward compatibility by using the "!!" prefix would
> not cause practical issues, then I am also fine with that, but
> inventing a flags word with a VALUE_PATTERN_FIXED bit in it and
> updating the callchain to pass it down from the command line option
> parser would be much less risky, I would think.

I will get started on this fix as a series on top of part-3.

Thanks,
-Stolee


