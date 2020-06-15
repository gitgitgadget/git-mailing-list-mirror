Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCFC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA91207DA
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y3tseAVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgFOQY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgFOQY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 12:24:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C3C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:24:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m7so7000977plt.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QsvpAWH0I38/uU+iT0Q68vPY6LwujfK81RqYmbwnJXE=;
        b=Y3tseAVVhgqxoNeRpkdKzHMbFCWvaQPpmjArXJ6jR5BjN/1g993jNMDYtilYhTIjP1
         S7+9aLsfH24xS1RgnfMYNQj7eVBjhXsLfb6PrpZ6Iu/0EPc3LGY/VUgW7NE6kPhO2EFK
         xVTcwrSUxPyW1e4jzLYUvvVp3H/bjTgnLTLvy/cu0AxHkraRF3HKqEuvtia/W4FmXU0k
         nW2NG19JGWtweevJshDyL2rFtJMA61quTc1gtR+yuMVpwId64iMbqh9lxW8uPteMkZc5
         4vtFD3D+htUWwXwx3/rYH8MUo7uerYAgGyynVt4fBLYOG9bPz+tS/VsSWx6OKv3IAHOb
         AwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsvpAWH0I38/uU+iT0Q68vPY6LwujfK81RqYmbwnJXE=;
        b=Vw5ADQeTCmmPt1x2MhP06Ok+N9xvIFXAbxjuMBJHjqZbNztGpxX7Ct/lquLllSdOFu
         sDY+RqMrFcjgnQZ6GSqkClNtsMLRMdMcdQOfkN/P/v3vxqkdBOazFAUcnrYeMKRZHMvE
         lRDz7WeLVtTZMmgUuTIT+HHbviu2dBSvKxgR8YKuPTgvPOBOjMb/1vmDbVqdArWDz8Q4
         Njt0+PqIAZ0Cbg47oxWwwwyh5WAX+AYG3l92ik2tDI9zTbp/IFqoVAZfYLiUnxEmM+S1
         Hp2fn5m1VmYxc9NHHIWJ46QOfm4jIKyXrWfosjCErKB7EF13yU1GYqKU7/ReWYcbzb4A
         0unw==
X-Gm-Message-State: AOAM532Ndjld4ZtylnKt9fl4Ff4AnNCgXgQiELINH9SMfHMGkmYvaTP/
        1rrfDtq9JnDQXAyRv14e5lzArA==
X-Google-Smtp-Source: ABdhPJxjrzBJyzXFr9GCvRNd3DdStczBkO7F5OLZEGNh/PKTqpjXaW6PuUUJAvnpSysAvSzvOkMJWg==
X-Received: by 2002:a17:90a:bf07:: with SMTP id c7mr67897pjs.233.1592238297708;
        Mon, 15 Jun 2020 09:24:57 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y18sm13919659pfn.177.2020.06.15.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:24:56 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:24:55 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [GSOC Patch v2 0/4] Move generation, graph_pos to a slab
Message-ID: <20200615162455.GA71506@syl.local>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200607193237.699335-1-abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

I am so excited that you are working on this, and welcome to Git! This
change will make a meaningful difference for us at GitHub (who use
commit graphs extensively), and it sounds like they will even make a
larger difference with your later changes.

I was out of the office last week, and so I hadn't gotten a chance to
review the first version of this series, but I'll review v2 now...

On Mon, Jun 08, 2020 at 01:02:33AM +0530, Abhishek Kumar wrote:
> The struct commit is used in many contexts. However, members
> `generation` and `graph_pos` are only used for commit graph related
> operations and otherwise waste memory.

Thanks,
Taylor
