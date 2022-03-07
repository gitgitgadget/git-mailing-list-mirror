Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D2C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiCGXdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCGXdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 18:33:39 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997D26560
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 15:32:44 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i14so12829418ilv.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=krQR4nU6ACSuGcVT54yqE9wgK4Zc/9NKOXXiYkn0ldw=;
        b=5J/xAto/r+dcNL5O4WxUpGZX60sL4aELK6ZzApRNGNr2+ut4Vvt34usAHHxO4M8Qj7
         mwW355f0LZloXvjZorvkUFwQdfYxyYsrkFcQi8vXB7JI0MhWigV5QPmU5ySBmaZYiDCu
         WJUyD1jZwEcCqPT7dOC78no7XliwDGGk4/AXp8XIG1Qhjt3UWze1T/O8baqMi7Dcjams
         yjeebUhHwaoOzNA6QcFxGFfqJoDCoY4IavRp7J0c64wpX+tJwsQ4N45vjSNKRqQt5w/z
         T69256lGhOmGPeV5Nbi40Vi+6jkkE13wze1jOSZMmIT61p3gMZadQwx6VWZfNiiJvs6b
         kAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=krQR4nU6ACSuGcVT54yqE9wgK4Zc/9NKOXXiYkn0ldw=;
        b=qdsLUGVes/pt7B4nH7JZmKniPeU/t6MHbXLj7BJlrJL/i6HEKViZDifFjpnUk1vRH0
         lnO3fQWNMoXVPVcPTsPBElkCCOLNxvonKuOlwKCIKNb5xx2ckDrzyGlmOHh+/ZG8MRHb
         3b+/iuc0WFT0z7rYEgCA2l4vS3pJs/ItOY3lqPzfOm8UymvyK60t8P+j3cUuTMXE2HL+
         bSvji1hPslVd0IIWPGizTPKnDSoWGV0/CnYJfyQlU3+n4bjTNoimSjESSRe5Hnx/Z/A1
         GD1NHXsRArSScS8Mtk0gliMR3b3SHsDH+3ihCdlz1J/ZAZdGuyM53Gx+6SZFN24gPxMy
         vf4Q==
X-Gm-Message-State: AOAM532zvUvbpqx6BAgXTwv9/uUdMsGgihmBztOMdzUAS5pR6Zu08wB2
        ycTlSJoP4TC6Fnzq/WjewJUst1bSdeqCpP9V
X-Google-Smtp-Source: ABdhPJzVCMhu9kS159alLfvOqSDInApld9npTmLSNkmWs7JDw6hrs1yn2cvRdlk+BJRz9MhX8RWkfg==
X-Received: by 2002:a05:6e02:1c86:b0:2c1:a67f:3d37 with SMTP id w6-20020a056e021c8600b002c1a67f3d37mr13361209ill.298.1646695963784;
        Mon, 07 Mar 2022 15:32:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c12-20020a056e02058c00b002c63f71c7dbsm2776464ils.56.2022.03.07.15.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:32:43 -0800 (PST)
Date:   Mon, 7 Mar 2022 18:32:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] block-sha1: remove use of assembly
Message-ID: <YiaWGrBNuk1+j89z@nand.local>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 11:25:52PM +0000, brian m. carlson wrote:
> In the block SHA-1 code, we have special assembly code for i386 and
> amd64 to perform rotations with assembly.  This is supposed to help pick
> the correct rotation operation depending on which rotation is smaller,
> which can help some systems perform slightly better, since any circular
> rotation can be specified as either a rotate left or a rotate right.
> However, this isn't needed, so we should remove it.

At -O1 or higher (at least on GCC) this optimization is indeed
performed. Here's a Godbolt example that shows this:

    https://godbolt.org/z/9zMP93hr1

so I agree that this code isn't helping us at all. And in the
meantime...

> The downside of using this code, however, is that it uses a GCC
> extension, which makes the compiler complain when using -pedantic unless
> it's prefixed with __extension__.  We could fix that, but since it's
> not needed, let's just remove it.  We haven't noticed this because
> almost everyone uses the SHA1DC code instead, but it still shows up for
> some people.

...it makes it impossible to compile git if you have
`BLK_SHA1=YesPlease` and `DEVELOPER=1` in your environment. So I am
happy to see this go.

On another note: missing Signed-off-by?

Thanks,
Taylor
