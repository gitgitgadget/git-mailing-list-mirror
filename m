Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31AC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1402237B
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="P1abrVcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgJSWDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387737AbgJSWDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:03:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDABC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:03:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h21so1733589iob.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+bQIcmTd2vyUM5niX8a36WYrJK1XNV9sFn+T6IVrJY=;
        b=P1abrVcurDk7qGHgnJ0P0VZ495BHl1ebh/81gdo5RuizEiFz0RAAXiMJN+/jXKORLr
         t5sr+9Y9NiZm26SGVaIXRbhb8XqjjEihYEdIBIOjrTs/K2OvrC5HNqZOEW5XdsWjqnbI
         JjJclZd9XMNj3+vZQK2zU6UFzUksSeEf2AjPPpXGlikfQOmvQGh1nOwtDQwY6jbWHla/
         h5xJBbOj/zF2eZJ6pJNVmML4I6/5+1hRgIqYXUcH8XjYQ3naJNKHr93KxTw2ji1rqF1H
         7VCtYUTXZ4V24bbpwM7or4HptepuiFNBIXgGqbi3K2cKaw62Ez1nDlkoxcmE9QBtzrF2
         2z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+bQIcmTd2vyUM5niX8a36WYrJK1XNV9sFn+T6IVrJY=;
        b=dqADSLvYliGcepj/C4jfx+52yvfI7+JVuU+Tpm6Zc5a1SW2t5lNyky7+BYmcCNnsMt
         s0jwPNcN2kRAxvkZag6VZzAinNQp+X65/qUzuOCAJpkcFnOxApVsmwaeNU/3RfPtnErV
         czhIvfVSo3hveAgLesX19ndAfHkY1MfVGp4HKdA63CmZ1PXDKTyvIMmH3p+nMhGWTPti
         3jqyxbOQrbhhGdvO/VY8APGBwhxtvY6v31t8I4p5871G9PjxxZahC2706t7Za3O0Bo/a
         puk2jpWd0k7cqxuHQHG7LkdFthmeU4RBkLCbCtBF4Q0iswT8flqO8XHh1zWxtg3tOVq5
         5eEw==
X-Gm-Message-State: AOAM530pfSOqJN3NdePjoPPG8qMVqwTeJjz4JrUkYL+zSZuhT9JWNBBI
        Z6v8Tnmijtneu8uTE/w6yd6fiQ==
X-Google-Smtp-Source: ABdhPJz2kTwArO5GABPEXXqmGBe8wxXNzOfzS1IVjR9maIDVQY2mSIb32O0uFq4plczIAYoCKjf/Lg==
X-Received: by 2002:a6b:6818:: with SMTP id d24mr1285339ioc.69.1603144980859;
        Mon, 19 Oct 2020 15:03:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id c9sm1314823iow.1.2020.10.19.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:03:00 -0700 (PDT)
Date:   Mon, 19 Oct 2020 18:02:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v2 4/4] t/perf: add fsmonitor perf test for git diff
Message-ID: <20201019220258.GC49623@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
 <20201019215438.GA49623@nand.local>
 <CAN8Z4-VxEFvPJwA987xWV9d54geyTJJgaqc0FRL-0MuQgVS5ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-VxEFvPJwA987xWV9d54geyTJJgaqc0FRL-0MuQgVS5ew@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 11:00:05PM +0100, Nipunn Koorapati wrote:
> > I was wondering how this slipped through since it should be checked
> > automatically by t/check-non-portable-shell.pl, but that is only run
> > from t/Makefile, not t/perf/Makefile. That probably explains how a few
> > raw `seq`'s made it into t/perf.
>
> Makefile issue is easy enough to fix - will fix in another commit

Thanks; I don't think that you need to worry about touching up t/perf's
Makefile (although I'd be very grateful if you did!), but rather just
swapping new invocations of seq to use 'test_seq()' would be sufficient
in and of itself.

Thanks,
Taylor
