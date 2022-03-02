Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiCBXvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiCBXvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:51:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F13A0
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:50:37 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 145-20020a630397000000b00373b72d65f5so1806943pgd.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9/MYvu2BUgcZYELJSHvVbFIKrHKnssJlfQvnhaMKJeQ=;
        b=UvmNyFhcNsw6jyhv190TqQKuJBrJflMXWqK3SEttWm+PZFIDiTOm7DSev9lWCyaxUS
         VuOzZ16QdQrTbI3yVt7/5WWkGe9C9UCunmewdlmOtWYvrX5lmQhbe6EMDHlnN2nNoHAU
         BjJWC50ibm/Fxbc9psNP3iITLRpyKerMPinKLhZ7TcWGFkHerTwbUx9LzQ0Y954S9/iB
         eKB6xGPxGZ25jlKcGbzsZBPtf7EuWwfZoeXoADVCQbfuu+7DuOZkNHx3xExOHHpKW6vi
         sdZFaCtAP3V0IaUQsmU1VovQPU3WE5ttO4ARse1/AAbvNRn7qDkmgKSNmjmj7y4k/vbn
         7GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9/MYvu2BUgcZYELJSHvVbFIKrHKnssJlfQvnhaMKJeQ=;
        b=JGxE8mExqLIb4iFvOEJVlcQiuMlMM4yyPe46twh1bQ1Mz3jc23qSILnB9jXqs/Ybk2
         UtsbJsCFNNCfbg4pht4LfWr/yvtDBr4RbHOv9968RweZdFrciXXzaxZbDJ9iTqqbbYO8
         N9hEQEVeWCB+buWvrIPoQthNGw6UrZCu4sRV9WRR+0glPOD6D/qWAlFSxdm0+vOELFGt
         16Wyssvz5dfTNQepI5IJ4uECUCDx1ne/1aizAshh5MrHtRLJGmoj0R/+E3UCj3e6uAmp
         dWbVfW7Tn0OI/4R+HXKXcLHBSf5Szw089MycIMh0Csxse1PhFbeqX1QCWo914mV+Q9hv
         mk2A==
X-Gm-Message-State: AOAM5337FcE7Ucw+VwZV8joyJiMAnodAdpgh4KGYUppDPlZ/XwxJsHEA
        8lqaGb07xw108tSHnRJdTqEpkDjdYZ0o5A==
X-Google-Smtp-Source: ABdhPJxBSfiM1ac+V4QNc2KuuSAr/+sM1VXgTIue+23X++/Gsfq/eXb5KwU0h91CcdjIaAkUjy4i78Dt9y3v2A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f650:b0:14f:139e:aef2 with SMTP
 id m16-20020a170902f65000b0014f139eaef2mr32690534plg.151.1646263525295; Wed,
 02 Mar 2022 15:25:25 -0800 (PST)
Date:   Wed, 02 Mar 2022 15:25:15 -0800
In-Reply-To: <xmqq35k1pg4c.fsf@gitster.g>
Message-Id: <kl6lfso0djj8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-10-chooglen@google.com> <xmqqr17p5ujf.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2203012039080.11118@tvgsbejvaqbjf.bet> <xmqq35k1pg4c.fsf@gitster.g>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi,
>>
>> On Sat, 26 Feb 2022, Junio C Hamano wrote:
>>
>>> A few tests added by this patch have been failing on one specific
>>> job (linux-gcc ubuntu-latest) at GitHub CI.
>>>
>>> https://github.com/git/git/runs/5341052811?check_suite_focus=true#step:5:3968
>>> https://github.com/git/git/runs/5343133021?check_suite_focus=true#step:4:5520
>>>
>>>     Side note: you may need to be logged in to GitHub to view them.
>>>     These two use different versions of CI to show the test traces;
>>>     in the latter you may have to click on right-facing rectangle on
>>>     the line with label "5520" to see the breakage.
>>>
>>> I think there is some baked-in assumption in the failing test what
>>> the name of the initial branch by default is, which may be the reason
>>> why this particular job fails while others don't.
>>>
>>> Can you take a look at it?
>>
>> The log says this:
>> ...
>> At least that's how _I_ tried to address similar issues in the test suite
>> in the past.
>
> Yes, I had a squashable fix/workaround queued since last night.

Thanks, both! I especially appreciate the pointers because I couldn't
remember how to set the default branch off the top of my head.
