Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99682EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjFNVgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFNVgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:36:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5F180
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:36:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25e836b733eso433483a91.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778573; x=1689370573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4NvuR5RZS/Cj1Q+Nze+CMUrcQPrdfNvX6vOkYFKj68=;
        b=hEwrw/ks4tze1yyQZKqLYMr+dIcheL1olYOYsun4GHUlNlB+P1DvBYOZ6i/fG6NMFB
         gptMNH27wk2c9SparNMHl3QmZzjqvRiylFu7fWRwLDWbrBmfimvohZ7ZzHlH8jCm1bLV
         qBW+sj2lL33LKtHVSBoxq7I+X841ZCrjiAOplteJHXGZNHj45f9vv1YNYfWBc3PIozqc
         95mM8E/Cowh1krjin+TruAWk0XENL/o0s4EwjCuF8btrgtnfp22XyDIOv8YcEh6PyfWi
         H7r99i9WT5B3OEyVmu+DEu3tGccePqTZu6LZ8PLq5af9+VECWhfgtIVjKzEx2Z8Iik6S
         4slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778573; x=1689370573;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a4NvuR5RZS/Cj1Q+Nze+CMUrcQPrdfNvX6vOkYFKj68=;
        b=kwE/x5IRUNumEa7jBZn68vcy1lWSTRUgoNiqKFq1yiwDod7gxSTFuM+YkvfJL6wIph
         V95L90yPcGFZu9pJVVvIDSrowuHBSAcy9ivV3nUxwdANA89mZJ5njrIZyL3Lc0lyKXrA
         2T3huVxy3cf7RVcG03D+jL5t6kSaMn8/GDLuMXSdjmCJaSeVGJg98VEQ2yhvMC7viI5r
         aBoyIW+NJy64ikK+JxF0umycz1Mufma7+8GxtalrHoDAQG64E6LITSt5ciIJlvq4wwbR
         dlcDttCMS1DoH8SSraQeTIy8L6iOKAOociVFr2tIciwOWko7+os8bYoL5J9o6Lyi9N3m
         2FnA==
X-Gm-Message-State: AC+VfDzAiJGq7Kt1cMAC2uKkHweutHQz8o4o38Rt+z/NxM/PbZ1oEyha
        WpyAZOf7dVQuJslz9dQA/kY=
X-Google-Smtp-Source: ACHHUZ6ZjeuufuB84XwPt3Imbcm4wXs6ShsKCS0DE8455or+YumhNnqAC7P2WSekivqH7VKW9BC3nQ==
X-Received: by 2002:a17:90a:19c1:b0:25b:bcba:1496 with SMTP id 1-20020a17090a19c100b0025bbcba1496mr2117571pjj.18.1686778572962;
        Wed, 14 Jun 2023 14:36:12 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b0025c03008555sm4766228pjh.4.2023.06.14.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:36:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/9] Repack objects into separate packfiles based on a
 filter
References: <20230614192541.1599256-1-christian.couder@gmail.com>
Date:   Wed, 14 Jun 2023 14:36:12 -0700
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:32 +0200")
Message-ID: <xmqqsfatwwtv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In some discussions, it was mentioned that such a feature, or a
> similar feature in `git gc`, or in a new standalone command (perhaps
> called `git prune-filtered`), should put the filtered out objects into
> a new packfile instead of deleting them.
>
> Recently there were internal discussions at GitLab about either moving
> blobs from inactive repos onto cheaper storage, or moving large blobs
> onto cheaper storage. This lead us to rethink at repacking using a
> filter, but moving the filtered out objects into a separate packfile
> instead of deleting them.
>
> So here is a new patch series doing that while implementing the
> `--filter=<filter-spec>` option in `git repack`.

Very interesting idea, indeed, and would be very useful.
Thanks.

