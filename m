Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E9C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJUWFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJUWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:05:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F96162509
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:05:30 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l6so2387386ilq.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEo4Ol7IQCerKUg7kklsZbV7RlvJocGQiSefPYKhvLk=;
        b=6qwxe2/Se2UU0wkIRm1+yWnt9BiotJ8yF4PjjC+6ddKq4XCZC/alRALTzAE+MATltP
         X3iPKTh0bE+sD2DJA1hHpYIABbrkJ92RWHs57Cb0nM+qJno74F1shg/L57nDXCZzgwjn
         uSl7YXakvez4NGBfGLPjEPrWQn/JDkajByQK6/5QaKvTXk1tM4zPLNVPpcXBev2ZY1TA
         GhxuS+pOM4GiSOl/Gcsf2gJLq3OPG8kkUpcA95YL6mFn7K+IHzd7/iGAka/0h8n44O8O
         ZeWFayUPEKxBq/EGebb0gU34knnLJXJG+B4wNPIAU5so4GSwqWHmq7UYLE5XiGimbmeH
         Xuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEo4Ol7IQCerKUg7kklsZbV7RlvJocGQiSefPYKhvLk=;
        b=2wdV0YLIix0Wq3xhQJ1TzqGeS+A25TcYFrF+95TNsxKOyf7IUGfDeSLb2++/1s4FVK
         dqgDtBhgAQ0vnVsxp0bD/Vu4g7Z0MSPs4bCfwwCvzrSFIaqK7eKafks32Vbj3w0Tz6lS
         cr5z38LqUarTUCRxrnk8qJ7UpMLvQCsB0uHonN++i0ITua/IePM8TqZFv0Q4aGT5q2d2
         g3mMM+Aj/gksql3xthcqQ25dsakyCIerXWvn4od5gvL0TGcTdmacHBt4QJA2o342ozPR
         WsyPK9yshkC7LTutbMMfhoL+CUYX8C8ShnO0Hj4UrvNuK/S6iGYWbYtdEp5pjoZT+EGt
         FOhQ==
X-Gm-Message-State: ACrzQf1CDJhnYls1Qxpu9PEKjpefAkeTNfAnHZBErG99jo67Hne11zvN
        A7piVWDlUjhgV0zEbiU0qotqCoxk5eUzdhon
X-Google-Smtp-Source: AMsMyM6F7vIymOnt6M8dm++TI6L3z6d//+XH1hlMFhLTwf/pqmwD7XUvfDjB04L+sU/tLzc3wa2p5Q==
X-Received: by 2002:a05:6e02:1a83:b0:2ff:72e1:3f7f with SMTP id k3-20020a056e021a8300b002ff72e13f7fmr5595848ilv.86.1666389930201;
        Fri, 21 Oct 2022 15:05:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q6-20020a0566380ec600b0036345b91f4asm4749568jas.23.2022.10.21.15.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:05:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:05:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y1MXqATtx5OTQtNU@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
 <Y0TLf/J22ioQ5UCt@nand.local>
 <Y1H9xdDJS+xKW8mS@nand.local>
 <Y1IoLBvVfo+pIC+6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1IoLBvVfo+pIC+6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:03:40AM -0400, Jeff King wrote:
> Right. I wondered if it might be a little clearer to drop the outer "!",
> which yields:
>
>   if ((log->format.nr <= 1 && !log->trailers.nr) ||
>       strset_add(dups, buf.buf))
>
> but it is not really any less confusing. If we gave that first part of
> the conditional a name, like:
>
>   if (!needs_dedup(log) || strset_add(dups, buf.buf))
>
> maybe that is better. I dunno.

Yeah, I think that this is best. I briefly wondered whether it would be
better to invert the check _and_ name it, but `if
(does_not_need_dedup(log))` is too wordy.

> Regardless, what you wrote above is correct. Thanks for catching it.

No problem, it was an honest mistake.

Thanks,
Taylor
