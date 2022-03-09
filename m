Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EAAC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 10:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiCIKBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 05:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiCIKB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 05:01:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3416F97C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 02:00:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z16so1808248pfh.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/k4oMO7P/c9uwuxCQ9YV8n9+Vk2m0Uo7EFL42JLqQY=;
        b=g2h3io+HhjhC7D94rl1zjdOSEvjliSJqe+F5ogQkiF9HOpNRQ4MJR3gqEKhdiHHaty
         aNv/rpV94a8fDVdEIOmSCpHr8YNaaP8CfX6mrxLbGzoFNfAcrPeRCzgxCtxtd+jEUHC1
         hokyiu5sh/BKrnLVnvlTobAJSckirN1pzTUjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/k4oMO7P/c9uwuxCQ9YV8n9+Vk2m0Uo7EFL42JLqQY=;
        b=OGlAbmnJhk2wttK2otBJ7Wf1fzgElZM1aqznllycHv9FEZxEWJpLVnBmM9s1XWpAUT
         OYjcg6Va1IGrkUDDORqRAYGWR9/5iW39xoWwUvZciLjTs7AmPESHVLK91NeBAl8l2jiy
         dRFUtTFBlsp2HBdeO1pFLe6fa4Qepss4VwRIMVqJZ//8Vi2iUvsRJR+GxglZOgsPxV8C
         IDpMCCAEj8WoLkXJAyKf0+GROF8Y3XG69lim9ID1dtHHY4ZOLORnzuSeBs6NTo1OI/2B
         k8E2Y71l3zU0Sq2vhJgVfKtz4CYU3HjiVfKg/9ZUfn8ZGS0zotLqNrf1GTx6T1zO3UJh
         UJYw==
X-Gm-Message-State: AOAM5319ZXztIgJNX4Bdky9Kwol/HmGJIdO9EPI7Cdk9Trdd+4i1XspR
        hKLfMU/RhNdNHIsvbw183kkosng7RS08BOfqxmukJijFHFPvIAhQ
X-Google-Smtp-Source: ABdhPJz22SfB2dxIJ4U7p9EasStrmj8LiCJZaluRLx9XGOtE98hHXjWnf4xFDizWXhTwHrEI6vwrQVcKDdoXRpfAnO8=
X-Received: by 2002:a63:28d:0:b0:365:8e16:5c19 with SMTP id
 135-20020a63028d000000b003658e165c19mr17948357pgc.579.1646820028116; Wed, 09
 Mar 2022 02:00:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
 <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com> <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
 <xmqqa6e51kms.fsf@gitster.g> <CACf-nVfEt8xWgg-d8JmtSD09Mvp=YvshN=cfMQ=304--h5Rjcg@mail.gmail.com>
 <xmqq4k49u0za.fsf@gitster.g>
In-Reply-To: <xmqq4k49u0za.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 9 Mar 2022 10:00:17 +0000
Message-ID: <CACf-nVdER0KGsaBPdcxbM6njy4ek8Ww0cW8KDLOd=bYih7VF8w@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] fetch: add --refetch option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Mar 2022 at 17:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> You may (or may not --- I didn't look) find options that need to be
> OPT_BOOL() other than "unshallow" one.
>
> While it would be excellent to add a separate "preliminary clean-up"
> step before you add OPT_BOOL("refetch") to fix them to use
> OPT_BOOL() instead of OPT_SET_INT(), that will add extra review
> cycles to the series by extending the scope of it.
>
> It is OK to leave them, in addition to the new one you are adding,
> to use the old and a bit incorrect pattern, as long as you leave a
> prominent note that we need to clean them up later.

I think for this series I will just do a re-roll updating refetch to
use OPT_BOOL, and I can do a separate series to look for other
existing booleans using OPT_SET_INT.

Rob :)
