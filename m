Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE3C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435AE23A9C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nacb3y9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIXWBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIXWBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 18:01:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECEC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 15:01:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s204so283936pfs.18
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kAGpEYMs+FjVJqrUdAOZzizhWqfjDYXs4ic3iSGUoYA=;
        b=nacb3y9eM8SMOquVW0PnFu6OyYUCXlYRQTwDGnpyIAA7Kn7TTMiijSnAjuVSl5l3n7
         1y+kIQSZLCXDIcJLO0zZNbgYjdvnp99U6AktXX7OwfLrlOO+m69iADUvuZWNRIScF1TS
         tt6M/5EVhhH4lbBgOt4MOSS7hTGOObOySrU/sKb7uqahk1QrpE1h3/Es1sFfU/P1s+p0
         s2e7C3lz0EYsEeF9kJhAfYM62WwBgl3CVavwcWDYISeP2aeoa4LYLilxCf3Nzd3JstFs
         Vw/Xr7jXSt3rpB93waZwNNrAMeIaFy6yWK0AwgySoFPfbwDJqHEgup/wwaYiDxxqqA5c
         TGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAGpEYMs+FjVJqrUdAOZzizhWqfjDYXs4ic3iSGUoYA=;
        b=ZNi8pc4ZsD8kfIq1TXRPCP9fpvhHsL0rQ3z/KqODUtGEaZFuOd8E1EJLWasnSNiob4
         87CKYZquVzMbRjyGtsjpUx3DIE3jWxBgNKHyW3hg/HXUMT4Kxk86iZHpZ0mPg3tLZPzG
         mjvR7UCYojXoUmndYqJv7MbklQnF4IRYzX/CbOaNjvGI44166rmdyP8ru3CkavWqsXHV
         sxHqKQ0OZlEUX//MadID111yR8jvQoE457fKMkcmnfLkuHDsWSKAdVjjf4pwqEIfFtD8
         J/dFmRi1Dhva6wvD63YACZPwHX4ax+Lt5VRLKNbju/2H0nW6DiAclrF4l1BtQY93lh0W
         kvDw==
X-Gm-Message-State: AOAM532pfoTEQYks6Vpv6HJV6Z37/le9Aqw3KMLYbXjrc7yK+4eTIEhn
        mS9jz1FTNi5rJzUqGR28HhXFkN3pyXPEPW0nWlsP
X-Google-Smtp-Source: ABdhPJzjV+MUUyIX6mGgUfgR2eFqmXYtdqSGf7fgCepJ/MlftENMoSG+QeK7M1ZfyJ8Fkqq3o3zQjz7VVdaInh5W6ObA
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a62:6287:0:b029:142:2501:3982 with
 SMTP id w129-20020a6262870000b029014225013982mr1088274pfb.71.1600984895194;
 Thu, 24 Sep 2020 15:01:35 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:01:24 -0700
In-Reply-To: <691ac9f0-0678-8c95-18ad-7b54f92ae531@gmail.com>
Message-Id: <20200924220124.1525034-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <691ac9f0-0678-8c95-18ad-7b54f92ae531@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 6/8] maintenance: add incremental-repack task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here is my attempt to incorporate your recommendations into this doc:
> 
> incremental-repack::
> 	The `incremental-repack` job repacks the object directory
> 	using the `multi-pack-index` feature. In order to prevent race
> 	conditions with concurrent Git commands, it follows a two-step
> 	process. First, it calls `git multi-pack-index expire` to delete
> 	pack-files unreferenced by the `multi-pack-index` file. Second, it
> 	calls `git multi-pack-index repack` to select several small
> 	pack-files and repack them into a bigger one, and then update the
> 	`multi-pack-index` entries that refer to the small pack-files to
> 	refer to the new pack-file. This prepares those small pack-files
> 	for deletion upon the next run of `git multi-pack-index expire`.
> 	The selection of the small pack-files is such that the expected
> 	size of the big pack-file is at least the batch size; see the
> 	`--batch-size` option for the `repack` subcommand in
> 	linkgit:git-multi-pack-index[1]. The default batch-size is zero,
> 	which is a special case that attempts to repack all pack-files
> 	into a single pack-file.

Thanks, this looks good.
