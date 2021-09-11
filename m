Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78315C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AECE6101A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhIKDdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIKDdk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:33:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF7C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l10so4123258ilh.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Mdml/SF0AsqEchp9V1cLL4Mp7SwUmZO6adZ8e9cX6zw=;
        b=1ABnTuMsz/CEczW+PrDgJxM6CalB2dVIdW3wBzd5LLNgH2TNZRY2v4RyAk5G9b3hwV
         ZzqfolYUDvI9y71DTTehqM6KxL8rTyzEuAFbyEe7kDrXjbmqStWQ9G6v+zk8HbiAV6Gt
         PnUPAJB3kOV0jaQYiTeplEZj3NC65NLP+sig5xaB19dZRJPrTyPN81swsh/51xmdvS5f
         0DUZ95buQLhvVDhgY7v5mNp2MQ6hsH1lRuUYCk5NzMbRmVn6+PpLwvmPSVhtFpYr0k7o
         2gwF18C7OAeBHmIIsDddD1dZWHmAbzaclrHZAsfqOs7m7tp5kcBaXB56bMOqhpXUHJu4
         9RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Mdml/SF0AsqEchp9V1cLL4Mp7SwUmZO6adZ8e9cX6zw=;
        b=LlN3guz4UMVZC5jJeSZJGNbzMxxtrOG1UuQMs7nlTU3UpM2l+AGasu57ff5odRfBhI
         EQJ8LADiahzKO9CS0jwJc069uVG3mvkUQMPQTh/2p3ZuPy4Vny8eXZJaU2e+8ThUxXMO
         apvU/SJfhLaqnki2Gf0zhVjBpDDi/Z2ennEJ7lO+E2lys9x/DeD8cf9LTe5SyOE3u8mL
         uDzst6wojE7cDLMpKhqD2mUhV1TC1M/joZHPKHXjW8OxbrBgNBG6SiWxtZksDCO0dmMa
         VQxaYyJ0jP0PiIPUn9CrMGclneFtnDN8iFw+iQBGgDqnbAGEo91FamlyPWsYu8tjYf8W
         6QIg==
X-Gm-Message-State: AOAM5337eEcP+yBX6JCGz/TEdN8mrNg926ZVVoh98LM9rdUKFzwB/6KM
        CbrIcx/MCNwDPR/RyEEVgFj8wMeGD/yGIJtl
X-Google-Smtp-Source: ABdhPJwNgp1MEhKpKX4G8/CHeVlLG1NWFWAnGggzCqKKkQLfuytlo51Bd1ilfqSiQ9KcYZAHd1h5Rg==
X-Received: by 2002:a05:6e02:1d05:: with SMTP id i5mr626965ila.245.1631331147640;
        Fri, 10 Sep 2021 20:32:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n11sm308426ilq.21.2021.09.10.20.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:26 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/8] repack: introduce `--write-midx`
Message-ID: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements the final component of multi-pack reachability bitmaps:
the ability to write them from `git repack`.

The gist is that it is currently impossible to write a MIDX based on the result
of a `git repack` without the possibility that an existing MIDX may go away.
That's because `git repack` may have deleted a pack that was included in the
MIDX (either because it was rolled up when doing a `--geometric` repack, or the
repack was done all-into-one), and MIDXs cannot refer to deleted packs.

To solve this, `git repack` is taught a new option to write a MIDX between the
critical section: right after the new packs are written and moved into place,
but right before any old packs are deleted.

Unfortunately, there is quite a bit of auxiliary tooling we need to implement
before this is possible. The series is laid out like so:

  - The first two patches lay the ground work for and expose `git
    multi-pack-index --stdin-packs`, which allows callers to write a MIDX
    containing only certain packs.

  - The next patch implements preliminary support for `--refs-snapshot`, which
    allows the MIDX bitmap selection code to reference the prior state of
    reference tips, preventing a race.

  - The next two patches prepare the `repack` builtin to write a MIDX, and the
    following patch actually implements `--write-midx`.

  - The final two patches make sure the MIDX generated has an appropriately
    chosen preferred pack, and that the refs-snapshot is provided.

It is based on `tb/multi-pack-bitmaps`. Thanks in advance for your review!

Taylor Blau (8):
  midx: expose 'write_midx_file_only()' publicly
  builtin/multi-pack-index.c: support --stdin-packs mode
  midx: preliminary support for `--refs-snapshot`
  builtin/repack.c: keep track of existing packs unconditionally
  builtin/repack.c: extract showing progress to a variable
  builtin/repack.c: support writing a MIDX while repacking
  builtin/repack.c: make largest pack preferred
  builtin/repack.c: pass `--refs-snapshot` when writing bitmaps

 Documentation/git-multi-pack-index.txt |  19 ++
 Documentation/git-repack.txt           |  18 +-
 builtin/multi-pack-index.c             |  35 +++-
 builtin/repack.c                       | 251 ++++++++++++++++++++++---
 midx.c                                 | 102 ++++++++--
 midx.h                                 |   4 +-
 pack-bitmap.c                          |   2 +-
 pack-bitmap.h                          |   1 +
 t/helper/test-read-midx.c              |  25 ++-
 t/lib-midx.sh                          |   8 +
 t/t5319-multi-pack-index.sh            |  15 ++
 t/t5326-multi-pack-bitmaps.sh          |  82 ++++++++
 t/t7700-repack.sh                      |  96 ++++++++++
 t/t7703-repack-geometric.sh            |  23 +++
 14 files changed, 630 insertions(+), 51 deletions(-)
 create mode 100644 t/lib-midx.sh

-- 
2.33.0.96.g73915697e6
