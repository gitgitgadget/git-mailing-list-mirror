Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2220C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKJCNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKJCM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:12:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212410056
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:12:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n191so266286iod.13
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzsehmJyNcWfHNUaoCbAnwf+zhc+lcgqMeDheuq/uGk=;
        b=FHc+CPT85uCOZLphonlF8PpQNbybBsPl3wIfk3ERmzDdfgdQpwgqe6XuYCn5V/gHSD
         oMGG56cS+TelYRWFOMRRp+HFp+DQrDLHQKhZjkL+sTnTb4nfy60cqqpmQ582+nM9HSnv
         QT2YCeg0Z4jFAws/r4U2M6fpEVvzdB91p5uuvAZdVkgrMaIU8Xlx3brnqiiSc2YLopU2
         CHuZqq1NvlH06sksw2tMQTS98HqLhADa8HikGyuZrBooeTMpW/eZUJ1ZT8e4LQntnvYd
         MS73gqSy8O4rMPq6lYjUgUkIG28Qh4h3x9CCL1nyp+ZDMxeDo/m+Tysab24Dj26iwa/s
         4/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzsehmJyNcWfHNUaoCbAnwf+zhc+lcgqMeDheuq/uGk=;
        b=zuGOwyC62+8JDkDYuvs/DTgYRDhsyoQOPTo5AVvbvUtLvRjYFsntVXxmSqDcbHy+gx
         g86m5KwVtSMoCOMrzBnR2qiHOkxFbfeqBEW2WWBZYGlqT+qBccgjuJDoD1IdCRkAAWf0
         pJ4QhE3V69Ahu843JKhkxVjR0jblhBYHq8XRNztKD2cUCLCYF85oyarelva8WhcrwBci
         2V69gkeYmKTfE5d+1a10QmM8LAndwbluAsKC8F9J/rYmhEja0zKNzp+KWksY3dK+sJU0
         lhtZNAQwVhO8qd9cisxEgICzcUnotaQZH36WiINHfnun5YEncXxqzfvOno19d6CAM15X
         FUeQ==
X-Gm-Message-State: ACrzQf19/REsdW3DMoqkrF2d/HznvovKWaFD3qHsUbTkn2YSZ8U914Qq
        Zu4EMFREady58OOtaJGlXxOM8g==
X-Google-Smtp-Source: AMsMyM7mHkDAF7MW93i4nSe/ba6I88ilB7Rd8he4qW2w40CmtzxPxIJdvQVx6aURhCZf6wGsNuDH3Q==
X-Received: by 2002:a02:340c:0:b0:375:b099:e48e with SMTP id x12-20020a02340c000000b00375b099e48emr2060458jae.319.1668046376440;
        Wed, 09 Nov 2022 18:12:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e020bef00b002eb5eb4f8f9sm5387039ilu.77.2022.11.09.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:12:56 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:12:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
Message-ID: <Y2xeJmkMVnn0tk5V@nand.local>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 01:57:12AM +0000, Victoria Dye via GitGitGadget wrote:
> Changes since V1
> ================
>
>  * Rewrote 'p0090' to more accurately and reliably test 'prime_cache_tree()'
>    vs. 'cache_tree_update()'.
>    * Moved iterative cache tree update out of C and into the shell tests (to
>      avoid potential runtime optimizations)
>    * Added a "control" test to document how much of the execution time is
>      startup overhead
>    * Added tests demonstrating performance in partially-invalid cache trees.
>  * Fixed the use of 'prime_cache_tree()' in 'test-tool cache-tree', changing
>    it from using the tree at HEAD to the current cache tree.

All seem very reasonable to me, and the range-diff matches what you say.

Let's hear from Stolee, who reviewed the first round, too, and then we
should feel comfortable to start merging this down.


Thanks,
Taylor
