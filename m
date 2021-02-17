Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B0EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378AF64DF3
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhBQUKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhBQUKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:10:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3982C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:10:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x4so19328627ybj.22
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X3jn/HklYLjtVIeIGJPrl4Ywua7tPA+Jkv77ha5uCpY=;
        b=BsXoE+NFROzPaHpnD7wyMdax7RdtFhXrB89hsBO63Cx+9Bz3EMYXJSvA+PAKc6hVy6
         h73Wd2gfQmZNkw/1eCpGbfj3P29ykpY3kVp7hvE60CCuxHCIzSMCP9V7qCrQOz4iiqaf
         WFJGxsTwTy5WfxfEU+Z8iXhqalOvqXjldLzgeAuMuXxUS7sqTu2neqgg91Ixku9BSq5o
         5+pV+az0BPnDMAPlUjLShZAwS7/Zru2dZZFmH+BUqU1q9RBE/QOgJitP0A3AOI+IAuVR
         /WwITVxCNDBcuE4Zg2VCEOLbrYaNqEt+XzFDtbJxqonvv1r+fc0dyUfpE7MiWX8n/Ara
         q4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X3jn/HklYLjtVIeIGJPrl4Ywua7tPA+Jkv77ha5uCpY=;
        b=XXFcw0i0MEGvIMscDXv1Miycs3xRWQfWt2ajA6DQaR9U3VLDgRREKhwmBgC8iiDLk5
         5HWTGUYFdx4AnFEjUOKtc5ZFsQndL/GAIcvQoghlk9SklO5LYfIN0Vg2vOfq11PU98pI
         krZQF9sIdlvczzX3iUWyPS3a/xxmw3W5sKB2a2d3ToE1qzbv6sif6+zb8IykIHdaE7hf
         1tWahJChjxu9S9ATaf5d3uHrZdZ52zoEwQA7DwROByaazmXByUQjU3zBfz9T5DoRH3Uc
         57i+jOKqOa5zKDtcbUAkcgDmBjgKUCktAFvC+yHrqz10/i3oYOTzBouByxtc6/veU1FO
         8Tmw==
X-Gm-Message-State: AOAM530Ls3S+DwScCBHNQekT+mWFLHRwQ9H+Nnhn/ECkxqjbNuPslKDy
        AwOotDl7ux+bm1updFWQpQLLfhIYofKFW5K1bLKs
X-Google-Smtp-Source: ABdhPJx7oN1idyj/eu1ODrwMqzlPKx1dzelTo6QmuUlwgnfECkFgJwnPS/qFlwX/Bxubuuqcy2p0bRZ1xQiRr6JedJQW
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:424f:: with SMTP id
 p76mr1684014yba.109.1613592608125; Wed, 17 Feb 2021 12:10:08 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:10:06 -0800
In-Reply-To: <878s7na1h6.fsf@evledraar.gmail.com>
Message-Id: <20210217201006.877438-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <878s7na1h6.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sorry for being unclear here. I don't think (honestly I don't remember,
> it's been almost a month) that I meant to you should use the skipList.
> 
> Looking at that code again we use object_on_skiplist() to do an early
> punt in report(), but also fsck_blob(), presumably you never want the
> latter, and that early punting wouldn't be needed if your report()
> function intercepted the modules blob id for stashing it away / later
> reporting / whatever.
> 
> So yeah, I'm 99% sure now that's not what I meant :)
> 
> What I meant with:
> 
>     Or if we want to keep the "print <list> | process"[...]
> 
> Is that we have an existing ad-hoc IPC model for these commands in
> passing along the skipList, which is made more complex because sometimes
> the initial process reads the file, sometimes it passes it along as-is
> to the child.
> 
> And then there's this patch that passes OIDs too, but through a
> different mechanism.
> 
> I was suggesting that perhaps it made more sense to refactor both so
> they could use the same mechanism, because we're potentially passing two
> lists of OIDs between the two. Just one goes via line-at-a-time in the
> output, the other via a config option on the command-line.

Thanks for your explanation. I still think that they are quite different
- skiplist is a user-written file containing a list of OIDs that will
likely never change, whereas my list of dangling .gitmodules is a list
of OIDs dynamically generated (and thus, always different) whenever a
fetch is done. So I think it's quite reasonable to pass skiplist as a
file name, and my list should be passed line-by-line.
