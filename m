Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DEC43215
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CE22070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHs2lEKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfKVLKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:10:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34629 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbfKVLB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so8132590wrr.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cZ0RlmA5Ja1M9/8NGxYlq4vDw0WW5cqjascs/fvGolg=;
        b=GHs2lEKH+Qat4mzYmrFnMwjenV8OxQnRO3XtYr3GsCv+qezZXhhxFrFhbBR9dcOyec
         bfK5tvSPxSrZfVd2iucBgzy4LDRBhFFxT64U8kfr1fiikeCZriH969hSJxF0PeG45pCX
         kocA6sksdZpyfwqyR6iwEJMugSjTglHJ1Ps20tpa0AYVuWDXA2QAYJv4BbbB6hCE6Uu8
         +f9WzLKop9Ven1NXCr042sh/B1PZLOocvKAeDgIOHFNmiQGd5TD6tLur7rAghUFMPjeA
         bsWXRCl1JbjJmo0N4Ia6A4zwM72cO35YsxUsltkzZSpTlgqyGZ185qj8llJspQ+Tnpub
         yqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cZ0RlmA5Ja1M9/8NGxYlq4vDw0WW5cqjascs/fvGolg=;
        b=dotDUL8LCN/3xInez6BHj0KwMTQt153x8dpg7sNRClBYoHk2+9thBQEVlnmk11fObd
         IYnKkt6MEEAQPXXIcSdh+2xT9MZ+YvvckK7FcmvM2cj8Jil5fVuRdVCvBCnWDDrNZ8gO
         QKba5e2csQHAY2DcVS4b0eWrBL0snxwR0Zgr6xTWK5vz/XDYH9PqsLC/t1GsoybLb3us
         sceJZ7znM8TcCDHTOhJSkexGY/cOQ20pAjfwgqUrYS+u4Vhfy7DNf1RF+kmGYKi6y1/n
         hmN/WIb79XQFQQEB9+/SC2ha6rMYbC9aYdf26rLJjjFYzPN2S32MKQpd/E8FSHtak1ru
         /Dqw==
X-Gm-Message-State: APjAAAWeCF9QKbQSlLU3tPcAYyJWE3xHrKGqEzPrAgfS5u1Y7OzfkXIS
        Q+BFbYGHDOo2o2kwvX/EgyiL+bn+
X-Google-Smtp-Source: APXvYqzJ4GwuSL4Z+Ne/TR/PesQTjQkYXkeXYcIFiPjyJCvRgY9XBV2nyj2Mfa9/sy7whYNtTw0ZDw==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr14876721wrw.208.1574420515049;
        Fri, 22 Nov 2019 03:01:55 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id a17sm7239539wrs.33.2019.11.22.03.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 03:01:54 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] sequencer: fix empty commit check when amending
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
 <xmqqh82w4do6.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0c393fc0-b9d7-66d3-4562-f5278f8a5b59@gmail.com>
Date:   Fri, 22 Nov 2019 11:01:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqh82w4do6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 22/11/2019 06:40, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This fixes a regression introduced in 356ee4659b ("sequencer: try to
>> commit without forking 'git commit'", 2017-11-24). When amending a
>> commit try_to_commit() was using the wrong parent when checking if the
>> commit would be empty. When amending we need to check against HEAD^ not
>> HEAD.
> 
> Thanks.  That makes sense.
> 
> If you compare with HEAD and find there is no difference, that would
> mean that the "amend" itself is a no-op (i.e. the user said they
> want to make changes, but after all changed their mind)?  It might
> be something worth noticing, but certainly not in the same way as
> "we were told to skip an empty commit---is this one empty?" gets
> treated.

Yes I'm trying to decide what to do about fixups and squashes that 
become empty. We'd need to do such a check in the sequencer before 
trying to commit I think.

Another thing to think about for the future is what message we want to 
display when a fixup makes the amended commit become empty. If there is 
another fixup following it then the commit may not end up empty by the 
time we've finished applying all the fixups for that commit. If the user 
runs 'reset HEAD^' after the first fixup we'll end up fixing up the 
wrong commit with the later fixups.

Best Wishes

Phillip
