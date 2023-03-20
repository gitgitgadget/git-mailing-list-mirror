Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7DC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCTSF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjCTSFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:05:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4D22DCE
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:59:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so13496796pjp.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335117;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSTw9iV/BGsOtS9psVD/3yPSUya6cbvR63bFVQt5o/8=;
        b=qwXVQzHVojBj6YdSzRMpeYlNZDyQbjoEjiFa9EwHHUwH4BCeFWYkmxTwlym4RxQBXA
         1qnhJV6Lc87i09ECvlqSPU5t0DkLZ59eNLX9D5JY4qAwu8Zw6n5wZNuz+Z50pWG0/KWF
         LIykgzx19G3Cwk4gH1pl/Bm+CVuiQtVmTT7zIBkW0ZnG29OMxebfxwiY0Itwiu4X2dIS
         uBonJ7DVza/pm0BkRfJB4TASWXSxPZ4K0QM9G8ty9v8TzaErkcLnHmTIwxkyTfx0MkEN
         0cT+FwCNDVxFdn1QRpw+bxHqQXeROIJE9LJsmYWPAe2uauu2ym9L3k77q2hmXQgiAHtY
         Vp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335117;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSTw9iV/BGsOtS9psVD/3yPSUya6cbvR63bFVQt5o/8=;
        b=yPXfaLq1P4tQ1LLPvxmYyKH1XcVt65CLOrKyzmFUr/+4qw1iyOFOegQbdcCdJeu2qR
         LFgfQ9oWEw1rc6cK82POAEmNzyt1f4+xCmiMCUbYhcP2309sPkTyM23HDo+HQZQEXfW3
         /TrF43YSFhZP434IVRcNG1QLwG/40mG6MaqNZat81a0i/hS47HcP1SvEexHMhCzE3/pj
         dCb2VAt23sCzIvhRFmsTQ5UZM4ImeLpWPbPs/B5ojunXpNQYQNaF4bU8jDcg74KFplQy
         uRpWhv4c5BVRjEw162CzgQvP+S5NZUhLbKw4sI4/urCVMYkeVcJIBybcZ6eOZXqtfHho
         0RZw==
X-Gm-Message-State: AO0yUKXWD9hrzrzIPf4oB1O1vXMD8dZi3tglI1wN2VgCTxLTvujZILu5
        ANUHCs3E/Zw4VMc4QJguFoHRSrYySnQ=
X-Google-Smtp-Source: AK7set/M/uY8yb4Y+6WNfR3MVYo/7fdk9w+i32JnJx1BMkpnVP2/VnQABi9rXYkKPslWudBmpo2MnQ==
X-Received: by 2002:a17:903:404d:b0:19d:16fa:ba48 with SMTP id n13-20020a170903404d00b0019d16faba48mr13530693pla.28.1679335117141;
        Mon, 20 Mar 2023 10:58:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709028c8200b001948ff5cc32sm6981222plo.215.2023.03.20.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:58:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] wildmatch: fix exponential behavior
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
Date:   Mon, 20 Mar 2023 10:58:36 -0700
In-Reply-To: <cover.1679328580.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
        message of "Mon, 20 Mar 2023 16:09:59 +0000")
Message-ID: <xmqqv8ivl2yb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This series is based on maint. Unfortunately it conflicts with
> my/wildmatch-cleanups when merged with seen. There are sematic
> conflicts with the removal of dowild() in  e303cf8092 (wildmatch:
> more cleanups after killing uchar, 2023-02-26) as well as textual
> conflicts around the change of uchar->char.

Thanks.  What's not in 'next' are fair game to break and force
reroll ;-)

> Phillip Wood (3):
>   wildmatch: fix exponential behavior
>   wildmatch: avoid undefined behavior
>   wildmatch: hide internal return values
