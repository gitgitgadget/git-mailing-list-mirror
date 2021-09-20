Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B7C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A8A61211
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhITVgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhITVei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 17:34:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3AEC065F3A
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:27:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q205so435594iod.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8T21q2XqSjswxvD2xIpgepm+Ut8kdyghNDjQU5mRFiY=;
        b=HzPmWTWnkvBJs2eSiwDidiSGqzv1MwyPiet/QMs4v50nf4Cg9TFMhgiejVyFAmrSgO
         UWLAeYVGXAXvLpovRCnCkrKVf2IsuLN/8jXyDQL3KKVDmNwVZyScIoJ1JRyrz8qgdUoP
         z9XaTLeK6bp8vo5kv/fuTvudoiQWVjUPZTG/+cEu+tkUm1mz7nn3gwg63HTSaj/RQ/rk
         AsjhahXBRXppij6vOlVKmnu8VUSzF30SYsBIeDaxm9366clQv8NqklBWeM+vd+kIZzok
         Dybx3hZgp8YZAudrUNG39QHjjfJ9GGJlP/QoFOD+QWSU1pdnbE5XykmESeBv+m6UuBgA
         4Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8T21q2XqSjswxvD2xIpgepm+Ut8kdyghNDjQU5mRFiY=;
        b=JNlCDkdF+OyseA1LINxV4ioZ+IPLjvwDywD/0sGsMajcZ6VtNvq2FM4N14bLiXCovf
         9GvLexpbuVLQfn/dg7W/hPuPfqwWt1W6deTmklHvxi7URqrPWSl3RcGJPsGi+lvIu35E
         R5NemqK9XBPBkqb4B/VJLY6zveb+p9tYCwZPPUUS+W4z7ydVy8cr7x3CEa71w6nxDj2o
         FCQ3vRbsiqT0IMs702DY4Kg8pXTmM6+lmRoDcHL9jQj6hEL89BJCSTLAOD6Y4vhKQu7P
         kDUkYs+beZBVLDqHUjbS4h1ePsE3smlP0UyKOe894JkFx6Ree8b6khaJADKA3sM/sK/9
         K/pw==
X-Gm-Message-State: AOAM533wSIXyBTfXesqiRYwaWbIbpEjDJGHy+tHOsGSaoY15ysLOM06V
        CzJZ/Nr1dRDqVnapRvoWdm38oKMyhriscg==
X-Google-Smtp-Source: ABdhPJxdbJB3XW3Kqzy05zkqx5vg6DYbZo4YT/ok90dlCuV+3QNo+nELAOI2fvmgcIYLk+wrJtcyrQ==
X-Received: by 2002:a05:6638:2722:: with SMTP id m34mr6359103jav.49.1632158846700;
        Mon, 20 Sep 2021 10:27:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id c11sm8839974ile.22.2021.09.20.10.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:27:26 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
From:   Derrick Stolee <stolee@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
Message-ID: <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
Date:   Mon, 20 Sep 2021 13:27:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 1:25 PM, Derrick Stolee wrote:
> On 9/20/2021 12:42 PM, Taylor Blau wrote:
>> We would probably want to perform this check both during initialization,
>> and when adding patterns in cone mode. It may also be worthwhile to
>> check the validity of the cone before running 'list' or 'reapply', too.
> 
> 'list' definitely seems like a good idea, since it is expecting different
> output than the literal patterns when cone mode is enabled.

I double-checked this to see how to fix this, and the 'list' subcommand
already notices that the patterns are not in cone mode and reverts its
behavior to writing all of the sparse-checkout file to stdout. It also
writes warnings over stderr before that.

There might not be anything pressing to do here.

Thanks,
-Stolee
