Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E252C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDEB21744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GpgeaIdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgGaTvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgGaTvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:51:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709AC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:51:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id v22so17953343qtq.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wY9G07Bn9Y6+Up/y1yEz6swilGr+yl5uDOi6NnL3y9A=;
        b=GpgeaIdfqxI0iUKORYUnShYpB18fcieqgsO301Ah/xA2M5Wz+FjGv5UNNicDhlOsdG
         l01BYXtumRk+53JVG3bmnqR1PrQiIP/QE2UD9UP0/sc/5S0oK5CxOhkZHbu76hca4I/l
         rR3WU3irr3YPAaCVkz9dCVdQosJm0rKZ1esgRY+Ao1MjgbZoBWC9sPUx1vDLUIQh4VZM
         AdamthVwONN5ryHdV/sfbez/IQUAZKADarpy3Vj8kwju5EFgKaFle6RHtR9iE+Qkjqvd
         jLQgf9sAM9ZQL0AL6JwbOo7KK0CN3HlzWrCInrXoq/VRhZgihJMEGPPZ9hqWqo4yjN+c
         yhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wY9G07Bn9Y6+Up/y1yEz6swilGr+yl5uDOi6NnL3y9A=;
        b=Bem1djel4UKiapM/YhC7Kq1X+HCBjvn1u7uwmy4CBF6ghAorQ12drWxiOQ+JMFX7cm
         sciJULrDMXGAJ3Gkf6R63F6xQ6lVZM3v970XHtzfMKrsKCrbb37NowhucGQvbPuoGDVB
         EQhTE/fYjlvtXn9RpbnAaAtvQuOXsxbSWNAIZjqR43rHYhqfvNIliYPvpULZzzGv4O5+
         qeA40r9lCs3V8f5DH1fLWm5+qsw+dW39KaI+VizjbK9ET78OXyY9+OqBiuWkY3X09bD+
         ZAhCxyuhDGbQeU6OKZ9xZ0ixMC93oYXPlGBVml64O5w9svsp/GuSJG7HnMYbG1cQl2HS
         KmdQ==
X-Gm-Message-State: AOAM53126zAc5au8o8LJnOSVaAxvIBx6NwQFYRWOoAsWuP2pV2TKMfQh
        0SEVXb6reSxKh7Z32Bs3FFX0Yw==
X-Google-Smtp-Source: ABdhPJzFV/tl0GeqTJpS+PxyOGhTKQLJeGheKh6wA9CsYvteA3LMhyeor4mP2woJMAMxpTGiytSVrQ==
X-Received: by 2002:ac8:1017:: with SMTP id z23mr5368792qti.147.1596225076680;
        Fri, 31 Jul 2020 12:51:16 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id q17sm2737212qte.61.2020.07.31.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 12:51:15 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:51:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Another Email <yetanotheroneemail@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Issue when adding new files to staged changes using interactive
 mode
Message-ID: <20200731195114.GA3409@syl.lan>
References: <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 12:10:19AM +0100, Another Email wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git init test
> cd test
> echo "test" > test.txt
> git add -AN

Passing '-A' to 'git add' is the problem. See the discussion further
down in the thread for why this is the case. Whether or not this is a
good thing, this will do what you want without '-A' (that is, by running
'git add -N' instead).

Thanks,
Taylor
