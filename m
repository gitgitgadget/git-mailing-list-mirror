Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F1C433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 12:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D21A207F9
	for <git@archiver.kernel.org>; Sat, 23 May 2020 12:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKACP1v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbgEWMaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgEWMa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 08:30:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386DC061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 05:30:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so6220814pjb.5
        for <git@vger.kernel.org>; Sat, 23 May 2020 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXRWi1d2gaNqqDm48szBGelCR8GSzi7DkI/c/uUn1V0=;
        b=KKACP1v6a+bGRTjQi7+NnDkgz2U32JkIf+cH6Vx5TAoTG8Fi3aqw4LGDrQGw6LEx4W
         UzGebvzbwuAbSuzadm+AiABVset1X5CSJ5Gc+Gra9stUCqjLZkLprvx4vhyeEPGmnEEC
         DQHkHx4xMQnbLZbofmiilCawI/ehfmu46ekF0FKlAFBFNl+70rGSev/4YvcSZsZ+zkyg
         xoPkqpP53fBpwOr90nhkZRPdIT/wrEi56OhIjwajXiUORkt1ZCEEjeJVsBxwctgJHwTN
         w2XDmA14M5C5/VX8kg/JVfu7318K1HHVICUNo23XtQRi935XbEl0DTPr1NWkQvunHyaG
         7UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXRWi1d2gaNqqDm48szBGelCR8GSzi7DkI/c/uUn1V0=;
        b=JCGdIz1HQVfqOHg0zYnuOw84e2KjnSRpMsgny8pG3UagaqBHA6STkm8hNyAQP8BAhk
         uWH9iutCpwxlVVCYpWP+FA/DNUxUzOsqhYsSb9FeS4+FVdhjMAfd5+uNvxevNLrGPP/D
         niTgevgbswjr/GQjaOoi/ClxXTWZh6CWLNCJ8pOc0T9RrLuyeko5VsYSdrVX8+cw/vL2
         xjQjnM//d2gKl7BCd5iZLjGDgxKcC39fWyDKi0qfjW4u961Ls3QUwxzgacvcTMkLqaob
         mNopmlfFl5GciZhAlAUHqo0D2Pu0mSYHWmBj2cNTc+DUc0snFtWoVMl3blHXmo+ZmpDc
         r87Q==
X-Gm-Message-State: AOAM531VX/Z2BgPwdzVrQKW+dTf1R4kh/DPoJtOe1Yhh38QnsLeu+Hf1
        3aZN8R5LlhrmXY+GtunLoD6nSv9V
X-Google-Smtp-Source: ABdhPJw338Hz5zLws2Qc/xMEd6ROsvvzTRiKFz1blrFMTxS/+5YyNxYhWUHemcsLaQmK5E1kUnToYg==
X-Received: by 2002:a17:90a:b113:: with SMTP id z19mr10358878pjq.183.1590237028201;
        Sat, 23 May 2020 05:30:28 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id q189sm9349456pfc.112.2020.05.23.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 05:30:27 -0700 (PDT)
Date:   Sat, 23 May 2020 19:30:25 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
Message-ID: <20200523123025.GA20683@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521101455.63484-5-phillip.wood123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 2020-05-21 11:14:54+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> +# Checking for +0000 in author time is enough since default
> +# timezone is UTC, but the timezone used while committing
> +# sets to +0530.
> +test_expect_success '--ignore-date works with apply backend' '
> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> +	git rebase --apply --ignore-date HEAD^ &&
> +	git log -1 --pretty="format:%ai" >authortime &&

Those --pretty="format:%ai" won't print the newline character in my
test environment.
It looks like it won't print the newline if stdout isn't a tty.

	git log -1 --pretty=%ai

doesn't have that issue.

I think there're some grep out there considers file doesn't end with
newline as non-text files.

> +	grep "+0000" authortime
> +'
> +
> +test_expect_success '--ignore-date works with merge backend' '
> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> +	git rebase --ignore-date -m HEAD^ &&
> +	git log -1 --pretty="format:%ai" >authortime &&
> +	grep "+0000" authortime
> +'
> +
> +test_expect_success '--ignore-date works after conflict resolution' '
> +	test_must_fail git rebase --ignore-date -m \
> +		--onto commit2^^ commit2^ commit2 &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	git rebase --continue &&
> +	git log --pretty=%ai >authortime &&
> +	grep +0000 authortime
> +'

From the test's name, I guess git-rebase is supposed to continue
respect --ignore-date after conflict resolution.

But the content of authortime read:

	2020-05-23 12:13:58 +0000
	1999-04-02 08:03:20 +0530
	1999-04-02 08:03:20 +0530

It's still pass "grep +0000 authortime" because of first line,
I'm not sure if I missed anything.


-- 
Danh
