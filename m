Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2332EC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiKPX1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKPX1X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:27:23 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F8532EB
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:27:22 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 11so208780iou.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+TvVdqAoCVNs6MH6jLBsxqb9f6JVJueSlsLsjvZ+7g=;
        b=CP00Vqyqt/+ZWSCfwRyRJz/JGs9wyoV1PjaoM4SaxgarFpNh62bUfDJaC3FlCwgZJL
         sQrCf6PPzz0MGob4hLdZlLl4i0hQtRzHiZc6j6iA8wsrl6MJKuqHpBt57xMBV1aionDW
         pw4XPWSKsm19j8hqDvsy5AeG9FIqVeUSS+ZPtVu3m/LmNcfULQjm6k7FoXchNFs3kgSD
         qZqrNUa2zMH6ESChkJ71PfYIGV3mXbbpIU/VursmpUOmzR/juyITQEfjhUjGldXmURgy
         ICh6qShrEu4DQWIQPc3lfhWUZxuABKm92VchBGe7psjJ6hOJDHnrLFro5EoKlK3HmBpi
         58Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+TvVdqAoCVNs6MH6jLBsxqb9f6JVJueSlsLsjvZ+7g=;
        b=UuSluN10HeKFAHfrQalzygyP3cBqFCWZ8o7xsUcn8dTXQQUA9riGfjjy9Zg3xUZgl3
         9omlLvXdgd+uavJFFkxEEY75ORIt7g15AaOP1UhHmGAeF1zAVgBdtd88AXXh7GtBqFRV
         ULYmtnDz/efTSuOk7wKrYcTnwTpANHKjq1+kFD8V2d0k/EiFrGQaaOar1nlNK3RTNjkm
         seC++RjHLHp/Aew9Mqrov5G6wkrDBcsVMque6GYj+m9gcrV2yNA+X/DlTClcsN0yqLhe
         b1QfLszflCfnn8LCDJ3O3ze3qUliAN/4iGg8O+GAtGPhYmvW0e1bYX2g3O+yYN3JoR+u
         i7QQ==
X-Gm-Message-State: ANoB5pm/1VVz9iuL+lRLEYHNIJCqm9LTTc2OaS4Qyrb6qJof1AfZi3pi
        eI5IfyWnLVlZ5hHpWFv2Sc/a8A==
X-Google-Smtp-Source: AA0mqf716gekOY/jBkRA20TWUlskJfMU92Rcqzw/5e9/rsYuew7LnVhW2cVkgvU5L0y4kspjyE1hTg==
X-Received: by 2002:a02:3b2d:0:b0:375:f558:f73c with SMTP id c45-20020a023b2d000000b00375f558f73cmr11817262jaa.299.1668641241465;
        Wed, 16 Nov 2022 15:27:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q23-20020a027b17000000b0034c12270863sm6289511jac.80.2022.11.16.15.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:27:20 -0800 (PST)
Date:   Wed, 16 Nov 2022 18:27:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v3 0/6] fsmonitor: Implement fsmonitor for Linux
Message-ID: <Y3Vx1wWYSCzAeXjB@nand.local>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Jeff Hostetler]

On Wed, Nov 16, 2022 at 11:23:33PM +0000, Eric DeCosta via GitGitGadget wrote:
> Eric DeCosta (6):
>   fsmonitor: prepare to share code between Mac OS and Linux
>   fsmonitor: determine if filesystem is local or remote
>   fsmonitor: implement filesystem change listener for Linux
>   fsmonitor: enable fsmonitor for Linux
>   fsmonitor: test updates
>   fsmonitor: update doc for Linux

Thanks, I picked these up. Let's add Jeff Hostetler (cc'd) to the chain
and see if he has any thoughts.

Thanks,
Taylor
