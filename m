Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC45C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1505E61185
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhFHU6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFHU6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 16:58:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFAAC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 13:56:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v11so2887396ply.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GIRcf+YEnvRjTaOrRWpQXkF2BSVlkH87luJqEoBuAw=;
        b=wSe5jw/CAc0SlGcF+a9y0/xkGt8EVroy3cF5xme5YsQwntw/GzRfy19v26eesJXCVW
         RHtphsK5WrEZ9sYi1ITh2tlP+HlITdr0+7vDGNAZ3NhN3CykOHCm9dNMkHA3Dow5/E0k
         NCSGYKu1JH54p4GSIbAtOF3Fd3RokdQ2hRu+VN1LuTUeE9ENPJeyL6Fq5jJpn2dFEy1P
         86ZjkUcD6i9IiQwiEvnzwP7mx87yOSqWPKYqeWqC4qSS4zk5eOVmpiefw3W6ZsygGUpW
         P3E2gl2HkYI5FZgM1x3w5uN3jD9JT8LoMvxUAYQ1vuJjLs1b7CuoU2t0qQEBukuCnQSW
         AHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GIRcf+YEnvRjTaOrRWpQXkF2BSVlkH87luJqEoBuAw=;
        b=YloPHkl2YrfEJNzlPmranifQsLbgqCol9Gq3zi4o47H3mSkLlV/Bps9/HuLmWBCNPQ
         QFJ0SmeQIRCKLpes45VVwXRT2Gf6mHL/O8tmZhtWfok1dLQ0+DEFGwVdjgaA7+vsXxZe
         z6y4UyOOdBn9psk5gBU6TanAEGVisuUehYKnP380X7535CWzrOhEOucWaH20sYWVzOaZ
         lHdzMNyL44dbthU6wiQo8Y3K1j6IJbA7sdiIKHA5yjPM+V0PSwHj4VI0MM3nrhPHbA9u
         KdZHPo1aTGbvwX5rkdkbfxvoZtLXbYPvFHjLUV5sy3wbHtjrkOH/kujuhHFbD4itXXJu
         GspQ==
X-Gm-Message-State: AOAM5333txdJMCmyzU1x+qvMzF9NSmB3NgkLhgEz+0aabQWDvpp4d9od
        fOcAnIYKvX/esaPcKcl30O5QpSWCBvhJag==
X-Google-Smtp-Source: ABdhPJwYy5BEoHvdDjOgdI3giOnyUX3RXxe7WBphQM6mSPZgz9DV5WRtwGC/DGVIx7NcjHGIxldwKw==
X-Received: by 2002:a17:90b:1283:: with SMTP id fw3mr27335144pjb.133.1623185774062;
        Tue, 08 Jun 2021 13:56:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id f139sm11420137pfa.38.2021.06.08.13.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:56:13 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:56:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] tr2: log parent process name
Message-ID: <YL/ZaEQOYkG6lRz1@google.com>
References: <20210524201007.115124-1-emilyshaffer@google.com>
 <20210608185855.668050-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608185855.668050-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 11:58:55AM -0700, Emily Shaffer wrote:

Hmph, this is failing CI. I'll investigate it today and send a v5.
