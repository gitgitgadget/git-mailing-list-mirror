Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B56BC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254D720732
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rspfS7Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440986AbgDNPwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732058AbgDNPv7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:51:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A06C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:51:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x26so48206pgc.10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CahxmQqFuSN17hzKxp22cYA04X1IdTUqMe8AwCJzziA=;
        b=rspfS7IzZ5kRBlyooFFNmV69ncvtpw7zU04/1hu5GoxTzCU6CpvLgim/ZylZm3Fsct
         NTae0Q01ofp6SetGsBIjUbqFoP7yabPhgk1Dslb/5trSx60J+dQ/JghEKzPzs4ZzKFij
         HavgQu50GOjijzk2EKhgr7hHnohu06L1aKObWjH8jQiTfVJuo2hEDZ9fSzKvHxQtxyzn
         U3ZBDzXJ2wxF+brPvBpcVdcTH63bhH4f1K3ywx287YqQEcITmemftQYaGJVjJpZ/w03s
         T1HBT52rzXEhrf5bQ/xAxKBTI/JU6Kh7gmf9qfe32xf8G3RIQqlolh5wnK2lVrFFL+KA
         P8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CahxmQqFuSN17hzKxp22cYA04X1IdTUqMe8AwCJzziA=;
        b=Os/FoMUNv35PwEuCaiJZh1tQ8HVGzxYjGCWOEbYzJ9nqGU4MRM2SKhNjVExD4aqthH
         kf5l1ZSr4+K6ZyiRkk8eqlt7GXJP/i6adPheHLBR/N1Z140EmOTyrnQh64dhWgC5Vfcs
         nkap8l3S/V6Maou+qV318Y6kqtGaSWUmJQNHTpgjKZmkB7mRudst6O0ehLrYJ309bH+d
         ws3slvZnBZCgqvOSIHdyyvZdYIt/nC/yqSxjpiss2Cm7VBRq85kfeJRYqW3WSvI97Cfj
         xFjkPnSXXTCGv6AZTradq9qVV/0ZMUOZF5V7/n4/z67vB/RTb2gJvF1qTwRWpfkHb1Ws
         Ktng==
X-Gm-Message-State: AGi0PubXlpqvCALxw1tg2sgylQhMGL88w/wsKP1CEOZ9bDHddO9SmIq8
        fRui/y53nxjXSX8pa9g8KhF5EA==
X-Google-Smtp-Source: APiQypK9logbneCH1KWyhCZ4MDXM+xEDvgFPaLXzlJn1LTFnw2DPRY/QuX1x0tZBF1ghzxPeMiJEYQ==
X-Received: by 2002:a63:5d7:: with SMTP id 206mr10706678pgf.136.1586879518681;
        Tue, 14 Apr 2020 08:51:58 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 63sm11442331pfe.96.2020.04.14.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:51:57 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:51:56 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (March 31, 2020)
Message-ID: <20200414155156.GC93424@syl.local>
References: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

Apologies for digging up an older report.

On Tue, Mar 31, 2020 at 09:58:17PM -0400, Derrick Stolee wrote:
> Uncovered code in 'next' not in 'master'
> --------------------------------------------------------
>
> Commits introducing uncovered code:
> Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
> builtin/commit-graph.c
> a599e2c9 75) *to = 0;
> a599e2c9 76) return 0;
> a599e2c9 86) *to |= COMMIT_GRAPH_INPUT_APPEND;
>
> Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
> commit-graph.c
> 5d5916fd 1557) break;

I was leaving this in my inbox as a reminder to address these two
uncovered hunks, but they have gone away in the backlog of commit-graph
patches I sent to the list last night.

Thanks again for running these.

Thanks,
Taylor
