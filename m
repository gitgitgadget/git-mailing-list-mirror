Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A3EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjF1Qz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjF1Qz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:55:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B619B9
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:55:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401f4408955so6361cf.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687971356; x=1690563356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvaS2BLixId/YwEJqzetK5Q7flpmmIwj6l1ylJH9D+M=;
        b=x1gPvYGVzb5EAVTH3PEI5QR4B+Z78mxEWm3EK3Wvx4GfH8FhePe4KxmtQJFeVive4y
         64B+Q6vextFaRDNeSPRlm7O+iuxdwpMjtpA2+gcp0P39Z7pDaOtULk58KbL2K/Oc+Y3E
         MLEAdcEV3zrimCUNhgScEMGfYfeLc553XJBnVWelrNr+NNhpZynSs0rBUvHXtxn5TIq7
         8hoiI4CDsq8ERB3CibDhzuqw2xse0Tq6E0Jgb4pTVXCJTYb8CwLC1uyJw1Lz93VPSw24
         TNCr9adZyzVihkJGFk6/gpBZO2kLNlmm5YeGo4i/cfOGUidQrJ53lUpSGGUjEN0X+FWt
         nQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971356; x=1690563356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvaS2BLixId/YwEJqzetK5Q7flpmmIwj6l1ylJH9D+M=;
        b=kbpWSX/VQaEA26UgQBMKeYSjXGvOBHVZIiUgZ2hWYTh7B5PaFsBYJ9fCnHV3qyPqgB
         AjyZAcPq5r4sOa+GGiVoO97T9mwTVsbnvJJI0Y8atq4DlZwZaNXuIoNEegcVu+fP2nYj
         +0gE++ZzF3GkiJkd5wp5HJuZxPn+vqLR1axqORqQLVT/QK22YSguY2pN2bbKlBYPzohU
         I95oyluPXBJqBkI1UdyK87ly9ea/2wHjid11LSu9w/bibU6NHB41vwzEybbzefl7uUyS
         NyBmOFZzVl7kHazVeJnbIQyAZjr9dk27Q5o3WfesMPu2HaTdckwvVQOXZteYaNN97U5C
         OSaw==
X-Gm-Message-State: AC+VfDx8pxzuPZWl/CCRAu6xfDc/P7nsuFz+rwFZloGQG4RZc1x4bfJN
        n0TxJfWsusPnVcAB7cWDLu3Pdqx0ZTQk0cuk8+2n7g==
X-Google-Smtp-Source: ACHHUZ46ZszmA2M22rhUjnpldnNWt+LjntBqz4CLIpfvXaFt0/6zoWj187MfTyp1BUMvH6irPKBC27BdtS3lr2dUQVI=
X-Received: by 2002:a05:622a:54:b0:3f6:97b4:1a4d with SMTP id
 y20-20020a05622a005400b003f697b41a4dmr264423qtw.23.1687971355837; Wed, 28 Jun
 2023 09:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-3-calvinwan@google.com> <e08d9319-9a4f-bf16-242f-d976aeae32bc@gmail.com>
In-Reply-To: <e08d9319-9a4f-bf16-242f-d976aeae32bc@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 28 Jun 2023 09:55:44 -0700
Message-ID: <CAFySSZA8kC5mN5ZgAnz+RiBXKXQq=z4DZ01QPnmkD50EbQjeeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] hex-ll: split out functionality from hex
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't think any of the remaining declarations in hex.h depend on the
> ones that are moved to "hex-ll.h" so this include should probably be in
> "hex.c" rather than "hex.h"

The reason why hex-ll.h is included in hex.h isn't because there might
be other declarations in hex.h that depend on it. It is for files that
include hex.h to also inherit the inclusion of hex-ll.h. If we moved
the inclusion of hex-ll.h to hex.c rather than hex.h, then those files
would have to include both hex.h and hex-ll.h. It clarifies whether a
file needs all of hex or just the low level functionality of hex.
