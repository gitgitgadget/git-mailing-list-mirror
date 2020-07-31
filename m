Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8551C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978B5208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nLPvff1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGaUSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGaUSB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:18:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290FC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:18:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so29952041qkk.7
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aCSj21Kqec84+EdAH/k7RjdYW3FJBFd+ANifqM0L7wg=;
        b=nLPvff1t2ktydyJAFuPjYuIna2t13WTr3EuNoKBuvE8sZH07Ns/xPPXoH5pNDK1pbW
         rGB8fYpkiRhpWLkZpc3fSkM0/r+kUtVrnZOAZ2ZG+XAaNKuSRODmhcGZMf6I/Vp3HpLF
         fkAnvL47YUTB6Bc2LzOWZKCpq7ounVyZCEzStdO48wuJxYLSTGhMZRSKyZ5vp5YcaDsp
         eozwO1pCLkCw3YK4c8hkMJwOfegZVz61lpdNuq/XFeWAhgeM+TryQpj3dK7wz6URK43a
         2V4fjXZ7Bv+/EQ8GGkfBgJTBaHZxagGdHyG6P9PSABAh1IArGuZxWWnwF2wpueQCPD3o
         mTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aCSj21Kqec84+EdAH/k7RjdYW3FJBFd+ANifqM0L7wg=;
        b=p6c15qMIzNiNPM0yFFD5ux/TPVUhsIacR3L+RaAHyon3NbeNw065vSkuuDtA//dIRy
         HFYZiGJEfNnKb3dNoMu5kNv0RvCzPyS6SlawNq3LphMdhNJFZsIVdHzFiSMAOQ5mWKys
         15d51xSJaCI4HzgLMAe03kK6pBepdbDUx10YRYkGYByYo9V3yzsXGFzdleFzj0juWfHA
         v+aWWMPF2CYKhcE7oYxkWCIC+V4uu/Wths9UaWyBIDmDwmtOQD/Cy2zxN+Ze9hXlk0c4
         5BjInqv96mvz08FLgYH9OVfwyhWEfkq7JUBLA4/zObLW0HXckpgjSIck5gULXv3SMaS7
         Tz+A==
X-Gm-Message-State: AOAM531mE+0mvNbePccwVJclfV/jeCS52sl+S29v4uBkd/tvI7WVkx85
        AeQ65rsfX4GDxxokh6xdMkAWabNtL4rVfw==
X-Google-Smtp-Source: ABdhPJxiz8ygKA9l2prPwKINnlLCbUQlncUJ4ZLPMZ4od4ECIHIvMxNdrAOWhpEHYk5fu5yscYeodw==
X-Received: by 2002:a37:4e4d:: with SMTP id c74mr5649858qkb.311.1596226680179;
        Fri, 31 Jul 2020 13:18:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id m26sm10748798qtc.83.2020.07.31.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:17:59 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:17:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into
 <branch>"
Message-ID: <20200731201757.GC3409@syl.lan>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
 <20200731004202.GA240563@coredump.intra.peff.net>
 <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
 <20200731022217.GA825094@coredump.intra.peff.net>
 <20200731200306.GB3409@syl.lan>
 <xmqqlfiz30ml.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfiz30ml.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 01:12:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I think that you could do this without treating 'master' as specially by
> > making 'merge.suppressDest' contain the value of 'init.defaultBranch'
> > (unless set otherwise).
>
> My understanding is that much more instances of repositories come to
> exist by cloning than running "git init".  Hence, the value you set
> to the init.defaultBranch has no relevance to the name of the
> primary branch in majority of your repositories, whose primary
> branch is what their origin has designated before/when you cloned.
>
> And the latter, "what is the primary branch name for this particular
> repository?", is what we want to ask here.  The answer to "what is
> the first branch name for new repository I will create?" is not a
> good proxy for that.

Aha, makes sense. Thanks for clarifying.

> Thanks.

Thanks,
Taylor
