Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C7C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiATRzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiATRzq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:55:46 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47992C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:55:46 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k13-20020a65434d000000b00342d8eb46b4so4049404pgq.23
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+O1Dq4yuo0yI6WeinJPdMXkexXrKVM8upGQa3BiINJw=;
        b=kVxl7GvP+rdDoGdbh2Vs/Vr1OpgMIOOHI1u3a+MmBrQdo8cDr/COpC7vdYmGkDP3fx
         3NvhCKZmT5QN5ydRiQHEsi4zc2e3Vrs1Su3VyurqamscsAulGXcry7adkVazsvYNhURY
         TOzxYuQdb4RMM9yrsUopnEVbwB4sWxhgLf84/gsW3kPpdVVl7t/NXmzViNixf5zBmLKM
         Q3AT5wO0iAB42d/l71yb+/6WJa7N1NvfaE5acCZoyoelTkGgwdky2PwdAUc/PRsg20k3
         xZVXu8jaceQl0Hr920URnWYJLwILTBK9sDs5puMzb00c6yCzbRLqQthoaIryNNbO+EvS
         Uh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+O1Dq4yuo0yI6WeinJPdMXkexXrKVM8upGQa3BiINJw=;
        b=Yf1bRLckwoBJlsgfMj7yX7bwiKlVRPuj7lRDjXI8bhqxisDqPGBF6Q5DILezWf+OqY
         XBPEjvzfP3FhlcDPE8PhRqkEG/1JjtjvDeAYz5fPyVk3OCbx3DcvNWbfvDxh0Mp+2O1D
         HsbodA/NT8LHgKpPHi0O7KensMuHzofk6YMcavFnasuOVqgtyYhqX9xx994hWhf3M4b5
         rL9RW1DcvrbXXmYPZZzUXurEiAMAfVu567MtMWDaVCBt6hOEtFZFIF7wiopoQdddybda
         CY8643/Zbb4cHSxWJFAt/RjL3f8vv+PAE3Q1EQ3qKmgk0k/5GR6PFbYawhOf7Ts8pMc8
         42hw==
X-Gm-Message-State: AOAM530JsIfe67JQI2c3IBcwyG9xI0RlZCnkuU5Y5rfsbzDrtuiKgBVe
        uGFf10qNK2AxIlSFLBgH9yh7aGaWj9+m6pMjZPe5
X-Google-Smtp-Source: ABdhPJx8tPCJdKQU58sHZVCqcVD+bTREJNUguPugcPHcKBZ3QFXbE7iJ2Sp80NQr26AwcQMMbA6AOtvhwp7qbQVYNie+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:d312:: with SMTP id
 b18mr17077450pgg.440.1642701345750; Thu, 20 Jan 2022 09:55:45 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:55:41 -0800
In-Reply-To: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
Message-Id: <20220120175541.3099054-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: Re: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after permutation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> This patch demonstrates a cause of bitmap corruption that can occur when
> the contents of the multi-pack index does not change, but the underlying
> object order does.
> 
> In this example, we have a MIDX containing two packs, each with a
> distinct set of objects (pack A corresponds to the tree, blob, and
> commit from the first patch, and pack B corresponds to the second
> patch).
> 
> First, a MIDX is written where the 'A' pack is preferred. As expected,
> the bitmaps generated there are in-tact. But then, we generate an
> identical MIDX with a different object order: this time preferring pack
> 'B'.
> 
> Due to a bug which will be explained and fixed in the following commit,
> the MIDX is updated, but the .rev file is not, causing the .bitmap file
> to be read incorrectly. Specifically, the .bitmap file will contain
> correct data, but the auxiliary object order in the .rev file is stale,
> causing readers to get confused by reading the new bitmaps using the old
> object order.

Thanks - overall, this looks like a bug that needs to be fixed.

For the benefit of other reviewers, here's my summary of the problem:
the .midx, .rev, and .bitmap files are almost always generated together,
and it is possible for two different invocations of Git to generate the
same .midx but a different .rev and .bitmap. For example, when
generating a .midx+.rev+.bitmap for 2 disjoint packfiles, the 1st time
with one packfile as preferred and the 2nd time with the other packfile
as preferred. In .midx, packfiles are always ordered by lexicographical
order of their names, and the preferred status only matters when an
object is in multiple packfiles (which never happens in this case, since
the packfiles are disjoint). But the preferred status affects .rev and
.bitmap, because they use a concept called "pseudo-pack order" (see
pack-format.txt for more details) in which the preferred pack comes
first.

As an effort to ensure that Git reads coherent .midx, .rev, and .bitmap
files, both the .rev and .bitmap files are keyed on the checksum of the
.midx file. But the issue here is that a .rev and a .bitmap could both
refer to the same .midx checksum when the .rev and .bitmap files are not
coherent with respect to each other (e.g. when a Git process has written
the .rev, but not the .bitmap yet - but this would appear perfectly
ordinary to another concurrently running Git process, since the .midx
checksum in the .rev and .bitmap files match).

This problem is exacerbated by the fact that the .rev has its .midx
checksum in its filename, whereas the .bitmap has its .midx checksum in
its file contents. When generating .midx+.rev+.bitmap, it would write
the .bitmap but not the .rev, since a .rev of the same filename already
exists.

The solution is to embed the .rev in the .midx. This means that the
checksum stored in .bitmap takes into account the contents of what would
have been in .rev, solving the coherency issue. (There are other
solutions like storing the name of the preferred pack in .midx, but I
think that putting the contents of .rev in the .midx is best.)
