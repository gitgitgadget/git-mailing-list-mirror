Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB4C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7392082F
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 23:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9tXnHdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGAXGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgGAXGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 19:06:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCDC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 16:06:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm21so2257769pjb.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ODfvVlTrvg9Yx/6PjbrS4i58SyGb7aQ1Z4ScXicYu8=;
        b=G9tXnHdEh9NNE7El32WDyPGCeS4gut8u4k/THMI/Hcq1/c2Ap9YZT6cPRjgx5Dpcx+
         FvHmtuPftznjYdfYkcBh+Qh6u/pkcQOY7/op8RELo9BLpTucmqTPJa6qO6JJwDQScc0t
         R4GaFxH5C6g6lKu08srnMSNlM2H1msPKcpogg9tzvX/2ZcVs1gwSZ845omCPUM3Y1VYn
         Rq4i3x7nwjTP0DoEZHHDWsMnsGAT7PTzD3JOJJrOnDzvHJHnuL41rgL+0fLZA8LS+uEC
         RG5b9sit1SBN2vckdRkdgE4jgNgQHcl28YYmUywttnfsLlm0J8moXdMCiHBLRnNldPnq
         ssQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ODfvVlTrvg9Yx/6PjbrS4i58SyGb7aQ1Z4ScXicYu8=;
        b=ZB9egx14AoI5v6/Ae2yqHit01Myv967JUp6Xy6o7dRKVhfOq44/jHwO7Wrn7ez5HLj
         lBJSJa6orPxeJOTm3yTXyCb7RCx4vYQisFGiQB9W1nGfJd2pzyNBQe9p9nWinWF+ktJJ
         3SkhG0qT0kcgtJ2Qbo2NbaXLB8DxJR9Gq83QVLMx88t2xgGT4qlTzmLxz39z9K4fD0LT
         S95sb9Ra1UYyG324frYkcxyK1RQ0zijkVoXZZqOUkwRMmBbYTx77nwQ2fc4LIy4+fIdv
         YbHxOGDl6PTbF0F7aoA9I7QvP4e0/WiMC4TFt1+3nQIGNrgikYFsWBtUF8zyQZw/WrtD
         OOyg==
X-Gm-Message-State: AOAM530w1Yy8TVBeXc1/XWYugndqPWTqFjNKeIs/W83Jun70bqvcm+rB
        PFCj2RTajN/FeuY+TOX3fVk=
X-Google-Smtp-Source: ABdhPJzlrOqlhovsRvPVFODg980SxS2hRdYlS/9ESUSzQmcQefTpiyI6FeM6uiPJ+56LxfWnZQgyQA==
X-Received: by 2002:a17:90a:2c0e:: with SMTP id m14mr6215466pjd.166.1593644810417;
        Wed, 01 Jul 2020 16:06:50 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id kx3sm6026399pjb.32.2020.07.01.16.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 16:06:49 -0700 (PDT)
Date:   Thu, 2 Jul 2020 06:06:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     lin.sun@zoom.us
Cc:     'sunlin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200701230647.GC1966@danh.dev>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
 <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
 <20200701141755.GB1966@danh.dev>
 <1764101d64fbc$ccf9d7a0$66ed86e0$@zoom.us>
 <17eba01d64ff3$50ea2de0$f2be89a0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17eba01d64ff3$50ea2de0$f2be89a0$@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-02 06:02:27+0800, lin.sun@zoom.us wrote:
> Hi Danh,

Hi Lin,

> 
> I'll push the patch to GitGitGadget so that it's will sending from
> the system mail. Sorry for this noise.

While you're doing it,
do you mind changing hasAutoMerge to useAutoMerge?
I think that name is better :)

c.f: https://lore.kernel.org/git/xmqq7dvndnf0.fsf@gitster.c.googlers.com/

Thanks,

-- 
Danh
