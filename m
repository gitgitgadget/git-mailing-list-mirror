Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B37C4332F
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 07:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhLFH60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLFH60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 02:58:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C8C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 23:54:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7644016pjb.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/DxcDkrVfm3vVrq6Zh47mW/5nisHUgsAtbSRLzk5+I=;
        b=OWSc7XBuBQsAwsmfLXW1HDft7yPQbuAzWdEMNHPubrL7qOnu5ln3PKTrtP6RoJHU2i
         J1QP15UDKpRUgvbi9hRALAhp0SNmXPD+6J4ARjUg2H/2Yt1W5Ll9jyvGKzLI1uq3LHps
         TxMgjfSl5DycBShFpdhR2Gm2fLl5ATUZObSCPYKLQ8gMVNCRbexDgxp4CnlRCmFJcFJd
         8noW3LaDJ2dCxs5mbBIx/N8H0rGZIlBfgwzai/aYgRYrHlvEucpx1gAWtzx8lugxL2UK
         k+nZRWR+hA81mPVczCUSsYO3jrUqrECvpJ47hUStZhsmqVNkHejn464YvTMnmFDjZAnQ
         eHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/DxcDkrVfm3vVrq6Zh47mW/5nisHUgsAtbSRLzk5+I=;
        b=gzlPVppGzDDo4a45JvLV8kSc+HVExGnVA+cV2nGVEiVFwXjxPxn+88qK223PlkjwJp
         2fZ36IimNa988Zzdum6nMPUuHXvmibjXfq64B59K7aS3L5gC4W+1Ec1K2w2Wdry+a2sW
         6+ATAhFT06G9wJd8UVxQM4I5FwIcKY5jkQVMqDRpUX1Tz58S1upkyL8hu+Iz7qNXaJZ/
         Fct+6Tc4WmMGzPfUdUgRSxoE7qkpiKynOQKdRMQNiZLiV+duGyEwjBBUBpcjoVuI39Y6
         ENxLhuugjQKbvKMWBiGBZEj32b7Pzaa+bcRU4ciHAQ6ULe6056yTQ98x1LevJJrFSeut
         GitQ==
X-Gm-Message-State: AOAM531pbQx2Zre5/njv2upXfdaTO8A2e0goKIUIrZaAP5nn4ZZdDWj3
        V2cytIUpofSWPwXhHxBXfaQ=
X-Google-Smtp-Source: ABdhPJxm8vvE94Ou9rF4Ynxt+q2eqYG8DAdomK/aBKYUMdnRdOKxBq7ZU2E0SLK+eeFtrTTl76bHcA==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr34966174pjb.49.1638777297260;
        Sun, 05 Dec 2021 23:54:57 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id o15sm8967562pgk.7.2021.12.05.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:54:56 -0800 (PST)
Date:   Sun, 5 Dec 2021 23:54:53 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 1/2] fsync: add writeout-only mode for fsyncing repo data
Message-ID: <20211206075453.GA26639@neerajsi-x1.localdomain>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <527380ddc3fe8b2fac8c8512de8fcdee6c96e65a.1638588503.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527380ddc3fe8b2fac8c8512de8fcdee6c96e65a.1638588503.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Context for reviewers: The mechanism part of this patch is equivalent to [1]
and [2]. With the following changes:

* The configuration code is a bit different and we now expose a
  `writeout-only` mode to the user. This mode is the default on macOS
  to prevent a change in end-user behavior.

* git_fsync now contains the EINTR retry loop internally.

[1] https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f3.1637020263.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/546ad9c82e8e0c2eb4683f9f360d8f30e2136020.1630108177.git.gitgitgadget@gmail.com/

