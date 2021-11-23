Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58085C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhKWTIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhKWTID (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 14:08:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBFC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:04:54 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so9469460plq.7
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=TOIL6W8b5uwwltZSplzYFD5eblLsYZNlY/jt26aPgm0=;
        b=ZE7rhHtG+OE0Kyjwnj/PJlcuZDp60UCkCUV8uN21BBWhcvicvWxorHSRt0NIQXqGwm
         F1QRElUHjSNwS+S1sjnHaxhMMmeXN/MhwI38aWN06uwyZGHSrLFatXGHwTYjzXfJ8ile
         2Wx1dTBkVwqYnpluenjZ/7fzzHvsTF/kdQUm+09sYkCmltPZFwmjjCaTlimuZVRHkRJI
         1ilbpasTTSDWPadVgjcdMylJJueBQ4wwuyLGvTwdw3Psefwld1BM8Qb8tR8Av5Q74Oq0
         H4kAKszJNHt8/lUVWv7kEawroY13awWHIrxLjHHSi6SPyocSpKy2xNjYgYdnYJVxL4rx
         9yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=TOIL6W8b5uwwltZSplzYFD5eblLsYZNlY/jt26aPgm0=;
        b=nH1qfBJZhdNbxlKDPWvlf8UMPD1YbOUeiOfmj879JVKLDEDxl/NiRFclXOt3rVdfSe
         4Cub6nJvIsCQFVx21iYeaqOTdjj0Dl0Lda3dwkQIdt67I9tg/1G0cRkx+B6NY8xyEVPm
         fMnEJHvVnmTzT8Itdce9GEAggxA8SspOl3gqQNW2rlGRgCBHibP6IG9qoAcXlwdrhS80
         3dkMP/i60woWm2UCZE4WmEJyIucWY8XXy43JmCv9Wa2JYCeFT+QEl6Mz01J6MIDfmS9e
         GmxPNdwOm2ev7QONiNJNMIqtPkl1Hw7SWAIw4CcU3DVnWF3uA8m+Gs6AQhGExdiCvT+Q
         WE4A==
X-Gm-Message-State: AOAM532nQSePo8xNEql3qCQP9gYzXTsvqJEGqv5Rw4f6igusC/vYhczO
        zt/DpmT9g0bOuaVLBK91zQbbcwQlEPhghw==
X-Google-Smtp-Source: ABdhPJwDfH9ZfEN7lnqTu7lT2DqvUYtfSvZISUzcjxOb0YGMW3ofSA1dLI1J1Y1IBlfouHkCt6mfl8yCyxeEXA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:64c2:b0:141:c171:b99b with SMTP
 id y2-20020a17090264c200b00141c171b99bmr9624793pli.55.1637694294043; Tue, 23
 Nov 2021 11:04:54 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:04:52 -0800
In-Reply-To: <30f6ee13-8db7-e983-fb87-ef038a3487a2@gmail.com>
Message-Id: <kl6lbl2ak817.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <bb9c0094-8532-c463-47a2-442b225ad52e@gmail.com> <kl6lr1bhtf67.fsf@chooglen-macbookpro.roam.corp.google.com>
 <30f6ee13-8db7-e983-fb87-ef038a3487a2@gmail.com>
Subject: Re: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> In favor of not letting users opt out: exposing fewer switches to users
>> makes it easier for them to get a good user experience. Instead of
>> giving users the ability to build-your-own UX, maintaining a small
>> configuration surface makes configuration easy and puts the onus back on
>> Git (or me, really :P) to make sure that the UX really works well for
>> all users, instead of opting out and saying "oh the user has
>> branches.recurseSubmodules=false, so I'll choose not to support them".
>> I think this stance is good from a product excellence perspective, but
>> it's an obvious risk.
>> 
>> A way forward might be:
>> 
>> * mitigate the breaking changes by flagging this with
>>    feature.experimental
>> * test this behavior with real users (aka internal) and iterate from
>>    there
>> 
>> Does that make sense? I'd like to make sure I'm not missing something
>> very big here.
>
> It does, but I think that we can still build a flexible product without
> compromising UI/UX :)

Agreed. The long term result might be that submodules + branches will
always live behind its own flag (though I hope not..). One person's
flexibility is another person's complexity, so we will need a lot of
finesse in order to find the right tradeoff.

>>> Also, I assume the new behaviour would carry over to 'git checkout -b' and
>>> 'git switch -c' ?
>>>> * `git switch --recurse-submodules topic` should checkout the branch
>>>>     `topic` in each of the repositories
>>>
>>> Nit: I guess you also include 'git checkout --r topic' here also ?
>> 
>> Yes and yes (I believe --r refers to --recurse-submodules?).
>
> Yes, and it works on the command-line ! ;) long options can be shortened
> if unambiguous, see 'man gitcli'.

Ah, TIL. Thanks :)
