Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937E9C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631E464F56
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 16:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhCGQh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhCGQhA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 11:37:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA6C06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 08:37:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m9so11112538edd.5
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 08:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3bQBGIthHHNp/Jk4VrY8MDud4keJ4ydUx+VXAmpRmnc=;
        b=E/XB9sOi8YvM356hxj3kvkthTAG0esstqyfKV3qsz80P0/V6KBBUs4fQG7kw0oxAdU
         /lRdhbQCDNNRuTdPUWdbfQczcpfC31s0MTWQNd6EO4IAy84urv+aA4FJRQe/IJ69m3h8
         LGBNKFrO1zHDQ7AiOc5QVwtpf34P/wqYs7mh88cawRvoN6d7EzCCVQP5zqJb0KGsTn0F
         1GOLvvfNhfBDZ+WnDGL2xZnGHFOR+2MjtNNATES4EXCu7nA8Qy65/l1ysS44PDPIhh78
         SaTNKqIwNsi16DraxdWXMxyQ3WFdRqt3l5iwcJG3mDz7DbeRhEaQaUJqHVU+B/YFrS4T
         Tc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3bQBGIthHHNp/Jk4VrY8MDud4keJ4ydUx+VXAmpRmnc=;
        b=NsprJOAfevIxRP00vthQKKzaHt0cu3Y1El7hfMrjgBpGDcBFvKDnjKes0+FpM4zRJg
         gQN5J7824lGWpqKI/pGaKXw/Rp7xSHnRClP5EdPFSVCUgT+glN+/CSRaTXrvf5TqaQW1
         wj0oQCfzlJ4NKmJiYjQ/RqgSoXeJdORa3312k3yqa8SrqC9pn7qHTceiMdlMgNIVSPM7
         qq6so00MhA3iEAnnyRBTbaBK9EYVBpuHeyqFBE235+vDqlYKwOsZWvhZoUvFnhIHP9uj
         MPlZBCxrh2pLZhOx9pv5DrzInKy30pJhJ8kIr8iIr7dH9hge5OFrL2/2pxVHT6rLLrIf
         O8Mw==
X-Gm-Message-State: AOAM531DfGAHMT7INybdpZ9xpM0ui44GvBJMfSWYJ9yEsErTjNwLL3tQ
        ppNocvNIUccGLCRSxAiDTM9G0cjwaXs=
X-Google-Smtp-Source: ABdhPJyrs42rkguiWgyJadpL4RU5n9huFAQEFlEjfwtv7GyDsDL+A809sbnTRbfOXnA1uu/hfASQNQ==
X-Received: by 2002:a05:6402:50c8:: with SMTP id h8mr18016463edb.360.1615135017944;
        Sun, 07 Mar 2021 08:36:57 -0800 (PST)
Received: from szeder.dev (78-131-14-12.pool.digikabel.hu. [78.131.14.12])
        by smtp.gmail.com with ESMTPSA id v13sm5726239ede.5.2021.03.07.08.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 08:36:57 -0800 (PST)
Date:   Sun, 7 Mar 2021 17:36:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mktag tests: fix broken "&&" chain
Message-ID: <20210307163655.GD3590451@szeder.dev>
References: <20210211015353.28680-2-avarab@gmail.com>
 <20210307132905.14212-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210307132905.14212-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 07, 2021 at 02:29:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
> remove last uses of GIT_TEST_GETTEXT_POISON=false, 2021-02-11). This
> would have been a failed attempt to type "C-x C-b" that snuck into the
> code.
> 
> The chainlint check did not catch this one, but I don't know where to
> start patching the wall-of-sed that is chainlint.sed to fix that.

Chain-lint only checks 'test_expect_{success,failure}' blocks, but
this && chain is in a helper function.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t3800-mktag.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 60a666da595..6275c98523f 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -17,7 +17,7 @@ check_verify_failure () {
>  		grep '$2' message &&
>  		if test '$3' != '--no-strict'
>  		then
> -			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&xb
> +			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
>  			grep '$2' message.no-strict
>  		fi
>  	"
> -- 
> 2.31.0.rc0.126.g04f22c5b82
> 
