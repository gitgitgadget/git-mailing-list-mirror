Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A523C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A7121D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RObCm6ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIRQ1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgIRQ1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:27:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F7C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:27:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so8872930ejb.12
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jg8pQ6dWOGwK5gIDUc7UBpb/g60yQIsiAF61+ZE4edI=;
        b=RObCm6zeDLyPWtJCFeJnQAjnKfgN2vKscv5lLa9g303bAO6QSMANM31DPOTSkZSgSB
         ZwgmEzTvIvzyfD9p4+93aNJImpTOeYL9WZzGhA3AerMO7ViI1BUMfue29GDv9a1I/FsS
         o08o72SIwcW6EjRWmaU8FYw39HaMIjxWLqUN28jADxoW9fdb3uYsj2jc2962UBzsH1U4
         uFrWl6DeQSbyfRcTHLIjzb+nIZOqQe4E3pB0Nb91fwBhLHGB/+W9MlOzMpmIZb6umBhk
         pEVXxxP/fn1L1o786dPW8TGnv0wCRmfCU4c/iLt4c9y6YDrRCKMxNcT7ZLEAiqYuZSwX
         NCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jg8pQ6dWOGwK5gIDUc7UBpb/g60yQIsiAF61+ZE4edI=;
        b=lnVxI3SDtmJ03/V0MseTOcN8Qc3w9v09ZJaSrIm5t4Hly7dKJNAxrghnEGNfZQGH3k
         ul0/GZGg/8y9CQHcZxnmtwWtmZ9v7EaBFvC+2RBcoCzjUI/WrBEWE6wyr7Slr1u1RRQF
         xImwNmJpT+B7WhidftgSw6S/d2ThWCMvSO3FfkNH18qiNBHIbHCRoKLbPFtWk9fJ9pJ+
         VLUgi7CADnEc5clC9T2k0QpkAHpZJKMooCpJ9Ut4az0a0kq1eqIQvZOac2d0BqGSqscm
         ixhj+S1FUKU2wCTHPwDPrHHfdXojC3XV63BmjBNbYgV3CV0TiIdkz0pxchgMyCmVAYNO
         w52A==
X-Gm-Message-State: AOAM533aw/1hmhiaCfYBiBPVAnXphdQipOuGZ4E5cAuUvyE7gyZshsf/
        GkWpUoF87Gl4GoseQ3vzyvg=
X-Google-Smtp-Source: ABdhPJxGpakKgRHOw9TF0Ec/1/9myYJa21otPyYK1dvp/DpBf4yYgfYWAnZpnpAOLJf4/B3MiHl6bg==
X-Received: by 2002:a17:906:5611:: with SMTP id f17mr38787959ejq.427.1600446466143;
        Fri, 18 Sep 2020 09:27:46 -0700 (PDT)
Received: from szeder.dev (84-236-109-2.pool.digikabel.hu. [84.236.109.2])
        by smtp.gmail.com with ESMTPSA id p5sm2534399ejd.56.2020.09.18.09.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 09:27:45 -0700 (PDT)
Date:   Fri, 18 Sep 2020 18:27:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v3 08/13] bloom: use provided 'struct
 bloom_filter_settings'
Message-ID: <20200918162740.GA25148@szeder.dev>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
 <3745baf8ef8810fe8e6031d06d2f6b8d967ef13c.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3745baf8ef8810fe8e6031d06d2f6b8d967ef13c.1600397826.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:59:27PM -0400, Taylor Blau wrote:
> When 'get_or_compute_bloom_filter()' needs to compute a Bloom filter
> from scratch, it looks to the default 'struct bloom_filter_settings' in
> order to determine the maximum number of changed paths, number of bits
> per entry, and so on.
> 
> All of these values have so far been constant, and so there was no need
> to pass in a pointer from the caller (eg., the one that is stored in the
> 'struct write_commit_graph_context').
> 
> Start passing in a 'struct bloom_filter_settings *' instead of using the
> default values to respect graph-specific settings (eg., in the case of
> setting 'GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS').

I think this description misses the most important aspect of this
patch: it fixes, even if only partially, the half-broken fix in
0087a87ba8 (commit-graph: persist existence of changed-paths,
2020-07-01).

That commit, among other things, tried to make sure that we use the
same Bloom filter settings to compute new Bloom filters that have been
used in already existing filters.  However, it only read those
settings from the header of the existing BDAT chunk and wrote them to
the header of the new BDAT chunk (and printed them to trace2 output).
Unfortunately, it didn't actually use those settings to compute Bloom
filters, because it left get_bloom_filter() unchanged to use the
hardcoded default Bloom filter settings.  This can result in bogus
commits-graphs and, in turn, pathspec-limited revision walks omitting
commits that do modify the specified path.

