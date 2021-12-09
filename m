Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E05C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhLIWZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLIWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:25:21 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09C9C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:21:47 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n6-20020a632706000000b00330ca963fc3so4006340pgn.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0aYKyzcQSuKKw/lWTjBjtAYFoo6bV4OHYb5uncQWd10=;
        b=kaRxDZic8eqjjeqs87TZ5TcNJGwZiKsYIhfNGKagL4xSsX5Ib59folF9KzdUfQlhNv
         YRV9srsHeTJ+8Q0VcW/4VZCOqAuX2mi8qU3B2mUzqPx1+UkpwJxsTm+FibTN293lrra6
         05P8yqRgcW1P774aUW8hRTbyU/T2XY4aaBsWvPg58F7I9caMvz4f0TrS4zH2oOdP311D
         AhzCUy12yQC2EXiRFbk3uqFkBfEmV0hg9EEADXTpVN3yswumplZuaJCi0MB+3eqDkOBu
         aC1BKjrOp+SPogLBumyh4Dyiw1S0Z5enQs/ROdElJQuNVOgyZ0x3BJU9V8NwS1WejXEo
         gfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0aYKyzcQSuKKw/lWTjBjtAYFoo6bV4OHYb5uncQWd10=;
        b=WL1QYzvXPaUFPcIdv20I+RI/C9dN6zYgBBJqk1VMwYtfh2HFbogYvJUeEwM43jpSfF
         4Qujccis4kQaaYVlCPFhOAxr5hJ7s1lDeZ1A/7ivJtx4uyVH2LrbAkR97kcVUL9PqrU3
         fGy7RpapKn1HUgJhnyo8lIj+dru/ZaO2Ubtsfn+zfLZpxvrHH673hjI97fZJ2qaHI/wI
         fzUX1O+a5En5VJUoqu3vH6dEPiOTD8WKeIYReSl+nifoXVy0H/nccmOjfz4bwnFYIgsO
         WG44ezIKhX6Daq2uIhXiBlrlX469NI3qz93vu4uCfzSppmIUqFfCHoN9BDXteT0Fq9Y1
         RP5Q==
X-Gm-Message-State: AOAM5304jlLkmDxZECKEYSIvFuoZbS92rfMtjKwRWOM+Zx9+OaGyKRCq
        tIqfjWuk9RlPqkHmTzck/6zQeNhIcDdElg==
X-Google-Smtp-Source: ABdhPJyIG40FjFTku0hXMQCLc3wvA7TEBGHCYSLiQzCclDTR1n9XBctO9Z4yaq77bgzWdI1LlfYOsAhCK219PQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:230c:: with SMTP id
 mt12mr19007343pjb.63.1639088507167; Thu, 09 Dec 2021 14:21:47 -0800 (PST)
Date:   Thu, 09 Dec 2021 14:21:45 -0800
In-Reply-To: <20211209215912.506354-1-jonathantanmy@google.com>
Message-Id: <kl6lee6la07a.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com> <20211209215912.506354-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> This version is functionally identical to v2. I've only addressed
>> feedback around code organization, i.e. the the merge conflict with
>> js/branch-track-inherit and making patch 1 easier to review. Thus, some
>> discussions on [1] are still unaddressed.
>
> I do notice that some of my comments on "add --recurse-submodules option
> for branch creation" are still unaddressed so I'll hold off review until
> they are.

Are you referring to your comments on v1 [1]? If so, I believe I had
addressed them all in v2 (and v3 is mostly a reorganization of v2).

Let me know what you think is unaddressed :)

[1] https://lore.kernel.org/git/20211124013153.3619998-1-jonathantanmy@google.com
