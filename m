Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EDC4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D03613E6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCCxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFCCxf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:53:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A6C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 19:51:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id l145-20020a6288970000b02902e9f6a5c2c3so2691971pfd.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5k/MtIx5IgSTWnVo7DVcB1O7BtKjFTOSUYGHv8CYTF4=;
        b=Pof3+ovFLLGSrvCRIGXclLubqeqnFfw6jkT8Wcmdv9aGVGcOJDFK6xI2WLjB8+1Umg
         HIZcLQSWfM5dTkplvyQVrft8LrGiPOADztrbgSft/QMPgQVUITqpdFitUWIu55cc1edw
         uvNgpfSwbKk4vWhDqIh5EzGez9nRi3bSQTl/9cr4FxgRqoimNl46I4MXfJIzdLJxGWmS
         2vPmhGHXVuzhL0EbabcNu5qabzGNp71GibJFJBET/bRHElNgFopccXGQt5hsdGb7sIjH
         LsHUN55DboqkmXD2zeqk/A1ranB/ynEWrskAMFkoHAYaWqUS6fXCamNYNIIK6tJocJvv
         hddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5k/MtIx5IgSTWnVo7DVcB1O7BtKjFTOSUYGHv8CYTF4=;
        b=rEsUJO4dyclcFaJ+r15Xb3I8xH7Fi2EluUvYaa3bstEzm0+FyHCzz9MosWQQHPI7mf
         luvWBbckmfHq2OoGdhBmMHj95ohYDK7w7JLA1+gUP82PnMo5TpRdDRIJ34wkAFRHMKoU
         9oEBRcUFfYT8NC0NPN7mrxaHFWGlIOyhkYrYI+//sPx/29IvclgEZZ/dkmDt753szCDW
         WUMxHX+SVTv0lPOkBULoy77BzfruppVhu/Oi3GV+gCpvrZrkvLoT5j+fMgIYQP7VnCpg
         5a2NNKy/rpwJ88Owpy+q8QRxcUMWGP/4fMA8niMxyWOn3rdkFxWLCJ+lyN65Dz6EBHHO
         IA3g==
X-Gm-Message-State: AOAM530bFKfCKqOxIv6Ms5VLC6bQfD3phn4RPrBii0D1mKtSK718I7Rj
        UQV8Ekt6HG7BMghfP2t0RuecDNbLX7IfOieNp9Ha
X-Google-Smtp-Source: ABdhPJw7CiWTq1yCvpd0OWSyVY7slukMTnrhQlaOETK7Kqfp524Ph7htyYG4Ox42rl2EchTIiFJoeh8jJAq0jrevi7Qt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:6291:: with SMTP id
 f17mr17249432pgv.280.1622688682407; Wed, 02 Jun 2021 19:51:22 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:51:20 -0700
In-Reply-To: <dd3eceade4fcf09a679fdf20dddae247b4e0e879.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603025120.348393-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <dd3eceade4fcf09a679fdf20dddae247b4e0e879.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 4/8] refs: make errno output explicit for refs_resolve_ref_unsafe
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
> contract for the errno output explicit. The implementation still relies on
> the global errno variable to ensure no side effects.

Looking at the next few patches, I think the plan is:

 - Introduce a new function refs_resolve_ref_unsafe_with_errno() which
   returns the error information in an out param instead of errno. Right
   now, it wraps refs_resolve_ref_unsafe().
 - Migrate all callers that require the error information to
   refs_resolve_ref_unsafe_with_errno(), and leave all callers that do
   not require the error information alone (that is, using
   refs_resolve_ref_unsafe()).
 - To ensure that all callers using refs_resolve_ref_unsafe() really do
   not use errno, set it to 0. (This is allowed by the errno contract -
   successes can set errno to whatever they want.)

If this is the plan, it should be written in the commit message.

As it is, this patch handles the first and maybe part of the second
step, and patch 5 handles the rest of the second step? I think the
patches should be more clearly divided.
