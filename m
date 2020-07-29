Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBEC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0EE20656
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQTRotMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgG2WTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2WTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:19:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790EC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:19:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so12673856plk.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8e8lWPi8LbpOVe6Z54wvgVDh7XxfM4YFAtVja7bnUs=;
        b=jQTRotMCwnKJT9GHmldT62lKpdeNNbovoucQxn/QpAnq1XNwx7+3QNUQ86ecL6q6m1
         9N6QXqxaO+H7cVaHGMhTOoOd6JVhWO0hqDA3Ht9TlvPtRDuMEPigV5+0EfYTmi3oHAGs
         PBmM6dlZiZAW58sPDyKpAN0JT2ncsd/mA0MsIqlyU1wHRIJwXzDDVmc21A8u8U+R6OSD
         SRtxe9jmOOn10iw2FBjVS8FunTR+SfIgyQXMaFJkQWbwmbvL4t0DqnQUCSCCOklQ74Ai
         pQVynp4sW9fEac0nhHyUEPOWzr0GtfMp/R+k//mYuzbnL9oKSF0fvOG4l7xOBcmX4Ez0
         yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8e8lWPi8LbpOVe6Z54wvgVDh7XxfM4YFAtVja7bnUs=;
        b=iDdlmjNCJttE0Ornfrj5OOT4eFaoXzayZMRIHuJJaOZlptevC01B7t43J98lVtb3hU
         4sdZWnUmKxNlhOXV6XevwSdhvNpSA8VFqMD9e1C3ylx8vhK2TKNGtPhUOHaI5zYLBf0R
         nS4x9GX8qryPVWcSvV0ZKh6qkpgBEq9/NVOscyR2NBvMGQW0mch2kco29vZ5GP0RALnM
         nwRWJrxik1yiI8ZxXsB/5IZJImCNguO56O3wAu81T789JBZIku23BsNGJaDGc8ifkhYb
         /mQAAwT79pPpf4vEk9M3HnLm5yDmCmsSPlT4zrZ+sujCblerTy/leNg0rrKE+gAMURlR
         shrA==
X-Gm-Message-State: AOAM532a+poIAF3jAOPWwvonrk8plfqAZtfDdPt3mbybRuC1lYX570Kl
        6DBgWnUUYFdyDG+ePfciNzdMBA==
X-Google-Smtp-Source: ABdhPJzd/nwAorFQ/ePTDlgTN1H0zo6PbRxb/TZYdrrKor5J5BEF7kQyifrXKeLl1QRmvvkffQCktA==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr7535243pll.277.1596061185856;
        Wed, 29 Jul 2020 15:19:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id m66sm3801924pfd.90.2020.07.29.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:19:45 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:19:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/18] maintenance: initialize task array
Message-ID: <20200729221939.GB2965447@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:26PM +0000, Derrick Stolee via GitGitGadget wrote:
> +static void initialize_tasks(void)
> +{
> +	int i;
> +	num_tasks = 0;
> +
> +	for (i = 0; i < MAX_NUM_TASKS; i++)
> +		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));

[jonathan tan] I wonder why this is an array of pointers, not of
objects? If they were objects, we could use an initializer. But in a
later commit I see the array is sorted, OK.
> +
> +	tasks[num_tasks]->name = "gc";
> +	tasks[num_tasks]->fn = maintenance_task_gc;
> +	tasks[num_tasks]->enabled = 1;
> +	num_tasks++;
