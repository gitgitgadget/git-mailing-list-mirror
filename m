Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DEFC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 02:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2B62080F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 02:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfKZCfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:35:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfKZCfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 21:35:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so20575181wra.10
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 18:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Vk+qdowha4Hv6+eyaQnQuwiGoCz3jAD0YMOKR5BDYo=;
        b=awPTAYgzUuRdBOj+YqwzrhPCSlfKglB6fv7h6JZ2JdGLneu2r09H0Ursi4flMmN98D
         3E5gAY7XuKO4NQnYBmVoFsUwQnreKA2TotfsV+FyuXj3rze2RQx3jTqB2YmYERtGRX8a
         fScbTxvCqovISjhSzzHBjQWCdXP7iGPCn+6IF6poMeFXyIlTxeu6EZTqdYURVEOX1GSE
         LMNJRyHyKDWRvmpFQ7behckLvYx9UxG0ncBsIcc3jeAk1y+aIvr82I5ukwUNnUFUa/8f
         PWU+sawW8ZwiINc56wo9q/666UOX6z8JENJYQ51zLLlPIanYS7eyY2hNSokqMhtuDZdq
         SNQQ==
X-Gm-Message-State: APjAAAXeuNG099nHc7HHjrPflFmLc7unzZ8YuWO6mq7IAUbBKiE6JPXm
        hynACvSkABnehNrhqPn6Mt2FY5gf5SwOgsP67m8=
X-Google-Smtp-Source: APXvYqxxnRiGEn8nz3dwgjQdF7x3co9aI0EfegFhjSnLASdbSU6CrUb821MXYD9iyVGlqEAIJT2To2/GTssWDVliUQ4=
X-Received: by 2002:adf:b193:: with SMTP id q19mr33615687wra.78.1574735744828;
 Mon, 25 Nov 2019 18:35:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574449072.git.liu.denton@gmail.com> <cover.1574731022.git.liu.denton@gmail.com>
 <c98a2a15090ac3d23757d1d4317d6a1bdcf5b115.1574731022.git.liu.denton@gmail.com>
In-Reply-To: <c98a2a15090ac3d23757d1d4317d6a1bdcf5b115.1574731022.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Nov 2019 21:35:33 -0500
Message-ID: <CAPig+cS13ohg7UJv3b-D4h4MPn5yHmH3joQRtdn592SN+XUeUQ@mail.gmail.com>
Subject: Re: [PATCH v4 22/27] t7700: consolidate code into test_no_missing_in_packs()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 8:21 PM Denton Liu <liu.denton@gmail.com> wrote:
> The code to test that objects were not missing from the packfile was
> duplicated many times. Extract the duplicated code into
> test_no_missing_in_packs() and use that instead.
>
> Refactor the resulting extraction so that if any git commands fail,
> their return codes are not silently lost.
>
> We were using sed to filter lines. Although not incorrect, this is
> exactly what grep is built for. Replace this invocation of sed with grep
> so that we use the correct tool for the job.
>
> The original testing construct was O(n^2): it used a grep in a loop to
> test whether any objects were missing in the packfile. Rewrite this to
> use sort the files then use `comm -23` so that finding missing lines

s/use sort/sort/

> from the original file is done more efficiently.
>
> While we're at it, add a space to `commit_and_pack ()` for style.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
