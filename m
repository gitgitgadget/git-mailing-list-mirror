Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C7CC432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D349F610FF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhHTO2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhHTO2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:28:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6FC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:28:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l3so7582972qtk.10
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vcc75RJ2gnEOvUfLTp1aSamYAFazWgQAdyT3LKBz1LE=;
        b=ttPpxGwYAYMH1+ixOoDQYbOaUi4cIq3FUeSH+e+sCnqSFBvx3bXw297NmNAHrepXRS
         VD7sHXf/DCVhbPMuEm2q/9GNmnrdo2Ei241mEQI9xqQxmzqZRDQ9d9U4tKRX37XYBgFH
         psPn8G1vfjWVouX6Ox52tVdsoP4q/lumY7DVAEOZ/8mXUmQ+Cu6CEplTpM6s3YRXXhWQ
         GVjnaOmKBr18awPsj/OPJV6cVs4PeXiDCmH0B+W233PxOc9G1KKPJXdngeL3ti1TCrsv
         aatYdnWqJYjZzsSGc7gkzmHSb/R81N1muBmCfoZDBrSb+6foBhhaJQ8lrhxfVF+KQHcY
         mVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vcc75RJ2gnEOvUfLTp1aSamYAFazWgQAdyT3LKBz1LE=;
        b=bEIBbtJuJ/gxfcY9ZYm83DccGLsmmpIUjEk42mxmZkbArmnnWcszU6dBVOed7uniZf
         i+fCNZrS57f/muIPeg9dvwrhf7IC1zo3PLN4mDPTndKNej8uQcENWA7JZP4tW2cL50h9
         U7INAp6RN0eI+YdjbNGvt4zRByWzIPE6WJm9tTS758GfRJ9NVyWEZTL20yYoo63h3DRw
         zX6nMRauSyNzQn2VViA99Bhmx+kQsSzdJvD1sHUSasRuv6ptWLlsaOvfPWy0HVsmxuW0
         bRD9yyTjiSWwXxMY9qdV0LoAHEXiK1ypwLxpKtirlm2TFg0veboGVLhVLYiN03bCy0n7
         uWAQ==
X-Gm-Message-State: AOAM531jAuRcDSRcqAEkglX2gWW4jI3Yuq33yvfG9jZtDjKaGwTxvyd6
        lQbaOS62s02lelLky1pVo1I=
X-Google-Smtp-Source: ABdhPJxomt8G3RBidYMTVnEi4DCQfmMEkSwa3YXJu/o47uMe6XWRtfiLR35WE9JUiyIzRTq8duCD1w==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr17914377qti.164.1629469680961;
        Fri, 20 Aug 2021 07:28:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id 62sm2722755qtg.58.2021.08.20.07.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:28:00 -0700 (PDT)
Subject: Re: [PATCH 1/6] fetch: speed up lookup of want refs via commit-graph
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fce98460-eed6-c874-8c42-bf3a6f5f93a8@gmail.com>
Date:   Fri, 20 Aug 2021 10:27:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> When updating our local refs based on the refs fetched from the remote,
> we need to iterate through all requested refs and load their respective
> commits such that we can determine whether they need to be appended to
> FETCH_HEAD or not. In cases where we're fetching from a remote with
> exceedingly many refs, resolving these refs can be quite expensive given
> that we repeatedly need to unpack object headers for each of the
> referenced objects.
> 
> Speed this up by opportunistcally trying to resolve object IDs via the
> commit graph: more likely than not, they're going to be a commit anyway,
> and this lets us avoid having to unpack object headers completely in
> case the object is a commit that is part of the commit-graph. This
> significantly speeds up mirror-fetches in a real-world repository with
> 2.3M refs:
> 
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean ± σ):     56.942 s ±  0.449 s    [User: 53.360 s, System: 5.356 s]
>       Range (min … max):   56.372 s … 57.533 s    5 runs
> 
>     Benchmark #2: HEAD: git-fetch
>       Time (mean ± σ):     33.657 s ±  0.167 s    [User: 30.302 s, System: 5.181 s]
>       Range (min … max):   33.454 s … 33.844 s    5 runs
> 
>     Summary
>       'HEAD: git-fetch' ran
>         1.69 ± 0.02 times faster than 'HEAD~: git-fetch'

These numbers are impressive, and it makes sense that performing a
binary search on the OID lookup chunk of the commit-graph is faster
than doing a binary search on the OIDs across the pack-index(es).

I do worry about the case where annotated tags greatly outnumber
branches, so this binary search is extra overhead and the performance
may degrade. Would it be worth checking the ref to see if it lies
within "refs/heads/" (or even _not_ in "refs/tags/") before doing
this commit-graph check?

> -			commit = lookup_commit_reference_gently(the_repository,
> -								&rm->old_oid,
> -								1);
> -			if (!commit)
> -				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
> +			commit = lookup_commit_in_graph(the_repository, &rm->old_oid);
> +			if (!commit) {
> +				commit = lookup_commit_reference_gently(the_repository,
> +									&rm->old_oid,
> +									1);
> +				if (!commit)
> +					rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;

nit: I wouldn't nest this last "if (!commit)".

Code will work as advertised.

Thanks,
-Stolee
