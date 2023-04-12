Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB0C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDLUjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDLUjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:39:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA9B59E0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:39:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f6a796bd0so127665327b3.12
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681331955; x=1683923955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZouqtpoPct26J7RWPJ1/8XIXQ56HqY4pHWFdehtPIM=;
        b=v4YfNEgaNIwlF+2S6BmPf+kt9bRvlFB9076BdaE8WxIr4iQFp4KAnLkBrdaUcNl3Fl
         GrxKqkHvHvVg+YwbMK3gKQmzb6r44L1/3h1j55wbES60+sFkGvS7WucsTZomW2hsw0ru
         HS+3HtKSABbnwepVTI4OG8xBTQvXODETF7DjUd8H4obKkVnn9ZyzllXeE+bTlGMqOvnJ
         qwHSoq+Kj3T+3uIiP5lZfyJMiqs102nWR6h85UOdJPGpNIzbRyQdOUvEivdwGEXBKCB+
         eW1/xGTWnj76tx7TxKeaVSNY4/uyVZRCn33Vlf60NeyZ1sL1clTSMwAcn4ZWGB8Tg3aL
         6WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681331955; x=1683923955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZouqtpoPct26J7RWPJ1/8XIXQ56HqY4pHWFdehtPIM=;
        b=DsZXo074EUysfAaaSsZ9iLEq6Uhq0we1D/iRjOqlceqWeUrlorb8SwKoL1C4BTJ5AJ
         JQrxi99FHq9DFf75rwkHLjR4aFi0zo8Gry9B2Y2Ut6kFL7mCi/Lne97GOxPGcWz85Jg4
         MyAhpIUseRUYurNBX85N79mcWqThOQyUQKJoCWeokjfIRP6e4ButepkwTh9N8YNkte4O
         06DlgQRhYPR0f97kXxxrwU4t7XzaEWzpNcN9ny1AzXZoTyKgx8hoQfnyG9GEj8tmKPxA
         hcHl9DEQfC+RL1gdlZuwNnvqNBWJKoP7Cuy3MNQLcsrBMeJ5fydOwqd7vMccswqrcwYW
         yYTw==
X-Gm-Message-State: AAQBX9dXjTaOQXK9UlKneidDw0s6EUb0qbAa9Wz9tUKZXxk0a8v8VaAl
        7/tAdMKaw/e9KwafxOOT8+dzXg==
X-Google-Smtp-Source: AKy350ZmqUQ7C6ncQV4/MeUy3q4JtOB0iGwKF1VN0ySZ2ygLmF8Z8ASz7PDGhjI66nF69n9Grc9Rag==
X-Received: by 2002:a81:4e0b:0:b0:54f:8191:d040 with SMTP id c11-20020a814e0b000000b0054f8191d040mr4337274ywb.8.1681331954791;
        Wed, 12 Apr 2023 13:39:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cp12-20020a05690c0e0c00b0054fae5ed408sm424853ywb.45.2023.04.12.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:39:14 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:39:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 3/8] repack: fix generating multi-pack-index with only
 non-local packs
Message-ID: <ZDcW7LjZkyeGjEsV@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <f82e44f1da47890b7ef6ee2f5c1cdbbe20fa6684.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f82e44f1da47890b7ef6ee2f5c1cdbbe20fa6684.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:39PM +0200, Patrick Steinhardt wrote:
> When writing the multi-pack-index with geometric repacking we will add
> all packfiles to the index that are part of the geometric sequence. This
> can potentially also include packfiles borrowed from an alternate object
> directory. But given that a multi-pack-index can only ever include packs
> that are part of the main object database this does not make much sense
> whatsoever.
>
> In the edge case where all packfiles are contained in the alternate
> object database and the local repository has none itself this bug can
> cause us to invoke git-multi-pack-index(1) with only non-local packfiles
> that it ultimately cannot find. This causes it to return an error and
> thus causes the geometric repack to fail.
>
> Fix the code to skip non-local packfiles.
>
> Co-authored-by: Taylor Blau <me@ttaylorr.com>

Thanks for listing me as a co-author. Doing so probably requires my
S-o-b, which you are more than free to forge here.

> +	# Assert that we wrote neither a new packfile nor a multi-pack-index.
> +	# We should not have a packfile because the single packfile in the
> +	# alternate object database does not invalidate the geometric sequence.
> +	# And we should not have a multi-pack-index because these only index
> +	# local packfiles, and there are none.
> +	find member/.git/objects/pack -type f >actual &&
> +	test_must_be_empty actual

This test looks good, though one small opportunity for cleanup might be
to replace this with a single:

    test_dir_is_empty member/$packdir

Thanks,
Taylor
