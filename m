Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1452CC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98526115A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbhIVXBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbhIVXBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:01:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74842C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:00:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 1-20020a630e41000000b002528846c9f2so2641015pgo.12
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PPdhrHUAL/HZhvbkQrJOBqIGDwnxo3kpUp7DAAXJrLE=;
        b=ZrJxJ1rzKXrdC5U+b1XyPgOCBWg7ja2IstnK/zsz+eDzf0PplRzzxLwD/JtQ6YWC2i
         uU/S5E6Q0RdK5YZu7dH9JeUp06JmWqhkF0bM3ssgMntq0uTXkSYrb+YO80i1Ire9+1ce
         alK3i1Ba2f3TlDTFohQcNAbwkAM/7Nt8hF3qqTi+Rx3QIN7TzgjcMlp2Hw7BzNpUmIsi
         KBNWZfvRFYFQ9YMo1YilKHa5L4FK9FLIX7aisaFkVYcvw1vVmQEv3ZUGvvqEIL32hRbE
         ptVdU+JPvVKBZwWuX3ai1YH8UP3ATfJjPpK5rq10UI5IY/pMY2DC+2v5/5Gi+KgwBfaE
         hwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PPdhrHUAL/HZhvbkQrJOBqIGDwnxo3kpUp7DAAXJrLE=;
        b=QDDAThpUO1mv7ukSxou7/r20o79D/txpTtIedLAsf4J17NyBmjyOSXWCQ7ehbhgXYC
         8pnnNvCHq6JpsnnDVMjCAi7Rvu7c9Zg920Yi6Ii9FmG9J1PJebALF8DnZxuH41QE3oDp
         gTRKRWoC5UGYzgZw80mLpLlbPQFgbQwI6D510Wt+/UzkjN/aeLt/zbmphZR2TXAWilj/
         DnMrxDrNhj4Ye+FaObbmqsNhqWmsxF4NK9ReKy4kZe8jtKH55HqtbHu5yYg+UfUh8GdE
         /VcRfd2zK1L0I+enWZaemoYQvtuVL014kf+wvjAHRkNXg2VQ1BoyMR9KXZpDd2nMwI9x
         80qg==
X-Gm-Message-State: AOAM530Kf/FwuZ8LH9Bq/zHfRG5j426nwW/PCfDGOsF23mN3aCK888e4
        Rkmgik5mXfFOUrq7LBcl0dRMFMtqo+WZVCBwNQ3g
X-Google-Smtp-Source: ABdhPJxUnw3goEWrJjdZm6QJ1eLIy2SptWjZtEcXidjuoEipbpHNKAnLroxNZkFJbo4kh1ov9W7QAP79QcMY3PYjQTed
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ac05:: with SMTP id
 o5mr14177919pjq.205.1632351614637; Wed, 22 Sep 2021 16:00:14 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:00:12 -0700
In-Reply-To: <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
Message-Id: <20210922230012.2608849-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 3/8] midx: preliminary support for `--refs-snapshot`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This approach will cause a problem when multi-pack bitmaps are able to
> be generated from `git repack`, since the reference tips can change
> during the repack. Even though we ignore commits that don't exist in
> the MIDX (when doing a scan of the ref tips), it's possible that a
> commit in the MIDX reaches something that isn't.
> 
> This can happen when a multi-pack index contains some pack which refers
> to loose objects (which by definition aren't included in the multi-pack
> index).
> 
> By taking a snapshot of the references before we start repacking, we can
> close that race window.

I can understand why we want the refs to remain the same both for the
MIDX generation and the MIDX bitmap generation (one reason that comes to
mind is how we select the commits for which to generate bitmaps), but I
don't understand what referring to loose objects has to do with it. I
think that using the same set of refs for MIDX generation and bitmap
generation is a good enough reason to do this, and we don't need to
mention loose objects.

The patch itself looks good.
