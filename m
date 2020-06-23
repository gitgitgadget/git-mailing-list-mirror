Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01792C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC6B207FF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhBlvAF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbgFWSyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbgFWSx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:53:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDDC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:53:59 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv17so10146858qvb.13
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZffZ6vFdF1AtAn3u9XpFSpy3x6ZHgVxFyXnEy3nyvIc=;
        b=HhBlvAF2TCjuQg/yUCt751H7g3kG/aA/BwzDC9FYxLEcdoUqiygoLpiR0yFNBmwlil
         ysZWORVIlUDyCwqzTdPdnplSegnQBco5RgJdh3bGNgDACP6X3aThdNYaEsl/YOL9afmT
         oy0Dg0ngWSXb3bW4z046naxzkTp9B1M8vOL0/xbN1ee0VWsGE9QgBt02qNXVatUWVTj6
         uoXv0bCq3u9YS3Wx5S4ttgFKHgR5AuTsFQROKIh+GcsGL+1DtrEOj+rg36nYVraFJR16
         RHdTIfyfGKsr61AFFPC5NbLTt8a606GL/xggKdQIg9SGd0lXLb/Q1CfnfayiAp3MyV51
         IPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZffZ6vFdF1AtAn3u9XpFSpy3x6ZHgVxFyXnEy3nyvIc=;
        b=UYBURXoBsDgpZZKyKVNuogzT5EXf8hdZyGbpdBZ0FE3h22/71M9CbFOq+YxoFCEioi
         1Ds0d8rJFr9G4qfNes33os0Dqm5hKc0Er1nd5jNxhUlXZbMD8/2HyBsSccuOILYbbgyy
         rMFbE6o16F5OYJXw/Sf3i5Dfx4Rv6M5UQnvSjlT+z0B+r93eAA78rdzZuRKNIVgxrtbn
         1860QaQCS+GCq48uAZJugcKY+6jamO+aS0TO9UOv7rdmFQN6TPO4EwvC5q2RHDbl0t7V
         GSm+u006XlY7WihbpsnXxKHrC/XG0C9aI+BhhD3835cg99+HsAy7Pe0rVhUEPPF98aCl
         D0PQ==
X-Gm-Message-State: AOAM532n6xCBBq9NqxtTHqXftTNfp7rLUZ633Pr3bI5X+Shz0ZkWagcY
        EQ2hmNoyLyf9Pkx2wly85NQ=
X-Google-Smtp-Source: ABdhPJy8CkQN8gsXO/7htGw4+QARxHIqM8LgB8c9jMy+ExB523nrCNz9QIBQJRlZdh6+t3LNiYPF4Q==
X-Received: by 2002:a0c:a993:: with SMTP id a19mr2655728qvb.34.1592938438455;
        Tue, 23 Jun 2020 11:53:58 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s42sm1460832qtk.14.2020.06.23.11.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 11:53:57 -0700 (PDT)
Subject: Re: [PATCH v2] commit-reach: avoid is_descendant_of() shim
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20200623081701.52607-1-carenas@gmail.com>
 <20200623184222.54201-1-carenas@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dbd85d9a-6fc9-1187-0268-d28e532ec507@gmail.com>
Date:   Tue, 23 Jun 2020 14:53:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200623184222.54201-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2020 2:42 PM, Carlo Marcelo Arenas Belón wrote:
> d91d6fbf26 (commit-reach: create repo_is_descendant_of(), 2020-06-17)
> adds a repository aware version of is_descendant_of() and a backward
> compatibility shim that is barely used.
> 
> Update all callers to directly use the new repo_is_descendant_of()
> function instead; making the codebase simpler and pushing more
> the_repository references higher up the stack.

Thanks for the update! This version looks good to me.

-Stolee

