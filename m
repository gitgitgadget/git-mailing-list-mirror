Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F58C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FBB206DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iEoWmQat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNUHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHNUHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:07:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312CC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:07:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s23so7846126qtq.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tUr87KK53nz9WWCMbuzK3iEGVhj5aiDib3SgmIUL29s=;
        b=iEoWmQatz+qndOqs2ByHRRdE8Uucbi9C6sDvoQJ3INxHzCMVAmSDPYiP/7oXak0Asa
         pZRQdxyIN808vyShW+i03VQmp9zu52ju6/nWT54/7p+R2xN1iY+UcSiqAh0TsX7hKTsE
         rbP3/5OQ8BTBvr/jO8ayAdgLDTUqBUbCZsE6ZafZsP0QCptE8p5rf80b/tH1sFIeOviF
         4Y7rBNKshd+8tGv/l5oONj3f5cvym7FpNX0XL4hkLflZnHz6JacHQv5ryEiv3YJ+MlJc
         /MuyqUk/P8yGAONbVZJGRvMKA+72DEZTw6awcHukVva/6eEVpCWdZW0+XzSqcWA1uTsl
         EOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUr87KK53nz9WWCMbuzK3iEGVhj5aiDib3SgmIUL29s=;
        b=uKMLZD4WXgoE/z/txm/hoKaWkUj7cvsHVUEuRkwxS9KD+gkkegdsG2H+DF8K4DWIqE
         /22tmydKN6DdSKxxehxf6HOzQGDoIXfe7h3OakRE6aS9SNHzZwWsp6SjO+2FvV/1IsfL
         JDbkkCHqTZNEx6n9futPV/7oX34xpL/yBvFQQPUxP4KAVI1QuSrEhJgfMLdZD1cazvAS
         oznpz2CdjxHIB3Sao+lR2RzSi9totShftkOp1lxs4kFC5gHqYNgEgSUKbEXy2B0j+FdM
         jwNw45n73RE0Bqlug+EP26cPW67iflWvyb5M0qKq/47wzCyccZZrvEhGVtwWeTS8D0Rx
         aedg==
X-Gm-Message-State: AOAM531qEnWpGRQ69xYZGbwS52ratK7UsNiBEc5oSTI0XJrYx9usUqKB
        TUSN/rZes9Ile25THZZ3alkNS/mymcKkzRWR
X-Google-Smtp-Source: ABdhPJw8XJL1sgtOm+TSzqELtxiR4/zt3eu5IFO4ng8nrZdFILs0rUV6y8FR0fkhSIB8zzGSk+nXNQ==
X-Received: by 2002:ac8:1344:: with SMTP id f4mr3590769qtj.285.1597435629932;
        Fri, 14 Aug 2020 13:07:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3009:7f9d:1da1:7877])
        by smtp.gmail.com with ESMTPSA id w20sm9518028qki.108.2020.08.14.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:07:09 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:07:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #03; Thu, 13)
Message-ID: <20200814200708.GB30103@syl.lan>
References: <xmqqd03u18q3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd03u18q3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 03:28:36PM -0700, Junio C Hamano wrote:
> * tb/bloom-improvements (2020-08-11) 14 commits
>  - builtin/commit-graph.c: introduce '--max-new-filters=<n>'
>  - commit-graph: rename 'split_commit_graph_opts'
>  - commit-graph: add large-filters bitmap chunk
>  - commit-graph.c: sort index into commits list
>  - bloom/diff: properly short-circuit on max_changes
>  - bloom: use provided 'struct bloom_filter_settings'
>  - csum-file.h: introduce 'hashwrite_be64()'
>  - bloom: split 'get_bloom_filter()' in two
>  - commit-graph.c: store maximum changed paths
>  - commit-graph: respect 'commitGraph.readChangedPaths'
>  - t/helper/test-read-graph.c: prepare repo settings
>  - commit-graph: pass a 'struct repository *' in more places
>  - t4216: use an '&&'-chain
>  - commit-graph: introduce 'get_bloom_filter_settings()'
>
>  Misc Bloom filter improvements.
>
>  Expecting a reroll.
>  It seems that the review is getting closer to result in another update.
>  cf. <20200811220503.GC66656@syl.lan>

Yep, I am planning on a re-roll sometime early or mid-next week. I would
really like to avoid another one after that, so I'm hoping that all of
the review can settle before then.

Thanks,
Taylor
