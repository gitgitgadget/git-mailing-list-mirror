Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47201C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLGBbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLGBbF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:31:05 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646B5131C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:31:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o189so5279220iof.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xhjAa1BAOHADj0w384UjcqYrwGRVFHU5lzveTKGkeo=;
        b=BMQJzKxuQ9MqG1nzjmiug60CwM+1Y/kURJ04Rjjo4DB7eldLDugfdLHuEfMlw7TTsH
         v5XtoaxnEnm1pdryKv9C9AX4fBewUENHnJBqWFs4pP6bk+r8TjzcJSPTLy7mJaAYk3Rr
         TKzoM0HWkbQuos+qOXCuowpStWiGmTf7Fw3X5XxB1XlxAZh60dIvIcq38V4seDuiGAGT
         suWZSzxGsr//NkOfmJt4E7XAZ/vCTHVTt9z3PNNvsEHD5sbWTv6sRg5Txhl52wurXi4F
         OwsUdvOcE77dye99qycAvCDKFSevYRdn8L8RUZq7V9htrtRVPje+YKcXVJKcBqzwtkJQ
         MguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xhjAa1BAOHADj0w384UjcqYrwGRVFHU5lzveTKGkeo=;
        b=rAOzA6YpGOjNn7iP2MFTfjLKEXIzH8jZ0+WHJ8PZKCEmoQ/g1pgKIyyrwYcuMInYGq
         hSfQwFNMDZJRfjpTdw7eVgqcBIPc7zptTGjiOcEj+WaVOBWpsUCQXSmqBez4ATpbSgq2
         8ZklnE/NvqyyA+dMa0zcNhR5ZsJ6sSr8VJSG9jPzKgF3bC+Bijv653sZ3rHxCF+OibbJ
         OIr0dJsfm8D2HBpEwOlHUQPMeWOGHWS6BOOQ2Nb8X74tZpNNZ21PwnGKzTb5zARCQ6m0
         5si8vbEjTp4DXgO8GNCCzABE7RksDov4ZE74/lJczmYidTbUtssPINsgKIMPOW58X7Tq
         Djvw==
X-Gm-Message-State: ANoB5plm+tF7XGLQRfyAhpYm28csnidhqvuUa1c89xUABwlWjafvXzIy
        0jIsUnv5YXJAgl5ea+589a1KZA==
X-Google-Smtp-Source: AA0mqf5iqzDT5ygklBCckN202IKabNT0kfzNaXIZDeXfr59pRs+a1oCCOJ6gF2toYBuC2zKHVoQNwA==
X-Received: by 2002:a02:3b56:0:b0:375:8878:9c80 with SMTP id i22-20020a023b56000000b0037588789c80mr38661796jaf.157.1670376663342;
        Tue, 06 Dec 2022 17:31:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a16-20020a027350000000b0038a08d5ac32sm6753525jae.31.2022.12.06.17.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:31:02 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:31:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y4/s1QcVFjjm31n7@nand.local>
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
 <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, Dec 06, 2022 at 03:07:47PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Learning the lesson to avoid shell scripting wherever possible, the Git
> for Windows project implemented a minimal replacement for
> `mingw_test_cmp` in the form of a `test-tool` subcommand that parses the
> input files line by line, ignoring line endings, and compares them.
> Essentially the same thing as `mingw_test_cmp`, but implemented in
> C instead of Bash. This solution served the Git for Windows project
> well, over years.
>
> However, when this solution was finally upstreamed, the conclusion was
> reached that a change to use `git diff --no-index` instead of
> `mingw_test_cmp` was more easily reviewed and hence should be used
> instead.
>
> The reason why this approach was not even considered in Git for Windows
> is that in 2007, there was already a motion on the table to use Git's
> own diff machinery to perform comparisons in Git's test suite, but it
> was dismissed in https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/
> as undesirable because tests might potentially succeed due to bugs in
> the diff machinery when they should not succeed, and those bugs could
> therefore hide regressions that the tests try to prevent.
>
> By the time Git for Windows' `mingw-test-cmp` in C was finally
> contributed to the Git mailing list, reviewers agreed that the diff
> machinery had matured enough and should be used instead.
>
> When the concern was raised that the diff machinery, due to its
> complexity, would perform substantially worse than the test helper
> originally implemented in the Git for Windows project, a test
> demonstrated that these performance differences are well lost within the
> 100+ minutes it takes to run Git's test suite on Windows.

Thanks for this update. I think these five paragraphs are an accurate
and helpful record of the history behind this patch and approach. It is
very much appreciated.

Thanks,
Taylor
