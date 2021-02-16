Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E83C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA55C64E63
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhBPSNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBPSNi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:13:38 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BA0C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:12:58 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z6so6664164pfq.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/7mHOgQeft/oD5vpDKi4+Xn3W2VN7JhVUavaEoMUzJs=;
        b=Tw5Rb+zB5a+7LgYZEaBXU3d1njxjzuvVltaZzgtXp6GMvWSY/qdse0gBA3IhN6lDjC
         BmR49TkeKahFLoLcC4C6xu2/fdUri9It8GFKPLrBrUoc0B2nCNLQkkHZjZlPCUjgju1L
         L6ORSte+hc286vOFzvpB2E8o4rNasHUx1MC25tQLmipuXG1sPg45DQfytLNkMMNYGttQ
         zrkLRio4SvU42DU8ebRyWfj/LRn7HRj3wKO6bcC8RgZZ2JlnxdS/EW+p1B4yxFX1R4hF
         ywObbu1LeNMt1XCrnlVntWDFxQufxPZ63Yg91OHUyD9tgq/CUFfyQPVom5Dhu2J2zXzX
         HAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/7mHOgQeft/oD5vpDKi4+Xn3W2VN7JhVUavaEoMUzJs=;
        b=ZdH9vyxdBMYWCSq5fHGCPKtSbcgjtHQ1DbF5YP1qUhqeVn5wEcu6C5BAHiT7eXybb7
         RB57tqm41PLe4B98Pjw3oZiWqnFC0K6ijz4jFoKoOUIfVM3EJOS+aRcrgSjTDvM6TKwV
         7t9430+aK9/VYFm4djRgtXix/xle7jZ3zm/K13kJKPPT0jitxmmDgoGuYyXeiGQqYO8T
         RDc3ZmO3d4d8lSKriGq2mS6znMpZ9yxmXeCw/P9jZE89YOFZX5AAth04CPiR3xI+UcCe
         B+wI9ngcAo2kCEx8HP2fwcrP0MR+uIPaVHeIOdfhA9PX62J48emHVtiBvfYi7s8MyNa5
         iQsQ==
X-Gm-Message-State: AOAM532L0M0/vM++dYVpGPpCzeTVlEQZI+GaUZGA3SS4EqJbxWrXp67K
        GqlI1WP2+0yzWdkq0Hy+OCc=
X-Google-Smtp-Source: ABdhPJygNuJOeJ94qDk1yv8XTihACI4sLvaCy6oysJiA2/9o2n9fKWzXhYbeXD56pgtKk/0ThEuOZw==
X-Received: by 2002:a63:560a:: with SMTP id k10mr20439309pgb.132.1613499177973;
        Tue, 16 Feb 2021 10:12:57 -0800 (PST)
Received: from [192.168.206.101] ([106.195.44.107])
        by smtp.gmail.com with ESMTPSA id z12sm3441728pjz.16.2021.02.16.10.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 10:12:57 -0800 (PST)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Git in GSoC 2021 ?
Message-ID: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
Date:   Tue, 16 Feb 2021 23:42:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Excuse my curiosity. I'm not sure if there has been discussion about
Git's participation in GSoC 2021 but my search in the archives
didn't get me anything. The deadline for Org application seems
to be around the corner (this Friday, Feb 19th at 1900 UTC).

So, I was curious to know if we've already applied to participate
in GSoC 2021 (or) if we're planning to participate?

In case we're participating we'll need ideas that fit the new
structure of GSoC 2021. Concise entry about the new structure
from Rev News 68 [1]:

  Google Summer of Code 2021 has been announced with significant
  changes compared to previous editions. Notably coding hours and
  period will be reduced from 350 hours and 12 weeks to 175 hours
  and 10 weeks; there would be 2 evaluations (instead of 3).
  Additionally, eligibility requirements will be relaxed, among
  others allowing people participating in a variety of different
  licensed academic programs, not just students of accredited
  university programs.

See the related blog [2] for detailed information.

Speaking of GSoC, unlike last year I'll not be able to actively
co-mentor this year due to certain circumstances in my family.
I'll be able to help passively, though.

Also, one thing about project ideas. Shourya Shukla who worked
last year on the builtin conversion of `git submodule` 
(currently stalled [3]) has told me privately that he isn't
interested in continuing the port further. So, finishing the
port of `git submodule` could be a nice project for GSoC 2021.
I believe it would fit the new GSoC structure but I might be wrong.


[[ References ]]

[1]: https://git.github.io/rev_news/2020/10/30/edition-68/

[2]: https://opensource.googleblog.com/2020/10/google-summer-of-code-2021-is-bringing.html

[3]: https://public-inbox.org/git/20201214231939.644175-1-periperidip@gmail.com/

-- 
Sivaraam
