Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C885C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D1E60F25
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhH3T6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhH3T6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 15:58:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6458C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 12:57:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f6so21586866iox.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTiDDdceJr7IouJQRQ+mFJbLj8z0tu/OpyG1BcdbngE=;
        b=xrHd1e0RVuNl96M4UCxMKpWi1bZ1AX571JJkPQVpiS+XuVz00rFaBJlFU5oV4V9tLt
         dEY3dvcsdvFe0S9FaDIIa3rOYPs8KPrCTs+0LXHehFWMxOMSAT/xv8Z6iCNvK4rbLjUr
         zcRKqlfY0PS8R2yU5L5gklF0cBTu49NamYNDIXXi1Oyj3d4xdDpT/tCTry9r0iyiAOQc
         z2kvFtwRq5qij7LF0vDR3ITo2qJAI4H/wW+e7PyOchZUT5mpURAK1jLo4fhy4UYath6X
         KayP6JRjDevJ4vGCC20z9Ak7Apvqwim1v499F7bJKqttc5hqYG7hI5wdeiGAaoMk9jlo
         qGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pTiDDdceJr7IouJQRQ+mFJbLj8z0tu/OpyG1BcdbngE=;
        b=GNyGBcaLKLb6Ft56zlkQ386aUNzdod7KXkx2OhXAD3EVOJKGtRmbovTegHXRlZXGs0
         sJaWyEEWfyg7F+RArEEVz6syDCzG3/CC8a1djpEFd3dvWfd4n704fX+mtxm/x05ogRZh
         gT0hZ/E8YM+WWD2Qbn+DZrNDMp7VU9bKxHsgNpAEccNFkIGd6dksb/b7ePg4TOKT+7MW
         Dr+LIxaa0gglx3E9zVS9kO8lcU9Nq4nmEUnkic5L3IurKqMlSltbvM5xJASW+1KERQNR
         nPU0ZQqLrU6b/wQ6SYjF9M8CHmMM1LTCJ46VarRiZFTfPGMzCNmWJEPw37impPn+BtXD
         2zrA==
X-Gm-Message-State: AOAM5304BiViwZdw41zhW3IluydBTpNDGl1HYBLMt2LLgr+wMVuu6Mi/
        eYvbqNMNUIFUrc3Ue+bA2UfMhA==
X-Google-Smtp-Source: ABdhPJw54Axh76I7OQMiptRhJfAhi4v2jdVGv1TeG/J2n8l72ySQs+vtVuvMIL0+M92Q8Yq2Nu1maQ==
X-Received: by 2002:a02:9f16:: with SMTP id z22mr111993jal.18.1630353438324;
        Mon, 30 Aug 2021 12:57:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10sm8859588ils.13.2021.08.30.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 12:57:17 -0700 (PDT)
Date:   Mon, 30 Aug 2021 15:57:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
Message-ID: <YS04HFTC3SczuWS1@nand.local>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 02:48:45PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index 49718b7ea7f..16a99382770 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -88,14 +88,15 @@ test_expect_success 'for_each_reflog()' '
>
>  test_expect_success 'for_each_reflog_ent()' '
>  	$RUN for-each-reflog-ent HEAD >actual &&
> +	cat actual &&

Nit; stray debugging.

Thanks,
Taylor
