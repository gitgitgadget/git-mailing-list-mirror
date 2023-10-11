Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68983CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjJKT0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjJKT0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:26:52 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E6C0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:26:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-419cc494824so1529141cf.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697052410; x=1697657210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWC/EJ3qsEtso5x1YfeRvgKEzeANDbx+95Klx192nxs=;
        b=1DCIlO0CoxIl5Lt6rFJWxVvsHU94Oaxzwzx8QnBkcpq7Ks+MFh+QNw80T1OSXEivB5
         bTLuwJ26dNLZltghUwSwMXbEr91h8b9r12e9z/yFWlTdf8ihrNNGDIOBRuSoDb8XHwSj
         lNvAGmrlF0lvdkP0VQDlLDmmvvnp/d82gtPiax6FfjJFEUEE1+3uTOvIwhCqKheXe1He
         HKWaLkI0Lfr5eCHA3/9o2FxN10cmfv16QTv2YisdmD5/2o51q4Bh1+0LYRQWTCIBmJ3c
         fB+gz5DBqVpT5cxd7zQZSfvmrApvyjWwmLAPQEjNSP4ZYmF7PfP2lcGUOFPuJ4jDhgd8
         uYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052410; x=1697657210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWC/EJ3qsEtso5x1YfeRvgKEzeANDbx+95Klx192nxs=;
        b=Y2gD80S5+T1hTbUmgrcU+58bevjM1r3PpqpgcLdKe5HqBqZ7SUul8PTaNUZ5A0jp5C
         eiKFufD3mx/ZByz1/uKGN2uvKYRwh8EVlLtSLCOu3HfnEXBIS33mpCKYXYfa0ftxksAd
         g9CPxzgWvPjUgrXZvZZ/eWMlqYlZxddufKy3oEZUURgsUI0dzmqCj1EQoWgh1cXsYwms
         dd2v47e9sCTAmYvnoYxv0u1PD/2oWMFYub/yUgfoDtl+jkTU9n2f0CNEBtsFWVB3XDYy
         BjdTgPZpv7ObqLzAXcx62auPV9c0FeUsue2UAHkSBt0VczNL8j/R1bNSbzu3xkj2yFNE
         jUVA==
X-Gm-Message-State: AOJu0YwvOg5AI0LkDPcAG1T33Gzu5KLfvz/RqqDT0MrSQSiGwONobdQ7
        tUvBVWTGZeJoP6kQ0gKGlR0EsQ==
X-Google-Smtp-Source: AGHT+IGdyzZWh5fG4Ccb8AEI1nyb/Hw1DMU2dC4jy832GlE51Yvjqw+KG4vheBzuxsG8DeTCnECQtg==
X-Received: by 2002:ac8:5715:0:b0:418:804:3406 with SMTP id 21-20020ac85715000000b0041808043406mr28735042qtw.39.1697052409895;
        Wed, 11 Oct 2023 12:26:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hb11-20020a05622a2b4b00b0041969bc2e4csm5608620qtb.32.2023.10.11.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:26:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:26:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #04; Tue, 10)
Message-ID: <ZSb292VxDQoeSu2o@nand.local>
References: <xmqqwmvuosf3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwmvuosf3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 06:32:16PM -0700, Junio C Hamano wrote:
> * tb/path-filter-fix (2023-08-30) 15 commits
>  - bloom: introduce `deinit_bloom_filters()`
>  - commit-graph: reuse existing Bloom filters where possible
>  - object.h: fix mis-aligned flag bits table
>  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
>  - commit-graph.c: unconditionally load Bloom filters
>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>  - bloom: prepare to discard incompatible Bloom filters
>  - bloom: annotate filters with hash version
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
>  Reroll exists, not picked up yet.
>  cf. <20230830200218.GA5147@szeder.dev>
>  cf. <20230901205616.3572722-1-jonathantanmy@google.com>
>  cf. <20230924195900.GA1156862@szeder.dev>
>  cf. <20231008143523.GA18858@szeder.dev>
>  source: <cover.1693413637.git.jonathantanmy@google.com>

Great, thanks for noting that you saw it ;-). I think that this one is
ready to go, but I'm obviously biased and I'd feel better if Jonathan or
Gábor (both CC'd) would take a look before you merge this down.

> * tb/repack-max-cruft-size (2023-10-09) 5 commits
>   (merged to 'next' on 2023-10-09 at 38f039e880)
>  + repack: free existing_cruft array after use
>   (merged to 'next' on 2023-10-06 at b3ca6df3b9)
>  + builtin/repack.c: avoid making cruft packs preferred
>  + builtin/repack.c: implement support for `--max-cruft-size`
>  + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
>  + t7700: split cruft-related tests to t7704
>
>  "git repack" learned "--max-cruft-size" to prevent cruft packs from
>  growing without bounds.
>
>  Will merge to 'master'.
>  source: <cover.1696293862.git.me@ttaylorr.com>
>  source: <20231007172031.GA1524950@coredump.intra.peff.net>
>  source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>

Great, thanks.

The only series of mine I didn't see mentioned here was the merge ORT ->
bulk-checkin stuff that I posted in [1]. The discussion there has sort
of morphed beyond the patches themselves, so I'd love some review on
these patches (perhaps from Elijah?, also CC'd) if time permits.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1696629697.git.me@ttaylorr.com/
