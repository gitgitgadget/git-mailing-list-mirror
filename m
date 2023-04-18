Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27BC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 15:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjDRPXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjDRPXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 11:23:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F912C9C
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:23:20 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fe3cd445aso156506937b3.5
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681831399; x=1684423399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPUgPDukzVuPElK1MbLKqMgDvsnX3KApHNe3lnKbnKQ=;
        b=WVsyUtFiotwaeWdLG7WvSfHXnUgt7HXAaKR8A1yE3wBYCVy1DBVQzsVouuK94x+UCw
         gtfmqzma0ABiwIx1Da3x0TWheqqF/igR10uh8v4zLXSUJ9D5WoiMiSdqzOhzIsGT2Pjq
         6skJKWMnlMvkjTIwZpxRUxjABX5yvwPWngWie6r2Odw0EmNnnLdUmYbzjVV1F0JIlwAn
         NAqEJywgtuVlZhWvJLR9lmODIwqsuaUI12wCN5CpNgZ2rPkjA4HVgDfa9P4I9VlbB19S
         zJxXw5x2YP2MURyQGHVIiHrDt91QmOthMbFLdphF0MT/QPMlPWnusZSrQh8cbKNLvJ5m
         5D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831399; x=1684423399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPUgPDukzVuPElK1MbLKqMgDvsnX3KApHNe3lnKbnKQ=;
        b=hfHK5N9F3kFLoLyA0ua5QFJoKcOQQVoM//6GYpIx4csgn1ylbQmlab3Wq9lTU05Eao
         ulkVlRWh+Z/ZvPwSD/39+xBu+1rBu1Yl3nWOWQewHi7kEPkpsCwWWa46aMcTXmR2gwkD
         xLt0cEZ/ShhSbybqPd4ICwvjt5wGpXWz69S6nixd3kie9eQPNFCQvXSmcbqInHJlkWVH
         Mn2vs3XF4PqW11KyJRX5GoJB6KPGtvTuyjCMbP1sRQpNnYkiHIfc3Cj+FN72EGi6Ukdt
         J/DfmL794tSxHYRzAoGfBGZjR2QPjjbUcaBnPlqKV67sRcq7JZpabcvEZQCzwyIBOaam
         jAlA==
X-Gm-Message-State: AAQBX9dDYVjES02hjkXb7LrZ8K92x7rg+1yuExC5aplk7Alb1zy2+YMb
        zj5fbLnkC+du5vNpzuTS1roXh7Wy9OhqfMq4JKjPsQ==
X-Google-Smtp-Source: AKy350ZhRWhdnpMmUE8ukdDSOvtt4sv4V5lRqbeKFrYNTa9CWBeI6TBlKQTccrKZ/Hs0TK3blYjMww==
X-Received: by 2002:a81:494d:0:b0:54f:855e:c447 with SMTP id w74-20020a81494d000000b0054f855ec447mr196402ywa.38.1681831398107;
        Tue, 18 Apr 2023 08:23:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d63-20020a814f42000000b0054f8b7b8514sm3892279ywb.128.2023.04.18.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:23:17 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:23:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] git fsck: check pack rev-index files
Message-ID: <ZD615MLzKVwk1jVT@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:21:37PM +0000, Derrick Stolee via GitGitGadget wrote:
>  builtin/fsck.c           | 36 +++++++++++++++++++
>  pack-bitmap.c            |  4 +--
>  pack-revindex.c          | 43 +++++++++++++++++++++--
>  pack-revindex.h          | 16 +++++++++
>  t/t5325-reverse-index.sh | 74 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 4 deletions(-)

I gave this a thorough look and it all looks good to me.

I left a couple of minor comments throughout, e.g., s/set up/setup, and
replacing 'wc -c' with 'test_file_size', but I doubt either of those are
a big enough deal to merit a reroll.

So I'd be happy to see this start moving forward as-is. I think that the
topic it depends on, tb/pack-revindex-on-disk is similarly ready for
merging.

Thanks,
Taylor
