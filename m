Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FAC433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22FB64E99
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBHWrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBHWro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:47:44 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755CC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 14:46:58 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l11so7807038qvt.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h/usFsM1qziErNOXAEs1C7QB6HMi76XvP4pvxWx0gas=;
        b=nbPCbkHotqgvY/5SqN86Z9Ii93kqmlO6dtYt2kICcFnwOKE8ft383IrBrBSRZw+CQd
         s8XGgSSAEWkMlcUM887Zg1F6nStCblyn+NhjGXj7v4R77jaP+L0COBS2v1QIoodGAx02
         qMMIsQmO2T+YvhwFsKHlEIreiN/pTTweWHeWaHRAb2E24m3nUPLwT7fzMiYxdP1HKZzS
         wxYW1dvBrQr69Wk4vDYaV/JFTmIlYmo+gAT/kypt1+jrOIuF6JszKWBCxVOnBzFy8cxa
         U2f6OLQwqu4nB39u5GSKJcqA/KrvVplEvIiBUz7Pj06JsQsUpIgP++SS8UWPz57uiRwG
         lkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/usFsM1qziErNOXAEs1C7QB6HMi76XvP4pvxWx0gas=;
        b=ewYpPafvbsfD84mMw2w/kkgCZseY1cZ8gjgPsDSr9LaNA95O0G/DcAKkuYvqlCb+g2
         ZJ1IPam1VJ2HpbksZEYii7eO/cLwyLCxiErMsG5wiOy1zMR03mYJ3FaebhY++vYwgkGN
         UBFLIJ1MuT1zoBTyAfdGcy+rNkeKjDKzutdLo+DrMGYPNmAioegn0bV5Qf0K4d2MKvvT
         miGnga7Z8ULV2UfEph/TamQIAM8kqGecZf7Cb9twvU3E8ZzQW+Nv4RMnb89II/MYwitA
         mj3g0n5sxqS3P777gHEjEqEX5R0DZGJlSzpgOcThamKr5KIS44z+/LQ1ievMofTqKrse
         zCWQ==
X-Gm-Message-State: AOAM532r7AKLq5guybf5mnFyfxrNCIL1B1I+tY5pPRFZGc2hDTJI6tK+
        XlVYeZ/dUYQXCugHoS8e0ioCUw==
X-Google-Smtp-Source: ABdhPJyqFDNX63qGHAjJJ3xIvkifm8ohw+EKsNDqWHmBrItOEzLtPKakqGOrPFDPTGtwWgY5DzqnDw==
X-Received: by 2002:ad4:4047:: with SMTP id r7mr18407363qvp.0.1612824417734;
        Mon, 08 Feb 2021 14:46:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:65b:f1e7:ac0e:a3a2])
        by smtp.gmail.com with ESMTPSA id c14sm3303641qkm.115.2021.02.08.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:46:56 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:46:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sluongng@gmail.com,
        martin.agren@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Maintenance: add pack-refs task
Message-ID: <YCG/X12qKVKu3/pv@nand.local>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.871.git.1612795943.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 08, 2021 at 02:52:21PM +0000, Derrick Stolee via GitGitGadget wrote:
> I chose to add it to the incremental maintenance strategy at a weekly
> cadence. I'm not sure there is significant value to the difference between
> weekly and daily. It just seems to me that weekly is often enough. Feel free
> to correct me if you have a different opinion.

I don't have any strong opinion about this. At GitHub we run pack-refs
as part of a maintenance-like job, which varies in frequency between
different repositories based on a number of factors. In our busiest
repository networks, this is almost certainly at least a few times a
day, if not "as often as possible."

I'd suspect that for any laptop-sized repository, anywhere between daily
and weekly is just fine.

I suppose weekly is a good starting point, since we can always change
the default to run more often if enough users complain.

> My hope is that this patch series could be used as an example for further
> extracting tasks out of the gc task and making them be full maintenance
> tasks. Doing more of these extractions could be a good project for a new
> contributor.

That's great :-).

Thanks,
Taylor
