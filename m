Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E5C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDATdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDATdG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:33:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1B1A963
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:33:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so33143533lfv.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680377580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY+cRzmkgg46yk/5enO7jC6HgeeXaHDe4oJCp7I1keU=;
        b=egp++1ycIbezeyCQif7GBqYf8ghFRmD2SpnMYSBJmvXryeT+kiR8pOb6XafWff6ov9
         bFU8t5Xqh7/atYUBZDWqHbJ4RUxNlgIoF8CgTdDUJQpxQPK+VLGVw5Bu9LRJRxPr4fmZ
         Qk3k+xpBTKupjtfrru/fNb7pZ1PxGu+JT5zTNImqbOvdEJ/WAyy5NdN7fNxzuzaJsmJD
         /1xpIuN3mwTtISu1PHkEqS41Hg/rsWI2/bAUZZtMBiBJLyfsqY/mNMGxIMcpVKaTyE7v
         Z0cL1bEu2E1iIretI9HWX8iPwcl1obvm/oAChtZy6r3h2fL+ndVrfVAa4UfHyxmw8FWw
         ySRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY+cRzmkgg46yk/5enO7jC6HgeeXaHDe4oJCp7I1keU=;
        b=vpFMRHas9IRnC0MdY49mbmv+8He9IOcGJx+davRvHu3MFJZ4Rqpn8jMMtQWxBqmfiG
         JTHkYehW0bU27vqSb9sbGY930Vjzz6DgVMMjoQeJMvF9y04wWiSGSE4QhuT3y0f91PSe
         DNYs9yOxPKmqikrGQxbIvTJylmPBMPR89/rwHvyVl4zV8Ksqztjn6LBMjhTfPfYig0oz
         ZTeVERnvBdf7ySLoQHbh2AoQSYHGwupyMhSfBbptgZUWe73Y3JH7nBc3AO1IJlq3kHzP
         gAWxL8jeqEZEX1iLCF24T3+Z8uOp4diKZWQ4up+zAXATn74YOJwzNMNWB/AdlxqiR4C/
         Fc2A==
X-Gm-Message-State: AAQBX9cyjjecGm6nL6c51PPCyju6K04LjKaN/i8gdFKg3HZ++ndcTfkx
        dW6IswmOpriYDwXxaeXwU8e6bjj5HSWHcaqKe/pvq32v
X-Google-Smtp-Source: AKy350b+/wS4eEX+AklFzULByaZfjEGaGspethwduhBPtowglwLtbAccQC1QoRGmt3xTFOdYd4QM8oitYvigXxg3eg8=
X-Received: by 2002:ac2:596a:0:b0:4e8:6261:58c2 with SMTP id
 h10-20020ac2596a000000b004e8626158c2mr8964430lfp.7.1680377580154; Sat, 01 Apr
 2023 12:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 12:32:48 -0700
Message-ID: <CABPp-BHP1fp2-Dnc4O=yhDJq2-iNGAn7rJn0p_rhjYv2LaBOag@mail.gmail.com>
Subject: Re: [PATCH 0/4] rebase: cleanup merge strategy option handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 8:39=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Cleanup the handling of --strategy-option now that we no longer need
> to support "--preserve-merges" and properly quote the argument when
> saving it to disc.

Nice!  Thanks for taking the time to do these kinds of cleanups.
Overall the code looks pretty good, but I left a few
comments/questions on patches 3 & 4.
