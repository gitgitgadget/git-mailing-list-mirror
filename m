Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A791C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF06135A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhFHRkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:40:18 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:33496 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhFHRkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:40:17 -0400
Received: by mail-pj1-f42.google.com with SMTP id k22-20020a17090aef16b0290163512accedso2171096pjz.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LaycHrTn2E1++tBsZLEzPYKibi6YUeefZW7JDwnPGYI=;
        b=cEyDPW1x+VYf+HW4U942XiQfuaQAN/aoRpAQn2qdujw5nFRXI864NXqNA0enORFnEF
         DmAxgfigKgQaAmWbPeOHOsAznrinb3L1I5CXiGzuHwLVtvnyk3EvH79wEwIOg5IWU2TQ
         Rg+JgVDFbRbn3nZKZ0wUjNsePQgcP7yabYG2j2ysOtjCbhimQEM17cjM3a9vMXU10ey6
         3A03ebsyKrblgpo4aIxU/oDMK/uw2qORbf6IBhwDnfG89n9IcwVOM9855hty3RUkvcsU
         MZnu4rpd7LU1rAJBPRjVjFQtXujcaMuQ2cmnJ5Pgm9LpZSHXmli5jHYexnsV2cuaHTB7
         hBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LaycHrTn2E1++tBsZLEzPYKibi6YUeefZW7JDwnPGYI=;
        b=DeHr6ZFMFybB+VegIfRUdDimjaVUdV2g7157+cEya0j46PVzFlRlVVXOO4UDT2CeTw
         yg0WUZkdioZBGeAOWD0HDyr1Be51YaLp9wQwFRsX0MhoKuww8nsHAggkaD5XQQ47lFNL
         ZOwEODRK7gJKXKgeN/CK8XTbIn3qQP9BzsogUC8so1IPpvH3s8cJ0Et5wK5VXQZxIW+1
         hdI6WMd8qSkTLWTkm2/4dsrkrVIUznkF6JpYID2qnGFNkE5oBF9m8+HQn4RfrnUxhb9S
         2ebLVt0Oqvmm+ZX5KzJunRYkV8gbsyhuFrHfVJK7Lr5EhdBSKPtKk08HSmZilIqescCZ
         je5Q==
X-Gm-Message-State: AOAM531Nvc6GS6rBRFFQSUH4rmQrEhLqJkS3DMJqgBI3aiDF2+qGlDNk
        wbO3mLaha/WxnxlelAhM9rQDqw==
X-Google-Smtp-Source: ABdhPJw7Z2/4BWaDGrEDCfgWR+SMydYDbj6KFwKjm4RHF4fYkSvUSK7oVK4UmW4IkiL0yP0H3hAeIw==
X-Received: by 2002:a17:902:db0f:b029:f3:e5f4:87f1 with SMTP id m15-20020a170902db0fb02900f3e5f487f1mr775316plx.26.1623173844360;
        Tue, 08 Jun 2021 10:37:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id d131sm11744369pfd.176.2021.06.08.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:37:23 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:37:18 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] *: fix typos
Message-ID: <YL+qzgs1sdkbspbY@google.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> These typos were found while searching the codebase for gendered
> pronouns.

Around snickering to myself trying to figure out alternate meanings
where these aren't typos,

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
