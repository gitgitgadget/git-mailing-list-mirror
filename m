Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2883EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A61160FBF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhI0Rwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhI0Rw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 13:52:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B5C061775
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:47:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y18-20020a1709027c9200b0013de17ef8fdso4747232pll.21
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QW62CRgyP565TLl4CNlEq6/AaZ4iNFXMg8g/nTipXEE=;
        b=eqhrJE2mwK9zPFMJ0Av36nMr3pUJpgnl3laS6ChSz10xzLENIfP56AKIM4KiE0wR2B
         t1ObhOZyW5A0+nl9EZFzRjgjEErU/pKojFGfwZwE5foXc2mU4udoQY8lG2WrYnq24r4p
         9fOtEn7is1fiYaMLwSh6otxOUu+PNrBDWLZO3C16F9+zbFRktPbCY28mmXQAdFB4vO/c
         zlzUhCSmzSWpkGtF+PMYrfspVhbiD6RNKUMflEiSWWWacxF8ZT6adT959ar4xWntqqQh
         iulzvj0JEN+UJGx8DYXicObpJl2Hchksh7eSvJhCNZtEUj1+T+7m1oitaRYSmOqcha7G
         emxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QW62CRgyP565TLl4CNlEq6/AaZ4iNFXMg8g/nTipXEE=;
        b=lT6aPwTbjju+pg9VOU6dagbFpRk6AAz1JzoM7ClP0d49aUdZRAuVQywbiGiT8ENLTY
         IgxuMGUG+0w42K/9tnZ73ETxfUyZWo2WSELVT55ktU2tLbOUkQPgJtLS/X0kCiJcGeVj
         +T68i3uTKNfx8XBSZbm8RXYA+JCaLenqGYZnYKrLHD+6tVh7gouVqLb/fxqe+45HaVMN
         sWro9qA71XtYP5FJ5vD/LProl7qTXPXNXkyVIkfpujnFgmvHPcpMbAWVJHvKeHcDGLIZ
         /lrjnYa3pTP10tMwtQq9CMnP7XxSAGi07asrolfZzp6IxMF/cETAjUey0cgS6aIPlYdt
         L7bQ==
X-Gm-Message-State: AOAM530qYuXrbEAbc8aBydO6hCYEbGGFQeLyopGbiHDOola/g+U6xMxi
        9jDi3Vii9bx5M3laUwNNtngBfDvKibpuOQHHUTwv
X-Google-Smtp-Source: ABdhPJzo5mym7tAKOp91fV6A7LvsejUVwALmujarvNnzHD0j26cx3HIaHNvQJQUHDkjxi4rv/S6cAP+g5RNF1PyfLC4M
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:4ecb:0:b0:447:a583:ce8f with
 SMTP id c194-20020a624ecb000000b00447a583ce8fmr1102407pfb.59.1632764826271;
 Mon, 27 Sep 2021 10:47:06 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:47:03 -0700
In-Reply-To: <YU4dkMt6rWhmsOlq@coredump.intra.peff.net>
Message-Id: <20210927174703.530229-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YU4dkMt6rWhmsOlq@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH 16/16] refs: drop "broken" flag from for_each_fullref_in()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> No callers pass in anything but "0" here. Likewise to our sibling
> functions. Note that some of them ferry along the flag, but none of
> their callers pass anything but "0" either.
> 
> Nor is anybody likely to change that. Callers which really want to see
> all of the raw refs use for_each_rawref(). And anybody interested in
> iterating a subset of the refs will likely be happy to use the
> now-default behavior of showing broken refs, but omitting dangling
> symlinks.
> 
> So we can get rid of this whole feature.
> 
> Signed-off-by: Jeff King <peff@peff.net>

All the patches look good.
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

As you have mentioned before, this clashes with my series [1]. But since
I'll need to update my series anyway to reinclude the
DO_FOR_EACH_INCLUDE_BROKEN flag, the obvious thing is for me to rebase
mine on top of yours so that yours can go in first, so I don't mind
doing that.

[1] https://lore.kernel.org/git/cover.1632242495.git.jonathantanmy@google.com/
