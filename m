Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146EC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA2461353
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESWFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:05:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A7C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:03:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x19so21406501lfa.2
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8/KdjpzLfIgi0d0we1GDXrK364LaTJ4Of0PryJn0r+A=;
        b=nOx7ABr3w/Cq34hxzNdE85xpjs3+pvmCy+pASMf+8xXnrOi415NHHClaNyMzeMgdkk
         INNBvuEqiDyvsLQgwDZWN/gV1cXSPOVQAZdvUZuv7C41GzSDmil11+hSC3E8ushMWj5o
         PYfghF2qxQylOmef0Vi0GJ18ukxuMBgHVtM+TbyKQxBWgeJINDZZPg0+VPS48Ti3Ntdn
         PuRV+KxxiSFiLP7m186xVhE5LnfsFEnhurUA++DXJkYMYfbyBMRB8Tuhxla58F+7P+FI
         v+H2uGj4/khAzZ1upHcriw6b1GrCmt/DAOMlQSvlAi2EmBvH9ONCjt1vDqDuMPqaWAiY
         D+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8/KdjpzLfIgi0d0we1GDXrK364LaTJ4Of0PryJn0r+A=;
        b=YDNjxBZk4KIne3FT+VM6hQwB4oJZutLvtrkghVLT/6mHD0UZ05KrAP54STP+p2hD3L
         t1LCaFFPVyddYtO4VRamufhj15B/aB6VRDvvnsfmdAd+BQviVEhwwNx51DZtK5Fcr+YB
         g6EyTCcVML6oL1gk8GYQvqaiYVs4D5m0O92AkBw0LlwVXnW1SOdn/b3y0UIYaX7dJalO
         KwebNkqgUDzEmep2xs4/mvsOYKF+FHdyMDU6sWkBYqhyVc7EJ4t6un3FHsJJNltfsFOH
         AbMfRq1xw2Z/YnnxP0tfmZK030NTZwZFDlZvwZNt8lFXs50Ez2MDgym9tcUKsQlcp12F
         2mgg==
X-Gm-Message-State: AOAM532hfDh5M19gAK64Om8H3rjY6otNa4ikpjgY2RDnQ5TAyEt7Tvzj
        jRHvuS8ZhyUiMEOzA+3PS10JD+puQdM=
X-Google-Smtp-Source: ABdhPJyXXGgPgxaO+p6JvNJwxvIkkeaNV7rR/YuWuuQjBU6z7FyjtMoVwjo3dIVmCPS62JI8Bjx2qw==
X-Received: by 2002:a05:6512:3dac:: with SMTP id k44mr1116415lfv.256.1621461833155;
        Wed, 19 May 2021 15:03:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i5sm54337ljb.129.2021.05.19.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:03:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <YKWHo9gZNp+i3fH9@google.com>
Date:   Thu, 20 May 2021 01:03:51 +0300
In-Reply-To: <YKWHo9gZNp+i3fH9@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 14:48:19 -0700")
Message-ID: <877dju754o.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sergey Organov wrote:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>>
>> After this patch
>>
>>   git log -m
>>
>> will start to produce diffs without need to provide -p as well,
>
> Personally I don't ever use -m without -p and --first-parent, so in
> that sense this feels like a change in the right direction.
>
> Does this also affect the plumbing command "git diff-tree"?  I'm
> guessing "no" because diff-tree already generates a diff by default,
> but it seems worth spelling out in the commit message to prevent
> worries about the effect on scripts that expect stable plumbing
> behavior.

Well, here are existing relevant tests:

diff-tree master
diff-tree -p master
diff-tree -p -m master

that all still pass after the patches, and I believe

diff-tree -m master

does change the behavior, but provided it's useless before these
patches, it should be OK to have this change.

Thanks,
-- Sergey Organov
