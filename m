Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308CCD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjJJUgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjJJUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:36:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D6C91
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:36:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7740aa4b545so409355585a.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970181; x=1697574981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VioNUQiXT0iMme687FMx3TLXSVJ7NJwu0WWOXaveSnQ=;
        b=OtUHTLyYw577OxSXRwTqRzuoVrYmUTX0z4nOeQCK3xf4DktX9WZkR8J9jnDFh7nFsu
         vrhxViQX6qP69bkuqLsphvx0OO0cvpWFPKAtdMK6jVz7ZPQepfW26HqmfnJdCfs7h+KF
         xeljkT26daHJ2ivrWeQcMjAt45z7/kOA3LsJIBUbfvBK0X2JYOMLmuQckJZ4lixKUApo
         4qJf3+63jtaUK1JQKMoWxhbLTnTQeGP6mEGasY9jm2nt/ZNNzDWYA+H+ZXNWvSTpXch+
         28yqVMTAOKTjPZfiK6pPUbYCxJkL8G97KF4NfqWXDk93rEx2p/nVEec4Vtg7sRMKZC6v
         s3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970181; x=1697574981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VioNUQiXT0iMme687FMx3TLXSVJ7NJwu0WWOXaveSnQ=;
        b=s9BcQnRHz78IjapKTMl9xse6s7dmLPv3D3opUSCoAiPe4zNyX4EGpwGBfxcank4ATj
         5XluxHno79hdfz0CJRqFVSeRHP3tWjQGIMGIP3UcFXoFCilRqo2dD5ONQLQo86aHUR1x
         L/IjPYefZGEB7YCcvqlw6BqTK56Ib3yPuGwQ3827dUasq9XYnbx6/RqzbIrP/N7ge7va
         8696EE9H3FGEj4dEsZX/n8Em7VJE1lAGEn3LbCgevNwKF1crreloOsuKbAB2iHOsfs65
         D5ggwRwedrD2B+gV5ibTUHiImj2AxYFRTHjJ5GU6aaTB5PttQDBdlV68lOYPvPQx6+8t
         eONA==
X-Gm-Message-State: AOJu0YzSNQhf65tlliHpfQzHuM1istqbsoZzuMTq+DL2DRviwQ8axHZ5
        qOH7itZtLSCxttoujd+latiM3w==
X-Google-Smtp-Source: AGHT+IHE8iUtfvj5Y8Fu05WWwByAK59Ljl3gCNokohkaF9sY7iNZPDNXc6igpvzXtfo0TC35K9NI4Q==
X-Received: by 2002:a05:620a:e14:b0:76d:984c:9d01 with SMTP id y20-20020a05620a0e1400b0076d984c9d01mr17241662qkm.33.1696970180831;
        Tue, 10 Oct 2023 13:36:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b00767d6ec578csm4635679qkl.20.2023.10.10.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:36:20 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:36:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
Message-ID: <ZSW1w70yug4rbBGK@nand.local>
References: <xmqqh6n24zf1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh6n24zf1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2023 at 01:20:02AM -0700, Junio C Hamano wrote:
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
>  What's the status of this thing?
>  cf. <20230830200218.GA5147@szeder.dev>
>  cf. <20230901205616.3572722-1-jonathantanmy@google.com>
>  cf. <20230924195900.GA1156862@szeder.dev>
>  source: <cover.1693413637.git.jonathantanmy@google.com>

Good question ;-). There were a couple of outstanding issues pointed out
by SZEDER Gábor that I addressed on top of what's already there.

I tied up what I think are all of the remaining loose ends and put
everything together in a single unified (if a little long) patch series.

This should be ready to go, but I'd love to hear from Jonathan Tan and
SZEDER before declaring victory here.

Thanks,
Taylor
