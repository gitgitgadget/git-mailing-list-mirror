Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01096C4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29BD2068E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jhtNhEHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgEDRbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729597AbgEDRbK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:31:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3ADC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:31:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so5860539pfc.12
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3UgTpnkPe+pUBu/uX6wbqk4YAdGl6ZbJWDiTW4aWZoo=;
        b=jhtNhEHdvtkGT/J8OtGKFFoSQf0y9HXZkka+ucTY+BopGiQIR5W3SmEiuJ8WHdXpa3
         K071xsYFBiWciP0+cv+sTkokYXmexYgfudBBj6JzP0rLMSTL3IvOYMJ4YsiUGEkBTh8B
         tXDiFbenVuknCH+FiH22Fm9xsaD5l8iGgMBUs1Y7dnKq2QF8ul0Uco6Oz8fkq1RX076Z
         6zsMz/ZdTtmBMewmWFjZZp0Xaq5kRyFxTbwfvJ++CAiS2Ee4zdMfsvyWdJu44O91ouAy
         nHkF+M3gd3wCGe9kUE0hXiUpL1zgbU3+AsseVKg+rPJA9YLdis9dAjSR0IvaljNnwyLV
         VRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3UgTpnkPe+pUBu/uX6wbqk4YAdGl6ZbJWDiTW4aWZoo=;
        b=qzUyraR8+KMi4uOZmhlFYL2d9FB15qXjvE3fvcSlG3UTwDNmJrOvPhBbQ8/lbLh+OC
         48NWu9GbUxiBMq4gvZJ4jixEKLplQXrIfrj4ghOWo34Z8oAncBgLSpEUVwBaHzo+4heu
         sCr8Lem1ICU/dd5VyCGQky4CTKyk0EkKBMy473l5n1oi9+ChmZau2OQPi/0rh8KNZ1aK
         SjtJYcIQd278wVkF2n99P1V8cHoDf/CF0mIBBXhGwGe9zZqLCBUCF5ZkfwbLsYLwDkHn
         2UUMg6qas3ZdGUSw939HxXEpMPRt9FZbpCHIyfmYAyhCfheyNA1i/urErxEEtw2ouXv0
         8MFQ==
X-Gm-Message-State: AGi0PubGh/3Zh05Ppe1In/Qe6r9/QM22cZrKVNO8rkDDy49XSpj3ZSQJ
        3JoMP/bRq5L9w3XOrHYgcXwRzg==
X-Google-Smtp-Source: APiQypIrSl6NOWm/SMQxXBxehQFU7Zl73Z99aJOmOV7pXoLAGjUikafT6vCa5gCC4fXr9KvhMWlSBQ==
X-Received: by 2002:a62:3287:: with SMTP id y129mr19332574pfy.167.1588613469438;
        Mon, 04 May 2020 10:31:09 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m1sm69424pjg.26.2020.05.04.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:31:07 -0700 (PDT)
Date:   Mon, 4 May 2020 11:31:06 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/12]  t4211-line-log: add tests for parent oids
Message-ID: <20200504173106.GA35579@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <4e3d7233095064de197c447cb31cf4652d42b775.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e3d7233095064de197c447cb31cf4652d42b775.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:26PM +0000, SZEDER Gábor via GitGitGadget wrote:
> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>
> None of the tests in 't4211-line-log.sh' really check which parent
> object IDs are shown in the output, either implicitly as part of
> "Merge: ..." lines [1] or explicitly via the '%p' or '%P' format
> specifiers in a custom pretty format.
>
> Add two tests to 't4211-line-log.sh' to check which parent object IDs
> are shown, one without and one with explicitly requested parent
> rewriting, IOW without and with the '--parents' option.
>
> The test without '--parents' is marked as failing, because without
> that option parent rewriting should not be performed, and thus the
> parent object ID should be that of the immediate parent, just like in
> case of a pathspec-limited history traversal without parent rewriting.
> The current line-level log implementation, however, performs parent
> rewriting unconditionally and without a possibility to turn it off,
> and, consequently, it shows the object ID of the most recent ancestor
> that modified the given line range.
>
> In both of these new tests we only really care about the object IDs of
> the listed commits and their parents, but not the diffs of the line
> ranges; the diffs have already been thoroughly checked in the previous
> tests.
>
> [1] While one of the tests ('-M -L ':f:b.c' parallel-change') does
>     list a merge commit, both of its parents happen to modify the
>     given line range and are listed as well, so the implications of
>     parent rewriting remained hidden and untested.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

These tests make sense, and demonstrate the problem nicely. I don't
think that I have a ton to add to this patch, so:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
