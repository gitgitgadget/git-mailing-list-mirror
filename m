Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32ACC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4C5206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE+XleBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFDOWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDOWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:22:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBFC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 07:22:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j7so2988298qvp.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M2db6UBez7DMQfmvrTNaW4ef7YJfbU672/v2HXHoHbc=;
        b=mE+XleBshUDaFjWfZWKvBWibPbuXpqzw1Sb5XyulidGnlOpKSv6ffXs7PTrmyG1D3W
         yQt97r5GFPREWnH4I0hkD5HTlfjFFVmXoVORTMan7VGSHqv9IaKpkLPTw5o/fJ6+JJjI
         vzkhMLpFaVFUVe27edMIEPvT2vWLXh+aaIp8mF3HqQDqkhSPm4fnknjsMyTNTuRKhMLR
         +RwxTs78jz3C8sZrHCqLOliX0KpK8OrUOSrUXQKh4J6IhHt7NAmJsWtBtplVIX8l1Jrq
         /8dW8coC/py9SLP6qrQu848Gh7zO6Zl9MJZb1TEihsFtpRvnrH6vIn6SHHFd9Y78ai4o
         ccKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2db6UBez7DMQfmvrTNaW4ef7YJfbU672/v2HXHoHbc=;
        b=YYen4MSgRMRchn2NdExqlSXp82zX8Yl/6Ug0Ws1GUQnQGW5YTFhTz29EuBk9hZPmB2
         FXe6kkh78vGVomi56x/fT2qeAyOL5Fmo4eo4AQCoQXaH2RCDYaXu9hdu/2NRXdGMmgp1
         xCK9Uzk1yj4FqAyTwQAkoadwwh8VGJiYpXjHEzmUDceAGjDHwey83G+fubbITmsrFPYT
         KIBqKmxrMElLNYN+BwbEbTyD7MHRRkjOvUPYk67+0EPtThuV+8XVyazAbegC/A4RxQb/
         9GicnH01HctEFWZKVEZ948xLbJMP24qcRUZ227fCVR5Efx2DdwNFGD203cN+VmqaLuu4
         lj3g==
X-Gm-Message-State: AOAM533gS++nxTm81rrBXPZxk1JBYC3xOPKVL2QCwLwtaRghHdBXed6X
        lCQPsE5bM3QpOygjdwSGvxkJKr2A3/A=
X-Google-Smtp-Source: ABdhPJynxT2P63BHNrsK5CZEuS7E8E3KHyYFrU7OuK0oHbH6tBCJCdgAhABFHso3fFBnhnjrvSkILA==
X-Received: by 2002:a05:6214:15c3:: with SMTP id p3mr4727351qvz.192.1591280549210;
        Thu, 04 Jun 2020 07:22:29 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m126sm4065648qke.99.2020.06.04.07.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 07:22:28 -0700 (PDT)
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
Date:   Thu, 4 Jun 2020 10:22:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> The struct commit is used in many contexts. However, members generation
> and graph_pos are only used for commit-graph related operations and
> otherwise waste memory.
> 
> This wastage would have been more pronounced as transistion to
> generation number v2, which uses 64-bit generation number instead of
> current 32-bits.

Thanks! This is an important step, and will already improve
performance in subtle ways.

> The third patch ("commit: convert commit->graph_pos to a slab",
> 2020-06-04) is currently failing diff-submodule related tests (t4041,
> t4059 and t4060) for gcc [1]. I am going to send a second version soon,
> fixing that.
> 
> [1]: https://travis-ci.com/github/abhishekkumar2718/git/jobs/343441189
> 
> Abhishek Kumar (3):
>   commit: introduce helpers for generation slab
>   commit: convert commit->generation to a slab
>   commit: convert commit->graph_pos to a slab

If we have a commit-graph file, then we have graph_pos
and generation both coming from that file. Perhaps it
would be better to combine the data into a single slab
that stores a "struct commit_graph_data" or something?

This would change only the slab definitions, since you
already do a good job of wrapping the slab access in
methods.

>  alloc.c                             |   2 -
>  blame.c                             |   2 +-
>  bloom.c                             |   6 +-
>  commit-graph.c                      | 116 +++++++++++++++++++++-------
>  commit-graph.h                      |   8 ++
>  commit-reach.c                      |  50 ++++++------
>  commit.c                            |   6 +-
>  commit.h                            |   6 --
>  contrib/coccinelle/generation.cocci |  12 +++
>  contrib/coccinelle/graph_pos.cocci  |  12 +++
>  revision.c                          |  16 ++--
>  11 files changed, 158 insertions(+), 78 deletions(-)
>  create mode 100644 contrib/coccinelle/generation.cocci
>  create mode 100644 contrib/coccinelle/graph_pos.cocci

I appreciate the Coccinelle scripts to help identify
automatic fixes for other topics in-flight. However,
I wonder if they would be better placed inside the
existing commit.cocci file?

Thanks,
-Stolee
