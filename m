Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D83C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiAXNsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 08:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiAXNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 08:48:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9FC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 05:48:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z19so12715266lfq.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xC7062mb1ZQWhSTe56vzu6LeTjP0awH7KSaaGUWW2vA=;
        b=MHj4KVeF+L0nU1/quDWfHkYPrbJ3hL7NpcU3p/r09c+Mx79mw8xTiul88tTF/0OIRQ
         O2IV++gAP+I8VMyIzqpOM7Am5HjUNZL2mmCpu+Ed5mgaGX0iDPJ8+WNR82O0oiNx3iHj
         42o6LF/7EZ032CJWtP9LJ0VrsMEqUbbcQNUcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC7062mb1ZQWhSTe56vzu6LeTjP0awH7KSaaGUWW2vA=;
        b=4u5+z2NmvDP1QZQDGMRGJ42BqaHT/yve//T0BEkrTQYzba6HfMx315wbtF2gTEbU9T
         P9NKi2f72cEQYXaKI35m+z+Mo0L29Y5U1FclNBLrAGE+X0KnXtdURNoZSpecqsZFxLxC
         wL+ZLYEpztavmqUDri+XLycSdAWcsbEKgzPd3w3wE8QzXd08XAk2WlwcF+oQ3yOhlKom
         DYH4z8UmVbABlzTy138ZcHz7wr04Pdc9raArqEcxe9g6PlDm9rXKus4rDnFJjKed/V7M
         QGi60glxpQ7LxBsg1gBf5Ga8YjHsnDQYR46gy47wlSjwnccfTLB6ZkAr+KMV93xS06lh
         /i0w==
X-Gm-Message-State: AOAM533I0yovLC8Hk9Li8f0ypDHjk/wnfgZMWa2Mmw+ELnexoxLB0IKu
        8CkLTFn42pkda6HyA2B/fGhcd3ZqHvMHf5+g0q5gJGySySsLYBYu
X-Google-Smtp-Source: ABdhPJyy5Bi1M0ZKFoRuIC7ea6hmdivN3OQVhPQIYCDHcb7ZeW62HPW/gnTz8cSd1Dn/dPbiMk+yxTikcCATxCrbn/8=
X-Received: by 2002:a05:6512:ba0:: with SMTP id b32mr3806849lfv.122.1643032123999;
 Mon, 24 Jan 2022 05:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
 <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net> <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
In-Reply-To: <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Mon, 24 Jan 2022 10:48:27 -0300
Message-ID: <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I now believe this is a bug in Git because calling `git status` fixes
the problem.

1) Create a hard link to a file in a Git repo.
2) Call `git status`.
3) Call `git reset --hard`.

Without 2), Git severs the hard link. With 2), the hard link is preserved.

Reproduction steps ("Test script") and further info:
https://github.com/brave/brave-browser/issues/20316#issuecomment-1020054082

This occurs for me on Debian 10 & 11, as well as Git 2.30.2 and 2.20.1.
