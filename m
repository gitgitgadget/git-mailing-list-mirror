Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE14C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A4160E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ0W7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhJ0W7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 18:59:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5F4C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 15:57:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso5988685pjf.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+C++ZVW+eHMsYH8kHCjA23NgVrJ7cDWP1LKL/bgWS8=;
        b=CdjGQ+W0qpmM7a4LbkAR6qphHz64lipB/UUsfs2cVgdC9lymAAl+vfwn9PaIn6JWSV
         eEPS2zv2trv45WEbRDSPJlw7N5P9jGxxpZMjoOuKLbajBK3rrg9u2YvfuCvqzNBNAAKf
         1xhV7ungM1RFrSDiLlHq79TAe8sjii7KJ+DLhO69GoSktqe0ynhEwtxJoMIkPXKiwGZG
         4bkP2bFgRhyaoqDsaASThfmUH/NwnoFlMg/OoJWHrPQkBqtO5QBBaQBFacqX5cbGwVyH
         ZLswGPGtC4Km06t5EfBrQ/L8tpAbW5cKng4WKMbokAxfS1TXRc9Fv6kQrdrQP12cWLhp
         j2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+C++ZVW+eHMsYH8kHCjA23NgVrJ7cDWP1LKL/bgWS8=;
        b=zEnDEP35kx1fleMoYmc3QJVpKEmw79zX7UrVYIsk8QuLa6NvkR4dXE+bwo+2C8ja/4
         CZpy2xDJ3uD06loccYy/pJwVmU4zKZsWV2bYZIAGB03LpN5Z9q4gD7kbHzKjsqvoV3bS
         Lwv1KMJ0A85uWH0E9YAUiNCJcW2oKwkOPCtwh0GFvCKKtjcUb8+QeWenNvFbU7tVdMmZ
         bjVzDURwCeUhBacjquLZHQJeT1IuNhmFU2JfDs83UaIUEi3QlotOPcEtllRHGAcdGXb9
         j1FEYnW8Uomouo4WBpkFos0dDmrfGQIF5okYqRkLWW0wrK8br7B/yz8dtV9Zye002Pkt
         6qAw==
X-Gm-Message-State: AOAM533LevU67wX0cDOVFJ3FJbUXnoya4pfxwgQztDM3+0QcvTVWAdqX
        U4TrkIW0ly7cOuLD3JN+6QU=
X-Google-Smtp-Source: ABdhPJyRtW9OJ+MeptopJXLcA3ZNf1miHiOv3zr2ScTtYr1dGA45hE1qkMU4LCpmDyqNFJhdfdP3YA==
X-Received: by 2002:a17:902:d508:b0:140:42ce:c7b1 with SMTP id b8-20020a170902d50800b0014042cec7b1mr541940plg.89.1635375429157;
        Wed, 27 Oct 2021 15:57:09 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id p7sm727374pgn.52.2021.10.27.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:57:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:57:06 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 0/2] tmp-objdir: fix regressions in
 core.fsyncobjectfiles=batch
Message-ID: <20211027225706.GA3984@neerajsi-x1.localdomain>
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2110271439120.56@tvgsbejvaqbjf.bet>
 <xmqqo87auqda.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo87auqda.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 02:09:21PM -0700, Junio C Hamano wrote:
> Yeah, none of the above is attractive this late in the cycle X-<.
> 
> It probalby is best to queue the "fixup!" commits as they are on top
> of ns/tmp-objdir, merge the result to two topics that depend on
> ns/tmp-objdir, and keep them without merging them down, until the
> release.  When it is time to rewind 'next' after the release, it
> would be a good chance to get rid of these "oops, earlier we screwed
> up" commits by redoing the tmp-objdir (and rebasing the other two
> topics on top).
> 

Hi Junio,
Apologies for the breakage! I just want to be 100% clear here: is there
any action I should take with the patches, or will you handle the merge/rebase?

FYI for anyone trying this on git-for-windows, there's one additional patch at:
https://github.com/neerajsi-msft/git/commit/435e1d2e5e8fb422b0f08ff6a01a130584f7e249

That fixes a gfw-specific breakage that affects tmp_objdir_migrate and causes it to
infinitely create recursive directories until the disk fills up (surprisingly we don't
hit stack overflow first).

Thanks,
Neeraj
