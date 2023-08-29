Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD8CC83F14
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjH2QuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjH2Qtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:49:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B181AA
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:49:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so65245547b3.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693327769; x=1693932569;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6oaGe2aYvWLc5alZcXZKIx0IwjljMPKoUElkJGjI7p4=;
        b=G7N3J87z+qAt0VsaW4uuOwdf2CduvkbHWn3ry/kopVTUSh4ZxGxOPefhFLEuAnF6fa
         8YFgeEPIsriEZKhFYhOFvou2OcmpLSqs4zC1tHJ+KyTbJKqSf/0TSg26xZ+KJRfYVuY0
         AEjNA3Wbs7dlmwhyQw0aeieUIfzFQke56iR57CIGf8UecmZj0bavhVhZN7kzFnmcNvNJ
         cRMQwedrJ33ceEoBIQfLJsM/c+GrBphJP+Ya+q8jBQkD4qjvNE1wsFyENDeMLkSYsoos
         MWoFVRyoqfEOqFNBiftpNihzFcf8GHmmqsZ/hay87guBGC34ij0tVX0y1RW7wFGk+8L5
         xoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327769; x=1693932569;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oaGe2aYvWLc5alZcXZKIx0IwjljMPKoUElkJGjI7p4=;
        b=NjKEqNx6VkO2q/E9+dvh+mR5dKFBOVPnApb009WyVei58H5TtnO7iVZmRs2q2YFqQE
         qWPxOJPvb5IHAYznm7k/bQqN/QS0ALbK8VlgJ8x1N5v/BzB2OT9a/MXiQCRxWwpzaoM9
         N5QZ03I5ti36y2BzJvCqF5JmbTt0hfRt7BYN5FsAa7soDTteubz60ajBM6hsHqaZuKb3
         httTnjevWgqmx+aRjHPrUTuOV6F/d0erOIujVf+/mUHTQ6MfgFKRVSWb7hOhQsi+g92f
         pvqOqzlwjgH+v2p0FH95m8wzUqeMb+Yzr1ImX131beCE/4x4dcjzXuB0pZUZ7TViT6X+
         g2PQ==
X-Gm-Message-State: AOJu0YwPdMVKkFQt72hNJplrH+OKxt/ZzStuixNRVLs5CVNVPHMIFHY9
        emV8HTk9W/ApYY50I0hbZhkD060v2Qh1vU8VOkqG
X-Google-Smtp-Source: AGHT+IEF0xkUtbskqRe6pz37oHor3UYhkgShXs6ALHQL466DI0Fxav4ORMWO6QvNlVdFy1D3FGllG3ZKzqMEW2y/5UQy
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ec07:4d48:eb22:d87c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:69c6:0:b0:d78:2690:5a47 with
 SMTP id e189-20020a2569c6000000b00d7826905a47mr680112ybc.7.1693327769279;
 Tue, 29 Aug 2023 09:49:29 -0700 (PDT)
Date:   Tue, 29 Aug 2023 09:49:26 -0700
In-Reply-To: <ZOj6PazHzDeQrY88@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829164926.367260-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Aug 24, 2023 at 04:05:27PM -0700, Jonathan Tan wrote:
> > Up to here is fine.
> >
> > > +	hash_version = r->settings.commit_graph_changed_paths_version;
> >
> > Instead of doing this, do this (well, move the struct declaration to
> > the top):
> >
> >   struct bloom_filter_settings *s = get_bloom_filter_settings(r);
> >   hash_version = s->hash_version == 2 ? 2 : 1;
> 
> Do we need this normalization? We assign s->hash_version in
> commit-graph.c::graph_read_bloom_data() by reading it from the start of
> the BDAT chunk, so this should only ever be 1 or 2.

I'm not sure offhand if we do...I wrote it this way to match
fill_bloom_key(), but fill_bloom_key() was written in that way because
it was the clearest, not specifically because it needed to normalize.

> > > +	if (!(hash_version == -1 || hash_version == filter->version))
> >
> > No need for the comparison to -1 here.
> 
> I'm not sure I understand your suggestion. When we fetch the filter from
> get_or_compute_bloom_filter(), we have filter->version set to the
> hash_version from the containing graph's Bloom filter settings.
> 
> So (besides the normalization), I would think that:
> 
>     struct bloom_filter_settings *s = get_bloom_filter_settings(r);
>     struct bloom_filter *f = get_bloom_filter(...);
> 
>     assert(s->hash_version == f->version);
> 
> would hold.

My mention to avoid the comparison to -1 was just for completeness
- since we're normalizing the value of hash_version to 1 or 2, we no
longer need to compare it to -1.

As for whether s->hash_version is always equal to f->version, I think
that it may not be true if for some reason, there are multiple commit
graph files on disk, not all with the same Bloom filter version.

> I think the check that we want to make is instead: is this Bloom
> filter's version (or equivalently, the hash version indicated by that
> graph's BDAT chunk) something that we can read? 

I think it's not "something that we can read" (eventually, we can read
all versions, we just treat them differently) but "the version that
fill_bloom_key" will use. We don't want this function to produce a Bloom
filter of version X and then have the calling code subsequently use it
with a Bloom key of version Y.

> And I think "what we can
> read" here is dictated by the commit_graph_changed_paths_version member
> of our repository_settings, no?

I don't think commit_graph_changed_paths_version always dictates
something - it could be -1 (which you have probably seen, since you
check it against -1 in the current version of the patch). One of the
points of my suggestion is to avoid this field completely.
