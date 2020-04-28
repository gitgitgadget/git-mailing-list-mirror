Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23B4C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17D420775
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Xfw2/JNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgD1VoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1VoS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 17:44:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71645C03C1AE
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 14:44:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so11122205pgb.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRSs97KVROse7gifZrbbyQuqIfgFp9uoz5sje1leUb0=;
        b=Xfw2/JNYsK7NU5GPek02mthm3hrdoDvCbwpx5tINkYFPfXrKG4u+80o3X0yfBRbRBJ
         BZCP6OTAmZuFuUiUKGDsdIFMLepfUD9ZFuEA7XACUY1j/eSkYdgW3N3x6REhJ1Zi0tGl
         WLDzTSAUUI7FdPM82qf55R6IBsftFz4QideiXq0nkPu5YmrQBr/446xdcvj5gRzEtmEC
         wAJu8CilUg5TaOvk8XTs6/eWLxo9VGxgraOqLerRYPotBTcXJ0kh+X3OW2pkCrSsuqo3
         g5/hDkeYI78XDKE1nnZDjirj4MzLHLxEPhWMHpo3+P8gCVjN2JAgDx2VWnbpLNIDzvlg
         FWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRSs97KVROse7gifZrbbyQuqIfgFp9uoz5sje1leUb0=;
        b=jht4vFKoE2M4+D4ra56OXuvgkaA7yxG2XkrWwA+tF+UBTehGhYaeVteXZbIhg7FapU
         jMtpmNfZVjJYudK9Wnuyihm4dcLGlAo5xVFyX7m+rDsmvkrbthZHNc6Q3Zt6p4zE0yu+
         L4BT1UN/v3R5+A47NEyk3xGyq+s+yo2nkwfNiAKd6K+RbBHcpTKf13RVzDGrDSkVY62y
         xIYa/xrjaXlc9gJX+JwrxNOoyuT2AY+PWJx/XKR8twn0Fjl109uIte6pkG80e2sS7fns
         NFVFs9U3A4OhLCKVZNYjroOzcQ90ZLhQj03GLzmtm0sBDoXqlfW9ZtuojuG9zUBGeAy3
         0S0g==
X-Gm-Message-State: AGi0PubTeSONzdxAU9n6DnNec58o/gGYZzquBBrgpM5g59v7V1NnuLhu
        yUwujCP9sZeGUoNlApf6I6Ue1g==
X-Google-Smtp-Source: APiQypLp+sJiMpG3BKrtdlP1w/kBlKfnNnVpA1KG2i5S6Xg7vDgfnhMwmxCVpqmBfIViMw2n4CikHQ==
X-Received: by 2002:a63:d546:: with SMTP id v6mr29830538pgi.228.1588110256747;
        Tue, 28 Apr 2020 14:44:16 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a23sm15506306pfo.145.2020.04.28.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:44:15 -0700 (PDT)
Date:   Tue, 28 Apr 2020 15:44:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
Message-ID: <20200428214413.GA47690@syl.local>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
 <20200427235935.GA14984@syl.local>
 <20200428033438.GA2369457@coredump.intra.peff.net>
 <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
 <20200428205913.GC4000@coredump.intra.peff.net>
 <xmqqd07r1fu6.fsf@gitster.c.googlers.com>
 <20200428210821.GF4000@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428210821.GF4000@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 05:08:21PM -0400, Jeff King wrote:
> On Tue, Apr 28, 2020 at 02:05:21PM -0700, Junio C Hamano wrote:
>
> > > This is looking like a much deeper rabbit hole than it's worth going
> > > down. I think the pragmatic thing is to just stick a "umask 022" near
> > > the new test (or possibly "test_might_fail umask 022" inside the
> > > commit-graph writing test).
> >
> > I think the most pragmatic would be to just squash in what is
> > already there ;-)
>
> That is OK with me. :)

Thanks for an interesting discussion. I squashed Junio's fix into the
third patch, but the fourth patch suffers from the same problem (so I
stuck another POSIXPERM test to tweak the umask there, too).

What do you want to do about the final patch that I stuck on the end of
this series in [1]? If I don't hear from anybody, I'll send it as 5/5 in
v3 and we can feel free to not apply it if it's controversial.

> -Peff

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200427172111.GA58509@syl.local/
