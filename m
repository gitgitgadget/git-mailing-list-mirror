Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE7C433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiI2WAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiI2WAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 18:00:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5A13A078
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 15:00:33 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so1670420pge.13
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zS/iZ9ndJ2TEB2ruCVyd4MV+pxxx8QmvUIzyLP4exuE=;
        b=Nkx1gv73OxlBBza0eGurP1su6qFK0QHCygmv+WWDgo54CeStXGiN0DJXKv9LSJybaQ
         2nmrox5PRdUPJWVDxIP8x2W/N6LKFh/Hep7uCX7VxggMUh1rweqVdQnL0qH98KfCGaZQ
         MPj1df9qVdbFUMZRg4QinP8QHj+PNE1/Swmsk7FeHrYj1vh2YaYTG8UxyGyCA94gvzdK
         ChVjx1pofhC2O4j8v5Pidk4tlmj+a8z5vYpMwYv7CjpFkLYUN0VWwiDj6aOkAdM2RUiB
         x15HRRt9Px93TYG48LoDi70ZNHzHpF9qil4AcIyRAzT13GQ6da6FOunZQZFzkbE57l/l
         wXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zS/iZ9ndJ2TEB2ruCVyd4MV+pxxx8QmvUIzyLP4exuE=;
        b=D5nvICph6scZQuCtgE0lEopusGdWz/TXUr4l2ogj567XZOJudJdZxnjcxnyI5lbnpz
         wYKvsBG6c1HkqFay8W1CogpNA6BIRKuXm0bFhf2BIV+zxCSYZbs5kwnRkDzlkFOdR1Ba
         apULOqo0CZKK0uFjiFEwX83wVAiSl+bqz5XTRD2prtWzVDCQ0QHv8HyFpCbJGvKDCqtk
         FOECSx6+5EcyRl8SSEC87qNnZ/nB8tHneh4qa0hp0Zg7PRqMNq/uiXnOG4vFmrzop+N4
         o9xat9z8aLS5FKC5jBvPrdmqvdUIHEJ/izmsfTJ5C49HBucQiNa9C4uhQp6IZTnJwo3t
         3Cbw==
X-Gm-Message-State: ACrzQf1r0YL66SITVXH+RitTm1aBBBQRc1T1J8CU+EUqasvTjEJYhQI6
        Pe9Lg/vue6GJEOf0nOyMu0aRevaVRixwpqvjYpxr
X-Google-Smtp-Source: AMsMyM73kEtg0nU77jBSij6rGiHnMFx18RHYe/q99RPMVba3CmmfztADQMVljR9qDjTaFM13vzHWBBYpVjXgAxj/NdzN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:2290:b0:178:48b6:f57c with
 SMTP id b16-20020a170903229000b0017848b6f57cmr5454459plh.78.1664488833404;
 Thu, 29 Sep 2022 15:00:33 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:00:30 -0700
In-Reply-To: <xmqqk05qne8h.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220929220031.1438958-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/9] Bundle URIs III: Parse and download from bundle lists
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
> > If some of the reviewers from v1 could check that I responded to their
> > comments, then that would be a big help to getting this series moving
> > again.

Yes, all my comments from v1 were indeed addressed, thanks.

> Thanks for a ping.  Also, if reviewers who missed v1 can take a look
> and give fresh insights, that would also help polishing the series
> further.

I didn't miss v1 but I gave some new insights. :-) The patch set looks
good except for some commands I had on the last one.
