Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF9C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F3322B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0ykzxApp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgGaSKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:10:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F78C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:10:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so27906351qkn.4
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s9uBwcz3cK14WYJoD9omyrjPcDoyo81AYZDn6puVDvI=;
        b=0ykzxApp7ldagCl6eJYnHVa2UOwgDXwkvDqnkRzsadcRY3lclwgPH9/5c3BM73qT/a
         ACehM9c5tqeI6vfrxjT9TRCJC1nAFubtn+o932H9VvfiBuWxQtu4uFYQY8olobX/3iB3
         HoD71S7lPvQFj2IXOswBLCaY81ymaTm8ba2ptlcU8LW4oxke+S6Waj/Lv51SP70h1l+S
         za0X2RnK/dUQq45u324gFUMN9iTuqpwP1C3ygFL3jaTH0+iH2O7/zKarmh1YOKXXlfW/
         0X0jAePL6Hg5RND77WHcAInzsdGvnxVnWR0lFbRqcLXj4PobZCHBFnsH2au3Oh4Ix7IF
         c6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9uBwcz3cK14WYJoD9omyrjPcDoyo81AYZDn6puVDvI=;
        b=jvu0Up7iIDJj3TJYe71kIBWKuRMcHiWLwxedfrtVWNbBeMGPaGJ2vHcoG3yvLv/dMK
         RZMpdh3JGThySBlLpDVV/WEUDBLzhnUCl8WEZo6FSbIoA/qVb4RQkcFwTJnLbbBtrlOL
         0PtLaaXC+xlQnkTu/2+u1U1D+CDxjtEOMfypsZa2EprUcOGI/oHQVtuvWCXlmbGFePuv
         Js8SqB0EpfseU2OiAJ85hmvU37tbcrxyTjQ9riKt7WnIEkBGRl5CMX4hoVFfNAyoYM0Y
         4S4mK4hviNNNWLLxkKGiGVDgQTBMe7rIgMXxM3zFSi274yW4FTYoXbi3+K3HeWBROzb3
         P9Mg==
X-Gm-Message-State: AOAM5324kGVD8l2e8qouYvu+louqm69c+wQXftGXh6p1zfjKUqqq1Kun
        lqh5A168jRTcPAtKAZsuwj53Fw==
X-Google-Smtp-Source: ABdhPJwB2eM6a15c6Anc9/z/n8vL6LgcHhTqzRsc4FgBnbakWSJObxtS6jaZWMzozFeYFZMxL0VFdg==
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr5467259qke.373.1596218999339;
        Fri, 31 Jul 2020 11:09:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:45c8:9c23:8c4e:a06b])
        by smtp.gmail.com with ESMTPSA id d198sm8935585qke.129.2020.07.31.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:09:58 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:09:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
Message-ID: <20200731180956.GA60133@syl.lan>
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
 <20200731180235.GA846620@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731180235.GA846620@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 02:02:35PM -0400, Jeff King wrote:
> On Fri, Jul 31, 2020 at 07:49:25AM +0000, Son Luong Ngoc via GitGitGadget wrote:
>
> > From: Son Luong Ngoc <sluongng@gmail.com>
> >
> > Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
> > to validate whether the commit-graph was written with '--changed-paths'
> > option.
>
> Is a single boolean flag sufficient? If you have incrementals, you might
> have some slices with this chunk and some without. What should the
> boolean be in that case?

I think you'd really want to know which layers do and don't have
filters. It might be even more interesting to have a tool like what 'git
show-index' is to '*.idx' files, maybe something like 'git show-graph'
or 'git show-commit-graph'. Its output would be one line per commit that
shows:

  - what layer in the chain it's located at
  - its graph_pos
  - its generation number
  - whether or not it has a Bloom filter
  - ???

That would be a useful tool for debugging anyway, even outside of the
test suite. It would be even better if we could replace the test-tool
with it.

On an unrelated note; this patch is broken as-is, since it will only
report that Bloom filters exist if the top-most graph has them. I have a
patch to fix this that I have been meaning to send out for most of this
week. I'll try to get to it shortly.

> I thought we had some way of reporting the number of commits covered by
> filters, but I can't seem to find it.

I don't recall having anything like that.

> Our "test-tool read-graph" can report on whether there's a bloom filter
> chunk, but I think it also doesn't distinguish between different slices
> (and anyway, it wouldn't be suitable for tools that don't rely on an
> actual built git.git directory).
>
> -Peff
Thanks,
Taylor
