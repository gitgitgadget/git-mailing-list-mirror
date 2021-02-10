Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27258C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD5464DFF
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhBJXVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhBJXVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:21:12 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E63C061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:20:30 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a1so1735995qvd.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ltwa+BphiiHdeBcsErYSINg3U1gzAJJjvNrdEQc1W80=;
        b=cn41zsnzJXPzipL46VBBT+pclYC/0nK35q7JcQQ3ZeYSXupXBVG6MaHMlaNrymcXsd
         Ioys5xb9zwopmb30Bq4TR+8VAYrKHZ7tCoz0dfc7ygDvBJNwIn/EJVO4wNhwxkR8CDa5
         LCMajRFv0fOfiLGnpUvOoz1H0h0QY8ahYrOk509wm7mkmRCayra7mEa1xyi4GnRt67V5
         v4L9Ko/cd/8kTf6ZTVa30ZIa7Y3cU5ZI4MnY+h6P0TOB2dyAxBb6XeggO2pkcFdcwhrV
         AfJDUDlMP5Rt1Mc6YMCbuRKHG3K3OHFWnymZZYl0rng6w3dSIFskm10JJg8bLL6r7ErW
         NqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ltwa+BphiiHdeBcsErYSINg3U1gzAJJjvNrdEQc1W80=;
        b=pJfma7dh6DSye4Y7OFitX8iwvIPhA7Yx8Y34CE+NToOy94seCI0hFLVm6iiumN6qyM
         7JgkCsH9D0lpDGczo1gF731AT/oEGjlUInBrEPtyCXboMioBduk/aQXLrocX6figY9rd
         vmAB7bDt2KFDcrJqdD+zqqfx/BEj6ITnLhafQQkV2q8+PAdqE++mHom50xNON/17pR2O
         vwD5HQSgR3qCWwcp63b5ByQHj3ZO69EydAwTklA0+NLAgsCp5JXdrFeLscCrEm9+b8dp
         SnZM+6VX/xjBTYNI+UuZKCka4yQJPCMQgj1LEvv4lj01aK8gDzh0y+EfNCR4yzn1nesU
         FTMw==
X-Gm-Message-State: AOAM532JRykXopb0tXM3eJPiyJ3o4ikeniNm58iHmzyLqu6ceR3+ZPDS
        CUyDiqtuI1YhZ1VDj7rNnEqggQ==
X-Google-Smtp-Source: ABdhPJwQqmNU2V8Ffz/dLkpE8jAP0ksOVZXe1Brc+X90FBOV+B32ur7zxr9iw5D+59OYCIUbiNJLug==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr5397829qvc.20.1612999230110;
        Wed, 10 Feb 2021 15:20:30 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id j13sm2460155qkk.118.2021.02.10.15.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:20:29 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:20:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t1450: robustify `remove_object()`
Message-ID: <YCRqOVS/iXp/d6Rc@nand.local>
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
 <24d43d121162a9052f31c760a5fc929fdaad76b5.1612980090.git.gitgitgadget@gmail.com>
 <xmqqtuqj1wzg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqj1wzg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 12:36:19PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -test_expect_success 'setup: helpers for corruption tests' '
> > -	sha1_file() {
> > -		remainder=${1#??} &&
> > -		firsttwo=${1%$remainder} &&
> > -		echo ".git/objects/$firsttwo/$remainder"
> > -	} &&
> > +sha1_file () {
> > +	git rev-parse --git-path objects/$(test_oid_to_path "$1")
> > +}
>
> Yeah, back when 90cf590f (fsck: optionally show more helpful info
> for broken links, 2016-07-17) originally introduced this pattern,
> we didn't have nicely abstracted helper, but now we do, and there
> is no reason not to use it.  Nice.

This has nothing to do with this series, but I do notice a number of
other uses of test_oid_to_path that are doing this exact thing. In fact,
many of them don't use "git rev-parse --git-path", which would be
better.

I wonder if it's worth a clean-up on top to consolidate all of those
"combine the loose object path of the object with xyz OID and the
$GIT_DIR/objects directory".

In either case -- and I think I'm pretty clearly being pedantic at this
point -- do you suppose it's worthwhile to rename sha1_file to something
that doesn't have sha1 in it?

Thanks,
Taylor
