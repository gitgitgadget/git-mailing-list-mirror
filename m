Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CEFEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjGKRhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGKRhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:37:34 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D73E4D
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:37:31 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5768a7e3adbso103904947b3.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689097050; x=1691689050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh8jbqjHmOnAdDtp2QA6P0ZpyKEg1p0sz49kbewcDBo=;
        b=f+Wc+Z333QoiqzCSfp1SoM0UYxGwXbPoS5vXfE4f5cpA/oASKxctcat3zooilxg1RM
         TPA6RRbkPWBBQHqBamJDP3EcipJ9enEKwlvKkuwCoQCo4b2QiM0wSKzEpMlgU6SLjIMz
         3A/UrLvlinwEFypf1eaeLUCH3KcFYp/jLYoAjPaovqxPyqE0l0VsQmTTSfox00BnHM8m
         USKcfv0RRHSwJ04dmFajLt9faoQEEVagM/ANw3iwf/UTO9QnML0hcAh36AKSBnbfs88Z
         QTl3idI9IjnA5FT/LSwVrKi8rErbgtwMlJdnW8YyXPZXGJeMdz0jk2nOayWZuNLVldj4
         lyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689097050; x=1691689050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh8jbqjHmOnAdDtp2QA6P0ZpyKEg1p0sz49kbewcDBo=;
        b=SyaWLH6rirCFHznjX062QnYfaVcXrjd7kSDK9W1+YN6Y5xHU0DhFlmNcBILNMd2tDZ
         qqFVddeZdI74OAoBKkYtYb04fFmmXu3jinsFhL0bKplLG4JeMFuBiEu+mH6gI8kBR2ZW
         NYyEpdaTWR1AZT868OKsOHZ+QJblr/OqUL+VzocK/FSrDJXcw1CpFVRtZKAyO8C1FnMp
         9V2OE4cYcdk7HqIMi56LMhQl6H0UvKehIyy0qmoC5DP5ezSjZQRUY98oLkjiZDKFjgCm
         nW7jnwDQQZuvVzRwrXUSaO0Le3WcsoupJUjqVEdUwAPJTiwNwl12OhoAKssmd4qS6E+T
         SadA==
X-Gm-Message-State: ABy/qLbyE1qWIozH00pai2NSg7zRwmdSRUlE0YVk3OBs9rvcHMZhRgm5
        n8cCSNqEVvUzjjxWWsJg+1epdu6jzTLRBfRM2nsOFA==
X-Google-Smtp-Source: APBJJlFsOuEEJH97sGNg6RTEWMaG151Fku4+SVX78DE74yJ31KKhUdFV9OYQh/6Q+uy9ylTo1b2Rzg==
X-Received: by 2002:a0d:d409:0:b0:56f:f83f:618 with SMTP id w9-20020a0dd409000000b0056ff83f0618mr13427344ywd.19.1689097050186;
        Tue, 11 Jul 2023 10:37:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q63-20020a817542000000b0057a68b6c2f4sm684200ywc.133.2023.07.11.10.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:37:29 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:37:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <junio@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #02; Mon, 10)
Message-ID: <ZK2TWdME96AODU4+@nand.local>
References: <xmqqmt032r7m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt032r7m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2023 at 06:05:01PM -0700, Junio C Hamano wrote:
> * tb/fsck-no-progress (2023-07-10) 6 commits
>  - commit-graph.c: avoid duplicated progress output during `verify`
>  - commit-graph.c: pass progress to `verify_one_commit_graph()`
>  - commit-graph.c: iteratively verify commit-graph chains
>  - commit-graph.c: extract `verify_one_commit_graph()`
>  - fsck: suppress MIDX output with `--no-progress`
>  - fsck: suppress commit-graph output with `--no-progress`
>
>  "git fsck --no-progress" still spewed noise from the commit-graph
>  subsystem, which has been corrected.
>
>  Will merge to 'next'.
>  source: <cover.1688776280.git.me@ttaylorr.com>

Thanks, this one is fairly innocuous and shouldn't cause any problems.

> * tb/repack-cleanup (2023-07-10) 2 commits
>  - builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`
>  - builtin/repack.c: only repack `.pack`s that exist
>
>  The recent change to "git repack" made it react less nicely when a
>  leftover .idx file that no longer has the corresponding .pack file
>  in the repository, which has been corrected.
>
>  Will merge to 'next'.
>  source: <cover.1689017830.git.me@ttaylorr.com>

This one is definitely a higher risk change, but I am as confident as I
can be in terms of its correctness. I sent a new version[1] to remove the
unnecessary 'ls'-to-'find' conversion, but feel free to queue either.

> * cc/repack-sift-filtered-objects-to-separate-pack (2023-07-05) 8 commits
>  - gc: add `gc.repackFilterTo` config option
>  - repack: implement `--filter-to` for storing filtered out objects
>  - gc: add `gc.repackFilter` config option
>  - repack: add `--filter=<filter-spec>` option
>  - repack: refactor finding pack prefix
>  - repack: refactor finishing pack-objects command
>  - t/helper: add 'find-pack' test-tool
>  - pack-objects: allow `--filter` without `--stdout`
>
>  "git repack" machinery learns to pay attention to the "--filter="
>  option.
>
>  Comments?
>  cf. <xmqqh6qi1byn.fsf@gitster.g>
>  source: <20230705060812.2865188-1-christian.couder@gmail.com>

This is on my review queue, sorry for the delay in responding to the
rest of the newer version.

> * jt/path-filter-fix (2023-06-13) 4 commits
>  - commit-graph: new filter ver. that fixes murmur3
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - gitformat-commit-graph: describe version 2 of BDAT
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>
>  Expecting a reroll.
>  cf. <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
>  source: <cover.1686677910.git.jonathantanmy@google.com>

This is also on my review queue as soon as the reroll appears on the
list.

> * tb/refs-exclusion-and-packed-refs (2023-07-10) 16 commits
>  - ls-refs.c: avoid enumerating hidden refs where possible
>  - upload-pack.c: avoid enumerating hidden refs where possible
>  - builtin/receive-pack.c: avoid enumerating hidden references
>  - refs.h: implement `hidden_refs_to_excludes()`
>  - refs.h: let `for_each_namespaced_ref()` take excluded patterns
>  - revision.h: store hidden refs in a `strvec`
>  - refs/packed-backend.c: add trace2 counters for jump list
>  - refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
>  - refs/packed-backend.c: refactor `find_reference_location()`
>  - refs: plumb `exclude_patterns` argument throughout
>  - builtin/for-each-ref.c: add `--exclude` option
>  - ref-filter.c: parameterize match functions over patterns
>  - ref-filter: add `ref_filter_clear()`
>  - ref-filter: clear reachable list pointers after freeing
>  - ref-filter.h: provide `REF_FILTER_INIT`
>  - refs.c: rename `ref_filter`
>
>  Enumerating refs in the packed-refs file, while excluding refs that
>  match certain patterns, has been optimized.
>
>  Under discussion.
>  source: <cover.1689023520.git.me@ttaylorr.com>

Patrick took a look[2] at this (which you responded to), and gave an
ack, so this one should be ready to go down to 'next', too.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1689096750.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/eddehgbfqnmkhvhkacbvnqiiripbn6jvjawpy76ysfnpohsygt@a43fbutqg64z/
