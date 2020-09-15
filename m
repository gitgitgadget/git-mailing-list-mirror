Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44538C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0150C207DE
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zuSb+Cg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgIOVyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgIOVyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:54:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74829C061788
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:54:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so4532076qtd.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5BNvWjGmWEGZjkdj4iKPW0CxierOzkLO/evGx/Ixa20=;
        b=zuSb+Cg5DSJ+rbni85OqKzNKUcsnqF5B21f1t6lYFdCZhJDnZx14V/iDQnpA/lIcmS
         0SMbLEDZUb/XtYU6jew1JDEvy6/4HtCWGBEEkHfKNv0LDiiTqUCwnToxKW+ZTHo2HF++
         HI2ltgWRyhnMmDgjJkcRQxdzvXaUdkCDf9//lpdkxHoJTzgMF3LgGcESxtL5tN7xOLoA
         XHCXJuRLAdi43mXBdxF87yWqGM3d3c1BsOs+v9UX7Xtm1ORX02FzlcngFgqbjSpaQXPQ
         AT0mY7q0ufLWNptMY4ldDNyuvleZ8R0hQlGlAh3okKgM5XVGcbHbbnPtQIrZqG0H1rcA
         vVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5BNvWjGmWEGZjkdj4iKPW0CxierOzkLO/evGx/Ixa20=;
        b=gfHppex+g2nJR4mce7kuEFTmUf2GoxqZ25wy2gbnDJHOqEWMR5I5ZLi5lcDyJk7eAm
         tEzCQWjKw63nSbkp7YCq6Kczd5mIQaPgft6lvAAmrtPhBpL0egXT+74gKElw+ciIGWl/
         kYdeOYXLaIeMPIqMQCSX1mJ1OjWP1cZ/NtQwPXQ6XQ7zw22F1vSeUXSyjPWiRCzp+4Sq
         pcxhzywlBaMfkMdsWjNT+6dXwoxqdpdtiAdnsMvH07rU4E5SXcbXqpOTBXC3dmkEYDYw
         d7xCHMRWmuogSIBhCU/7Hf5O5E0jYHQLBPT5B8ztqMoZvXVOmHgYOoDXSec+tksygcJz
         jQrQ==
X-Gm-Message-State: AOAM533hZd0dc7dYyYff7jIlwX9n1KMn4ELgQ1/zR4dst328bZmo4juc
        PkiRKVnURWoiFyUmXvQ+A+bV1Q==
X-Google-Smtp-Source: ABdhPJxXwz0HrVoVwDa8d63tj0E5vDe4+SVvpQOhRWGj49AYcvCNyKrBGPOefBQ/nxp4+poMYjy0xw==
X-Received: by 2002:ac8:1a7b:: with SMTP id q56mr20032475qtk.56.1600206841968;
        Tue, 15 Sep 2020 14:54:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:382b:7dc1:797f:40bd])
        by smtp.gmail.com with ESMTPSA id l5sm18194110qtc.28.2020.09.15.14.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:54:01 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:53:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200915215359.GA2726@xor.lan>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
 <20200911192555.GA3612@nand.local>
 <20200914201258.GA12431@nand.local>
 <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
 <20200914203659.GA12855@nand.local>
 <xmqqv9geyaku.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9geyaku.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 02:49:37PM -0700, Junio C Hamano wrote:
> It's getting so unorganized to follow from sidelines.  Even
> resending just the few steps that needs replacement, indicating
> which ones are replaced with them, would be easier to manage (and
> full replacement would be the easiest to handle).
>
> Thanks.

I'll send you a full re-roll, no problem.

Thanks,
Taylor
