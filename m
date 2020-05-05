Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573EC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDB7206CC
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyO6RYEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgEERFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729553AbgEERFu (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 13:05:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CDC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 10:05:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so1070062plr.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PUrXo+SAYk3c23+4cuhfKAtFdbPEUATyPcf5fqZRjzM=;
        b=UyO6RYEJ3TJfvcGUpImPbluBVxSfXVZjOL0O99V2RzfS9AE9NoPzou8/j78kjC7OjT
         BRZcyoI3CQzyNaUb6wCfl0Mc6YDpmlekEBbwMT68/cjo/23cmkjWVfjSHxDtvZyte+2b
         m/3cYB6V+VzGTcHukRIVLzB5Hgh4A0kJqmDySmlgLB3YHAbjFVGPo19r7yhYiUJ9yfpC
         +qbHbq+fgwwP0/ToFxZs14zFeytbtbQPmZxpKV8iPtpMK7XPhsRCW4zewHiX8cad0FPV
         jF+V9jCW6HCigBPp/NvoJB7MdBNPeHt+9kK1YQfeHZISGzXu5/vbLDLKJU81xrvMSEkD
         m5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PUrXo+SAYk3c23+4cuhfKAtFdbPEUATyPcf5fqZRjzM=;
        b=ODhjrbdburB5jSFzSkaOtSs92DfB1RRS4KxYhFlDifjF0gLg6x3jl5+dJ059anmcFo
         qAA3BwXvPdAB9G81IMTdtrwVa3rCzduIUs2k5rmX6PX4QAuHj7aDH5s9Ter8ersAULth
         7y6i6iRZcYVAA/Qko2n3BE7AcHgtA/qs0NjI8jS4besBWH9y7zkRmPGfmLcYuwbPfcWA
         oTFg4Xq+DigBaRkhimppu/IaSpUOPv4eHgMm0lq/0j+bUOPY+JUnTpEubNHtLzXvKM03
         sw8uaIVbNxnuRD6WBHnxmaKNOLobpsaHov4GZfPxuTyDLcFnTsyba0HJzz+ez9prSf4b
         VIOw==
X-Gm-Message-State: AGi0PuYN3toImH4E7YcD8hyP0Wf/ACSdDGg/Sfc21joGdQlF/m/wt/cl
        8UVcDZhwbKgXYwowePTQaAY=
X-Google-Smtp-Source: APiQypL6U8fbX83mL8E26sBSKw92hkqqcrKj4zweXQvxwqk2qubWD9+EwhTfY32W0Q07w7mgAxwv6w==
X-Received: by 2002:a17:90a:6c96:: with SMTP id y22mr4220599pjj.74.1588698348690;
        Tue, 05 May 2020 10:05:48 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 184sm2513532pfy.144.2020.05.05.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 10:05:48 -0700 (PDT)
Date:   Wed, 6 May 2020 00:05:46 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] CI: limit GitHub Actions to designated branches
Message-ID: <20200505170546.GD927@danh.dev>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
 <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
 <20200505165125.GC64077@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505165125.GC64077@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-05 12:51:25-0400, Jeff King <peff@peff.net> wrote:
> On Tue, May 05, 2020 at 11:26:40PM +0700, Đoàn Trần Công Danh wrote:
> 
> > -on: [push, pull_request]
> > +on:
> > +  pull_request:
> > +  push:
> > +    branches:
> > +      - maint
> > +      - master
> > +      - next
> > +      - jch
> > +      - pu
> > +      - 'for-ci**'
> 
> Should this be "for-ci/**", or are we intending for "for-ci-foo" to
> work? I'd suspect anybody who uses this would use a full directory
> namespace in a refspec (like "refs/heads/*:refs/heads/for-ci/*"). It
> might be simpler conceptually to only support that.

I made this because I saw someone mentioned that they would like to
push to 'for-ci' and expect it works for them.

I guess it may be better to have:

	- for-ci
	- for-ci/**

> 
> > +    tags:
> > +      - '**'
> > +      - '!**wip**'
> 
> IMHO this "wip" match is going too far. That was the name in the example
> I used, but really it could have been anything. I think we should
> either:
> 
>   - just build all tags; it usually takes special effort to push them up
>     anyway, so a one-off "just mark this spot" tag likely wouldn't get
>     pushed anyway
> 
>   - just build v[0-9]*, which would catch actual releases

This sounds better, just build "v[0-9]*" and ignore everything else,
with this pattern, I think we don't need to advertise tag to our
users. And our maintainer shouldn't worry about it, since our
maintainer will (likely) only push v[0-9]* tagged code, anyway.

-- 
Danh
