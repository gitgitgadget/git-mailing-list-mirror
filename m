Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803CC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0ED2376F
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EpJF4TeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIRNeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRNeS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7AC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:34:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so4935763qtv.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+pL/HGVuoPsv2iSlXID3Oe1/pik0VEX4F6sLw4MRJXo=;
        b=EpJF4TeWPJyb4Wkj99aQ6mfdSHIGF40bAs8ivHo+jfVlYIyqzhoQeOanhqgz0TAZP2
         NXAdcIZVmaoRgGz4dg32wKWzZFPK6M359OqVmjuYGzbBLAjbSX2C3974iS4UWmSTNgaE
         tCGG6/SmB/B4YZJGUn6QYKmaJMCWQIOdjUvsnUgXPQO+cUEZGq7jlPexf9wzfJ1kNU8O
         v2C3+ZgFwezXT5o7puw4aogQpUzKPh7SttZX5UcMqL/rhg23M4IqL2EP/y0b4zFnvEnc
         V9mz283uAsnsSMe1RMBN90Wgw9n8ef2s2WFJ6ML+o7bJHwCRoEnku1Ju944QM6wYxSI6
         M5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+pL/HGVuoPsv2iSlXID3Oe1/pik0VEX4F6sLw4MRJXo=;
        b=oIE93eF0tBJME63jg+CL8Nko0jfG2BJLiucup340VkDwQ6HPhhf4QZBKmMKrAVDKXj
         NZ+uKNBG7iHR7oK+IPVr7NrJ/kXyolANM7EQZq3WrXX3KFCsyElkfOMKyNnNzy1x+i8d
         R8pXRQtCQDPozyRX/nLgdjT8F2dvOiJG7Hq9qufytS0a243YeqDaqej3IYxi0GzlSwDd
         WgWfy6IRkoUPAKlUOC6ZDRN7hf3X7A5bc/jprtYdkBzN2WxAaoRHN8knsnS3jo/VjKNL
         g3crNl/BZF/FmOWOAmtNlvEKYq3BkX8sy8YMatkkvjlE7tr+8XTbdnXTZvpNaUGQFnIb
         eg4Q==
X-Gm-Message-State: AOAM532e/B5cfNa014QsTtlnP7cJlSo9akMctdP6FTSaG3sEUW7N3BRI
        +DJhl6YV1yl6H97AUb4OJXLVKA==
X-Google-Smtp-Source: ABdhPJy5bJNq1YfEntm3jNzrXet1Yyj+dDGqgVhnx6pdC3vNmqYMBFjE/UDEWXltjo5OorSbbM+ETA==
X-Received: by 2002:ac8:6f50:: with SMTP id n16mr12318368qtv.190.1600436057198;
        Fri, 18 Sep 2020 06:34:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id e1sm2205103qtb.0.2020.09.18.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:34:16 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:34:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     gister@pobox.com, git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/13] more miscellaneous Bloom filter improvements,
 redux
Message-ID: <20200918133413.GA1602165@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
 <20200918133140.GB1601745@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200918133140.GB1601745@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 09:31:40AM -0400, Taylor Blau wrote:
> Junio,
>
> Two replacements for this version, if it ends up being the one you
> queue. Gàbor suggested some helpful changes on 12/13, which in turn
> cause a conflict when applying 13/13.

I should mention, the changes are purely an alteration to the new
documentation introduced by this series. Here's a range-diff:

12:  4549f0f747 ! 12:  1c3f6b5c96 builtin/commit-graph.c: introduce '--max-new-filters=<n>'
    @@ Documentation/git-commit-graph.txt: this option is given, future commit-graph wr
      +
     +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
     +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
    -+enforced. Commits whose filters are not calculated are stored as a
    -+length zero Bloom filter.
    ++enforced. Only commits present in the new layer count against this
    ++limit. To retroactively compute Bloom filters over earlier layers, it is
    ++advised to use `--split=replace`.
     ++
      With the `--split[=<strategy>]` option, write the commit-graph as a
      chain of multiple commit-graph files stored in
13:  375ecf1f36 ! 13:  a7330ee850 commit-graph: introduce 'commitGraph.maxNewFilters'
    @@ Documentation/config/commitgraph.txt
      	commit-graph file (if it exists, and they are present). Defaults to

      ## Documentation/git-commit-graph.txt ##
    -@@ Documentation/git-commit-graph.txt: data.
    - With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
    +@@ Documentation/git-commit-graph.txt: With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
      filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
    - enforced. Commits whose filters are not calculated are stored as a
    --length zero Bloom filter.
    -+length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
    -+configuration.
    + enforced. Only commits present in the new layer count against this
    + limit. To retroactively compute Bloom filters over earlier layers, it is
    +-advised to use `--split=replace`.
    ++advised to use `--split=replace`. Overrides the
    ++`commitGraph.maxNewFilters` configuration.
      +
      With the `--split[=<strategy>]` option, write the commit-graph as a
      chain of multiple commit-graph files stored in

Thanks,
Taylor
