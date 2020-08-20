Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE843C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DE72076E
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW4pJAhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHTOe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHTOev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 10:34:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4299C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 07:34:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so1059770pjb.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZSiIXCgCNNhmdEoQETT/ykid8xgEOatfEGQOSVBXU3U=;
        b=eW4pJAhheXUDGH7nMPriBfQ7prI3hj8pr5a9DopH/jU2vCq1Dxo4k5NbZN6RDwrvPh
         GwcEbTHqDhoDWfX0lrZFlKqdD6HqsLsEJySa9ox32jpzCbxcLUUgmsiBVgNa+CMtUvXg
         AZ0Kpg52R1dRDAx0l3Oo90/5qSz9lI7RY2kBIOX6SB4ANI6rCrzG8siR7HNLR+fksHKi
         zo+Dh3OWcZFVeuCvGb6llZrZeHlb0atimedb/sPHBxVA+HMB89tHDYOoo4+m0CVMf9n8
         r4+rbSjtrGT5Lpa2KS6wZR/NPw/R6vhU8taR41r898b5Ws/Pbyuzf72uhGcvYoLSMg6w
         DAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSiIXCgCNNhmdEoQETT/ykid8xgEOatfEGQOSVBXU3U=;
        b=Y1PMLzD/yRGlcVwGG/9ae4oqPF/JnOK8SpKw0igE1BSal5xbcVxoSx5F9s9zTT8/KQ
         DMBnN+TFne4hxZZFmim8TxUf0b92Qlzs555OUWHsvY07yel6QijBt5WDypxHJ5aNaNbc
         PclMxg/Fm288xIdrOYgFV39sGtkL/g+R6G0OO8YOOmubMTpy8dVQx82y6YTGJjz28aeY
         X5jQkpFREDt2dvaOv34XvF1olj0fM1cFJy7Jfmo9vP0DOqo1khuNGEJkvOLd7ULjC1OS
         EpMsDLPxFa9Fwrz1CjVXHsS42drLuPQyAxcY9W6UAW8djUzO3kyRxU4KNOUhzjVYyV5X
         VenQ==
X-Gm-Message-State: AOAM533Qr7HfqrJCizqAgU9lrEEtKkSvLGQcTueikPYALCwBMaztR/eh
        Hue8Kwt4wlugOzVJgkmGlJQ=
X-Google-Smtp-Source: ABdhPJzlUdf+Fg9glnB2ymNlEpV3fnSvZZsry00mLuYeYSBVxRW/VcMbbS6rF8+zuyOz05dQfyYuqg==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr2806529plz.76.1597934091012;
        Thu, 20 Aug 2020 07:34:51 -0700 (PDT)
Received: from localhost ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id 62sm3064690pfx.47.2020.08.20.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 07:34:50 -0700 (PDT)
Date:   Thu, 20 Aug 2020 21:34:46 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/7] maintenance: store the "last run" time in config
Message-ID: <20200820143435.GB31084@danh.dev>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <bdc27fa28ee70222ed3c7c9863746ace8ea835e4.1597857409.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc27fa28ee70222ed3c7c9863746ace8ea835e4.1597857409.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-19 17:16:43+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Users may want to run certain maintenance tasks only so often. Update
> the local config with a new 'maintenance.<task>.lastRun' config option
> that stores the timestamp just before running the maintenance task.
> 
> I selected the timestamp before the task, as opposed to after the task,
> for a couple reasons:
> 
>  1. The time the task takes to execute should not contribute to the
>     interval between running the tasks. If a daily task takes 10 minutes
>     to run, then every day the execution will drift by at least 10
>     minutes.
> 
>  2. If the task fails for some unforseen reason, it would be good to
>     indicate that we _attempted_ the task at a certain timestamp. This
>     will avoid spamming a repository that is in a bad state.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/maintenance.txt |   5 +++++
>  builtin/gc.c                         |  16 ++++++++++++++++
>  git-gvfs-helper                      | Bin 0 -> 11171736 bytes
>  t/helper/test-gvfs-protocol          | Bin 0 -> 10946928 bytes

Look like those 2 files should be added into .gitignore, no?

-- 
Danh
