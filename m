Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB6C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F08464E6F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhBQUcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhBQUae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:30:34 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF56C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:29:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b24so10525128qtp.13
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/UBYfw74zjoT4BR2k2ae4WOTJRrnFp7PPOZy+U2xCY=;
        b=OzdqlmYTUDynAyT2It3kwQzKqAAVdDGvNYImh4Dc/t/DnqFBpOBK4hCMCZiYDPzagb
         QCJXetOvfZf7JG3dd9f2Aev3UyxlFWcRiujhbHzIJSUvPlr87uCPrdGgpZmsF8+hGZSU
         vHhw8fP93MODTMQAptjOqpNye2jR1BUIcSCeYXEvMRLEjCcHo2SSyz8LL2tHLKVdMcPq
         hphTgIb4SKEpGvYJFLBOyK760+tPHkbiCgK066PtbpbShB8S94aHtKySCc/G1ipTV4ZE
         qII0hziX8+PQrhztXpG9Ogk/cS7FB7rOvrzNXoAYCyrYlbNJvMP2b25pkPHlm1fZ+EBv
         VBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/UBYfw74zjoT4BR2k2ae4WOTJRrnFp7PPOZy+U2xCY=;
        b=cSWZe1I6/01pPI/JjtiETxKvHHrokis4WHr3kh54UUgWf/I9CxIykkiRcQ4l5Y3nGb
         au0ERb68VyU0E4lKj9U8pBb7bhqwgf+0OFeWIXAf9LOhmIDq5bj9kemWZOdLYpnNjLR0
         nW0dcGLeDv7G19QdbUSQj0uKwzbL7xN3Ug92XsbclFzw5LV6ljbiqoie1IhcOVVUQVnK
         Z7o7HGXCNeQto4lMfwxCC4kY5+watJWtoC5PPkJOjmjvXAtIJ8vZLUXL/9JY10vyYno1
         nz0vAvfi6c1d44/USylKN+ZMIZ+mifEEsyYgnWDfdWH1MDyaw+rKwN9FKX7WZZDaofAo
         tSPQ==
X-Gm-Message-State: AOAM530Trd/L+MecZ31abNYPcbtJGNj6H1MSKuFXMzDxvwOsFnzPGKQg
        iBxOd+Du4zl1P0QIN5rmaG3frg==
X-Google-Smtp-Source: ABdhPJypn7LRX2tml6uCpAta0p781oUOCQaoHx5/fpk3SVYztEp4XstYTm/pDk/d/MjFeUzfh+y/qg==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr1079572qtj.78.1613593792696;
        Wed, 17 Feb 2021 12:29:52 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id i5sm1933269qtw.3.2021.02.17.12.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:29:52 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:29:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <YC18vmTYKo/lEaB7@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
 <YC1OJDFXPnxGMHPK@coredump.intra.peff.net>
 <YC10eZkpqtzLlJUP@nand.local>
 <YC17rflmxAAdBBCd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC17rflmxAAdBBCd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 03:25:17PM -0500, Jeff King wrote:
> Would just doing:
>
>   if (cache.packs && cache.flags != flags)
> 	BUG("kept-pack-cache cannot handle multiple queries in a single process");
>
> be a better solution? That is not helping anyone towards a world where
> we gracefully handle back-and-forth queries. But it makes it abundantly
> clear when such a thing would become necessary.

I dunno. I can certainly see its merits, but I have to imagine that
anybody who cares enough about the performance will be able to find our
conversation here. Assuming that's the case, I would rather have the
kept-pack cache handle multiple queries before BUG()-ing.

> > > Is there any reason not to just embed the kept_pack_cache struct inside
> > > the object_store? It's one less pointer to deal with. I wonder if this
> > > is a holdover from an attempt to have multiple caches.
> > >
> > > (I also think it would be reasonable if we wanted to hide the definition
> > > of the cache struct from callers, but we don't seem do to that).
> >
> > Not a holdover, just designed to avoid adding too many extra fields to
> > the object-store. I don't feel strongly, but I do think hiding the
> > definition is a good idea, so I'll inline it.
>
> This response confuses me a bit. Hiding the definition from callers
> would mean _keeping_ it as a pointer, but putting the definition into
> packfile.c, where nobody outside that file could see it (at least that
> is what I meant by hiding).
>
> But inlining it to me implies embedding the struct (not a pointer to it)
> in "struct object_store", defining the struct at the point we define the
> struct field which uses it.
>
> I am fine with either, to be clear. I'm just confused which you are
> proposing to do. :)

Probably because I changed my mind in the middle of writing it ;). I'm
proposing embedding the definition of the struct into the definition of
object_store, and then operating on its fields (from within packfile.c).

Thanks,
Taylor
