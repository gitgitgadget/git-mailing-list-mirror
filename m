Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE6C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiBVTuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBVTuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 14:50:11 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59460B6D09
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:49:45 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m185so21636128iof.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IA77Jw9LfDj8eI3+Ev5imfNrNAkzTdq/bQHm2s01umo=;
        b=3F8QqGpvd8TRdgXzZWu7CJuN8Oxmqq1/pHutrGV+6d9v2l5D+QANIpwGMU1FRN6Ho0
         lwV+1xKPzDciyxC278PHT5WDaUAMbFKii0kL0phC+JIDJzj89NudjG9J6Bfoj+ueloqv
         Arg2UgNfnmgelouOy4vFB2Lx1eimYufNIlLyeuGk7qTP1MDYU2JaN/PiZwoM5XJApmsJ
         cu5xrdfBbdoWZIMzNQLcWLKjEMrNSHSa0+IMbH+NjJ3o0lZX08FOy0gBdajzE5/0sEgn
         Ft4SxcUmDkVY5LraOTXtMtEKkTkkYAvznBYLpzFZbPh0HlZNyAbq04A2FWpNXx6GrgQF
         5HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IA77Jw9LfDj8eI3+Ev5imfNrNAkzTdq/bQHm2s01umo=;
        b=kG9nR+LBj3BaMa7mBJG2g8JlSqN1rZr3KvUkNfuQyzX6syOTC9GWjncxrXim3LqcDF
         e6KzZwzqoqANF+HkXw19o+JyDdcCcoiWfMi9+hzwv/ZC8mui9tndLyyS8lBoHa3DgvpL
         /aR09T2g4SmJvGifPkVxWG7SX896y7HL1Qdgxk0568XUIfi5Q7tKpl5B7sUWJhiccpYd
         rFjxdanmsc95/HmN9tB7aAt0cfmZzFlSMmhszuhK7FdiFM84e/6hLiXol4JgcLZrkZO3
         LxMR1k0Qkap/sojdN4Q5nOy+upJJ5JbdS7Fdca2YKHNscE+i8hEFm/KEm0qm7BGltSwl
         5rkQ==
X-Gm-Message-State: AOAM531nTKAc53MB9m7Md1auShYMek93BcaQ/muuqGTo5KKyqtLYR3Pl
        fN3SUJ7pMuw9ZkAvOR4oPE4mcA==
X-Google-Smtp-Source: ABdhPJw7IYaHmcUrybrFygjmJICktan3+VSngiihZBNopyCqfBekZc7xzFWZk3alLwRIcM0CvKuyNA==
X-Received: by 2002:a5d:87c5:0:b0:610:1e57:152a with SMTP id q5-20020a5d87c5000000b006101e57152amr20823664ios.43.1645559384734;
        Tue, 22 Feb 2022 11:49:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x11sm360199ilg.22.2022.02.22.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:49:44 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:49:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com,
        newren@gmail.com, jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 08/11] worktree: use 'worktree' over 'working tree'
Message-ID: <YhU+V+k/tp5B+NEP@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
 <65a0cd527118578c98a6862460caa86ecb49735a.1645489080.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65a0cd527118578c98a6862460caa86ecb49735a.1645489080.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 12:17:57AM +0000, Derrick Stolee via GitGitGadget wrote:
> Helped-by: Taylor Blau <m3@ttaylorr.com>

One more small fixup, this should be: s/m3/me.

Thanks,
Taylor
