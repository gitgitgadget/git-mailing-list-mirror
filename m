Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561A6C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6D56109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhFPOZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhFPOZh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:25:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E8C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:23:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u24so2924703edy.11
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zVaAW0UqJWumldvB+d1GY70Zdn+quNyi+f1ZUESVp4g=;
        b=qesfq1MQNng+8HisvPPUlQrjMJUhYwJIn8Pn3Mroe88jLDhBLJfBI3yZZO1cSTM0t5
         Y5p3uzyUm4bFDohsCQpMSahWNwqf0925JahxRJjVVeJhe4WCNL5MRlVJ8ANJfIEB+M+7
         0T4vB6oCmvqOXlLnFT0gOjUJ8A92a96Hhygiw+PZOtyHJ4j4QxemW04hgkxzBCgvLREG
         j1GXNDu8aZgUrRRIonaxPEtSgYF3UHVQDZVxwXuEzRWsFVVmXPJ4+Vg1goXB//7lhYZM
         QGPtTEgTQEkVMfJEwYHqFnhZqmwi616nszlfi7O0JMyGPx7lMkhyp1wBiS3+U6gD1vx+
         j/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zVaAW0UqJWumldvB+d1GY70Zdn+quNyi+f1ZUESVp4g=;
        b=S1e7qEwnBQBuK5HXwT4yIJI90IgDNxIEI+MWrR17n5I/u8xubs1cYj+HcmX9CvGrL+
         +rdQKwuM957UZn8R4ewuR+8rLPuNNhpOWSfTbotXBWdLp++EPeyzdpACqTDtp0KB55q/
         O9HMY/VhLBcW0V+f8gWRBAFJmAyw7+fk18woFDbcttQwMHQ2p6cL+bkzip6IPUsDQdZY
         l4CwlP61I1JcWUW++6MasUZRmDn/M9hqFAS0LpaGn8wKwSqSvIfNiWY93RGBag7YyE2Y
         xICWMmfil8ejfZaZKR5yjm0qnP3nYpi5aFND4sH/p7uD9WWi9L2YWLvgOt0otS+/OaZD
         bhwA==
X-Gm-Message-State: AOAM532/xetTqdT9ufLVQ98UeN13aBft+tWBAon8PKu/GyyZH+nNo+5S
        EnR0hyyRf/NlK1dIS5BR5CN//Ezw69+OiA==
X-Google-Smtp-Source: ABdhPJz4xFNxoNgAXfpMn8sUHodKjE9Vq3ljgh1O2Ega+8uqaqeedccLSyViNt3V+15BLzpBWgr5kw==
X-Received: by 2002:a05:6402:1763:: with SMTP id da3mr4635701edb.352.1623853409001;
        Wed, 16 Jun 2021 07:23:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e25sm1733631eja.15.2021.06.16.07.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:23:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Rostislav Krasny via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rostislav Krasny <rosti.bsd@gmail.com>
Subject: Re: [PATCH] Add a basic support of SHA256 repositories into Gitk
Date:   Wed, 16 Jun 2021 16:19:57 +0200
References: <pull.979.git.1623687519832.gitgitgadget@gmail.com>
 <xmqqwnqutx6o.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqwnqutx6o.fsf@gitster.g>
Message-ID: <87h7hxyjkv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Junio C Hamano wrote:

> "Rostislav Krasny via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Rostislav Krasny <rosti.bsd@gmail.com>
>>
>> Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
>> ---
>>     gitk: Add a basic support of SHA256 repositories into Gitk
>
> Looping-in the gitk maintainer.
>
>>     This PR makes Gitk working on both SHA256 and SHA1 repositories without
>>     errors/crashes. I made it by changing and testing the gitk script of Git
>>     for Windows [https://gitforwindows.org/] version 2.32.0.windows.1 that
>>     is a little bit different than the mainstream 2.32.0 version.
>>     
>>     Still not fixed functionality: [1] There is the "Auto-select SHA1
>>     (length)" configuration preference that affects "Copy commit reference"
>>     on both SHA1 and SHA256 repositories.
>>     
>>     A new "Auto-select SHA256 (length)" configuration preference should be
>>     added and used on SHA256 repositories instead of the old one. Since I'm
>>     not familiar with Tcl/Tk and this issue isn't critical I didn't
>>     implement it.
>
> Thanks, Rostislav; please follow Documentation/SubmittingPatches
> next time you touch gitk (or git-gui), as they have their own
> repositories and maintainers.

A comment on the patch at large: I realize that the author isn't
familiar with Tcl, and this is a minimal & immediate fix, so maybe we
should just take it.

But I wonder if this == 40 or == 64 shouldn't just be "accept either" in
this case, these all seem like cases where we disambiguate a hash from
some other name.

Doing so would be nicely forward-compatible in case gitk and others ever
need to deal with viewing a mixed set of hashes, or maybe I'm again
misrecalling the transition plan and that'll never happen (they'll
always be translated?).

Especially stuff like this (grabbing a bit to quote from the patch):

>> -        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
>> +        if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{4,@@}$}] $id]} {

Would be simpler as just:

    if {[regexp {^[0-9a-f]{4,63}$} $id]} {
