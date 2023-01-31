Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E74C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAaQUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaQUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 11:20:53 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCD19D
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:20:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w3so5177769qts.7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Rvmtp4RQKRcBz93rCzCxN162iN8liGr4EWSCJVmOU=;
        b=XO6WOJMhUey1SKYVQlY14bI49kCNTP9PYQzmM1obEOvR5wre1nDFgQe44/MqYURi6M
         Eo9GdDGcTSS/k/pxVbWiyBLo9o2ZEdHJPIH3+/pkBJbNDh95Eq2tOjJUY4Fnm1DpNYCp
         atz9aQocXeKKyeD5ma6nrCuXrkWygTdUMm3JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4Rvmtp4RQKRcBz93rCzCxN162iN8liGr4EWSCJVmOU=;
        b=YFBqKBtxFL/NL0fFzvbHYv9U6iCCeAyv7Ze1UL/3+VR7f7DiSviSpV9ZdYCZ8LsphZ
         ZqKNluIAMWGl1Qj7YoKw9UbhwbmHtPkuO2cnQ2YEkgtWABHLtMGAckCpd377DR8r9D0F
         VO+mobtjUUvwwae5Z5Oe8v4iQTsEUpqfuD/Hlt2DvBMYh/bxrCQr4vdNT6Mhyoexb2t9
         UxPWJbvEG1PTMEnFzZEblThzvxLr8ryiH2YYAD3K04xuowm9FqLm/34n5DHWKWGdnUMn
         QeqFrnhFAlyyki7ZFoGHRDRVP+zo6GZqhBRjV9IdFYpQQj9A6NQNpDC5/EVWzQ+nIbMW
         A40Q==
X-Gm-Message-State: AO0yUKVxoDAFcoAam1pd/Z8vCzh/bYGowjbV9TF7gcLZk3Iq7GfY5jX+
        RDAay9DLrdVhIl4vqvKd3QTVS3IYtGUpdMFl
X-Google-Smtp-Source: AK7set985Ko31Cb63WxrgCEzomqAYTIVJrGWLFkkQ1e3o50mpUrdwRLvsvemlbgrFlL5CS2YDJQguw==
X-Received: by 2002:ac8:590a:0:b0:3b8:2ea9:a08d with SMTP id 10-20020ac8590a000000b003b82ea9a08dmr23602095qty.52.1675182051841;
        Tue, 31 Jan 2023 08:20:51 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id p64-20020a374243000000b006ee8874f5fasm10152661qka.53.2023.01.31.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:20:51 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:20:49 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <20230131162049.mgqdxcucjesw4afr@meerkat.local>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2023 at 10:56:52AM -0500, Eli Schwartz wrote:
> And for tarballs that are generated once and uploaded to ftp storage,
> not repeatedly generated on the fly, we know the checksum will never
> legitimately change, so we *want* to hash the compressed file.
> Decompressing kernel.org tarballs in order to run PGP on them is *slow*.

FWIW, the most correct way is:

* download sha256sums.asc and verify its signature (auto-signed by infra)
* download the tarball you want and verify that the checksum matches
* uncompress and verify the PGP signature (signed by developer)

This script implements this workflow:
https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball

-K
