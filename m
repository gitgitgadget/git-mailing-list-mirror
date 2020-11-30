Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C7FC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3458220725
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5UrWuex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgK3Seo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgK3Seo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 13:34:44 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86CC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:34:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b11so9664470pfi.7
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0xoiPjokqGm2m55ZD59rDllcN+RmFjjMI8zxHE52FxU=;
        b=t5UrWuexnoc6l4jX8MaIZVU/Hlbr8/x0uS5nS5jdanlzVXUh54UHLx0aBxt9PDREWn
         bJ03IMHxbrBHyzQzMXxFcAQvK6l5uUUlSWzlDeXGrKPXBLeFaEAAZ6MGnXjibbOHBp+y
         NbPgt7dfqt+iI6JTYt2cBOngtfMi37pr7kknzKz75uYe6AHpuLXoW4SYhnTLCGQkOI+l
         dko6iL9o94yt89aFA78X9BDc1DFv6NcBPB+pNBE8Gp1o19k57O2Fqd98L3IbdYVUQjUt
         pfVQCd1EljNxN50hB2LXYir41i+2sznQo+5Myz4mbEVpocAAb5/eXS16CZ43wF0iHJai
         SFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0xoiPjokqGm2m55ZD59rDllcN+RmFjjMI8zxHE52FxU=;
        b=iSeu4PZ1WOy1smBv1Fym1fG3UpMpIINB2N0J/4X/QfZ7qGXUc62rvbpfM8oMYnS/eK
         rVZPIAFADjDThWWba7yY92pzOTEiNSXv6h8HFacb2Kb0/WuwTj47rbSMxs3cW1aYKOmZ
         qI61Rv4eTYwXmUlLGrVZ+/t4nD0Y4mQQcEpQ07UyckjXqZRPazhpDxlEgYgrDyhZrob1
         6cRutUjlsVilt/AavxCjHEWmf1MN3A9WnI0SNQyHir7sQI5+AvNG6E9Q6/+aW1Yu9+bH
         a70lraoU3xxGVJgZ+VjJivX+3oexA2AZN8YeXC6mlgWkNac3uNv0nvYzBSEgc5Nu+Pb9
         SjRA==
X-Gm-Message-State: AOAM5307AG2WcBAplhqCmCJU0l46jXD97N9rXuR1AeYPx/fMBwx2p4yi
        qLN7/svHGgOwi8jWuQGZQ0NkIeylVTM9/XIN0Zdv
X-Google-Smtp-Source: ABdhPJyp+c8+TsKxGChLchELeAmuRxwVAxJkEhiYWTqyoiV0fvVZtDFjCA2wpXrwg1o+2fGiJW30CKQR/bH+bDfNnCAh
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr112845pja.0.1606761242932; Mon, 30 Nov 2020 10:34:02 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:33:58 -0800
In-Reply-To: <X8KHEMl87sU5cIGK@nand.local>
Message-Id: <20201130183358.2965225-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8KHEMl87sU5cIGK@nand.local>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit history
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks. Stolee and I worked a little on revising this last week, and I
> think that the current log message is more along these lines. Here's
> what we wrote:
> 
>     pack-bitmap-write: fill bitmap with commit history
> 
>     The current implementation of bitmap_writer_build() creates a
>     reachability bitmap for every walked commit. After computing a bitmap
>     for a commit, those bits are pushed to an in-progress bitmap for its
>     children.
> 
>     fill_bitmap_commit() assumes the bits corresponding to objects
>     reachable from the parents of a commit are already set. This means that
>     when visiting a new commit, we only have to walk the objects reachable
>     between it and any of its parents.
> 
>     A future change to bitmap_writer_build() will relax this condition so
>     not all parents have their reachable objects set in the in-progress

I would write "not all parents have their bits set" instead, but this is
fine too.

>     bitmap. Prepare for that by having 'fill_bitmap_commit()' walk
>     parents until reaching commits whose bits are already set. Then, walk
>     the trees for these commits as well.
> 
>     This has no functional change with the current implementation of
>     bitmap_writer_build().
> 
> > >  static void fill_bitmap_commit(struct bb_commit *ent,
> > > -			       struct commit *commit)
> > > +			       struct commit *commit,
> > > +			       struct prio_queue *queue)
> >
> > As far as I can see, this function expects an empty queue and always
> > ends with the queue empty, and the only reason why we don't instantiate
> > a new queue every time is so that we can save on the internal array
> > allocation/deallocation. Maybe add a comment to that effect.
> 
> Sure. Would you find a comment like that more helpful above
> 'fill_bitmap_commit()', or above the declaration of 'queue' (in
> 'bitmap_writer_build()') itself?

I think it's better with fill_bitmap_commit(), as it's the one in
control of how "queue" will be used.
