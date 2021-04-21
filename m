Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53538C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109316144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhDUNZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbhDUNXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 09:23:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2AC061349
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:21:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v6so14555898oiv.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8dA0F3A5uJgC20WZRPuDFpIiFnhEarhmhvPY0p7kMII=;
        b=WTGrTDP5l4gNJvthQ0Eyqt2JWnAolBac93jaBAeHLxqunuhx68PLUXoIvsXBlrIy2q
         /OWabUjxTyvuW60NqhSFb35UjvtuMJbZTK5+YcvwTp5BPuow/h5qc9uoPALnxnjpSaRN
         opRUX4qiyItJA2abVnARpm1NiZ3DZZ8/9tfwDsMeq9PZ+I2gmRYlAVm3T4zMaLHYS/4e
         joG1awyq6shVx/aElaJV4Z8r40jgSShIqZFmNRsUBqfJ1uNn1nemk6RLq4MW3MCM9NQ6
         mik6RprUGlu9vUfkuxmIC+Tm+PtzoPDDFajKzPc8SwMGiO8bbRFi8Jy0qxFBV1NJJh9w
         MTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dA0F3A5uJgC20WZRPuDFpIiFnhEarhmhvPY0p7kMII=;
        b=aFhYeeyduGUTLrh5ZlAxyG7ImHta46/ch6awtzojoACrmF5aMOWoOWAQTL7wEvcf87
         AuV933Fb2JFIFXserpxgeM7bLz01O1Y0JCiWVnVvFfSBt6RKMWPAm7+ix1Q8d6brEUl2
         8mk9gL6stL/Pk52M3qX9ZxPmsU9XUyQj+gd2WRk6AW3AhpvDF3u1Tkp9QsJz8AVu0xuS
         TWi0spwIBUaWWlFR/YVAxdwJK86NjIEfGxE195FYnfqxAW98gC3Glv7MXCTfGtEKYbL9
         SrWzy9aW1RmsRj1HmCMvUfvendQdi0abiNQwPZaJkZQ+KuMjiV3MfD0S43y77a3dKAAy
         vWMQ==
X-Gm-Message-State: AOAM5314yyI48dmN3kENV3/BfPSqMsEEHqUL5N9hj63daYd/VeTU0c2Z
        +zPduKyVKWkSmVzk9DJB+Ds=
X-Google-Smtp-Source: ABdhPJwXSUF8IhZjyUGSvCYf/T6ZQEbwU1T/aJKXVRvsL7wPk24x7SgAsT4bqAsnoJZiB1FIOtm6OA==
X-Received: by 2002:aca:d787:: with SMTP id o129mr6942883oig.40.1619011275693;
        Wed, 21 Apr 2021 06:21:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id q189sm454480oih.25.2021.04.21.06.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 06:21:15 -0700 (PDT)
Subject: Re: [PATCH 01/10] t1092: add tests for status/add and sparse files
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <184087ce-b560-11e5-1c5d-e25b6bd58127@gmail.com>
Date:   Wed, 21 Apr 2021 09:21:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 5:52 PM, Elijah Newren wrote:
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> I'll note in particular that it's easy for users after running "git
> add" to run other things such as "git sparse-checkout reapply" or "git
> switch $otherbranch" and suddenly the file disappears from the working
> tree.  From the sparse-checkout machinery that makes sense; this path
> doesn't match the .git/info/sparse-checkout list of paths, so it
> should be removed from the working tree.  But it's very disorienting
> to users.  Especially if some of those commands are side-effects of
> other commands (e.g. our build system invokes "git sparse-checkout
> reapply" in various cases, most common of which is that even a simple
> "git pull" can bring down code with dependency changes and thus a need
> for new sparsity rules and whatnot), but it definitely can just happen
> in ways users don't expect with their own commands (e.g. the git
> switch/checkout example).
> 
> The patch looks good, but it'd be nice if while documenting it we also
> add a comment that we believe we want to change the behavior (for
> sparse-checkout both with and without sparse-index).  It's one of
> those many paper-cuts we still have.

I can try to comment on these corner case tests that the behavior is
not intended to be permanent, especially when already needing to comment
how strange it is acting.

Thanks,
-Stolee
