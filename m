Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhLGVzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbhLGVzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:55:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8131C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 13:51:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so1317596eds.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 13:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgZCYdX0lF7FCZ2DcppTHU/6VlICPiOmtJcKB75D/YI=;
        b=SMxSdiQ3quFsRofLZc2kCSI46k0bvK733e2IPRUxFKIc7JuM0GeKNtkgxH5Gqbdwnu
         WJvi7/AZsYLSHTovcujlURAMTuBiUpVM0iIl/4t4X2CC8a8c5K4CTqKmjTrm3Q6R4Tyr
         Uv5zSjDOdNsMh83PPkkcTU64TcHMOqK5/8nsix5zRxKkUb1HRErMrQ0WvTvHNqc2rCHJ
         HySqxyPYiY5uq/KhTOR4Jn/nne6W9OpsmP0bbaQl1eVP6zb0G69zf8ijsbN7QL42Zeez
         A8Ihq0EQ46SZxMXY92EGeKlRXXXP+Opaf/b5PQGuRz9zUZmRF4eknwiNUMYrHIEeZ2LI
         tsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgZCYdX0lF7FCZ2DcppTHU/6VlICPiOmtJcKB75D/YI=;
        b=IxBmtM84NvYdA2ucmj0QIrXYL1ejIcMnK4ZNHzocG3xx+0ftFhIBmkAe/CzV9C+vKN
         Z81/Lp/GORVMMkpbYSWCgtyZGnRukgqgxQRX9Seel7URYXxu6yxlzvCoYBXLZb5sl7qw
         fhtQjrL5rDkUmWXtPhHSzCkb4U+CpAO5J3MC41Q+TR9eyoZYcXaILCn0dD4CpAME78BX
         eA3U54AQFWlTBDowBKxXyRXhHmNvg0pkX/Lr4Xh+tEQlmm2hXCcJW80zdgnPNqLMzNyw
         7ri33fRsh6/yHwXr/19M7xb38NbrCkNMOO8GI4JqHTUywq9x2M5TOTLB3DAO5SfGYJ6k
         uW7Q==
X-Gm-Message-State: AOAM530yMHNRhko+wA9qO59Aqx16L8dY/rHGvwtQRWDuaFLJL0Uz97ab
        riFnpfSutVLX/Cw4QNbmB5oGrFzl+qEURobW7cU=
X-Google-Smtp-Source: ABdhPJwe2COio9+5unFdXyy7d5aQkdFanxK3e23gfgKBFVGHzoGUS3x0dSDdgiRFKfzv1RsdoPSnehZeDqSfVwvmkuQ=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr12940462edb.175.1638913896311;
 Tue, 07 Dec 2021 13:51:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 13:51:24 -0800
Message-ID: <CABPp-BF-xvJzfWO33p1ODtkLGMy2KENAbEu7KnrxPNq7UubbFg@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparse-checkout: fix segfault on malformed patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 12:02 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series fixes some issues with parsing sparse-checkout patterns when
> core.sparseCheckoutCone is enabled but the sparse-checkout file itself
> contains patterns that don't match the cone mode format.

I was only able to find what I think is a small typo in one of the
commits.  Everything else looks good to me.

> The first patch fixes a segfault first reported in [1]. The other two
> patches are from an earlier submission [2] that never got picked up and I
> lost track of. There was another patch involving 'git sparse-checkout init

Sorry for missing that series earlier.  Glad we've got some of them now.

> --cone' that isn't necessary, especially with Elijah doing some work in that
> space right now.
>
> [1] https://github.com/git-for-windows/git/issues/3498 [2]
> https://lore.kernel.org/git/pull.1043.git.1632160658.gitgitgadget@gmail.com
>
> Thanks, -Stolee
>
> Derrick Stolee (3):
>   sparse-checkout: fix segfault on malformed patterns
>   sparse-checkout: fix OOM error with mixed patterns
>   sparse-checkout: refuse to add to bad patterns
>
>  builtin/sparse-checkout.c          |  5 ++++-
>  dir.c                              |  5 +----
>  t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
>
> base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1069
> --
> gitgitgadget
