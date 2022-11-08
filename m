Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBD8C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiKHAbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKHAbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:31:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EC1DDEA
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:31:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so12721400plj.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+Nn1ZL/24lyYY5T9ZFioQNQ8puDOGA94GYWRsHrRCE=;
        b=Wefk7rw9VyKFAjDCT/aKShzImCyiotTK7IxjnFCJB5pzAvM1AzZiWjSyKt0KPRpF/h
         fF8J+xWVXPA/Znt8cSH2bbUdMiKHjkJriSBM0rckrZTDDaMlrv3lg2IJ5ufhknG/8IuI
         7l8XQUw4bWlFWiIj1jV0P47wz/vdsz+6Damxs0rzPFi2P1Uemc3+yiYo2V8W6ym+bbek
         jwjsxfhCUtd5nFDXnifiX2qLOSQSu+uiRj72YwzNxBT8sSs03SdB9vBUh5UbxjGMGuHP
         t4URrngfdzzMuTQ/gP9n8p2hOtzhqqt3aSU4GZHyCEpXsF+lCsAIsj0692LauMYUvCbz
         eHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y+Nn1ZL/24lyYY5T9ZFioQNQ8puDOGA94GYWRsHrRCE=;
        b=1UM5bqzUUt3NHk5ZZf4AFDz05kKlMUt1eRD4Nmtc/To1++8Bcf0SlK7p00PEm2lPFW
         ZihjIfiQLTXVnIJPTDrS8kORGriO1fHJWyuAN3acAiQppVoMCedAlMSyQgF0nAP0GMu2
         HHHVse0eBUDgP/dpXAaDNAVB3WMsN9uFJHSetqtuvr6PuQcfmEYpSr3q6UR75Uod8uhb
         OU2R85KHZqwX3zG338nJWGOkvLe5JCBJGoXoAxh2aEFRiJ81Dj68URQsZ6OP1TK730/S
         qYdYqDFgBjEIbnl/Ui7LONs5603yxbCITKKdSkiuU1s46izVaKaQBNRKOsM0Qm3+8K2z
         ABNA==
X-Gm-Message-State: ACrzQf0geECDrfHS13/ePAqBrkgHNB43ig9yyzLv/wu+hVxxMkNxaSU2
        BFPykgrq0/ysPyk0qduh0GE=
X-Google-Smtp-Source: AMsMyM5buZCVqaG/jw/f2gbaN1QEu4xWZdpSgmIuGezlOpUf3mFkGEPlV8uChv1Y0N8BxdGXyY2mXA==
X-Received: by 2002:a17:90b:1b4b:b0:213:4d2f:9832 with SMTP id nv11-20020a17090b1b4b00b002134d2f9832mr54049651pjb.233.1667867497346;
        Mon, 07 Nov 2022 16:31:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a24-20020aa794b8000000b0056cd54ac8a0sm5049778pfl.197.2022.11.07.16.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:31:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
        <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
Date:   Mon, 07 Nov 2022 16:31:36 -0800
In-Reply-To: <f975f57e-71e2-3227-8039-14dff82f04db@github.com> (Derrick
        Stolee's message of "Mon, 7 Nov 2022 14:45:24 -0500")
Message-ID: <xmqqk046cmmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Whenever a branch is pushed to a repository which has GitHub Actions
>> enabled, a bunch of new workflow runs are started.
>> 
>> We sometimes see contributors push multiple branch updates in rapid
>> succession, which in conjunction with the impressive time swallowed by
>> even just a single CI build frequently leads to many queued-up runs.
>> 
>> This is particularly problematic in the case of Pull Requests where a
>> single contributor can easily (inadvertently) prevent timely builds for
>> other contributors.
>
> As someone who is both the cause and the victim of this, I
> thank you for finding a way to reduce wasted CPU time. This
> patch looks good to me, though I'll need to trust the docs
> and your testing to be sure it will work. We will definitely
> see it in place as it merges into 'next' and 'main'.

When I see breakages of 'seen' only at the CI, perhaps because it
manifests only on macOS, I manually "bisected" by pushing various
combinations of topics merged on top of 'master' and pushing the
result out as 'seen' only to the GitHub repository, and not having
to wait one to finish before pushing out another was a really nice
feature.  Of course, I could wait before pushing another out, but
after seeing the last one close to successful completion in a few
minutes and being able to push out the next one was a great
timesaver, not only for the "few minutes", but for the countless
minutes because I will have to concentrate on more than just a "few
minutes" on another task if I have to switch to another task in
order to wait for just a "few minutes" before pushing the trial
merge out.

So, that is the only concern I have with this change, but in
general, not running jobs whose results are clearly not needed is a
good idea.  It just is "clearly" is hard to determine automatically.
