Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C39C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63757207E8
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XCB4ydcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgJPVwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgJPVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 17:52:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281BC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 14:52:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so4357664ilr.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7++MLD2K7jdzctwKJ+sAIQS4kPqM+rzX1LN4M+9FCiw=;
        b=XCB4ydcwWU4MieR5pwtlVVUwH1RwUAKYSaFvykHqIQk5BMi0quveRL6JwphYLtW8Xr
         uPI0xmVU2qhRVXEWw35Nyw9BKzgtFIUnpPJlFd0MaV227GmT2ilX8w3dq6i23zUQdfFR
         w2I0u+kMXoyoWwURi3ORqm5gJsNu+5VSTPdtNZSuh9+JCEK7+q9zEto8YCJ+0NnXI0zq
         C2El93dVqwkYuNnlPSD6JCi0ykyyq8ltjkpbM3XpMA5hNWDvBvZ3O/ZW7TsQFiT+r/Sb
         iKXlKdAR1oBlPJ8qE3GrsF8JTT/NVQatVtQJ4z/7sirYLPZriIvKfkvyKpBzKj65zBY5
         GHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7++MLD2K7jdzctwKJ+sAIQS4kPqM+rzX1LN4M+9FCiw=;
        b=Zefi+RtAYYChmtzNAliSIW1e+xENXgs7to1tDEckZzOzqgpwLWQGaLpELbQb0NpI+P
         scOQsPzUOLcjk7p1homo+U+ZVg5DbcbEg0NI5icQ6gMUdXrB1RL14fVFGLzRGJqDqJoM
         ov6urf1K9WTtlox8mhuTRankhLQtQG+g9lEifmNqNMt2a0Ou5bNqMJyuFquhGEC6u0lg
         zy1EsZxupOJXYPT2iH5rSwyTheMuXvnIp/+mDBZFwuKCcDPKCReZ0dDyJOCf4CT7lWh2
         Ug5xZHkBkjVz3B9kYq7PK3cImKWpjzrLTgOGJYGD/XaGhmUYSWyIXkd2n3X+g+4+vBy5
         o4kw==
X-Gm-Message-State: AOAM532nKy0R/DufYEX56HfWlu6zUMeoQX3mkNAyfV+Fs83f2q93yufo
        8KNloHDRno8FJD7ahCppesTA8UX74yKsbP2R
X-Google-Smtp-Source: ABdhPJxroceQQltBH344mmyeGKtr4OdSYWaEUEoTk9IWfyxnKvt/w+mWwoJkOdyv/RUYThq0knRUCw==
X-Received: by 2002:a92:980d:: with SMTP id l13mr4120270ili.244.1602885159713;
        Fri, 16 Oct 2020 14:52:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64b4:b8fe:39a9:61ea])
        by smtp.gmail.com with ESMTPSA id c66sm3805246ilg.46.2020.10.16.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 14:52:39 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:52:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] MyFirstContribution: clarify asciidoc dependency
Message-ID: <20201016215235.GA2208862@nand.local>
References: <20201016205232.2546562-1-emilyshaffer@google.com>
 <20201016205232.2546562-2-emilyshaffer@google.com>
 <xmqqo8l1amtq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8l1amtq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 02:21:53PM -0700, Junio C Hamano wrote:
> As this is only moving the existing note around in the
> documentation, it is not making things any worse, so I am OK to take
> the patch as-is, but if somebody (it is fine if it were done by you,
> Emily) can double check "apt-get install asciidoc" on a vanilla box
> does bring in what we need, that would be quite good.  FWIW, we
> write in our top-level INSTALL file that we require asciidox/xmlto
> toolchain (the latter is needed if you format for manpage, i.e. if
> you do "git subcmd --help").

I was curious myself, and surprised to learn that 'apt-get install
asciidoc' installs more than 2GB of dependencies. Yikes. Unsurprisingly,
somewhere in those 2GB we manage to fit in everything that seems to
matter, since:

  $ cat /etc/os-release | grep PRETTY
  PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
  $ apt-get update && apt-get install asciidoc
  $ cd copy-of-git
  $ make -C doc

...works just fine.

Thanks,
Taylor
