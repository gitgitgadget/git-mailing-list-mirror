Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D14C2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B6522254
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdphvUAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761920AbgJXQGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761911AbgJXQGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 12:06:13 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EBC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 09:06:12 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u17so5868540oie.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2SvRkj0d4/RO8dBlUywoCy4F5Pt1aU1DQFAzkltjtA=;
        b=kdphvUArVZlpriJvjRY4THBzf/PS1E5kPOppevwa9ZwQdmJsx/QHg+6Tf1iqZ9iUcy
         N8D1KrIx9F4TlHo/qGi8WIyPx3WFHcXRdzNsZrqsuuK6yR+n0uX5CU9RQszBRdU3XzzH
         BEscHmu33sUn5DyBczdiYHKtlmHMMDxIbv3Wd6udCTG/PVYWkpWsQiMHTP6vug0Y9Er6
         6bjLkxDNnfzTx4uEdIIMPlkX9KPnrkF8NXolzGveznt44E1YEvmwIVFdrAznjQMGw7Ig
         iy302ZkuMmrQg1diSiMmcjfiF3NpKiQ3ZqUS73PVjfWysRVhzFoTY22S0kc1y64lOrbL
         cSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2SvRkj0d4/RO8dBlUywoCy4F5Pt1aU1DQFAzkltjtA=;
        b=pwC2EQI9xKlbNFrPQAr6ral9FfBkgMe3gLbbP5wZzF27iUrxq4trqx7lB9cqX6RkK2
         QQsTvvj81AGZKIMdGv+uUDkLX8kDUtkajTjPSKUgE9NLWxAL5ZgB97XLNTqMTwuPAbxi
         b+8t0efKgGG+9GL67ZFtZpvOBeqLTKigzEN7Y6qWkl1Y5gVY0oGtkkqHgFcdk/VZnlA8
         8bMDagjMUMBixWjBl0queZdafzP2ALs+4j9eOFrprkjXpLH81DNImPJoxIDBXZKGKkmH
         ibAZy1sAqCmtR5PLspuNrUNgAnI1ff1lkXGldrRCeUoZI3fAqQV0thZ7ebS0wrSeESI+
         ATyg==
X-Gm-Message-State: AOAM531LF7dKQP3eQUcL5NbPhwjayt8tp26r/wU4dnSBVCdoyvuJICnN
        nEQljmtwWmBCAQlimrzKmFTYBM4jqM+wwCLLRitWafItFM0=
X-Google-Smtp-Source: ABdhPJxR+wS/Ouv8WmmerPrx36mjmQm/S55lM2VGOUMRQzBSsINr20xPLKHRREXM4l894K/f1GzP2mn3QRw30DW+NGw=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr6691631oia.167.1603555571615;
 Sat, 24 Oct 2020 09:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com> <2aa44c1f13ac1fd70167770f7749611eadc396d4.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <2aa44c1f13ac1fd70167770f7749611eadc396d4.1603468885.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Oct 2020 09:06:00 -0700
Message-ID: <CABPp-BFuQ44O79OFGnNKLNNXi8d1f5AA5ApOkox4QrEocG7QrQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] merge tests: expect slight differences in output for
 recursive vs. ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 9:01 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
> index 6abe441ae3..b205b5619e 100755
> --- a/t/t7602-merge-octopus-many.sh
> +++ b/t/t7602-merge-octopus-many.sh
> @@ -77,6 +77,10 @@ Merge made by the 'recursive' strategy.
>  EOF
>
>  test_expect_success 'merge reduces irrelevant remote heads' '
> +       if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +       then
> +               sed -i'' s/recursive/ort/ expected
> +       fi &&
>         GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
>         test_i18ncmp expected actual
>  '

I've got a portability fix for this local hunk that I'll include along
with fixes for other feedback.  (I could have sworn I had this fixed
before I sent it out, but I guess I sent an older version somehow?)
