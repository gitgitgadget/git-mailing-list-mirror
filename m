Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92516C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F612072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="To2ngMZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgC0PED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:04:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41814 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgC0PED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:04:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so4624986pfz.8
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OJRA+WxtWwHNbNSVepFr7HQ9MMLN6vmu3FwE4vCW2Bw=;
        b=To2ngMZ9mnq4KXQLtN42L3DEHt5D0ujSfo2sdQN0FrL4nAPewFwpDD3K4NK7LLDIy/
         qlC4POxqMn4rs6e+DipNEh5z7HNxfsOHfH24Rvqn+NBxHuHAWarJtW8bel5Y6zHCsZNX
         M6SAh0wWaNuqZVgB9fewjcfeFJk4b3Mkdi8QKB05MNtb/PT+RTJsWCEjvM/ah3M17Ikw
         gLmBIuLJxSYPB8ujbR9g+0H0rU9s19ST0l3DH5Oz8G4iPhAGFg4BLRImoIJtmRRPQAT8
         OeDtRPC1VLWN+9E+ocYwZ8h7vCjMvhWkSt40PVaxwdGUNugQDvXI3GWjQ8kZMFQDmtNA
         LaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJRA+WxtWwHNbNSVepFr7HQ9MMLN6vmu3FwE4vCW2Bw=;
        b=AQwRLWez8dZ2hXiHiR8O/OF/USU/h4PxTPE6QOJTWaBFlE+aHhSTc5h5z8MEB69ry7
         qFECgo6jue6BTpP0yxKJfJJtidoaO9FZwYg4ULsdqFXDhJjRx3JKhwlOAKMdMawaj0VL
         F4Jjz7G4L5E4fnDyN+PNgI8sN+hCrz8gDW+iDc8Eol1C0MTy40WCXtjT3Fm8mK3Z/QVf
         l7M7wGA8tiPBlYE0TRkwBfPSiA/4JY+L5OaKk84pxeOIogp1CYP0GnPRxmu78qiexjUq
         dh6BFIAaIe/bQYAsxYq/ht+cnmK+JBKI1NI72FyF4yyp8nuxs6OJzAmXmt2u8uCCyrHD
         OXvw==
X-Gm-Message-State: ANhLgQ26RdAA8UolLt9Id1abo2bsar/TNB2/p/1NbIh9kCripfHol69O
        Wj4x2VeNgDIal6k8zMEzlFtEiQ==
X-Google-Smtp-Source: ADFU+vszkUbqmOwUSIXtm5VLdCKB4oX1/e4Ra30gh90gHoIohdq63QIx56tQSB5mV7npIQtJE/SaGA==
X-Received: by 2002:a63:b52:: with SMTP id a18mr1719249pgl.130.1585321441078;
        Fri, 27 Mar 2020 08:04:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f22sm4047197pgl.20.2020.03.27.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:03:59 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:03:58 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200327150358.GA30204@syl.local>
References: <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322060434.GC578498@coredump.intra.peff.net>
 <20200322154749.GB53402@syl.local>
 <20200324061159.GC610977@coredump.intra.peff.net>
 <20200324230826.GA42939@syl.local>
 <20200327084248.GA607390@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327084248.GA607390@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 04:42:48AM -0400, Jeff King wrote:
> On Tue, Mar 24, 2020 at 05:08:26PM -0600, Taylor Blau wrote:
> > I can plan to deploy this patch to GitHub's servers for a ~month and
> > see if we experience it.
>
> ...I don't think we'll actually generate good data here. We're probably
> going to end up doing our "big maintenance" commit-graph roll-ups by
> just feeding --reachable as input, and dropping all of the existing
> graphs.

For what it's worth (and I'm not sure that it's worth much), but this
is only true in the last day or so. Before, we were running:

  $ git commit-graph write --split=merge-all --input=none

which *did* exercise this code quite frequently (and thus would have
been helped by this patch). But now, we are running something like:

  $ git commit-graph write --split=replace --input=reachable

...where '--split=replace' means "write a split commit-graph, but drop
all existing layers before writing it". This case is obviously not
helped by this patch, although I think the patch is worthwhile for
callers who do the first thing.

I'll post patches about that shortly after they've been a little more
well-vetted (we're only generating split commit-graphs on a percentage
of repositories for now).

> -Peff

Thanks,
Taylor
