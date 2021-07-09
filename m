Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA643C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EBB613C1
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhGIPJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhGIPJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:09:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18107C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 08:07:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s18so10244463pgg.8
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFIThpCtVRuHkyJUYJuVWFA+apxEGspXye+1ty0GIbc=;
        b=p0DJI9y1ygUqaPPpEO5xHs28TEzrz6p39kS7jPsxhfEA4vBpB2kyB+IqPM8LOIe717
         d7K5eW+X6bAyl5TVxIupfkMfyDQnmKKyVOLkEk/ZEoH/E4eEWxcLtl2kK4mqawroKimb
         LLhzuPi6TldrnqHVUIGGwgD6/st0OQzmhxLuxMu8O7hITXF+5JTE57Fs+9TvpOyX0R3W
         R5wyqr11/Kmhb2/GKixWpJUaxXUUwsUQIG2vEVq0KtSLndTLeSqHPd/DznpeaJXUit1F
         FH8f4s9oW4vDBoBSCPvuxqmoDRFvr+vZ8UV8WJ/nePWDm1y/lvCnA+WZbhPaG/8EuwtY
         UPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFIThpCtVRuHkyJUYJuVWFA+apxEGspXye+1ty0GIbc=;
        b=T5mjpXEDk4WQTmbBrS3NVUi0/omQmU6Dp+/LIQl0jYZVq/Qe+v5XvB4x97c3/YESkz
         DJ7TLv07hrA9a5/uuxgTou7OqW3WLNFlyj5IsB4/+Oahwit7yFbFOK3x8VTDTWwKsvem
         /GEm3tjDypSGxNIL4afv/VxpE1RcjRL0jC1TD04cD8DpEOFANJAjkD1Dhss6OK9d8L4i
         ex0qeuv200XTyMFg3Y4Aet+Ek9RfS3J8OxUpkH2AguDemijCeqq8tjnU/I55STUYpeZj
         iB39s26J3eD7BrIcJVtdYr6pRpFnsA5HT+rtDS7iUaX7ojPp7OHufhqGYmcr+2k0RAaL
         WsQA==
X-Gm-Message-State: AOAM530gJAHmqUgo2hb1vUAbE0xlWioaaPAJ4KRwpDO08Qco0f6xRSEV
        wiCaUkDaUOw5TGFRH5b0qgHhkStPmFNPmg==
X-Google-Smtp-Source: ABdhPJzT0x9XyA/ziasA7E9iaRybhhcWZICU20dI4Unhn4k3M8FkdKWyTlAjz9pEhXSXNRrWnAmerw==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id e22-20020a62ee160000b02902feffcf775amr37468737pfi.59.1625843219642;
        Fri, 09 Jul 2021 08:06:59 -0700 (PDT)
Received: from localhost ([2402:800:63b8:f6f9:3a91:18b:7264:dbcb])
        by smtp.gmail.com with ESMTPSA id a23sm6665862pfa.16.2021.07.09.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:06:59 -0700 (PDT)
Date:   Fri, 9 Jul 2021 22:06:56 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: unit tests / cirrus ci fails
Message-ID: <YOhmAGig//yfABWv@danh.dev>
References: <a7aca5f5-3a5e-b13c-ccae-3e515c774420@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7aca5f5-3a5e-b13c-ccae-3e515c774420@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-09 15:31:01+0200, Fabian Stelzer <fs@gigacodes.de> wrote:
> Hi,
> i'm having a issue with a failing test on my pull request.
> https://github.com/git/git/pull/1041/checks?check_run_id=3028222798
> 
> I have added a bunch of new tests and they fail on the freebsd12 test that's
> run via gitgitgadget.
> Is there any way to enable verbose / debug output on these or a simple way
> to run tests manually in the same environment?

I don't know about cirrus CI, but, skimming over the log, it run into
fatal error after skipping t4202.71, I think the bashism in
"test_lazy_prereq GPGSSH" is the culprit.

"|&" in "ssh_version=$(ssh-keygen -Y find-principals |& grep -q "unknown option")"

> I had no issues with the full test suite on fedora / centos linux except for
> "t0500-progress-display.sh"
> which seems to be a different issue. this test fails in master as well on my
> fedora34 but works just fine on centos8.
> 
> Kind regards,
> Fabian Stelzer
> 

-- 
Danh
