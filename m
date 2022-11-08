Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596AFC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKHA7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiKHA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:59:10 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95B12D1D
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:59:10 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b2so10333142iof.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glFwFMOm2i+wU9t0Ul+GH7zfS2fzK5eX9mpkgV9K0NE=;
        b=PlXbO7TjhmC1GiyMwYeXz8XaKKCRGUbbapmQ/cjhE78G2vvA9yT639+bN7xRp0pVGS
         9rBmdmhVK1jHoXykMufH+OCLIe0V51oPYDM0NZpX8WIGPuNVcB4oqET+HQcsqSzIz2xk
         4WQ64Wv8PfropaYduJq1UEfY0ZfkDQt5ld5rnMqjfDrSvJ0HSFNUE+hNXmCXKMwLPrTn
         P1nLfh19NlsgVkhWhec4KZjyK4SvcBhfNhbDbFDgExJiH7WuceomM9F0qWFma0OchUH+
         s14j8nB0IIdFDmZUjHvzOoHh2sM7OE6m+F7uKuVVV/hKvSe6a3qkbpljKfCyg+gK0a+x
         qF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glFwFMOm2i+wU9t0Ul+GH7zfS2fzK5eX9mpkgV9K0NE=;
        b=e+yY++O9Ue2pmjwjaVhKN4iOrmnfxON9fV8nOtIV3BVVIJ0N3cdDsRo/g6ZV9BmZMz
         QnnocibJ6GXs8K7C5fRP/dxhGHIe6oI5srMNAXMl9jSDXaGS4xYKpIbooSs8V2JQ7c4m
         wXy1T+71kFaNHrlXWcHjeWUiZa68U+QJ/DgYeQU/NaM904UWkqi/4kCaOtTJSSV6mVAd
         Yn8FSKkfw18Z8PeU+3kqJa8RObrOpGs0WoZGSvtWa0EHI7xrznUDFDMxlT/ks46ZEqX6
         Jyy7Fog8hfsh/i0zV2jDZpcHM+bdDv4gU3dvr3bid0m0YH8ahyc1e0cxz/kLGwkxnqks
         615A==
X-Gm-Message-State: ACrzQf2bD1vjpAw/XDMh11cj9mMsKNkAwsKW/M1nqhQjMRal1R2BKDiP
        05iD6Vrpf0WmSD+/vqx3QifI4g==
X-Google-Smtp-Source: AMsMyM6VugDEKPzVIknvXgEyTQWp/TIWP4QOfiXStg4SWLKhErNhTK1p6AsM8XXt5+sV0meuU/85nA==
X-Received: by 2002:a02:a40d:0:b0:375:2ef:c7b3 with SMTP id c13-20020a02a40d000000b0037502efc7b3mr31225667jal.281.1667869149738;
        Mon, 07 Nov 2022 16:59:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca9-20020a0566381c0900b003711ce0dc15sm3280651jab.68.2022.11.07.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:59:09 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:59:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y2mp3MZNehiTBKbE@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 01:16:19PM +0100, Patrick Steinhardt wrote:
> Patrick Steinhardt (6):
>   refs: get rid of global list of hidden refs
>   revision: move together exclusion-related functions
>   revision: introduce struct to handle exclusions
>   revision: add new parameter to exclude hidden refs
>   revparse: add `--exclude-hidden=` option
>   receive-pack: only use visible refs for connectivity check

Thanks for the updated round. This version is looking pretty good,
though it looks like Ævar and I had a few minor recommendations. I am
definitely puzzled by seeing '--exclude-hidden=transfer', though.

Thanks,
Taylor
