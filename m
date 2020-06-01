Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD1C433E1
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE9D206C3
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uMnw4Q/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgFASun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbgFASFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9CC05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 11:05:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so257666plb.8
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+lRWod+/FT6mv+wpzxb9hLvvQD9RpV4NRcrZLMUYDI=;
        b=uMnw4Q/JM7lY5pdS2ip1OX449MTc73HhZRZQh2Z+I0WHlUWaGvPzayArsF/BLaX9OA
         MqCylQs9vWm/Q+nYMvxfpzJVmRpgImBMw9C14VKXEW1cN+UB+dGtVeGR0Y1uF7LoqVFU
         OPIJORwfXRlkCKXnEbOw/qvTMNfyRki8sJ6JIAiRNkj0xbzSv0gg5nVigRNKuoPVdh1q
         n6Spmmkwa4xbg5YNKU4kGNabB+1zw4f5znBiQMla3NcQrnMwiD4G9dZj1mgSCeIac2KM
         ExeORY2QWX2W87Q7eG0Q3c7QjrD/2Cw3MlfynBYuwqEDuTrhPdmWcjrmKKkgEe+6fpFR
         4R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+lRWod+/FT6mv+wpzxb9hLvvQD9RpV4NRcrZLMUYDI=;
        b=tMbskA5D8yrfSPMGw7WArwy/9UQDgQwdkz44msmafNf9SbrdWmcElZJehQld12GPpp
         fb6zfurBrbtDpmn+Hg2MND3zRPEy++Tet491P6JFn1vSjUlBsyUtbiymH9RvwFwem/NY
         QHJ+khJAbn/sk8+0CJlacLJzTn8F5oU7WcYrd14PIEnHgH4xDp2DA9re85zxDhXPxHPP
         50EgmBB/gusAG2aaaeiMtWL70RrBQKP84GwWuRYg2gi3dJp6aAPkejJ0nrzvmwxE/nOE
         kLVEl4PmKqQQArhmh9s19J437W+WYJWRO79uzPe5SeSFqUVqJ56PIVQlL012peHgv/0X
         Ysig==
X-Gm-Message-State: AOAM5314nNG+l8/ctvtIsz6XNx8vo0OQyptm/B8kSbdCqyS4Gh5M2hwr
        3tWt28jT6zIpszsuQX0UWBtl9w==
X-Google-Smtp-Source: ABdhPJwnhsd+iN24MGG+EWYyCjoITDf59a+EOP1aJW7/Ybb/JddgLzoqldkLGxtnqsR6pyy9ZCspPQ==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr21081926plb.91.1591034744227;
        Mon, 01 Jun 2020 11:05:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h11sm117850pjk.20.2020.06.01.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:05:43 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:05:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (June 1, 2020)
Message-ID: <20200601180542.GA29247@syl.local>
References: <a2ec90be-8559-b83d-de76-5e742c452378@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2ec90be-8559-b83d-de76-5e742c452378@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 01, 2020 at 11:46:22AM -0400, Derrick Stolee wrote:
> Taylor Blau	5b6653e5 builtin/commit-graph.c: dereference tags in builtin
> builtin/commit-graph.c
> 5b6653e5 244) progress = start_delayed_progress(
> 5b6653e5 268) stop_progress(&progress);

Thanks for pointing out this area. What's going on here is that we
aren't testing '--stdin-commits' with '--[no]-progress', since
generating a progress meter from the builtin in this path is new since
'tb/commit-graph-no-check-oids'.

I mailed a few patches to the list to address this. They seem to be
trickling in slowly, though...

Thanks,
Taylor
