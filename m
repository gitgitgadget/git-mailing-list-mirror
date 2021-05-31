Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DFC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A1B61263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhEaKCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEaKCU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 06:02:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06EEC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 03:00:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e15so4987470plh.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=esK+VNp3gsoccmo5n+3tLWaR4WbnsxS6wR9Q81yzr+w=;
        b=NTPylAF2cAPHCDtiE+EaJf/HwUjeGnNk6Q9qHh2sE/siSPFs8nCK8Gd/ncPV+NUmoE
         mixJ7aXmflisoauUixquc1WSWxFhqXtVbXaGNG+LR5M+bjbgJHWLD6lsCR9s+lEXqp9c
         Bd2AfFoOQwtMqq52sFuonMmPYKk/dOW2Ic8twYLSLhve+qU9YXU886uIGpMHLlET4HZ+
         7w7DT/ICBipsC/evPFk4fwiUPWZFMduRaylz22zgV7OnfoElEBNvcuLSQSsotsMFKopH
         FqErpG9cQLnM4HgCyxRQojoy3mz8hgW0qn6uXS/pzeJfFrF123rthenlxqjfOY//gb00
         Xj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=esK+VNp3gsoccmo5n+3tLWaR4WbnsxS6wR9Q81yzr+w=;
        b=YtZdWInxtD7HGMVbRKc55bBSECxW2T8Ic7GZ8DhzMiu8PCq9P3BMETFloO/Oz/3doK
         LQz7UGSosaN48yP8dzcXApIAbYJVGcTpeDBBc1OlZh65jyf83kl/MuP7nrUjC3E56Gkt
         e1bSEDkMtNWRIi5Nflo+h+hKcRD1cQag9kHdj5tMmYGVl1B62WSJi5QkpgCMJm6xboUn
         PxxIE3ZFvrcVYBDhGYrXWuK+b0qTY2b/7lOhYoTtdDnNfgsA/F/4X1SEYYcz/iiEQ2ch
         mcon0gxqXuaxsiAABhwGBsIzBxzwfj+KsX8QZX9CaxGLj4SpUKVqp6SS5nLGw6Irbt34
         QTOA==
X-Gm-Message-State: AOAM530zLfY+TPLoUWs4GfQs1KMd8nN9YBDuWBgfYQ3PL3GuxrUfUIzm
        UAWHxtSAfvcPNRY/tNSpks2Js98PLAo=
X-Google-Smtp-Source: ABdhPJwCEJyBrR/M91mkJ1L0vEMJzS+8vLbih5RIf2ddLZ96ZXPkD30jkZ/hmp7BHpI9IvuikVmEdw==
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr13693660pjn.44.1622455239243;
        Mon, 31 May 2021 03:00:39 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id b21sm10207663pfo.47.2021.05.31.03.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 03:00:38 -0700 (PDT)
Date:   Mon, 31 May 2021 17:00:36 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andy AO via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Derrick Stolee <stolee@gmail.com>, Andy AO <zen96285@gmail.com>
Subject: Re: [PATCH] describe-doc:fix a obscure error description in the git
 log documentation
Message-ID: <YLSzxIyULB1CcIdQ@danh.dev>
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
 <YLSGasYc4wVoOfYt@danh.dev>
 <f34de283-d749-854a-0ed0-d4e244dc259b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f34de283-d749-854a-0ed0-d4e244dc259b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-31 14:49:32+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Hi Đoàn,
> 
> On 31/05/21 13.47, Đoàn Trần Công Danh wrote:
> > On 2021-05-31 06:00:56+0000, Andy AO via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > > From: zen96285 <zen96285@gmail.com>
> > > 
> > > The git log documentation says "The default option is 'short'." This is wrong. After testing, the default value of '--decorate' is 'auto', not 'short'.
> > > 
> > > There is no difference between 'auto' and 'short' in terminal, but there is a significant difference in how they behave in the shell.The information generated by the 'short' can be saved in shell variables, while the 'auto' can't.
> > 
> > Please use your real name and wrap your commit message at 50
> > characters for subject line and 72 characters for body.
> 
> I think the case here was Andy forwarded this patch from someone, which
> happened to be also himself. Maybe that From: line above can be removed,
> unless that he forwarded from other people (in which From: line must be
> preserved).

Andy is using GitGitGadget bridge.
That bridge uses its own email address (gitgitgadget@gmail.com).

Thus, the identity in the RFC 822's header: "From" should be ignored,
and we should use the "From: " line in body instead.

In principle, GitGitGadget will use the Author identity in the commit
that was pushed into GitHub to generate such "From: " line.
So, it's Andy's resposibility to configure correct core.name and
core.email in Andy's machine, and create a commit with correct
authorship. Otherwise, GitGitGadget will create above message.

Hope that help.

-- 
Danh
