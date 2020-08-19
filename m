Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B362C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44601206DA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFa2Hj/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHSRn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSRnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:43:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBFC061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:43:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so26935658ybg.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JFlDw80AZncbSwH6cBZyOPT9aVddyBvbUlsgpXot/I8=;
        b=ZFa2Hj/ud1kC3js8Ya+wgjphtFUOxz85qcOEnkII4O9p2pJmt69ztC/7Ij9B7t4f4C
         Flet6s8n/bBWozE1VaWt5UpMpgJn4l1RHh6HgyHh6Mxxidji0Xx46G+MfTEVX/srLO7x
         OjwzvMyWEqEFP5FMvHnSonJPvw4u/Qm7Q/8jy5G64CfbpgrrZ9ma44TVT2CrazqYn7lH
         MalhmulFML5tSm/9eiqBn9yAVPrNtBpNkw9w5xupu1wNL+0HmDo8aETT60o+e3z5ISE/
         4yzpITBh9Rl390SKRST7+zt9yaYgu0ena02DIubS9u7z3RM0Ddr2gwVXB2TYZD8mVRW2
         1COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JFlDw80AZncbSwH6cBZyOPT9aVddyBvbUlsgpXot/I8=;
        b=cjkzCmRrk2TbAkYkrjtE24neGGpZhHMW/Mk6gsMbcLoseVGqeu/GBGJor7fwLWwOVV
         XvXl8OsPbEXBwWpGkxAYECHs9Pn9qrTg5kCW/oXvwXmrttqDk3SWT/m3lL3XQMXRfNUl
         CM8lOQS4WfB6KpeQVT2efSx86AernFtdCtyJbRWmH1zQ5QQojpBhXm9rzsLOc7KUNWd6
         awUdUbvcIrfmpNRf10WZoQCyrAAKryNdXl/zVfQBeGtfv+zo/sSL5y2fWI71wR5SaB/y
         k08Z3tlcV49DRaiKW2LwXn1CADoanoI39LR5nx0zC/NOlGxloAh/9Yj+ELlqwjr4kyZd
         HtJg==
X-Gm-Message-State: AOAM530YNDZIIyjcH1ETFIggv0auv/XXFp6NuNPJExo50/8YpCL7H9+y
        Vif9bC8wztITPiYJLYDV5lrguip9+OmvmaCe+L/3
X-Google-Smtp-Source: ABdhPJzmWk1g7EUWO8wKJ38HC4zv2Fopht1O8IfIDUpM6+Y2tbMnTA1r/jubYXf+F1k0kMFvbES3kAC6MsNdNAH/9I+P
X-Received: by 2002:a25:c68b:: with SMTP id k133mr37803680ybf.491.1597859004748;
 Wed, 19 Aug 2020 10:43:24 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:43:22 -0700
In-Reply-To: <66ae9121-80c9-4030-1119-a11eab8d392b@gmail.com>
Message-Id: <20200819174322.3087791-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <66ae9121-80c9-4030-1119-a11eab8d392b@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH v2 05/11] maintenance: add commit-graph task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The cases we've seen this happen were root-caused to hardware
> problems (disk or RAM), and the invalid data was present immediately
> after the "git commit-graph write" command. Since implementing the
> "verify" step after each write, we have not had any user reports of
> problems with these files.
> 
> Are you suggesting one of these options?
> 
>  1. Remove this validation and rewrite entirely.
> 
>  2. Remove the rewrite and only delete the known-bad data.
> 
>  3. Insert a way to cause the verify to return failure mid-process,
>     so that this function can be covered by tests.

I was suggesting 1, although 2 and 3 would assuage my concerns also (2
less so, but just deleting the file is relatively simple and easier to
reason about). I don't think Git in general defends much against
hardware problems, but if an issue is noticeable in some hardware (as is
in this case, at least in the past) I can see why we would want to
defend against it. My concern is that if we do defend against it, but
leave it untested, several versions of Git later we might find that we
need this defense but it does not work.
