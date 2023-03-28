Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C609C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC1RpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjC1RpN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:45:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB39EC159
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:45:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so15896494pjb.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025506;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7TSm79LZrJj5iosR2YaRs6faxEJZL8DvWpODUg09y0=;
        b=Pq0NZB/C89vLPWizDRGZktgb35SjxTem2Ewpv130XhPKmlokkInYsxPyYxTurwTwaL
         wpXrgG7UIT8raIRQmvxnG0Herq8K8atM45MWAUZMfR3G14fu7sjCUTJd6Hp+v3Yc+gUi
         nMzKm2o6VljGK7dgbCuuIy4lV3fa3Kag/3l26O79JqfMVQEdamw6YHeEiZxiwcLcWZ1C
         6ardX4KTIemNV2RhIiNmVtCxkt5tw2XVOfIiNRV+qdVowVfG6L2gjaCWxOq3y+UkP+I5
         3kIofdCkBA+RUHsmT8kb8IWYu2g6jf7cJR2nMSCMU/8I3RhWD0XL7ZHm4KiYIzqS2KPF
         GRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025506;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7TSm79LZrJj5iosR2YaRs6faxEJZL8DvWpODUg09y0=;
        b=umxg7vn/n6QVKoi2oT0owOrnP/CVNh0VEar/r25tIdjLrfwQzsaZq5HCYXxHRauLLm
         GD2Q3AlF/oN86j4dQy+HLiFQuaZw1vshjZAUFIc6bCzkZy4T5xgqMswfBvkjQIeZd4WJ
         TKfUVdHGMo+qRyvrKZZFEximamG+h6raMvgJ8MmZYQnNaqUjhJ5RcxfKH1iUrLKdcpgH
         MoF28xE3DGTJ6BJwdnSgGltm02mNj6Wc/9xXmHkU5o4RSkFwJoKOPrRQ/cFBoju+xITZ
         hOc2f7ITpmPt4RJamx3SXNDWovSjmprb3rzSsUo1sMlYdO2H4JJMbP+/se9cp1a2w5i6
         jhTQ==
X-Gm-Message-State: AAQBX9fJrU3mgluWXxd+0Bu7+uOiGRHgRNzYLEwA2p4QjcOXIICpqq50
        mEqw5VTBpe0YxaeatRagN3E=
X-Google-Smtp-Source: AKy350ZRHlI34PS38LoT1truBrasnUnpl1IbMbDS4F5rWDpNdZkHKDiLjDyScCrbbinyRPFeqG5RXA==
X-Received: by 2002:a17:902:f543:b0:1a1:ce5d:5a15 with SMTP id h3-20020a170902f54300b001a1ce5d5a15mr17281568plf.50.1680025506235;
        Tue, 28 Mar 2023 10:45:06 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902a9c400b0019f3da8c2a4sm21357015plr.69.2023.03.28.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:45:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit-graph: fix truncated generation numbers
References: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
Date:   Tue, 28 Mar 2023 10:45:05 -0700
In-Reply-To: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 27 Mar 2023 10:08:25 +0200")
Message-ID: <xmqqfs9og47y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In 80c928d947 (commit-graph: simplify compute_generation_numbers(),
> 2023-03-20), the code to compute generation numbers was simplified to
> use the same infrastructure as is used to compute topological levels.
> This refactoring introduced a bug where the generation numbers are
> truncated when they exceed UINT32_MAX because we explicitly cast the
> computed generation number to `uint32_t`. This is not required though:
> both the computed value and the field of `struct commit_graph_data` are
> of the same type `timestamp_t` already, so casting to `uint32_t` will
> cause truncation.
>
> This cast can cause us to miscompute generation data overflows:
>
>     1. Given a commit with no parents and committer date
>        `UINT32_MAX + 1`.
>
>     2. We compute its generation number as `UINT32_MAX + 1`, but
>        truncate it to `1`.
>
>     3. We calculate the generation offset via `$generation - $date`,
>        which is thus `1 - (UINT32_MAX + 1)`. The computation underflows
>        and we thus end up with an offset that is bigger than the maximum
>        allowed offset.
>
> As a result, we'd be writing generation data overflow information into
> the commit-graph that is bogus and ultimately not even required.
>
> Fix this bug by removing the needless cast.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> This commit applies on top of cbfe360b14 (commit-reach: add
> tips_reachable_from_bases(), 2023-03-20), which has recently been merged
> to next.

The patch is clearly explained and the change looks quite
straight-forward.  Derrick, Ack?

Thanks.
