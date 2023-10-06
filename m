Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE7DE94136
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJFXCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjJFXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 19:02:14 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EB9F
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 16:02:10 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a2478862dbso33087077b3.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696633330; x=1697238130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thr2hdkD2X2EqcVUI8qWjWe2eVqVMUxUrell/3n/do4=;
        b=ZoY5dOQawSo4Q9DfuPh9qA8Ri4u+D2laC+1xRYpPnuN7SNaoyDlsE6VJVJYRkeo4rE
         zyFXXPeccBhUNLoXralnCfEJ8O9Idh6owP9AN8TcPOcWpOHDDkBdpPOLMO1HtgFjP5n5
         MpcWZVgFNLGCCAiCrrLYAdzkezNa08zftnUJoKvwPDciHMOqxel1dzjH5f+T1mhp2FnI
         KQeZWB5kNqqse9TeRAE5M7p5cjGjPjWtjTQ44L9CpBCz8szIuas21shZecF1DqRcny3+
         kESfRUoRbahOrIeogcRseYbaKrhw6BZOu4weywJJASr+/iWqhgtGnsb7wBBdqHaZoWZk
         LWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633330; x=1697238130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thr2hdkD2X2EqcVUI8qWjWe2eVqVMUxUrell/3n/do4=;
        b=BLthX/JuTEVuNAzWHtyYOl3VNcilF/PdBKklJ2jeaa3uWPdRDJQieBm4+mDzh2/KI3
         BfYa4OWRwg8gHrb2CzQ46GEQU/BhzTkMWVUr1qcJGSkXoKnhCHSeY9g6dgLleChLVjb3
         ibCr4r2F/ud8jjB6k7eT4OT1Su+YiJf8s5SjI68HfJH1iyvonvInkLObRz6q9ERRbsLs
         M2GB02gqDz4+QTmqhu/fg690XA6uvXwHXtcgl+ZBgI7tin/13oSFREvJuESCG1S6f2vE
         XYqIl34z29/QV9r8rMIIAJrZRtB2x4r36VF+Ay7SvcfwUaZug3sfvbmMd0ga7Htmv1BC
         yXOg==
X-Gm-Message-State: AOJu0YxVeVIo+CKWDMcTkV2xWeXkO7FEb/zKiwcuE8mHjWzQJw0fJfy3
        BzUAxEX9ou7fKE5FGkt8VpJ5DQ==
X-Google-Smtp-Source: AGHT+IHvv5d/38JwvcqkPlJOUtFbMP5ebdHX1X+zJ1hRKwY0ppki75W1ckQWaaNpIDaS/QF2X1FPYg==
X-Received: by 2002:a0d:d690:0:b0:59b:eb64:bcc5 with SMTP id y138-20020a0dd690000000b0059beb64bcc5mr10318398ywd.8.1696633329935;
        Fri, 06 Oct 2023 16:02:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020ac851c1000000b004197d6d97c4sm1611490qtn.24.2023.10.06.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 16:02:09 -0700 (PDT)
Date:   Fri, 6 Oct 2023 19:02:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSCR7e6KKqFv8mZk@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil7j751u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2023 at 03:35:25PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When using merge-tree often within a repository[^1], it is possible to
> > generate a relatively large number of loose objects, which can result in
> > degraded performance, and inode exhaustion in extreme cases.
>
> Well, be it "git merge-tree" or "git merge", new loose objects tend
> to accumulate until "gc" kicks in, so it is not a new problem for
> mere mortals, is it?

Yeah, I would definitely suspect that this is more of an issue for
forges than individual Git users.

> As one "interesting" use case of "merge-tree" is for a Git hosting
> site with bare repositories to offer trial merges, without which
> majority of the object their repositories acquire would have been in
> packs pushed by their users, "Gee, loose objects consume many inodes
> in exchange for easier selective pruning" becomes an issue, right?

Right.

> Just like it hurts performance to have too many loose object files,
> presumably it would also hurt performance to keep too many packs,
> each came from such a trial merge.  Do we have a "gc" story offered
> for these packs created by the new feature?  E.g., "once merge-tree
> is done creating a trial merge, we can discard the objects created
> in the pack, because we never expose new objects in the pack to the
> outside, processes running simultaneously, so instead closing the
> new packfile by calling flush_bulk_checkin_packfile(), we can safely
> unlink the temporary pack.  We do not even need to spend cycles to
> run a gc that requires cycles to enumerate what is still reachable",
> or something like that?

I know Johannes worked on something like this recently. IIRC, it
effectively does something like:

    struct tmp_objdir *tmp_objdir = tmp_objdir_create(...);
    tmp_objdir_replace_primary_odb(tmp_objdir, 1);

at the beginning of a merge operation, and:

    tmp_objdir_discard_objects(tmp_objdir);

at the end. I haven't followed that work off-list very closely, but it
is only possible for GitHub to discard certain niche kinds of
merges/rebases, since in general we make the objects created during test
merges available via refs/pull/N/{merge,rebase}.

I think that like anything, this is a trade-off. Having lots of packs
can be a performance hindrance just like having lots of loose objects.
But since we can represent more objects with fewer inodes when packed,
storing those objects together in a pack is preferable when (a) you're
doing lots of test-merges, and (b) you want to keep those objects
around, e.g., because they are reachable.

Thanks,
Taylor
