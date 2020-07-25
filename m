Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C0C433E1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4002067D
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TMNUylfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGYB1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYB1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:27:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE1C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:27:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so8261153qts.6
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o48nKWy/5+ohs2X4UGqksiHittNgRfCy/TCdKu9mjKQ=;
        b=TMNUylfDdw0FMqVmQpgsFdHenNsyKBtlbT/dFw612Ob3tMAHPBO5i8tHhcuf7lH/Qw
         moLy2n4y+2HMQgKDUli1oAAA33MRBCqn+g7P6e3OCO1jFeGidUI4yVpAvRJEdY/A4BdZ
         J5L4oqmv8Xb1uFB0yLt2aUqweJkc6o32hvHj0VREhPF3KH1090rLVoLb9pw1/aVws0ch
         6EQlhjLJJUSHOqiyxF7e9ztvm8pdKqC3JMQPWik9CpGtl14NDpioTVu58/bVFR47U5Gw
         hUWNbi1qis5IICK28HZ/0hner8J4jk9WrDhQlui8H/ZXV7chTyds9kYET6nhCN6Tto9s
         33oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o48nKWy/5+ohs2X4UGqksiHittNgRfCy/TCdKu9mjKQ=;
        b=mZ9ZZOyiVDSHY/vt/XC8vitXBYdQPwnvKu2tZJyejcRnAHw1NvjJDjbPqmBWqYBmnO
         PnGvVyMShmLiiEhmxvzEmOQKw337baygnz4xwtmbzRhjVX4yuvtiO38byT6sDadAHCZQ
         IHQoj2Mfa+Ra2HfT7yAhiMan0xgYp76zfVTVKGhRr7DjGyhKGkOJvFjbeqN1hqgbTYcc
         RqGfp+F/mjdJu5iuRAo0c6mSb6vQ8xXUiEMepFjZEbGPVxmv1vFY4/+lQuo0kaBuMzdw
         UfWzbjBOdoM/dKcmIRakObQn3g6i6nM9uyyJBshxB8EBL6YSi2p4f+un/Oqb1fArY8iw
         EflQ==
X-Gm-Message-State: AOAM532ndY+S0G2+MiGc+VL/ospM1hayxx4n8Zb7S1MPpBwSvMqyQCvF
        Lc6PpNPcyHfvpsUgT+EO7V0zgA==
X-Google-Smtp-Source: ABdhPJwb7zO3YFpleHTdjxSu67sy7fbncRHX+5SHOaJKswJWSk96Y5KMBNsxGhW3qEWpE4d0fALEAg==
X-Received: by 2002:aed:3883:: with SMTP id k3mr12431340qte.365.1595640420518;
        Fri, 24 Jul 2020 18:27:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:348b:af05:525a:6ad])
        by smtp.gmail.com with ESMTPSA id l68sm1145793qkd.62.2020.07.24.18.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:26:59 -0700 (PDT)
Date:   Fri, 24 Jul 2020 21:26:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200725012658.GA35171@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:23PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>

Everything in this patch looks very sensible to me, and I think that
implementing 'git maintenance' in the same file as the current 'git gc'
builtin makes a lot of sense to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
