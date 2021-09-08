Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAB6610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhIHNND (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhIHNNC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:13:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BBC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:11:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bk29so2395032qkb.8
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHse9hhsIZredPkjHNB0bQXJGqE1qpnumzJst00pv+U=;
        b=Rw6LhuKkpTducqBo9ur0d6Sbvwn2x9YKGihlqHvSxzd8nmMFtgixkz1biO4kpCSc+8
         QFCZ6p3U89bnoieR6e8nuGMuw45EsU5NRedFmn570NpZ4g0gMw7FWpOPBHDrKOAwhy8l
         Gk+dh+C/OA3iHMYA5WR1+64s6c1el2r4DPAHnCS45wgg0xp3TouhJYOPwuIBbYC6uU+b
         MiepozTXEk/qDnxJJaafVY+Jl3H85GJg/ErPH3CDxouqlfQKoC8+/KHzwezEaunmh/aS
         G/p9x7sZDrmXa6ClPR6kCTSDF8IhOvymmg+Ks3Y1eKhR9qrabihYAzYpvoRERekqnViC
         81UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHse9hhsIZredPkjHNB0bQXJGqE1qpnumzJst00pv+U=;
        b=6iicXszx4g9KA1ZI9ijt4Q+3t3G+OYlMj+JqmfZjpWq+uQhGVlPI04XdNokNQn5uh2
         3akKYtTTa65js/6os+Vf2vTHH+Ps1frAse9SY1zPswZf5EdDJuNICJaOOe96u5xxp3Jw
         ow6hd7DddYKWJ7eJRo5m/Y4dBPFRA2+ytZubaljS0fN+/kVL2npnqvIoYJ+diKml3s/r
         EakP0omxjsqUOqX6s7vXbmEe9ut/Eqq/ZZtRYgan/YtvE/d2jEryU+MAW5sHO7/EOkpS
         WJZcieW4lO2O9dV5/ahGLezP/6yQP5oWLTdK/l9r2awYnEeyKR85gKluKeAeQR/jIhnh
         Jm1g==
X-Gm-Message-State: AOAM530VTv7knnMYeThwOmnzavjYauvrFXsd0lre+GNjbkuJpeDTRmLe
        ObP2P+qezCqWBOWswrbPIlkJTU0iP08=
X-Google-Smtp-Source: ABdhPJzUytydiv5Vjw+Q0OGraN2TyBTYKq2diC7vxjTroeS6W5Mr0WLaczF1urlkMRUuUMpCyvoFXg==
X-Received: by 2002:a37:a6cc:: with SMTP id p195mr3236677qke.161.1631106712761;
        Wed, 08 Sep 2021 06:11:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id q22sm1474485qtn.25.2021.09.08.06.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:11:52 -0700 (PDT)
Subject: Re: [PATCH] tests: remove leftover untracked files
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1088.git.git.1631076472457.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <10725c54-9831-1f44-e5fb-9971374c264e@gmail.com>
Date:   Wed, 8 Sep 2021 09:11:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1088.git.git.1631076472457.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2021 12:47 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Remove untracked files that are unwanted after they are done being used.
> 
> While the set of cases in this patch is certainly far from
> comprehensive, it was motivated by some work to see what the fallout
> would be if we were to make the removal of untracked files as a side
> effect of other commands into an error.  Some cases were a bit more
> involved than the testcase changes included in this patch, but the ones
> included here represent the simple cases.  While this patch is not that
> important since we are not changing the behavior of those other commands
> into an error in the near term, I thought these changes were useful
> anyway as an explicit documentation of the intent that these untracked
> files are no longer useful.

I think your stated goal is a good one. These minor test edits are
good to fit in while they are not conflicting with any other work
in flight. As long as it is easy to fit in with other ongoing topics,
then this should be taken and merged quickly.

Thanks,
-Stolee
