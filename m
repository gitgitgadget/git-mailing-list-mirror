Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470AEC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0572065D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0p5Q5NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHRXq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRXqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 19:46:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFBC061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:46:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t19so7399941plr.19
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JqVrmpObfVz6AWmR3FVqtqvUkeYUGc8i3iXKPKqtfrU=;
        b=t0p5Q5NPVDRpcZrZpNe8+qo25i45nN8B3vicheGcAQEFNYn6mHtXy2S94O0f67VVEm
         DA2XiBA2bQnX2YBPINvvdpJfM6pV4IWIgZerSfzAa7XE9tFcUR8C40zE2CXNn1BtD2mm
         c/y3Cq700v/mNSg8S2Uz9KhQN+uZoWfkG+l1suEZuyIA3Ka6hol7RqShwm+C7KFC8xDF
         A2avVC03iewm9qoUYLmerBnjXbWfbWU59oDhY+fq+wdWrLHw8BGHRv2TlM/QwjxvyMRQ
         JfejUIijiVJjXVuIS3PfsJxoJi3ie0QA5gdWgLwODasnz+Rb6EUVCbf6Hlne6vexz6Y5
         j3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JqVrmpObfVz6AWmR3FVqtqvUkeYUGc8i3iXKPKqtfrU=;
        b=HOXpgCialdiggfur8pstp4WO9qT1iM+5WTzoSYOD+Fr1/yQShwYNeUougs1S+4QTlL
         0eKCXfZpJKXQSZhFU10KqlMkWRSDd5FaazUy6HLPc90heaVaONB+j02mB3Qbnq16WE5Q
         Eqgxn9gjuUWXg6n5S1vV3M0Af7jd/5iwNUr3bDUGODHaqn3EXeYM+KKKUTDDT6FH9i+d
         Xi4pRb5gFLeEQ0+ZlD3+F3z7mIQq1L6uRVTOBkHPuJxydOpwla67uWXyAxgJsU6zZtwr
         0hdAFV950WY0k/4nV7vczQaDP53KS5ucdkVk4KtuxJBKvJWzTYKzwTS2eHziuH0eVSvz
         s8CA==
X-Gm-Message-State: AOAM5325HE1tSzPIbS3iOuPbKBdlktBBc18rbMQvT5bGHrtOwnpUFBPZ
        6ysc24iuxr8upgmuVBqeVYYWgt2TrtlbZSipDnXU
X-Google-Smtp-Source: ABdhPJzR4ZXkGYu6+5Prc9X/FWU3u6oYXcfRmNvGpKezFlyNfo24OXgs4FaNjLSbjIyrCgem+dftRoB+OIv7HEV5zamr
X-Received: by 2002:a17:902:7616:: with SMTP id k22mr17530148pll.25.1597794384868;
 Tue, 18 Aug 2020 16:46:24 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:46:22 -0700
In-Reply-To: <1db3b96280d9bf7908b7dc9fa13b80c445164a99.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200818234622.2833790-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <1db3b96280d9bf7908b7dc9fa13b80c445164a99.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 04/11] maintenance: initialize task array
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In anticipation of implementing multiple maintenance tasks inside the
> 'maintenance' builtin, use a list of structs to describe the work to be
> done.
> 
> The struct maintenance_task stores the name of the task (as given by a
> future command-line argument) along with a function pointer to its
> implementation and a boolean for whether the step is enabled.
> 
> A list these structs are initialized with the full list of implemented
> tasks along with a default order. For now, this list only contains the
> "gc" task. This task is also the only task enabled by default.
> 
> The run subcommand will return a nonzero exit code if any task fails.
> However, it will attempt all tasks in its loop before returning with the
> failure. Also each failed task will send an error message.

Better to say "will print an error message", I think.

Other than that, patches 1-4 look good to me.
