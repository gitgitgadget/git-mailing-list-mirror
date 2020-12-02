Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E93C83012
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0756721D81
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbgLBQWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbgLBQWF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:22:05 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2845C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 08:21:25 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q3so1380478pgr.3
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zMudqH1CJgAiL9DITOcjaySwAI4LEWmaNWlZJ5VDuPM=;
        b=TmeCyHb7diwdFCVhg4KbBEriXdyyFfz0mfrWEMEbXkSmJJJxl5XI0ycBruHCv1A+II
         fKkKqF/SV1qXWuJQ2tseaz4mtc3UknYfzHOuZqhEABVrLgz+bA6YQ9ACr9G06xK6PuN9
         JwBfzcd+w/nKlvTWsXOiNRRarg9EKgmWG4L+YUvx7lityPLDwos86vIdttk8gG0uWtOn
         ncXg6AlVaKZEUZAhtZAM3C8odpmKT/r0mLlRLREiVn8/MmZ8DA2LTUorAk5Wt6Qfn738
         dEoeHZV6eELawFFPGcKOfhaKYuPdJGbj0aOeE/2T2ajfS9j/YngFGxfesSzOlPmvQM7a
         Sh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMudqH1CJgAiL9DITOcjaySwAI4LEWmaNWlZJ5VDuPM=;
        b=cduAzxVpQ04YjtplnGkDnrdg1Ssm+3y9v7snrlqJyAC46DZnJye/Y76zX8/5qA1WfF
         r8RE7TDOYKRlQp0vezbYcXlht7/ZPVV3bA2KhRZ5moO1QegrKrOxmOp4v6zBUOBo1uzS
         5/dM+KHlWmYrokOo28bQ4AuZFHnKzfWbKnrHkfNTox+P71ycFge6jxhwscdBvj62A/5e
         ju9ZHfHLXZ0RCO9jrlcnDbiKp4NLzjma9WNq52KUFYJMQhXG+mf2Drgor8aqNZOdM5NP
         nTpTEcapPs5t/65ujIU/ZLIeWQmreKO1icEE94ojVo4TjXLv5dfpLGEJKnKAxgivrLTN
         2LQA==
X-Gm-Message-State: AOAM531MXqXCGa1Lo3rsUVrDwzpuSpTCjyqztXgBvUUTsZSkD88u9fHt
        gocHLJDEg9/f+aFmztlkEy0NjsUuuMYUfrsI
X-Google-Smtp-Source: ABdhPJwTJzn2nL5tjHgZZisFgWc2UIsqDAxzCjeFgKzmUmaMtkhMJhAJKIcgY/EnZWlrGze+IkrLQA==
X-Received: by 2002:a63:f317:: with SMTP id l23mr563991pgh.384.1606926085124;
        Wed, 02 Dec 2020 08:21:25 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w2sm281682pfb.104.2020.12.02.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:21:24 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Wed, 2 Dec 2020 11:21:22 -0500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 22/24] pack-bitmap-write: use existing bitmaps
Message-ID: <X8e+0476g+TtfGHx@nand.local>
References: <4bf5e78a54dfdcbe13dd66ba4c5955a159ea181d.1605649533.git.me@ttaylorr.com>
 <20201202072811.3474340-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202072811.3474340-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 11:28:11PM -0800, Jonathan Tan wrote:
> > However, if we walk trees
> > from top to bottom, then we might be parsing trees that are actually
> > part of a re-used bitmap.
>
> Isn't the issue that we shouldn't walk trees at all before exhausting
> our commit search, not the direction that we walk the trees in (top to
> bottom or bottom to top or whatever)?

Right, the direction that we explore trees in isn't important: what
matters is that we consider them after the commits. I've clarified the
commit message to reflect this.

> > To avoid over-walking trees, add them to a
> > LIFO queue and walk them from bottom-to-top after exploring commits
> > completely.
>
> Just to clarify - would it work just as well with a FIFO queue (not LIFO
> queue)? It seems to me that the most important part is doing this after
> exploring commits completely.

Yup, see above.

> >  static void fill_bitmap_commit(struct bb_commit *ent,
> >  			       struct commit *commit,
> > -			       struct prio_queue *queue)
> > +			       struct prio_queue *queue,
> > +			       struct prio_queue *tree_queue,
> > +			       struct bitmap_index *old_bitmap,
> > +			       const uint32_t *mapping)
> >  {
> >  	if (!ent->bitmap)
> >  		ent->bitmap = bitmap_new();
> >
> > -	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
> >  	prio_queue_put(queue, commit);
> >
> >  	while (queue->nr) {
> >  		struct commit_list *p;
> >  		struct commit *c = prio_queue_get(queue);
> >
> > +		/*
> > +		 * If this commit has an old bitmap, then translate that
> > +		 * bitmap and add its bits to this one. No need to walk
> > +		 * parents or the tree for this commit.
> > +		 */
>
> This comment should be right before "if (old && ...", I think. Here, it
> is a bit misleading. It leads me to think that "this commit has an old
> bitmap" means old_bitmap != NULL, but it is actually old != NULL.

Yup, the comment is much more clear when placed there, thanks.

> > +		if (old_bitmap && mapping) {
>
> This is defensive in that if we somehow calculate old_bitmap without
> mapping (or the other way around) (which is a bug), things just slow
> down instead of breaking. I'm OK with this, but I still wanted to call
> it out.

Right, we should never have one without the other, so in that sense this
is a defensive check. IOW, this could easily be written as `if
(old_bitmap)` or `if (mapping)`, but being extra defensive here doesn't
hurt.

Thanks,
Taylor
