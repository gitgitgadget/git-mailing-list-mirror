Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C9D1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfIMNCv (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:51 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44046 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfIMNCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:51 -0400
Received: by mail-ed1-f47.google.com with SMTP id p2so25761798edx.11
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kORzbG56XclRSTh86JvlMtkevz0YALWExqsIdYZ0HE=;
        b=XPqhwWiMB24F5PKlLUpZu5ArB0376BuXg6hF7K9uXv1llY65ZkKV8bL5bNSNYYnGo+
         rKNWd9s+QQmtH7VTgnFoCBFwseiNJHfJHeDoK1yI3q9XXE2wl5B4akH/sSmqYMCX9G19
         cG5pz8zju4Qkcsm4Yi6r1vF3dV/BuRrRTFgfm1/43N1BVkDfsCfSy0tTtw+oZfgDcgIR
         oLePNGzJ2uI94G91pGRQbSjh75/o64FiVjhnPk1aHNBFc9hg3AcHieTVlMPZ+/TUby6k
         mqX2ZdFDYfpdawz2mWA2htc7cv8XKpYDKt1bCGNNdvS5AbviEUbK02rIurcJRZ3inPWf
         iEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kORzbG56XclRSTh86JvlMtkevz0YALWExqsIdYZ0HE=;
        b=Yr0Zs6Upbg6mtAtluv7xWSCOpl+o5TDqkIzo0vApvaAVZZ6WKs6529E/p/44hOdXdJ
         cdcW/nbGOttQXKzgje2uBl2C/bLDCQXXCIjRwCpJ2+QBdSjrPTpA6b8mAiHMqVazesvj
         ABYS6gFfpfjXbL5++uGb3KL24JYPACgk83uq/KqaII3+Zj9hr6VL1kSaJncRlqPQLqmM
         CjgWjeEzSSJAvXhmmQ9Jc0GbZseIVCbnvmvGOZbf17nyeLHh6hSmgC0SvYtAMpHOWUkj
         6PjTIZAsP5LZu8hqvjznqx95lvMV3/D9zseseWmM6D//+P2U3d9S7hHEx/gKXIgEop5A
         Bbug==
X-Gm-Message-State: APjAAAUL/s3lwOaEJTHjnTxxrye69Ro6rWDaMt60Piqm3k1RSsTsAlIB
        +H6DBWuHbzz6eiqFQ0MC1l6vxzcR
X-Google-Smtp-Source: APXvYqz3FyqiOIo6k77vl+JZGjWzxw5vfRS4wAu/xhTwWIzt49rz23tyNLHGm3zVHkUEuw7b6zm7dw==
X-Received: by 2002:aa7:c5c2:: with SMTP id h2mr68502eds.260.1568379769542;
        Fri, 13 Sep 2019 06:02:49 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 00/10] Rewrite packfile reuse code
Date:   Fri, 13 Sep 2019 15:02:16 +0200
Message-Id: <20190913130226.7449-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is rewriting the code that tries to reuse existing
packfiles.

The code in this patch series was written by GitHub and Peff nicely
provided it in the following discussion:

https://public-inbox.org/git/3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au/

This is an RFC patch series that mostly for now just tries to split
the code into separate commits. If this split is considered ok, then
commit messages will be improved and some doc will be added
(especially doc for pack.allowPackReuse). Perhaps performance test
results will also be provided.

Most of the changes are in the last patch (10/10) and I haven't found
a good way to split them into several patches. Ideas are welcome. In
each of the other preparatory patches there is a small change that
might make sense separately.

According to Peff this new code is a lot smarter than what it
replaces. It allows "holes" in the chunks of packfile to be reused,
and skips over them. It rewrites OFS_DELTA offsets as it goes to
account for the holes. So it's basically a linear walk over the
packfile, but with the important distinction that we don't add those
objects to the object_entry array, which makes them very lightweight
(especially in memory use, but they also aren't considered bases for
finding new deltas, etc). It seems like a good compromise between the
cost to serve a clone and the quality of the resulting packfile.

I have put Peff as the author of all the commits.

Jeff King (10):
  builtin/pack-objects: report reused packfile objects
  packfile: expose get_delta_base()
  ewah/bitmap: introduce bitmap_word_alloc()
  ewah/bitmap: always allocate 2 more words
  pack-bitmap: don't rely on bitmap_git->reuse_objects
  pack-bitmap: introduce bitmap_walk_contains()
  csum-file: introduce hashfile_total()
  pack-objects: introduce pack.allowPackReuse
  builtin/pack-objects: introduce obj_is_packed()
  pack-objects: improve partial packfile reuse

 builtin/pack-objects.c | 248 +++++++++++++++++++++++++++++++++--------
 csum-file.h            |   9 ++
 ewah/bitmap.c          |  13 ++-
 ewah/ewok.h            |   1 +
 pack-bitmap.c          | 178 ++++++++++++++++++++---------
 pack-bitmap.h          |   6 +-
 packfile.c             |  10 +-
 packfile.h             |   3 +
 8 files changed, 358 insertions(+), 110 deletions(-)

-- 
2.23.0.46.gd213b4aca1.dirty

