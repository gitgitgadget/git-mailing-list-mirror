Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F56ACDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJKTTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjJKTTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:19:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7690
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:19:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41954a3e282so1209111cf.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697051970; x=1697656770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdZlkvDo/E/xnXcQ/EOhqrsDQ38PAiqjWBGOjDI5riU=;
        b=C6jf5qzTSKWPzYG0+UJT/Is4apWoaH2rruwt9xIFzDZd+wtQgWZoRcNo7Kk30xUyNE
         Io0XigAwV7nwqDy/kAClmqK9bU7JYBDRnoxXJ1aBd48NghAQ1HIQYDQk68QM2ldZ7DpE
         i/IOLxT08YPv5USDTcQn8zwgiGlmQEV6vvmH3rpm0V+7YTmAh7yoasUHz+hEeMu3Ik17
         fvbKJ3pKlFE1j8rAOl8ZftEQmdSQRiuq42bmBe6Byeeh0/0gURKDRjdvw83dOu1M2wuF
         3IDWbb299yZroKUkAng0hT0Yp1YYUBkbG8TLOwjs016pcOZE5o1t9QAX9lhGusc+a8g9
         RJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051970; x=1697656770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdZlkvDo/E/xnXcQ/EOhqrsDQ38PAiqjWBGOjDI5riU=;
        b=YBW7ok+h82ZAeWtrrV4vJBz9rw7lPlL0idOc7jwgb05UPKr2QcjKv6wFCklfgI54nU
         bgXJ7hJWt+TXDfgRw5zDSVaPxAZQs9LQLjZ5IYlNKMgSjcixRGlVu4BpboNNIJ/MXCyZ
         3huHfSNB6UnKfttRBrxySDxFQlLmODCBUY3WNud/ur5e3/cGQUZZ+Ab5JQZ73I6+2X1y
         fDwAS0Ir02Ah5ag28uosCVY4wU6cZgPXrSwn/fflgazS92aFnX8qOlgUfgoZ45Rrg6bX
         DNkeEL93AZl/JWdxt9BrH9aCa5+sVYsgiYqn0Trt2kg4ycq+ZDrXSDM/xM3acIMq5pig
         1lSQ==
X-Gm-Message-State: AOJu0Ywdm6TBgOC/0hNgRWQT3MzjNjJLvT715AeHJuHmLiwRgNJLk6P3
        GARY7qWXtTYBx07Ya+CtBHJwy1/HyKe0cwDo6+FhSQ==
X-Google-Smtp-Source: AGHT+IF1dUfmQREvZr5sZ83iO8zOZ0Tr8qdYF/3HSRVhj4en5Kc22FeNyctPTgJ5UedjKog9rvDRBg==
X-Received: by 2002:ac8:7d0d:0:b0:419:658e:ab1e with SMTP id g13-20020ac87d0d000000b00419658eab1emr23465466qtb.60.1697051970421;
        Wed, 11 Oct 2023 12:19:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g26-20020ac870da000000b00400a99b8b38sm5540280qtp.78.2023.10.11.12.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:19:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:19:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/20] bounds-checks for chunk-based files
Message-ID: <ZSb1QAaLX+xcZK4a@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 04:55:44PM -0400, Jeff King wrote:
>  bloom.c                            |  34 +++++++++
>  chunk-format.c                     |  24 ++++--
>  chunk-format.h                     |   9 ++-
>  commit-graph.c                     | 119 ++++++++++++++++++++++++-----
>  commit-graph.h                     |   4 +
>  midx.c                             |  68 +++++++++++++----
>  midx.h                             |   3 +
>  pack-revindex.c                    |  13 +++-
>  t/lib-chunk.sh                     |  17 +++++
>  t/lib-chunk/corrupt-chunk-file.pl  |  66 ++++++++++++++++
>  t/t4216-log-bloom.sh               |  50 ++++++++++++
>  t/t5318-commit-graph.sh            |  76 +++++++++++++++++-
>  t/t5319-multi-pack-index.sh        | 102 ++++++++++++++++++++++++-
>  t/t5324-split-commit-graph.sh      |  20 ++++-
>  t/t5328-commit-graph-64bit-time.sh |  10 +++
>  15 files changed, 568 insertions(+), 47 deletions(-)
>  create mode 100644 t/lib-chunk.sh
>  create mode 100644 t/lib-chunk/corrupt-chunk-file.pl

I reviewed this carefully (well, except for the new Perl script, for
obvious[^1] reasons ;-)).

Everything mostly looks good to me, though I
had a handful of review comments throughout. Many of them are trivial
(e.g. a number of warning() and error() strings should be marked for
translation, etc.), but a couple of them I think are worth looking at.

Most notably, I think that by the end of the series, I was convinced
that having some kind of 'pair_chunk_expectsz()' or similar would be
useful and eliminate a good chunk of the boilerplate you have to write
to check the chunk size against an expected value when using
read_chunk().

Otherwise, this looks great. I appreciate the care you took in finding
and fixing these issues, as well as thoroughly documenting the process
(and the security implications, or lack thereof). Thanks for working on
this!

Thanks,
Taylor

[^1]: That I may be the world's least competent Perl programmer.
