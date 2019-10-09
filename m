Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513CA1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfJIXo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:29 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55546 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:29 -0400
Received: by mail-pl1-f202.google.com with SMTP id g11so2509058plm.22
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8vQeYVkicCWwGawCYLRuWzLBhyYK5d953PK2tAk0GKo=;
        b=J7PZ322HdNMx4RuaXpz5IR6zsf/GUyxex7FEt9HGVPa8gxxWyLxHxZJ5iKm+5v0j81
         puy7qEadqYn/NDMB/X2RGGpH9HL3bY0Mh0+zlovW+uNIrIvYEz9s+NKa2T1K+ZMVUwre
         NvyghufvcRi10ZQtR1qi9iXoINFIyVXx3x7lWdWBg4w5+FSAxfBmWErKqS5ZCiUfegT8
         /cEGN/AUIxq1m8H0LnMBJY9H8cGS68nSBgy8+Iw9ZFW17+2zHBYq8JxQSck2tZ1/eNm2
         QaRz8ctvTvm04F4J1DzvojoOd1g37x8WwoBMJSotFZdNUqxhg3+VsXmpIxJVEVH63vkm
         2/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8vQeYVkicCWwGawCYLRuWzLBhyYK5d953PK2tAk0GKo=;
        b=fWBtBP9EYaLpYIsyoNXNlee56YAEHKf0d45IhEkAcs6h5hkhJTff1QxCdafbTX3c2l
         J8vwyWxT0VYT5O5/k1Omhtn8HwdBVYDuKTtdYgnnEsh8pZzHUff4dVYLWFG3lnu1eOSY
         EBVZ6eom22Ee71yLkv1CrsKNfxiJNSMbzb4s6f6IQ73FrwHthW2/Lf1McqMwa32lQAfS
         iho/HKFupbrbLUruuc0gr0CJs70FM33O1tr0DQXVmV2ywiGAFguZKNDSqZoHG6vTJJdt
         rlZlO4XTS2PfbzX+TOmx4NAqSpD71xOTFsEx8S058emmMpT1OCJsM9ydbhyhamJEXGfT
         j5Gg==
X-Gm-Message-State: APjAAAU2zahmKYus3TrA6YvWPevzhGrgOdVPEQV2loYDcztXTOspB+6k
        jhDYU9RDMk5x4zwgudI0YEyx0hzMNGMknFpgAJe2Far2ko4o6gCvh2H+NjfTDOjq6TLavqGES4t
        KGT8/LCCDaIE9SAdrRQccThlJyRriH397uwYW6rVpz1DTrIfAcWJlvxaX+vBYCWXraymJwdMx9L
        rB
X-Google-Smtp-Source: APXvYqyX++YBgEvloeTCTcUnaDuA2VLLRSOC4m25YXclSAj4lBZiNcKI6qrcBOnIMIJNhBqqdMfJNTXaI4eqyFvBcoc5
X-Received: by 2002:a63:fe44:: with SMTP id x4mr7178588pgj.118.1570664667753;
 Wed, 09 Oct 2019 16:44:27 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:16 -0700
Message-Id: <cover.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RFC PATCH 0/6] Better threaded delta resolution in index-pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting myself [1]:

> index-pack does parallelize delta resolution, but
> it cannot split up trees into threads: each delta base root can go into
> its own thread, but when a delta base root is processed, all deltas on
> that root (direct or indirect) is processed in the same thread.

This is a problem when a repository contains a large text file (thus,
delta-able) that is modified many times - delta resolution time during
fetching is dominated by processing the deltas corresponding to that
text file. Here are patches that teach index-pack to better divide up
the work.

As an example of the effect, when cloning using

  git -c core.deltabasecachelimit=1g clone \
    https://fuchsia.googlesource.com/third_party/vulkan-cts

on my laptop, clone time improved from 3m2s to 2m5s (using 3 threads,
which is the default).

As you can see from the diff stats, my new algorithm uses comparable
lines of code to the existing one, but I think that it is a bit more
complicated. My main point of difficulty was in handling the delta base
cache - it must be GC-able, but at the same time available to another
thread if it was being used as a base to inflate a delta. In the end,
what I did was to make individual mutex-guarded refcounts for each
inflation result, but the buffer itself is not mutex-guarded: so a
thread could increment the refcount within the mutex, inflate (and
verify) outside the mutex, and then decrement the refcount within the
mutex. (One global mutex guards all the refcounts, as well as other
things.) Any ideas for making this design less complicated is
appreciated.

If this is a good direction, let me know and I'll refine the patches. I
personally think that the improvement in performance is worth the slight
added complexity. Also, in this patch set, I did some cleanup to make
future patches clearer, but some of the cleanup is undone by the future
patches themselves; let me know if it's easier to review if I should
squash those patches.

Also CC-ing Mike Hommey because Mike brought up a repo with a similar
case [2], although that case happens during repack.

[1] https://public-inbox.org/git/20190926003300.195781-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20190704100530.smn4rpiekwtfylhz@glandium.org/

Jonathan Tan (6):
  index-pack: unify threaded and unthreaded code
  index-pack: remove redundant parameter
  index-pack: remove redundant child field
  index-pack: calculate {ref,ofs}_{first,last} early
  index-pack: make resolve_delta() assume base data
  index-pack: make quantum of work smaller

 builtin/index-pack.c | 375 ++++++++++++++++++++-----------------------
 1 file changed, 177 insertions(+), 198 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

