Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE2CC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6440A613F7
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhD2MjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhD2MjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 08:39:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7EC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:38:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so104720272lfa.3
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BEaBuwvnH50kSMy7hDEh73XyM4WmXvn3xji4ONa2QhI=;
        b=H/OzaVI3aEwXS5B9g18T/f+7Us4ZfdkcYxSgrqePsjFDjXYTjrx3Krd78U2817i0HF
         z5cGlMgCLJ2YN8XxX2BtaT+uji3bzlaPGZ1iHNFvDyLjeiifwl5q10Ty+eel7r8c9b38
         QP0m1+h6PXZasCXq5GuneFFAGZAljEdNxpEDx5APyfCEIZFPtFJKJJC86/zROyV0IYal
         RltuyhddV0+8FsBLy6Gj9mSR9dxyUwSKhomxjCfC+wD5gqG9uUHtcue0uNgsN6E+/sy0
         YbIasGpqSoY38gX5oFA0fjRoO2lfvAxVFmKksCZbjr9REX7MkrDoM+kTV8zU2KAen5Lf
         uFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=BEaBuwvnH50kSMy7hDEh73XyM4WmXvn3xji4ONa2QhI=;
        b=W8rkcey8uz1/Y4pOQgIbKwWhTf/GIfj3pWOBPHB8E4UqYyG9DGQO1zSxH3ZWOVuiI8
         UfK06Uq6hUGPCfpeiqYYc0Z0El0OMKwvwjCWnRsOtKVFJ/5vrUQTZ02J12c7YwbHgatz
         /gU02t9YA765v6Fow8c3GpNUMPLBN5ZWOTzwBg27xexG6eIwYYxNYeaNmfOTXSvHThPn
         yTghXJi5jJ+pM+LAsx8UdvchnVe2MxgrvwwEXQrq5EdACKJzae/qaXGmf5GXE73E5vRi
         OCOkUae2J0E5zCpy5cT1wBiu1Ij+8vprolGQUBJnEm6XN/pDDCl6NeLJ+iW98o+biJ8P
         7RpQ==
X-Gm-Message-State: AOAM530xXAIyWxe5Xol+443VuE8pZq1E4j83i23t3sllimLwSx0lmUue
        f0BaaG5q2s4LbPu5XmJO3RCWEOBq+wg=
X-Google-Smtp-Source: ABdhPJw+6sGFr5HI7s9sUjMhwgCEfE0XaKxNd0dfrKQsJxLPCqtU3ytpk557qj90U6ZfAcbWq32YSw==
X-Received: by 2002:a05:6512:54c:: with SMTP id h12mr3697836lfl.357.1619699912769;
        Thu, 29 Apr 2021 05:38:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j5sm506207lfu.268.2021.04.29.05.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:38:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g>
Date:   Thu, 29 Apr 2021 15:38:30 +0300
In-Reply-To: <xmqqwnsl93m3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        29 Apr 2021 12:22:28 +0900")
Message-ID: <87im45clkp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> Why do -c and -cc imply -p, but -m does not? I tried to use both `git
>> log -c` and `git log -m` today and was confused when the latter didn't
>> produce any output. Could we change this behavior in a future version
>> of Git?
>
> "[alias] lm = log -m" can be used when you only want the logs
>
>     $ git lm maint..master
>
> or when you want to also view patches your preference is to see all
> sides of diffs of merges
>
>     $ git lm -p maint..mater
>
> but depending on who you are that may be of dubious utility.
>
> It is best to move on, writing it off as historical accident, and
> embrace the new --diff-merges=m option, instead of wasting time on
> pondering "why", because accidents do not have to have a deep reason
> behind them ;-)

Yep, but --diff-merges=m doesn't imply -p either, though it does produce
diff output without -p, for merge commits only.

As the final purpose of all this is to have -m as user-friendly short
option, I'd incline to finally let it imply -p, as --diff-merges=m now
covers another side of the coin.

What do you think?

-- Sergey Organov
