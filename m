Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8948C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiBARhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiBARha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:37:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767BC06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:37:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q25-20020a631f59000000b003654beca609so584505pgm.22
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kmEwPsQxaVtZu6UxvbVDpyJvdAM/3C20t+l3nNwZps4=;
        b=HSZRZn67/UVuH8YYReoE/ZWMwfOfwn3g0HTkaILJZtSyviJOEzGxgI1hftQJsZF6lV
         UhkYjO59SgfP6w13eGEpDMZ1EGn/05iUQUnQahG7B2tL8ifTbEilm/NMOGMprvh13xYL
         egbmW1rDJRCF0Ce2QFRaOiV7a7M86Dzjyyx66N9JD6tlpDipI7TXZ8ZGSYo62KVoVx8c
         EF08Y9sxR3oOvtvlnj8J70IpR18o/GVkzV++9SRXWPvOCW9dpBcd12bCrWd62QxWAfBN
         MOsEZx9sTfMgIP9K7pCOPOASW1Sm0LLWxPjn+g1bg0IZiVaVFVWjJFQ5z1yajrJ2MItA
         AsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kmEwPsQxaVtZu6UxvbVDpyJvdAM/3C20t+l3nNwZps4=;
        b=pRYTQpfg8qWZ3j7gKhxYDvGB4QtLtNeQO/xttYMnGgi8vMIpT6J2K+wdmTqwX5B+R3
         AA3pKHW9dldBr5qt50sNSyiAYmTvT+aufukL1H1RsdrpG6o4ZuWDavino6JZrvhHeiAN
         aFamYKcG1zvPMtB7l8sdkolz42B6y+0n9vcGKIqOz81Imto9i58EL1BbLOFYErlR5zxZ
         NL61Hq+i9LS5H1cnZ8hNUBXxaONnrdrDGVwosUQasVCzgJ5yDN4iZEYpv/Ohs3QtDISb
         hqvun5AYBV9gxp1fWR/+Cdx1cjLUbTBMzJF/HAvVtEUVwY/8RPvrHRTUVIbeJze8f2H3
         FFZQ==
X-Gm-Message-State: AOAM532LYWTRFr/yBmaCiAUVDxVLhlUmFLDYtPVVzHACWSW2WKEjZDLO
        FrjQ7IIYdghtYNLhA9Nk4wGSh1mDt6j9qtvPqDHA
X-Google-Smtp-Source: ABdhPJyGxIbJFrryHGqKFx3uYjgDlvfQRuPW4CDd5ofrtf8Tq/Y9N7qVU0JF/OavRckOvdIjYikzjba8HLlipN7Llqkf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4d82:: with SMTP id
 oj2mr470844pjb.1.1643737049658; Tue, 01 Feb 2022 09:37:29 -0800 (PST)
Date:   Tue,  1 Feb 2022 09:37:26 -0800
In-Reply-To: <CABPp-BGRPOdhqV0uXGR2YfroB5Q3K2C6DiQqCdAbG4Xoi2-d9A@mail.gmail.com>
Message-Id: <20220201173726.1577257-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGRPOdhqV0uXGR2YfroB5Q3K2C6DiQqCdAbG4Xoi2-d9A@mail.gmail.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: Re: [PATCH] repo-settings: fix checking for fetch.negotiationAlgorithm=default
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     avarab@gmail.com, gitster@pobox.com, gitgitgadget@gmail.com,
        git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> Maybe Jonathan also has ideas/preferences, since he wrote the "skipping" code?

No preferences - I think both "consecutive" and "exhaustive" make sense.
