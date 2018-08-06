Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9BE208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbeHFSJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:09:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55513 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733013AbeHFSJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:09:39 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so18086243itj.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouIzZD44LeYS59sXAxwlAwZ4YpebsqeKGxbxcBWtE2E=;
        b=XajMBX19UVmKgJNKPGARYaPvkvGv1BTAuoeY7KthBX1RmtVi+221hRTK3tNtNXFnrv
         h+1cvTpH3gHGwb41EpIkaNyOjeifwSCH4Xg2qfW1mektcLHXffwcyRoJOy0gFVs7Ns7z
         sBb97zAHVwJWJnMlhDrtjg+Q+T1FAbqSpISNU6s2nODsuwpEGQ3Q1P3CC7SWiBr11c5N
         hRxNmOuM4d2pCjASK+RMeUzKm66kQVGL/m46bB2SMvRFlK0/8ON3OK4CvrsCCOPosnq9
         Ittt0e5f2/Gc9lMpSu26Wp8idyhvKPotfzX0uD4kRpUIlq+BlP+7nb0DGZd2cHhTr8MW
         HQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouIzZD44LeYS59sXAxwlAwZ4YpebsqeKGxbxcBWtE2E=;
        b=GdxGESwHgu8FpIfkz/43mJtvzN2+glk8QhPF5s96z8+ZYarurOwdxAzPa2MXM4fcs1
         4c3dzfmO7JTMClhMuzYqPc3jKXyPUU0M3hnkJkCfLCohVUyP6+d82RVlgW+vVrnJq5tg
         qFWua024Tn9CiJT+IT7Ds2kQymQLf3zuJBVN4n7Z8bF/Nqx2/blI5YZgFD7P+5Uj/+oL
         VPZ87OIjI8vngnbIcUo1nXybm3fRWb9yQW4CqFz+tc9B4nrrimG+dLsaAfgQZCwZfVAa
         0anWppYt7o/6RJVYzoD2Ixv91nHdTgHmfY7Ny4fh2DMtSEJfviO34zNIDCXyS/h5UmyO
         fwpw==
X-Gm-Message-State: AOUpUlFpIbtVtra6FhQFMS3cv+Pf1K8x/vwpxYTprv6kR/m8eyjLSa9y
        OGO+Fyae8K8cAIxsiPaT1OwM0fqgLYn/2WytYHc=
X-Google-Smtp-Source: AAOMgpfN8hQTM88zuUnGH8QDjg5PVPVotqYlFkTyyHMMNRQySN6qRPDfbJ6xVo6sk9Kq7m+lEBhQn/cadu0otvHIDjc=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr12694665jad.94.1533571194634;
 Mon, 06 Aug 2018 08:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Aug 2018 17:59:28 +0200
Message-ID: <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 5:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> > I've also checked about the lookahead thing in unpack_trees() to see
> > if we accidentally break something there, which is my biggest worry.
> > See [1] and [2] for context, but I believe since we can't have D/F
> > conflicts, the situation where lookahead is needed will not occur. So
> > we should be safe.
>
> Isn't this about branch switching, where the currently checked out
> branch may have a regular file 't' and checking out another branch
> that has directory 't' in it (or vice versa, possibly with the index
> having either a regular file 't' or requiring 't' to be a diretory
> by having a blob 't/1' in it)?

We require the unpacked entry from all input trees to be a tree
objects (the dirmask thing), so if one tree has 't' as a file,
all_trees_same_as_cache_tree() should return false and not trigger
this optimization. Same thing for the index, if it has the file 't',
then we should not have the cache-tree at path 't' and the
optimization is skipped as well.

So yes branch switching definitely can have d/f conflicts, but we
should never ever accidentally run this new optimization when that
happens.

> The log messge of [1] talks about
> walking three trees together with the index, but even if we limit us
> to two-tree walk, I do not think that the picture fundamentally
> changes.  So I am not sure how we can confidently say "we can't have
> D/F".  I'd need to block a solid time to take a look at the patches.

Yes please :)
-- 
Duy
