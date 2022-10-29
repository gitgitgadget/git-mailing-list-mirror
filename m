Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0515C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ2SAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2SAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:00:14 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9657E2C
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:00:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p141so6973285iod.6
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5B9hta4A4lrgUZc1pXbTHEDteyZxE4OgegU8DZ3hBo=;
        b=HwlgjH/nYZZgtfUYGcBFkZHdLaUlzUnTudl1WgCSgQbs+w1WOKvlMTjbKGkY1NFxoR
         mYDAAOyhex0gUisnyt4C8lhzHUzdrSC4fnCJD7zKrHR30Cqhv9HMkrIkY/u3G2i7ZI4I
         OBNIkgtZR953N8YKZv6rc3tlgCYZweFm5qD6L1fSsfcSIGzu4W+9LW4SHXXHIkGjqzj4
         1qWxaw9MxTPI6Ovu997IwLppR4p7y4SPgZixz9wOgHvXr6R7jr6AG4lwJMBFNtAnw04H
         p1eTcP2LzpkzTjn6TtW7t1iTjgxoIuXoOMzQyEn4P8aon3PRHIHtMZxtt/N7j+RS455y
         yv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5B9hta4A4lrgUZc1pXbTHEDteyZxE4OgegU8DZ3hBo=;
        b=6AoJt6I2mQENYGUq+fH/A1iBoo9OPMgYAjwiF5jyEH8DTRMo4tIE87tShV9iFHv/ve
         ZkpPU3A5Wm4YF5mUTcMKcGSAJ6J1LCeHQaLh0WRXzVjcmQV6KcI+iVDQoUOGGiYtGmfC
         y3VGHoBDsENqn10pzYsMtIQCNy7iGLd2rFoiPtGyqyVGyIRFWRTp/DVrClLEQGzgn64T
         eVXWE824t3BVg6eRxTiHOdn1Ql6FGG3uw3rN+a8PEq4gYZ2fC48KDQTkxo4uO9QGlet6
         7MuXHNXBbvXKVWHF5hnqw7kWSuc0daCy91E0xoTdX1aEPvXPx4zDT/wubMg6Rim9Z5aR
         4YKg==
X-Gm-Message-State: ACrzQf3RvDBBE1MF/vw/EbCsUUACE6xYrvdmLBaAeJd9pdnRrFCcAC7s
        o/jT443S3pGvmrhGDskC1k7h6Q==
X-Google-Smtp-Source: AMsMyM5282PmiMeSDw6bOszUlPQj7/yRT3lSrJ0HyM8EQp4Yi9cM+AXjStv0hHysTAc1JrO5mtPUaQ==
X-Received: by 2002:a02:9090:0:b0:375:451f:a537 with SMTP id x16-20020a029090000000b00375451fa537mr1665402jaf.167.1667066411200;
        Sat, 29 Oct 2022 11:00:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18-20020a02b0d2000000b00363ff12ca47sm818524jah.125.2022.10.29.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:00:10 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:00:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH v3 0/2] Add mailmap mechanism in cat-file options
Message-ID: <Y11qKQCWvdH5zDYk@nand.local>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221029102459.82428-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221029102459.82428-1-siddharthasthana31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 03:54:57PM +0530, Siddharth Asthana wrote:
> Siddharth Asthana (2):
>   cat-file: add mailmap support to -s option
>   cat-file: add mailmap support to --batch-check option
>
>  Documentation/git-cat-file.txt |  6 +++-
>  builtin/cat-file.c             | 27 ++++++++++++++++
>  t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)

This approach in this round looks OK to my eyes. Would some of the
other reviewers (perhaps Ævar or Christian) chime in and see if they
agree?

Thanks,
Taylor
