Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1AEC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AFA20721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AfToBDrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgEDVZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgEDVZU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:25:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4AEC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 14:25:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so50657pfx.6
        for <git@vger.kernel.org>; Mon, 04 May 2020 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fh144m6lA7IAGxUP5h8bHouZ0xR9ZDpAifY12i8D+9k=;
        b=AfToBDrcjb3N6C0BjfGG6JSlFCJzxYAmpKphMW52OZHZ8Zv2IN9R8FZKPcylDis5SY
         cyi/9eyIPcErX5bLdpuGfwVUmKheEgA+SfEeh8VTkXf4qo3BWVIVKuJkuWAsT5mOnupX
         XPCZAwnPJqVylcSC2Qteipca9zyNjUWbP0x9o8VwWH+1KwRUiafdYXXe4eN+UlNmZAnW
         0fLcx/1My0EHqmJF8T6ddrn2EPXMCOpcQBLfFgozPoS/wYwfli2uWMXMJqCJaJiHYpKp
         jBP4NUTBfn4a1myiiUCHpbMRBdUuWTA4BQcQuMlbYGErVMGJDv3r0/QL2kbp9854skGG
         NEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fh144m6lA7IAGxUP5h8bHouZ0xR9ZDpAifY12i8D+9k=;
        b=ciWdlxw5y0jKwhRPRDsmd846t5mQ/7Vgtn4ZivOKRGGkgJQHiOCtl/ttnWV4eSoUYs
         2VmKBt31m33TVVSs5eBbFa8F2ZbmKIZigDpZ/sIpczTsVeARTtiyUAvF0htWEx7P5tsD
         85V6focFplI85z0RinZpZx72qdoNgpnPrKcYVgQw1UL+eopD8tGdfBGvGUPXEl7w9f49
         krA8GMYmGfrMzBe2KAQ7IPGzI8yyVxxrIeSEpokFiIkAE/VUNiho88bYw+9XQ4fDjPFs
         aSgD6DVqJHC8/D1vAsgps/t84CTUfb0GApI4WJeHZYCG1b4g9GOymk+gPPBaLgt/AfMq
         BcvQ==
X-Gm-Message-State: AGi0PubUSzgojbMRaRL5z7YZz+AHsnX7/vSPXxteAIww0ahWka4K0T7Y
        +UQwrM+N4cqvasXmxctk+wnfbA==
X-Google-Smtp-Source: APiQypJBoWA3lSWhCeEY6z+HAt6p9F1OeT4Lm1Dv487k7easQFgmjd0VQZmSKzf3HouMm8BATRUCLQ==
X-Received: by 2002:aa7:951a:: with SMTP id b26mr18561529pfp.44.1588627518454;
        Mon, 04 May 2020 14:25:18 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a200sm3402pfa.201.2020.05.04.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:25:17 -0700 (PDT)
Date:   Mon, 4 May 2020 15:25:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 11/12] line-log: try to use generation number-based
 topo-ordering
Message-ID: <20200504212516.GA45250@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <3abc713092456b7c34ac72c0064b0b5c51ac726f.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3abc713092456b7c34ac72c0064b0b5c51ac726f.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:28PM +0000, SZEDER Gábor via GitGitGadget wrote:
> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>
> The previous patch made it possible to perform line-level filtering
> during history traversal instead of in an expensive preprocessing
> step, but it still requires some simpler preprocessing steps, notably
> topo-ordering.  However, nowadays we have commit-graphs storing
> generation numbers, which make it possible to incrementally traverse
> the history in topological order, without the preparatory limit_list()
> and sort_in_topological_order() steps; see b45424181e (revision.c:
> generation-based topo-order algorithm, 2018-11-01).
>
> [snip]

This one makes sense, too. Sorry for a long gap in reviewing parts of
this series. A few other things have popped up throughout the day. I'll
get to the last one shortly.


Thanks,
Taylor
