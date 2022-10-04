Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC6C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJDQMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJDQMV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:12:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F52AE0C
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:12:21 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3560e81aa1dso117474497b3.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tFJIrMepRfUcvtP6mczIAzdAYObNVLBTkRDQJG6VkNU=;
        b=Pl9wiXpSi/4saEbGfrVfx8RXTnl56tj9VUY6F/cKFTruMLPeyq9FmWO9/yKcY31Qz6
         AIpBe5uyZWlFnkmdeSclIKH8gSb4gAYNTvGOWP+S0JyZONtn3Lo1syLSOpd/84bWVSlK
         fd/kttjJ2HRgXVa+3TAfU+x8lHldljLtdAviTDJnKrp6Nip+QHACAYOqXPLQkM0i3213
         Z6Pe3AnBSGOA1eIzyqon+DR87vqJQ2t+/b+T/+QAFgFvoIdQGdaSUT6c26wQRvQNYYJF
         1Yn+iywOPdSVn8aDUdy5748H/Hv1a8GWjFsHNxmTTFFUEnGmM+3ixNl60naYU5TAciEW
         uLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tFJIrMepRfUcvtP6mczIAzdAYObNVLBTkRDQJG6VkNU=;
        b=i7P9glzSmGCgjKnm9wZ8or3jyHcJJxI2TRTJRvwQBQVxst9Ii+GUsAZ8TD46FmHiUp
         V23u7oFTiz0SjhpK/0JFCNlMSJ5+qVJFS6F+Ye4SzS3NE+WpcL7E2h6nJOyIpw0On8rZ
         4TarcyxrJ6a+a5dxeJ+lOnQaAYcxY2CWBb57JoXO6AhdkO744RX0Q2XlCbrBFEqFVQ3E
         2IPhJl9GQTsCWUg8x+S7bZ5Z0r84Uly8bHIaMel3KinazCkiL9cWg5/WDbnAFCTgWHF5
         sPpIZklD4WBEyyaqbIm3mm5H3XId6JUKeT9Qiv9lMdq0IusYATJJv0maCl1h1OtMeicS
         JxBA==
X-Gm-Message-State: ACrzQf1WiTr0AxqZSRne1upvtV4q+yi4Lho9a4pKhvdFGBz0JaGStNZS
        p6beWI83ZpcJVRxBt4s6oQbolSsWYbqnrK/b7hqaBQslaGw=
X-Google-Smtp-Source: AMsMyM6OIofhzPcrWKvTvvkUlb2qj6a/vDJ8uTzt4Rfwo1kGbmsDY5fyyZRv2BsnWA2B8jiUhy4Ni3ylZe9UjfvEqZM=
X-Received: by 2002:a0d:c706:0:b0:34d:1b70:1c7 with SMTP id
 j6-20020a0dc706000000b0034d1b7001c7mr25033608ywd.284.1664899940299; Tue, 04
 Oct 2022 09:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 4 Oct 2022 09:12:10 -0700
Message-ID: <CAFySSZBfcvFKuD3xjOVTxWFAb-fTmy_nNMKXCgBc5nRee9vN2g@mail.gmail.com>
Subject: Re: [PATCH 00/15] run-command API: pass functions & opts via struct
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for sending this patch! I looked it over and all of the
refactoring changes you made look good to me. I'll go ahead
and rebase my patch off this.
