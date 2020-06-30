Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089CEC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B5B2078B
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAikPTc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgF3Bvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgF3Bvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 21:51:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A658C061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:51:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g13so14456946qtv.8
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6oesyCsGm6bJzJhYYwSSeAeWe3HbAC2YXCSORNLIDc=;
        b=uAikPTc64NySOy+fG5GrFCpzmmYO/k//fiz9Thz9u6J9iEihVDnWAhIoLIfhHwnRQt
         RRgISCZArpTUcGPhtppjBSQd5UgqXiBk9Z0l9+SOkRIGp5jDv1VCTz1m4PLSRLskWWiQ
         BPqU5PgzmV3IiaTuvrOfVuaPlmkfdTgE9yoNgGJjzTLYV/Fi8Tt2oX5g/YCGmnXHlMj0
         h1Ozs32HHakW73p+V/yf8yj3yIM9Ekcsc/8ZIGJb/KhTRjz68NHy9kKM/iKvwCuOk8cF
         vwbKFCuw/LVFj1A+ggcN4cfv2qr0fpd1c2jP3udWQRZNOj0rANNVPX8qjxzCPgRCNeWY
         ypLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6oesyCsGm6bJzJhYYwSSeAeWe3HbAC2YXCSORNLIDc=;
        b=uKIoF1GuaE7k8h/i4fvuU7t6wHrrMxjNfBb83xJG38o1syLt8BWhvMV/mRCEurz1s3
         Rs9cG4xRXdrquSU0QORx1N5/bGkS/IOYHhA8q6p+JHP3MxJtflxl/fv36OEAvpLaQ0zc
         3XQ0c8VdedZuEDG826QWdyJ5DKEIFU3bo7opcTzHUp7en5pcyclv/jilQkqxDcTt8ZDL
         KIR+Nmxy8Nt5ptGRosrLL890FMeZV4TSHiznHa/c1h1ZIoVI0anLkv50Ll59SMeh7dIE
         1qrDJNXZc0Rou8DPfLVrFrz2YPx6dBpdvngQ49zzI3sU2q0AGlxfvtKbpONWFHDg9Mf+
         AwBg==
X-Gm-Message-State: AOAM5308lz9ajFflggQVblpmRJLWRAB9lEF8rJN/Rgpfi1NM0UndTbmK
        /TCAlwG9iZa1kxnRbLs17TEPtAqR6ZU=
X-Google-Smtp-Source: ABdhPJz63KgJxAv2K+0PJbgL/jEeg2pb+vyYOPhmU3h21XIYKgwW7CQ+FZLs8A+c+wel2DxaGRg/3A==
X-Received: by 2002:aed:3c64:: with SMTP id u33mr18606563qte.56.1593481900279;
        Mon, 29 Jun 2020 18:51:40 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u58sm1727419qth.77.2020.06.29.18.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 18:51:39 -0700 (PDT)
Subject: Re: Commit graph chains with no corresponding files?
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <20200629220744.1054093-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
Date:   Mon, 29 Jun 2020 21:51:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200629220744.1054093-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2020 6:07 PM, Jonathan Tan wrote:
> At $DAYJOB, a few people have reported "warning: unable to find all
> commit-graph files" warnings. Their commit-graph-chain files have a few
> lines, but they only have one commit graph file with very few commits. I
> suspected something happening during fetch, because (as far as I know) a
> fetch may cause an incremental commit graph to be written, but I ran a
> fetch on a large repository myself and didn't run into this problem.
> 
> Has anyone ran into this problem before, and know how to reproduce?

The incremental commit-graph code deletes any commit-graph files
that do not appear in the chain. I believe this is done by comparing
the contents of the ".git/objects/info/commit-graphs/" directory to
the contents of the chain file.

These appear to be case-sensitive, full-path comparisons.

It is _possible_ that something like a case switch or a symlink
could be causing a problem here. That's where I would look on
the affected systems.

Likely the full-path comparison in expire_commit_graphs() should
be dropped in favor of local filename comparisons. A case-
sensitive match is less likely to be important here since Git
is writing the paths itself and should get the proper case back
from the directory listing.

Thanks,
-Stolee

