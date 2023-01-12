Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4E2C7113B
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 20:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbjALUFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjALT6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 14:58:31 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A728D
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:58:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c6so21304086pls.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yEXs8o/bz1T9kST8t2/NeNwS5FQrKbZZ7AY8VGiD3bo=;
        b=Da5MSzIIpnCbf73P674WpTarnNZgJEgkEM06sjjei84p4pfuh0txsgGnJjqA5afLGj
         F5eDR/sVihlVrIt2/Bq41vQMWlmfPTVzmFjDlAiv2chJCXBOcXwJyieLYp0flniA2B/z
         paGxD3mPCKyWqUmix3luz0R6repgFyiagFQtSW4xSy7qvH54b5C2ZTgSBC4RsxZL+Mnm
         2aVDYwrgohFgFMgw40xAU5DTqHaQcAFU7r8u+xOWbchxNppXBNkJlN0msm/xMdLD6Vwb
         oXxQjyHZCtcfj6pz1adqGekkJAMYCNR9Gbfy2YfZ8bP/W4/s9rz5usXDrGQ0nKrbO4DS
         npqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEXs8o/bz1T9kST8t2/NeNwS5FQrKbZZ7AY8VGiD3bo=;
        b=TxPl1bLu9I5mYmAgihzxfJEsSBHK7KjasMCH9duZw7/hk0IAi/GsSnkdNyOBoRXdGm
         EdzBsNmxEvwfEBxIFd9FyYRXvlHnqSZZTRjplY+i6VW3LbHCjSPnSxv9utubP0llsFhh
         RtWf4yKRTfUiypZTZjOpPEHZldvh08tBon7pZavH9WCE/D+XVu285ElwS0ZW5yiJARGj
         k0OyL4N6H6U9+7xIfRS21y20bVI36gbnREvIyjteDN4uwZuQEON549y3y6tKL5jRv2HA
         ztRb07Zyp8Cdb14jzCq1YsSq2HBiuFGADzj3ZIsdSoVj04a9BMDva304xrYtyWI46SD4
         ft0A==
X-Gm-Message-State: AFqh2kpcR/+CWatDR+qn+TR998Db7Pd1xU4MLvIiqothL3M13DOwKMh6
        YvVcSUeXRZJBjP75CpXqH2Y=
X-Google-Smtp-Source: AMrXdXtHT2EWUE7ul6UV2f673q79NP9xmLZpyLexpix5PFrIkZg+07+2JkNJ9N6s4HejC9A91235Rw==
X-Received: by 2002:a05:6a20:7d9a:b0:af:9539:a2c0 with SMTP id v26-20020a056a207d9a00b000af9539a2c0mr115448829pzj.26.1673553483090;
        Thu, 12 Jan 2023 11:58:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b0058ba98f16a3sm1455207pfm.171.2023.01.12.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:58:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
        <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com>
Date:   Fri, 13 Jan 2023 04:58:02 +0900
Message-ID: <xmqqwn5rseyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Given my above comments, I personally don't buy this as justification
> for adding a new way of reporting on the skip-worktree bit.  It may
> still make sense to add this feature or something like it, but I
> personally think it deserves separate justification from "`ls-files
> -t` is semi-deprecated".
> ...
> To be honest, I don't yet see any compelling reason to use this new
> option.  Even if this patch is accepted, I'd just continue using "git
> ls-files -t" (both directly and in scripts) in preference to this.
> However, you have inspired me to try to fix up the ls-files
> documentation and remove the "semi-deprecated" label for the -t
> option.

Thanks.  I think that would be the better way forward between the
two (i.e. adding this one-shot new feature vs resurrecting -t).
