Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4141CCE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjISScK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjISScJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:32:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500690
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:32:03 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59bcd927b45so62858217b3.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695148322; x=1695753122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GqVXSIG60BnvJotqxJTvPbY0yyB0VMtMev4Bsqf4kc=;
        b=raEZr/IC9y0v+kAmjZypppl6/Iqr8Q3hC29wL1prRrWioQpj5NCB+0/hMk7Ug/bVgC
         kV2bR0qucWddCcNVD3KoU84CVVTPQqh5bC1gjSaTlAmyj+ccmCkjZj2ecpsDVMm0o0pV
         Fh2qlbvzTCrgc0VeUS3OReV1IQWE9xQGYFZXEAAwQtRKfR5a4pq3CPcLGsJFpIS5ypub
         UL5KHbVOXuugArVW3rsDuIvliOu18UH0izjJQN2N6xhLW13Dq9TrULIu45iB8uteVC62
         BN8nFKS6Cf9JGID4CaaROUEJfhPQ/rp3npH1jgZ3B+hskY0ZdgyZaPodHjs/2FPNWqIS
         r2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695148322; x=1695753122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GqVXSIG60BnvJotqxJTvPbY0yyB0VMtMev4Bsqf4kc=;
        b=ENlXPG/2n6ReLfrytNif01k3aeIgcibefiTyZFyCCwVQXHbL40B/FHwmXZxoWttoqi
         NxLNVs+iN0EiPe4vlheki3rLtJOTy+zhxaJi14gYUnRI9yE8u4l7uPol6n9rjCRM/X5k
         gMmgQk1Pz2653LEruC0c7IBA0/UUb8uOV93P0M6i0EXKLjWr5Zq/fgTxmDMiII6LzHjd
         3Q6Km5tBe5AjsBeBiM4uxdnTwPKNshVi7rAydxcYgSAPNtZygx8p/VTBVTACGhKjySKz
         iNb4drkh0AltxKB9eOVPQOt6ITb+xDjxPJKKMBnOLqSOMc7wEFR0l/dMShLwQLIWNexd
         9FLg==
X-Gm-Message-State: AOJu0Yw62BbpMVYq8KWmyDI/B1l+EnqcKBceTT1tmS4GypZuBc/4AKmX
        MOJQHfCkXV0klDEgM9eBH85Di16cC2efX/7sqvTX0A==
X-Google-Smtp-Source: AGHT+IFL9cSsQIzbMGXDhlsabi+MqPQvpaXC49JUE83PXLvugw6K1CdP58k+EjwQ/fp/hXUVXu+p2A==
X-Received: by 2002:a25:8051:0:b0:d7a:d628:f69d with SMTP id a17-20020a258051000000b00d7ad628f69dmr456138ybn.32.1695148321203;
        Tue, 19 Sep 2023 11:32:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n193-20020a25d6ca000000b00d1dd5c6c035sm2978789ybg.62.2023.09.19.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:32:00 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:32:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
Message-ID: <ZQnpIBR4hEbOLCwP@nand.local>
References: <xmqqmsxmdhdw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsxmdhdw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 06:41:15PM -0700, Junio C Hamano wrote:
> * tb/repack-existing-packs-cleanup (2023-09-13) 8 commits
>   (merged to 'next' on 2023-09-14 at bb8065e89c)
>  + builtin/repack.c: extract common cruft pack loop
>  + builtin/repack.c: avoid directly inspecting "util"
>  + builtin/repack.c: store existing cruft packs separately
>  + builtin/repack.c: extract `has_existing_non_kept_packs()`
>  + builtin/repack.c: extract redundant pack cleanup for existing packs
>  + builtin/repack.c: extract redundant pack cleanup for --geometric
>  + builtin/repack.c: extract marking packs for deletion
>  + builtin/repack.c: extract structure to store existing packs
>
>  The code to keep track of existing packs in the repository while
>  repacking has been refactored.
>
>  Will merge to 'master'.
>  source: <cover.1694632644.git.me@ttaylorr.com>

Nice, I'm happy to see that this is moving along. Thanks, everybody, for
participating in the review :-). It's very nice to have a second set of
eyes when touching the repack machinery.

> * cc/repack-sift-filtered-objects-to-separate-pack (2023-09-11) 9 commits
>  . gc: add `gc.repackFilterTo` config option
>  . repack: implement `--filter-to` for storing filtered out objects
>  . gc: add `gc.repackFilter` config option
>  . repack: add `--filter=<filter-spec>` option
>  . pack-bitmap-write: rebuild using new bitmap when remapping
>  . repack: refactor finding pack prefix
>  . repack: refactor finishing pack-objects command
>  . t/helper: add 'find-pack' test-tool
>  . pack-objects: allow `--filter` without `--stdout`
>
>  "git repack" machinery learns to pay attention to the "--filter="
>  option.
>
>  May need to wait until tb/repack-existing-packs-cleanup stablizes.
>  source: <20230911150618.129737-1-christian.couder@gmail.com>

I sent Christian a draft of what I think the conflict resolution should
look like when rebasing on top of tb/repack-existing-packs-cleanup [1].

I've looked over all but one of the previous rounds, and have seen the
most recent round and am happy with the result. So I think that this
could go in relatively quickly following merging the above.

I have a couple of other repacking-related topics that are in my queue,
but I've been holding off on sending them until Christian's series has
stabilized. They are:

  - tb/cruft-max-size (git@github.com:ttaylorr/git.git)
  - tb/cruft-preferred-inference (git@github.com:ttaylorr/git.git)

The former is on the list at [2], and needs a bit of work before
queueing again. The latter isn't on the list, but fixes a performance
bug where it is possible in rare circumstances to select the cruft pack
as preferred when generating a MIDX bitmap during repacking.

The second isn't crucial to get in any time soon, but I would love to
get it off of my queue before we start cutting pre-releases. At this
rate, I doubt it will be a problem.

[1]: https://lore.kernel.org/git/ZQNKkn0YYLUyN5Ih@nand.local/
[2]: https://lore.kernel.org/git/cover.1694123506.git.me@ttaylorr.com/

> * tb/path-filter-fix (2023-08-30) 15 commits
>  - bloom: introduce `deinit_bloom_filters()`
>  - commit-graph: reuse existing Bloom filters where possible
>  - object.h: fix mis-aligned flag bits table
>  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
>  - commit-graph.c: unconditionally load Bloom filters
>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>  - bloom: prepare to discard incompatible Bloom filters
>  - bloom: annotate filters with hash version
>  - commit-graph: new filter ver. that fixes murmur3
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - t/helper/test-read-graph: implement `bloom-filters` mode
>  - bloom.h: make `load_bloom_filter_from_graph()` public
>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>  - gitformat-commit-graph: describe version 2 of BDAT
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>
>  Needs more work.
>  cf. <20230830200218.GA5147@szeder.dev>
>  source: <cover.1693413637.git.jonathantanmy@google.com>

I think that Jonathan's most recent round of this is ready to get merged
up, cf. [3]. The outstanding issue you note in
<20230830200218.GA5147@szeder.dev> can be addressed separately, I
believe. To that end, I have a RFC-level patch proposed here [4].

[3]: https://lore.kernel.org/git/xmqqo7io8gmo.fsf@gitster.g/
[4]: https://lore.kernel.org/git/ZQnmTXUO94%2FQy8mq@nand.local/

Thanks,
Taylor
