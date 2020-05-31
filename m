Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CAC433DF
	for <git@archiver.kernel.org>; Sun, 31 May 2020 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD09207BB
	for <git@archiver.kernel.org>; Sun, 31 May 2020 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDFXlqYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgEaRX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaRX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 13:23:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F9AC061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 10:23:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so9222526wro.1
        for <git@vger.kernel.org>; Sun, 31 May 2020 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=je2rjQYUt3XrWPM7ge40xHcBhFyd1l1NKOpzpq5hbZw=;
        b=nDFXlqYo5ebsMipWQHGYdA8yTYgozOYqa3JX8MbERnYjYgNRh1FELVpYfihT0+fsqU
         syZtIZVyE+6JzJOdSl9Yb0eSRXdgSoD7GeoERIZRvDd0gduHnsSaCakeOVeBgefBtPfd
         rK43sOzCmLI1i9gLGpNDKgTyhr3ncEsUVeD+duJGUONpgmYhwjtboaqIFdOJNBjiqT7A
         TEce/6GPed4fHsraeiqqidePi+vwDfLMhmkWCbyCpbnHVtX/yTDz1N/ws2Xt3kG7sPsS
         A8Ebmu2uIvoyedMIIUupQDdEmfcFhMLsTtdSj3gsAa+58e502eQvFVzWuybGF35UUVny
         BY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=je2rjQYUt3XrWPM7ge40xHcBhFyd1l1NKOpzpq5hbZw=;
        b=QLsAefSbfSlPNAE/BYh4bxj07n3GR8oUcPG1OsCmMT8bgs8hXDyoU9akL46p2NhGrC
         bthvUniWTdIOYc0LeqW6BbJZPrzRneheVMGFg1DQnsBsHiYrz2PR0CDRiLKH8m1dYtA9
         isfKB2c+miqZymwvkX24KlJsD/ijILfMb4fZhca9blckEwz1jgKSKBIDR5jaP3iepS6Y
         M6gG7kLKUdw0hJmersoDVn4vYpN318RzdFo6oOGaMXCd8yNeqVtvMP0dcCB+CtRRjxDu
         CPiu2OZCeKxmK9yd0T5bIQGj0+bH4SuhB0wBLcj7zU81Dk6+I9WI+CEtaDbiWVTBGLBE
         nzEQ==
X-Gm-Message-State: AOAM530A+NQYuDPJaUfXCFzFbZAJSmEGbvVCAYVqq/O7KqyWWOpUTnhA
        FGeK1JjSkm2opa6ZjJlIa58=
X-Google-Smtp-Source: ABdhPJyo6txbVxtFxYz083dzkhFX9YPUbl8GKJ92f1hiSvPxmKVXtr5SGM052Ld7q92gqtpqWBJCgA==
X-Received: by 2002:adf:fc4e:: with SMTP id e14mr18063263wrs.348.1590945835948;
        Sun, 31 May 2020 10:23:55 -0700 (PDT)
Received: from szeder.dev (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id q1sm7696506wmc.12.2020.05.31.10.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 10:23:54 -0700 (PDT)
Date:   Sun, 31 May 2020 19:23:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 09/15] commit-graph: write Bloom filters to commit
 graph file
Message-ID: <20200531172349.GA9990@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
 <20200529085721.GA25128@szeder.dev>
 <72cff41c-bb2e-5f87-5db6-d4e9ead25a47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72cff41c-bb2e-5f87-5db6-d4e9ead25a47@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 09:35:17AM -0400, Derrick Stolee wrote:
> >> +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
> >> +    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
> > 
> > This is inconsistent with the implementation: according to the code in
> > one of the previous patches these entries are simple byte offsets, not
> > 8-byte word offsets, i.e. the combined size of all modified path
> > Bloom filters can be at most 2^32 bytes.
> 
> The documentation was fixed in 88093289cdc (Documentation: changed-path Bloom
> filters use byte words, 2020-05-11).

Oh, good.  I'm waaay behind the curve and haven't seen this fix.  Even
better, now I also noticed that two bugs I was about to report have
been fixed already (though both fixes have minor flaws).

Ok, so at least the specs are consistent with the implementation.  I'm
not sure this was done in the right direction, though, because too
small Bloom filters do hurt performance.

> > Clearly, using 4 byte index entries significantly lowers the max
> > number of commits that can be stored with modified path Bloom filters.
> 
> This is a good point, and certainly the reason for 8-byte multiples.

Note that Bloom filters with power-of-two number of bits have higher
false positive probabilities when using some form of double hashing.
When going for 8 byte blocks all commits modifying <= 12 paths
(assuming 7 hashes per path) will have power-of-2 sized Bloom filters
(64 or 128 bits), and that is a lot of commits.

> The incremental commit-graph can actually save us here

Oh, I haven't thought of that

> >> +      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
> >> +      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
> >> +      BIDX[i] (plus header length), where BIDX[-1] is 0.
> >> +    * The BIDX chunk is ignored if the BDAT chunk is not present.
> >> +
> >> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> >> +    * It starts with header consisting of three unsigned 32-bit integers:
> >> +      - Version of the hash algorithm being used. We currently only support
> >> +	value 1 which corresponds to the 32-bit version of the murmur3 hash
> >> +	implemented exactly as described in
> >> +	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
> >> +	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
> >> +	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
> >> +	in Probabilistic Verification"
> > 
> > How should double hashing compute the k hashes, i.e. using 64 bit or
> > 32 bit unsigned integer arithmetic?

Note that this should be clarified in the specs.

> >> +      - The number of times a path is hashed and hence the number of bit positions
> >> +	      that cumulatively determine whether a file is present in the commit.
> >> +      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
> >> +	      contains 'n' entries, then the filter size is the minimum number of 64-bit
> >> +	      words that contain n*b bits.
> > 
> > Since the ideal number of bits per element depends only on the number
> > of hashes per path (k / ln(2) ≈ k * 10 / 7), why is this value stored
> > in the commit-graph?
> 
> The ideal number depends also on what false-positive rate you want.

Well, yes, but indirectly:  according to Wikipedia :) the optimal
number of hashes per element depends only on the desired false
probability, and the optimal number of bits per element depends only
on the number of hashes per element.

So storing the min number of bits per entry seems to be redundant.

> In a
> hypothetical future where we want to allow customization here, we want
> the filters to be consistently sized across all filters.

Wouldn't customizing through the number of hashes be sufficient?

> >> +    * Note: Commits with no changes or more than 512 changes have Bloom filters
> >> +      of length zero.
> > 
> > What does this "Note:" prefix mean in the file format specification?
> > 
> > Can an implementation use a one byte Bloom filter with no bits set for
> > a commit with no changes?  Can an implementation still store a Bloom
> > filter for commits that modify more than 512 paths?
> 
> This is currently due to a hard-coded value in the implementation. It's not a
> requirement of the file format.

Should an implementation detail like that be part of the specs?  It
sure caused a bit of confusion here.

