Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6340B1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964975AbeAXSGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:06:02 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40171 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeAXSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:06:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id g16so3237552pgn.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gCjufC1DAkWxyfaEPTexXw235OvYPHWbBboenpbFlbw=;
        b=QW3CnoPMXG2z9R76eXLmkCBATMRp2rDcxhy1G4wiAbr04F5nlM1pNqE+7QJLk4BzrC
         BTuG8I0MinfIZFU7YXLoPNeeZ6C06lQmmMVqMr06tnhw0AFw4fdOQtVEw2NZ+9vc4uds
         Id8DU1280gs4rrCQd6Tujz6rh8aMU7MudaepypwD3KN+qC0rO/4t3mf29GeXDZnADWB/
         ZH1zH0RTLLXtfJl4qustvh6euM0QL8MOD5OQiMyHxuVjgIpnog9KvMWJZYd1m4X19rvS
         irou+FZqJFAsUgsX7db46BxtcQULWPwIUK9vVW5BiECTvioKJdE6teyX4Rfu8h+hsevE
         on/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gCjufC1DAkWxyfaEPTexXw235OvYPHWbBboenpbFlbw=;
        b=onxt8NUKItjzwdEc7Pk178D1RjriOsEMdg/CHwYa7Ov8J0ptxcgtgO3UE325OQ/6SO
         34qxPUoAULWkyFq2/FGdZUDOU4M5rBbVhBEIWp5SUwlAsvUD/jy7OiaSkOGLCzxp8AMd
         eDw9NNFXKsrUI+4LyVaybS8C1gQIUXl6AO9xsw6doTJUvOWgod3jQHOVc6/guePIUcCM
         Y6hqeHDDz3hU58aJZk0HVqAmuQBDKTTT380/hjQldMHMY+uvxAbKJPgid+tLZW6t6rzS
         pTlgb2NWNQM1Eq5pZAh95b96UtTuIk1exPLePZ/Cb9jWsrXD5YeASNIZryKV+SvRcqQG
         7v5A==
X-Gm-Message-State: AKwxytc7O8jNfxDeHUkl4oTvwwe/r4xe5buiA5wgLtaqGddbBrJhUZgM
        svkuVdBvNgw6trF1D7sIX2ALsk3XGkg=
X-Google-Smtp-Source: AH8x2257bgSSqb26FM8GmvxwOHo0xOTChJsAw4CkS855UN/mgyOzi1v53c3OgCCbPm13xqMCbnSSYw==
X-Received: by 10.98.0.5 with SMTP id 5mr13637211pfa.202.1516817160487;
        Wed, 24 Jan 2018 10:06:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id b69sm14797469pfk.128.2018.01.24.10.05.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:05:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] packed_ref_cache: don't use mmap() for small files
References: <20180115235251.GA21900@sigill.intra.peff.net>
        <20180116193815.4568-1-kgybels@infogroep.be>
        <20180117220902.GA14952@sigill.intra.peff.net>
        <29c51594-6e29-be34-3d5f-2b9f399490f2@alum.mit.edu>
        <xmqqh8rdn113.fsf@gitster.mtv.corp.google.com>
        <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
Date:   Wed, 24 Jan 2018 10:05:58 -0800
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu> (Michael
        Haggerty's message of "Wed, 24 Jan 2018 12:05:01 +0100")
Message-ID: <xmqq607rf7y1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The change to using `read()` rather than `mmap()` for small
> `packed-refs` feels like it should be an improvement, but it occurred to
> me that the performance numbers quoted in ea68b0ce9f8 (hash-object:
> don't use mmap() for small files, 2010-02-21) are not directly
> applicable to the `packed-refs` file. As far as I understand, the file
> mmapped in `index_fd()` is always read in full, whereas the main point
> of mmapping the packed-refs file is to avoid having to read the whole
> file at all in some situations. That being said, a 32 KiB file would
> only be 8 pages (assuming a page size of 4 KiB), and by the time you've
> read the header and binary-searched to find the desired record, you've
> probably paged in most of the file anyway. Reading the whole file at
> once, in order, is almost certainly cheaper.

Yup.  So unless your "small" is meaningfully large, we are likely to
be better off with read(2), but I suspect that this might not be
even measuable since we are only talking about "small" files.
