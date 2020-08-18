Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F5C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9363820772
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vw6g8Jjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHRXvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgHRXv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 19:51:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A47C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:51:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y12so6855111qva.8
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8S3siyD2afWxoE/K8OIIWRaI2DTHaWgKc+hOv09XXVE=;
        b=vw6g8Jjk2uA0/HfowzuSfGN+2l6W70FkGs/MzaT5VjMzbncrS3jMFhnrPT1C3Zgd2t
         NTAe2tagII4AK/AcQR6colojpBWgeUIDmPtAfFgefeg+N6ahiKxUAQv0gt27FWPWKGth
         yQ32/rLzTYwqAlHIka+XZWU92knFL+YHsocCNod2x9p5P8RS4Yg6DYcccq/ueRrfmURA
         bMDIgLQjV8bO0xZfybvIOEih9F4tfdapuwkfUGvKd+b1jR699CCxVXT5fXgVrkRp4KrT
         tmRfh2T4HfEDTBcj6KE4RnJmH9+jLNHol7d2tMICeiKKhdj2y7/1r7exklKmyjtT6xEk
         s95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8S3siyD2afWxoE/K8OIIWRaI2DTHaWgKc+hOv09XXVE=;
        b=OX6w+6xbJzrbd17ZpyTedXz4soMiYvub2U/EprJoWUU1vUMaKF3UETDk7/Bo3OF6L6
         IdDKaL0T/CW5LuPlvWaQHRG3LcwIXcoMueCkcbzNPHpua7D1gIG3n1vfEP0rtvfg8gW5
         4J4A4+FqWb8047KiL/MhcEGZBgeit/6F0geu/Mrdm/R4W821jyZAMVpSoYSE+NW3NQAP
         N1EggVVEUA8DVqBQy385AkO6+LSCi+DsmjZkaCy/T96tamyyZNBUGRECpWl8VfqO/Nqp
         u59/s1Wd6MEKhPZPIlRRXoMWuLmD07OD02WpHMcR8HPaac8d4lLGxlC8ODBDTuVf6KIK
         Gd7w==
X-Gm-Message-State: AOAM530A41YnF8iy4332Ch7U3j4wTA7R5eNpU0Sl7FQpX0jukVmdjSnp
        PUxUVtjEodRzWlMixfc/mgjPAXnlFuqUCyR3y6/u
X-Google-Smtp-Source: ABdhPJxSZji0SEvhm/cqker52fzDGty2+qWv9GTmaoy9MN1Q2diG3hxXz2GmKGd1bLIOz/vO+ImjTg81Mc2wO7zh+SAz
X-Received: by 2002:a0c:d98d:: with SMTP id y13mr21799753qvj.203.1597794688375;
 Tue, 18 Aug 2020 16:51:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:51:26 -0700
In-Reply-To: <50b457fd57aef4e9ac6a15549561936dc962ef36.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200818235126.2836309-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <50b457fd57aef4e9ac6a15549561936dc962ef36.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 05/11] maintenance: add commit-graph task
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

> By using 'git commit-graph verify --shallow' we can ensure that
> the file we just wrote is valid. This is an extra safety precaution
> that is faster than our 'write' subcommand. In the rare situation
> that the newest layer of the commit-graph is corrupt, we can "fix"
> the corruption by deleting the commit-graph-chain file and rewrite
> the full commit-graph as a new one-layer commit graph. This does
> not completely prevent _that_ file from being corrupt, but it does
> recompute the commit-graph by parsing commits from the object
> database. In our use of this step in Scalar and VFS for Git, we
> have only seen this issue arise because our microsoft/git fork
> reverted 43d3561 ("commit-graph write: don't die if the existing
> graph is corrupt" 2019-03-25) for a while to keep commit-graph
> writes very fast. We dropped the revert when updating to v2.23.0.
> The verify still has potential for catching corrupt data across
> the layer boundary: if the new file has commit X with parent Y
> in an old file but the commit ID for Y in the old file had a
> bitswap, then we will notice that in the 'verify' command.

I'm concerned about having this extra precaution, because it is never
tested (neither here or in a future patch). When you saw this issue
arise, was there ever an instance in which a valid set of commit graph
files turned invalid after this maintenance step? (It seems from your
description that the set was invalid to begin with, so the maintenance
step did not fix it but also did not make it worse. And it does not make
it worse, that seems not too bad to me.)

Other than that, this patch looks good to me.
