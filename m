Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D80ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiIAQRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiIAQRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:17:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858E3B969
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:17:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2880747pjq.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=HVmc/uH/NTa0C5mrlu4TgOg29TgUVJVMsDTIFPerbvw=;
        b=gV7DH2lTXQnV+QXrXrPkpIQ6iZuzAQ+k1/hp3RLakM/PpTCBRnjZw5zUHs6u21fXBA
         Ay97l+lwo7ZKdzoP3a6Sb/X72qWoTwBPCZMKKexkF2FBDvEru5qLWG/btpjhGeiFhTJD
         d5s1Xo6+S4m1keXzXVd/uRv93AnnLSng2wtrPw7ibc2gAxoqTa0PtFJtRdR/1KbQ22/v
         Fw64LI0TKRlqxmK8k5y22E7AGXBVLQMqopSN3m/HcTjnnnoyh8w9zvuWt7zV75Gju/dA
         v2eyWIywRQ78LTHti4DJeQdbX7qQtXxKTW5JpHAOUKOl7AEHqP0SAmZ/dHeUm6y0y/ET
         A0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=HVmc/uH/NTa0C5mrlu4TgOg29TgUVJVMsDTIFPerbvw=;
        b=Yk3RpvAw0ZT+JUwPoAKfJ5pGPh8qyqydywmrHYiSG9eRKnpx6/TKl8PHwvVydZyNhR
         q2N6SLwxnofVNgsp8AG1Ptsliy2xxMd2/5J1LYPaOAF2ZBwOTCeC2caMFJJoJE15LKsK
         53o9Jaz5WESRgNsZCbt9eZNbDBnkXZyVctR36fUMKiU2dG5PBIcBsD3Jn9EVw8KF9Ey8
         2UmxPxnMk7z5SqFhW89bJkOkYJFkhUqPfPR9s2+7LVBhCh7PZk+qgoEXw/udsdOgkEoJ
         IJ64HECxEYtVE4z0O7YyemhRiWFHo6O58RS/LLXIORESWV06Hov+RE5ah+UoOaEwM+Y7
         xGcQ==
X-Gm-Message-State: ACgBeo12FAqx1ZeGcjDEXTocuFk4vWc94EzwBCv4WloKJ/GpEij+aOaZ
        JpWjnxBUW+XrnRtSI0TuPmyLEJF8ACk=
X-Google-Smtp-Source: AA6agR5mgJdGy22Z34la3fmhcnqxv0w48Y2dFyNoUn89f+wRWcjxd/mtatXF7C0DcqbtHc8kB3UeeQ==
X-Received: by 2002:a17:902:c611:b0:174:7f4c:3b4d with SMTP id r17-20020a170902c61100b001747f4c3b4dmr24252693plr.130.1662049034447;
        Thu, 01 Sep 2022 09:17:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902bb8400b001636d95fe59sm14011295pls.172.2022.09.01.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:17:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] add -p: ignore dirty submodules
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:17:13 -0700
In-Reply-To: <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 31 Aug 2022
        20:31:17 +0000")
Message-ID: <xmqqo7vzax2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks to alwyas running `diff-index` and `diff-files` with the

"always".

I notice that this round (like the previous one, v3) is made not to
apply on 'maint'.  As I said in the earlier review, in general I
prefer to fork a bugfix topic out of 'maint' unless there is a
strong reason not to.

It is a different matter if all these bugfix topics are actually
merged down to 'maint' and tagged a new maintenance release by me.
But I'd prefer to make it easier for motivated distro packagers to
adopt fixes that proves good in our 'master' front to their maint
releases, and it would be much easier to just merge a topic based on
'maint' than having to cherry-pick a topic based on 'master'.

Thanks.
