Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC5C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLGWYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGWYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:24:22 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223EC1F2DE
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:24:21 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o13so8487575ilc.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIS+hcbeZuPAoSbGiFepuJe4MQQ+FfR7bDT52EkPo5Y=;
        b=V/Xk20MzvTo1hgc44o9scObAIwB8oung0zpBflZ41yoDg0SJJmSzVH22shJ0/KBWwC
         Aub7ntXpwKsbCp/dip0f7WIod/9Y1a9ssZxTnYXpTIHpTEMzS4ATmnmrpqHgubE94Keq
         plEF58FxXbw+a0Hu88E6EClE/zELwmKPx1tyVd0y5IkpE9R9/EgkxDgHU5iSefWjl2Jm
         kh9RUs1Gn4Wmow89MO1au51QTToy6w4eEtZYxv9g3ZPV18YEhuO7w4bQqsnfJ7sRQy1e
         H8FmbyTCKCpW8NCJOp3By4WkxpaWObYBTg8JWZIS8QNmV9EUTOp/gy3jP1o+5I+HyKP8
         6r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIS+hcbeZuPAoSbGiFepuJe4MQQ+FfR7bDT52EkPo5Y=;
        b=b6q8DNDYvJ46ZNPu6U/E97XV8Eh7nK29GMAYouynFaBTLxZYGbbReOZcif0bxlPMKL
         mhuYakkQwE7I9o14VR2b51JJA1AY19oggnxMhJ1JO8TjijWOPhsxO5SVJ3MZ4/ILEmFC
         5rkOpEgrzN6ViaBr+cLRRLhh2JW9gBULGQuMOq+DEAvLhCVKkjIXzrEmS5/+Mf3R+Dnt
         d7E4Zm45n5+09CiDTJ5s+jGZBbZu0KaQy739d8SDmkAhK6RLSywsSqMfQEe/cVElXfq0
         4bCBBc+/Oni8bQd7FtHZS9qnoSE5RWQseQ+r4m0rAiFt4T8Qrl8MTQYkYct19hEWps7R
         OjiA==
X-Gm-Message-State: ANoB5pkrQP2MQXLgV/8/oausYL061ZLWlIB/P/tiVeB85AU3PZte/oEb
        kUtyUrJ8gddoZZgGlaXiTBQ8Lw==
X-Google-Smtp-Source: AA0mqf6A2i9YCmW6JBmO9W2BP2YFWSwTJ/r7oCAUlmzkudTUdZw83aDyxcC3asnbYNBlw6DgOX/rsg==
X-Received: by 2002:a92:d28f:0:b0:303:5d8e:5bcf with SMTP id p15-20020a92d28f000000b003035d8e5bcfmr611969ilp.29.1670451860462;
        Wed, 07 Dec 2022 14:24:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z15-20020a92da0f000000b00300f4e0d41bsm222774ilm.57.2022.12.07.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:24:19 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:24:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] ci: avoid deprecated `set-output` workflow command
Message-ID: <Y5ESknffj5iWF0IY@nand.local>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
 <1693393443975bc25f3020e61a29944804e35601.1670423680.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693393443975bc25f3020e61a29944804e35601.1670423680.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 02:34:38PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Due to security concerns, this command was deprecated and we need to
> write into `$GITHUB_OUTPUT` instead. For more details, see
> https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

OK, this one and [1] are pretty similar. I don't have a strong
preference between one or the other, though I suspect it will be easier
for the maintainer to pick them all up from the same series.

So in that sense I guess I have a slight preference for this one, though
I admit to not feeling very strongly about it ;-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com/
