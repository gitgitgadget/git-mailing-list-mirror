Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D9720248
	for <e@80x24.org>; Wed, 27 Mar 2019 04:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfC0E5U (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 00:57:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35214 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0E5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 00:57:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id f88so1435290uaf.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKKU6ikU9MSE5YOCW7/BMRk1ZiVAHWrrRXqLofyXfpo=;
        b=RURcmDRDli21y80ZaJBvYCrfloK19qYH9emrgG1WAcDGYbm4vWDywDYTU1tYgi3h3N
         gp7U+ygwb2AGbkffq8EQ5ulann0HPc8jysBOtJ+7q7kYzoiUy9foCLlei8rnqU0JJOLH
         3JA0Uwon1G1eIe4hOCL5NP99vwCN8FfitVv4vlkoqW6vOPhoBAOlhYsOjNUpUxepuDO0
         x1/Kq7p1/UqiL4uEn+bXpM1kILpu2elNmy1E8D9yibmTHubfpCcfr9hgo5eq1Lnf1q+U
         xWBzRwYGObXNQLXRyS1ge22Cp7m4K/CE4QhTTpRI7UvYgBVeeexc7QQSqPT4WskFievs
         C3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKKU6ikU9MSE5YOCW7/BMRk1ZiVAHWrrRXqLofyXfpo=;
        b=Ljr44EAxcIPB8KH8Mu8qbBC+NKQf3jKOri4utHHmjq2p0zno2PZD7C/pp191CPsndE
         0324kRLPSFCJl/hqnmrrBEIFnCmAO8QW4d6PfAgH2wTDhfXaNW1zyoqq4zMyH4TdBLPL
         dvvFlkD9ZJ3X7L4L/ByqCMWZxz05sjaQQlqFSxgAjYUVwB8R/3Ykp6o4vrpQlp1Wo/kv
         p5Jg7YUgIAu9ieL0BjiyFT/qFdRfKXUhAbnpvT6/SLlLbTA0HPPx+MtgTtP5wguoMlKf
         ad0ukV1tpIxB2s6l22LWQS/d3O6q7CHcCXmmNRJgPaP07OFBWslI9P2BBqMPV8H22JoD
         AMFQ==
X-Gm-Message-State: APjAAAVtfivtbUI53uNdIbhX4ERlVJAxpbA3JiU75u+sgXpM7XcnF9DQ
        EJ/TMPYacn/CEmA8T33ozx70l2UnB0KTGaaSA5U=
X-Google-Smtp-Source: APXvYqw80EN1fH47cGK8/hdrcShKpbSanU2qkmKT0zvFdSGRQxAzNXZ9yWuYYha11Ihgev6aXOTcsrX4ylPO9EprWVc=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr9667011ual.95.1553662638879;
 Tue, 26 Mar 2019 21:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com>
 <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
In-Reply-To: <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 21:57:06 -0700
Message-ID: <CABPp-BGKWxJVGfQC3imj8Z6RHxQ6zLOGRpkOjyn93a3RxmE0Lw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tag: prevent recursive tags
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 12:56 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Robert Dailey reported confusion on the mailing list about a recursive
> tag which was most likely created by mistake. Jeff King noted that this
> isn't a very common case so, most likely, creating a tag-to-a-tag is a
> user-error.
>
> Prevent mistakes by erroring and providing advice on recursive tags,
> unless "--allow-recursive-tag" is specified. Fix tests that fail as a
> result of this change.

Any chance we could use the term "nested tag" instead of "recursive tag"?
