Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A5DC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 04:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiKKEjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 23:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKEjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 23:39:17 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413E6034B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 20:39:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q21so2883991iod.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 20:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCiRZVDPxDhVIaXwrHWJSlsMHUFBCTAEIjWKZc0HbE4=;
        b=Qp3ODJU5lv8fuXoFxw3kCG6FJKsYAoczPePVGNObEjrwVnnhPnX6BJUOCdwGt8a9Ah
         oLNh+DUqkGRpVZezariQDY7OUwkBRrjdQM61qsosjyQGsSrOVQ9xglYtfLVvnK9/xIP7
         +dXqzS/FNcAwpD1SvtDIndSW3+wo3ut0Bh+M5Ry7NVRS+QakHGrlL3kei0M6BaxwZpF3
         RGWp4f8rZIarlaaMf698cFkRq7veyQJiDX/2NqziGUwP3w52okYZwOYJnHfBiN0RWZ3y
         GpXjB/3Ne1a0FvkoUddnNnojpK1XsAQg12R0vA8oZjv2RZ5PD6bhc9vRG3haC2CFX1Ns
         rgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCiRZVDPxDhVIaXwrHWJSlsMHUFBCTAEIjWKZc0HbE4=;
        b=KFlLLBExF5ZgEmZm2HY2RugX5dftcjYlbPmdNPGaGUjNTSSrXgA33lhKzSxSdlAszi
         B6eNNXbmB893ZXa8S+BvKxZo4XR4/Uo+m/Bu+XwLlBOBEF0mk0QNaXfKbx1/0FOYozb/
         GGrCgoGVEgn67iLfidxxC19JJBu7BjYkpXeVZnPSqbJGzurqJQzzowkpHpvM1LgD4SFY
         R5YIFeB6cnDNRtM1jdg5668cH4CXmoz/BweJMA0zWsRT2c+w+myQfZ7YVwF+Jh1iICw+
         ejtM7vFWXGPFit66QBeKmYfD9t0fF0LYY29YdpndSey+RoPKTpXa41KUBngWfCi81sCM
         jyOw==
X-Gm-Message-State: ANoB5pl5EtImxDQm+F+++yZkI+VaXvEpZVrgVc0mTH4Yc1EY07Ilm8/b
        3xvqyWm3UD8oq1putb83AlesYecb63NW+A==
X-Google-Smtp-Source: AA0mqf4DtM5k2zAxnCwokrL92N9eid0sg2BGMaNBgUtvDM6C4W4EzqVq5CGERYbHJ7z73JqNtuDvFg==
X-Received: by 2002:a5d:80d4:0:b0:6bc:ebd:4df9 with SMTP id h20-20020a5d80d4000000b006bc0ebd4df9mr268731ior.84.1668141555936;
        Thu, 10 Nov 2022 20:39:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y16-20020a920910000000b002e85e8b8d1dsm538199ilg.5.2022.11.10.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:39:15 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:39:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] rebase: stricter label lookups
Message-ID: <Y23R7H7X/NEDR/0c@nand.local>
References: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 04:43:39PM +0000, Phillip Wood via GitGitGadget wrote:
> If a rebase label does not exist and a branch or tag named refs/rewritten/
> does exist it will use that instead of returning an error.
>
> Phillip Wood (2):
>   sequencer: unify label lookup
>   sequencer: tighten label lookups
>
>  sequencer.c              | 53 +++++++++++++++++++++-------------------
>  t/t3430-rebase-merges.sh | 17 +++++++++++++
>  2 files changed, 45 insertions(+), 25 deletions(-)

Both were a very pleasant read. Thanks for working on this, will queue.

Thanks,
Taylor
