Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6CC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjHBTJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBTJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 15:09:34 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA07E7D
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 12:09:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5839f38342fso897677b3.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691003372; x=1691608172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7jiMJ7v159XfoZ8Ue4CAnQ4uCejJfWwWySon512yEk=;
        b=hzYdZpARp9JamDJN4YIc0T7+GLPF/86qk9J2HLQUP5dVoBtZ9ME6UkNRUJFCwwgh52
         p5KWU+pPSOhP8s58sVR1WYxWf+iJzaDNhVAzK4bIx7uutzzbZpeAUQNNPGg41ZuroJVy
         8ZHBvelyg+IbWuvL3SqzUqTBHutVhWEkWZVq3W0o+t3roNpf9BryN3ZsgvyPrq3nN1+2
         kKEogVk2GwO33gEJZQuQwSg+aZWjP23oLerYkFvMHuh1YgM6jkUx9xuQIm18bb3PeJve
         vpgXwE+K1+fuJi0UQOF05A25Atf0Gvgs02Qtnvfu4bkBvk+6c3TR2pIXEliElREAfRzB
         Plcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691003372; x=1691608172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7jiMJ7v159XfoZ8Ue4CAnQ4uCejJfWwWySon512yEk=;
        b=ILPjxzLQb2628QfGiaJKJnRFScwjyPclwiys5+kJVcxj1lBblq7EsrqbBfrPPINwdz
         KOtnx7p88IK8e0ceKQxmCKKkNMd3BiRUbftIFgNP+6tpmTrw+02b+XAzAHCgt8kV28S9
         Kak8CIJeMmPEK8ji2ZFfvaaiS4/uRsxmIHixycZxSc1dFSyRpI2CULIkwNsLGr+661nH
         YIi6PkZ4+Kx2Xlfttw+1GLZ5JZ0AV4aM4kBzF95FqzV8bxRaFSheZIquWSjz6wmXaF9f
         bMHZpnxerZrFl8pbYEFOFdzroIOwjWGxqYlio/wefVi7JXr/2rY+Bo7WuD9nWRZ43kyL
         saWA==
X-Gm-Message-State: ABy/qLY74zSTwxgvMRYp5fD+LYSQPaWFb9PDJxL4BWvDJ7vp9XTtWibY
        fnVAi2xn8cYd2VYKurNPbrVxDA==
X-Google-Smtp-Source: APBJJlHmeRiHS7u0ceYqf133KmysVmYQHDF0Vl0qUZ4YwnwKEVquFpaaAG1dK7Tam2xjLiZleiuHZQ==
X-Received: by 2002:a81:6704:0:b0:586:3102:edfa with SMTP id b4-20020a816704000000b005863102edfamr10487873ywc.13.1691003372527;
        Wed, 02 Aug 2023 12:09:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a63-20020a818a42000000b0058390181d16sm4830457ywg.30.2023.08.02.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:09:32 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:09:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jt/path-filter-fix (was: Re: What's cooking in git.git (Aug 2023,
 #01; Wed, 2))
Message-ID: <ZMqp6K2iXixWH/zT@nand.local>
References: <xmqqfs518gdh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs518gdh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2023 at 11:10:34AM -0700, Junio C Hamano wrote:
> * jt/path-filter-fix (2023-08-01) 7 commits
>  - commit-graph: new filter ver. that fixes murmur3
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - t/helper/test-read-graph: implement `bloom-filters` mode
>  - bloom.h: make `load_bloom_filter_from_graph()` public
>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>  - gitformat-commit-graph: describe version 2 of BDAT
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>
>  Still under discussion.
>  cf. <20230801185232.1457172-1-jonathantanmy@google.com>
>  source: <cover.1690912539.git.jonathantanmy@google.com>

I am happy with the most recent round, but I think that it is probably a
little late in the cycle to be merging down such a large change.

I wouldn't be opposed if you did so, but it may be worth waiting until
we're on the other side of 2.42 so that other reviewers have a chance to
look at this one as well.

Thanks,
Taylor
