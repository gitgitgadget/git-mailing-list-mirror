Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12684C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK0JPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiK0JPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:15:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE010B4B
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:15:02 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q186so8708843oia.9
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pDuJTca2eM3bh45/YoLHVUkkLnNirwQx036iwXzAmPw=;
        b=SH2d5UJ+mJCn+KU11b9RPbyj6hevtkJdZPXWk2A1u/s1g7nUjqklh/Vep8LnfGKJCN
         oNbeLGByqkFS++9z1QckI7acDI0irs/jEHh2LwIrA9yEjkHAPHzkC5eSvsO9bWqJNdOL
         xoeqMggoMR/o8VivLorV1PQm9LMGAzOOjVAxK7ybIv1LRiwOsOR716GCWCy4RudW2crP
         ar+Luh7fTCmYe8xwX/TCpbs6/BjjV2TxCehK46sP3QaAKtDlY2VfMHJlWe637IgusfiF
         I41kIkeAbju5WlKo8FTBQUmR3iPcASWzJFPCPnsyrU/hwd0h6QgYbCXMr3CpZ1zfH5mb
         brYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDuJTca2eM3bh45/YoLHVUkkLnNirwQx036iwXzAmPw=;
        b=RQjXUnDe1umqyAppriX15dX14QsSRzt0qVNS/0ltKJca0zseukZjKe7o6OcHn7k6t5
         /tgdqynVA0VqawSKbWYLS4WmMHwVQiElcct9kH5Oz93emPY+vMP0Ye4bgZFYiv9CoSwg
         6ePXRryP9Q7kNCjnjjd2wVlqDUwmaCGlmXp2AL42IkB68NkDdzXsZw1Hv0WuIyCJRxfa
         vxD7+bSgFo19vuumFK0TrpHnKeSW1J9GJlsZ7m8O0B+bEMfpj3u5nOiNTeRVmWKd7s2U
         Fl15tmL4a03Mi0Lwex0oqEPkj5KtPCozckuj2zgpYr6JhRXEagOqhXtqKCCG1RLlyL8l
         Paxw==
X-Gm-Message-State: ANoB5pn32ActFqq67ph0ghFQQ2fioecEg5hhlGYrRdDtRkbtL+Z+Crsa
        S1fzuZZozvwuRDAo5NDc/JcIFTrOQfsv9TQt3Og=
X-Google-Smtp-Source: AA0mqf4qmXaX/hlN1dC1eeQV6+agK/EVtxXvrgRPmi5PVfyFgzLdiEefKGgbTgOC2yvXnMZZy2U2LjQJ/d9aEEpO5t4=
X-Received: by 2002:aca:1004:0:b0:350:d543:7554 with SMTP id
 4-20020aca1004000000b00350d5437554mr24346302oiq.251.1669540500902; Sun, 27
 Nov 2022 01:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20221124153934.12470-1-worldhello.net@gmail.com>
 <20221125095954.4826-3-worldhello.net@gmail.com> <xmqqlenxb5xv.fsf@gitster.g>
In-Reply-To: <xmqqlenxb5xv.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 17:14:49 +0800
Message-ID: <CANYiYbE3tyLBrCoDxVWPN_eWUesCYAmjzaFYj9CnjAUvuEO+wg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ci: remove the pipe after "p4 -V" to cache errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2022 at 8:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Subject: Re: [PATCH v4 2/4] ci: remove the pipe after "p4 -V" to cache errors
>
> "cache" -> "catch", I think.

oops, it's a typo. I used to copy and paste the commit log to MS word
or Apple pages to check for typos, but this step is very cumbersome,
and I always forget it.

I see this has been fixed in your tree, so there is no need to send v5.

--
Jiang Xin
