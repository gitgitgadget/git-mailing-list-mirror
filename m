Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57855C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E0E60F24
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhIVXNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhIVXNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:13:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A89C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:11:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q8-20020a656848000000b0027e00518162so2664595pgt.11
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fL9/fPGju1t9+KAEuI7RAs320ACfkMIGIbco/AQx84I=;
        b=dDsgJCvWFLVHz9BXK+1AQBnHWFM/Gy8AqCXX2VXBtNGxjkE5Gj3w5kIu2h+PMk8xBI
         PM4mM1LsmwR0JwEQRkiDS+Mr1BqwLbBegUMrCemKvMN70Mv6HbDyiF9ssrElHO9mYpeM
         TjUFgP6kCpuNaN4tYRbHBhbIg1hrXpJgD08hARiwMoWwe5gMnJ25A4mGNrWVTsTrcNje
         OKshTrrI7xq5VZuWz0rSJhQgjQbtPmOAiFCDZZm36CffGYhLvc+W06iPry7aV04hwZo6
         3eMwVAUseElaciYzjBmGAtyYRi61ZUH1bV8tvtcA9STa/9cjH3lDIV3SBdeUhc7XC5YN
         Gubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fL9/fPGju1t9+KAEuI7RAs320ACfkMIGIbco/AQx84I=;
        b=t6kuY4Zei1cseJdRSYID1Oxf7qLTLbqeK9UM4r00I8WIr/e5I6nIugIileSk3hG2CM
         T8bwgYsYm2CzkUKL9Cz6+pYxn9lEcl7GOzrUqEXwvbi7UvEbYLYx/oYTsRu8mfadv72P
         ncfvxpK1Yj2ZzrH1b2/93TfRAhsAVUAkSCwRryBZ3u6fnkP2pRQl2RqG3jseFAndSn6V
         pTTAKfOZ1EJwaShkoh+/bUagJwGPUqEV76fPcCzs31ZikElD2vowNSshAusWndNonrQo
         vLOH8Ypq2a6IvALB/LwfcUnvTNsbViwAD/4iH5w1vdMkv4IUKTXO/gpGK/7NfyyetJQ+
         sCWg==
X-Gm-Message-State: AOAM530dbDcmoQkMW6RmcokoT32GyXUHDrYowrVRfPDJjfexYl5rhsEh
        0hipUJhuJL1tBaV+Qwke9YSFaHP3PJuHS9EJaABz
X-Google-Smtp-Source: ABdhPJwEKdwDjOUGTnO+UexkZAXX/qNkKQGFMlyCjoD37wPFth2LDjI6chMSCH++IKG/H/4zDtATvlqQtscmHV/Nv6hm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:bb97:: with SMTP id
 v23mr13944477pjr.128.1632352299191; Wed, 22 Sep 2021 16:11:39 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:11:37 -0700
In-Reply-To: <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
Message-Id: <20210922231137.2610100-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 2/8] builtin/multi-pack-index.c: support
 `--stdin-packs` mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> An alternative approach
> would have been to call that function from the `git repack` builtin
> directly, but this introduces awkward problems around closing and
> reopening the object store, so the MIDX will be written out-of-process.

I'm not sure if the implementation direction started by this patch
(eventually, running "git multi-pack-index write --stdin-packs" to
replace the midx of a repository while "git repack" is running) would
work on platforms in which mmap-ing a file means that other processes
can't delete it, but if it works on a Windows CI, this should be fine.
(I don't have a Windows CI handy to test it on, though.)

Assuming it works on platforms like Windows, this patch looks fine.
