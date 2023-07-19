Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E46EB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 10:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGSJ7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGSJ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 05:59:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F0EC
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 02:59:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-577ddda6ab1so9745227b3.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689760766; x=1692352766;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RK/GJWS2V8ee8m2Zt+YH47u1GLx8ulBWTgfyI7DiIN4=;
        b=m2pksYQ7Yo6JIdoITNRfA83o1aQIKvcicZZhNFf58uDoPDfABm9M7ZyMezc/ibRYQl
         NP0niesfNDDh3F1VUjo0MjIFZ+VnJKWZY4BLrA/dROks84NXSKEX0/VFVn1BrjJoa3Ii
         49gN7MlfB27t/jc3nYaqyRM97I2z3KFdUoQnQRlpPXcMmq2z1voDUbg8zHkFCSJMA0n/
         Uxbi1udZb30Zf//i349mX3gtQ5VGJL0QkdogskMiIVGZyLFx+0BNpK9RgagMVcgTQrHo
         EdQjZTp4K0Yac1xWu9CRLK7iUwYB9CwojKzB3TDqwhB7UsMTFBhvMeeJ4zIRHH+Mu7wa
         9yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760766; x=1692352766;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK/GJWS2V8ee8m2Zt+YH47u1GLx8ulBWTgfyI7DiIN4=;
        b=RwH8rWaWB7aXXz9YDjV4+P9HHlYg10DEClYjBIr4Y4K5GgLNnFpWzSk+hYP/kaMBrB
         CaPOn3koBmSONlsRLpIRdN4aWzdb1eNtMMuD7REmWHKQ4YSNYRsPuwckyODdRJgihPiG
         8GC0ungbkII/QzGKEopbaYV1DCLz8DqiRaVRqfVpZwrsQOI2aZuxaeV1gbTDnZBJd5cg
         ftX4nCTazP6OwHlzW9cnRIQQ/XpdDSETHhw5D6e+2Sn4PDDZp6lSqjRSN9XFX8Be6/K0
         FjsNK4aTBSKSm8/orucOFn6S6u/q1u9PxXkTvxGYkyDukdzRBpo+cHfeapUNplg/5QcX
         g7gw==
X-Gm-Message-State: ABy/qLb3bjpG1fCpCBVxXaBtPPsDmNWtKtQw0fLPAj1cS+szMOKv3yah
        U5WEHtKAt47rp15VmJ3atuWt0vDmtgKxprvGAvEGwJdgvcWhqXSZ
X-Google-Smtp-Source: APBJJlGiZcG0VRHhg9t19sndp0O07YHedClVVVRQMuXNKNAPuPH5Pbd3NvBcjuNkrtXd039qbPvUXt0Li5JZRcRynL8=
X-Received: by 2002:a0d:eb91:0:b0:56d:1563:5b28 with SMTP id
 u139-20020a0deb91000000b0056d15635b28mr1686301ywe.11.1689760766327; Wed, 19
 Jul 2023 02:59:26 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 19 Jul 2023 17:59:15 +0800
Message-ID: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
Subject: [QUESTION] how to diff one blob with nothing
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I want to diff two blobs right now, and one of them
may be empty, so I tried using
0000000000000000000000000000000000000000 or
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 (empty blobID)
to test its effect, and the result I found was:

git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
0000000000000000000000000000000000000000
fatal: bad object 0000000000000000000000000000000000000000

git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
fatal: bad object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

Since the "empty object" has not been created, the
git diff operation fails.

There may be some other methods [1] available to diff
two blobs by creating an empty blob, but I don't want to
create this empty blob, are there any other ways to solve
this problem?

[1]: https://stackoverflow.com/questions/14564034/creating-a-git-diff-from-nothing
