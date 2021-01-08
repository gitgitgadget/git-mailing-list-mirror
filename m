Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC7C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4124123A75
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbhAHSRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:17:23 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1136C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:16:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n4so10607684iow.12
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xajHmmQh1u1o3rwB3eYsmC+2rJ+UdkNbkax6d0Y5luo=;
        b=uCMVVm1r4icpdsBhUNAqDpOPcE2eRyYA9GJpMQN103z+AzjorJZ5t9YATSNia6Xcq/
         hjnll0fg6fdWErQmCSN2hk9RWyQzYpLGVAWZ9n+15nZ6PPARLV8HD5rOq04KcGjNpt11
         n8gsWoTwb8eKJiOW9Km00Mh8sI9SSsbXKDSu1RMfsyIdQGoOBcNhFyt2WDY8CK/6EB2+
         eDwuGT0iqQylLLeWKcPENHyCVIWX2l9orObDuFD6WTmb7I6mprYSHR8CbvoVXaH6P6g5
         Eljta2QRHh+tz/je3jzgAqG4vJdh6k9CTDXi9/n0Hn4JK0Rnh47nsvqheHLhyiVgtC5x
         AdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xajHmmQh1u1o3rwB3eYsmC+2rJ+UdkNbkax6d0Y5luo=;
        b=NMA9wq622dh6RBu94Z2qGcVUDxsyKFhtBoEgQ9OnL88UTH2FRn4xdiimpk1UnWBhvO
         wsujlwKHluhmK+ll33xAUq25SQU322EaU82y/hJqcmmG7J3MYb4ElifyEL6ITVaXoxAD
         F6jCdWA+ddflvfNPktK0asb5nhJPR3EANi1AThWBRW030EQ91QyPAW8DiAApjipRoHtm
         iKetSar8rqci+vRoX9N460CI2FM6lNdPflclm2DEcU42Oan4TQqlbkKiJjapmbRv7qwQ
         wn6taqo5kDmJIMJpi6rcmcNJyxZ1goQERRfhiuLuI9m1ELJPgeK2Wj8H7zfdTKTZX/9G
         nqRw==
X-Gm-Message-State: AOAM530uGAbM68WRSYVZuHsCs71pOm3xAZZ4wns8/xvNDutV7O+tEqy+
        GqpjjTM88e+C1pbr+0/F+nRMqnfqsegwdg==
X-Google-Smtp-Source: ABdhPJzGl+LxVw4jo9AeTcSmeg9gMO5J3oIR7u40v0fmd5x0FLCy9N3oGKgGAu717kaCeiL4v2n1ng==
X-Received: by 2002:a6b:3957:: with SMTP id g84mr3846640ioa.44.1610129801832;
        Fri, 08 Jan 2021 10:16:41 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id y5sm7593872ilh.24.2021.01.08.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:16:41 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:16:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is the first of two series to introduce an on-disk alternative to the
reverse index which is currently generated once per-process and stored in
memory.

As a reminder, the reverse index is used to translate an object's position
relative to other objects within the same packfile to that object's position
relative to the pack's index.

Generating the reverse index in memory for repositories with large packs has two
significant drawbacks:

  - It requires allocating sizeof(struct revindex_entry) per packed object.

  - It requires us to sort the entries by their pack offset. This is implemented
    in sort_revindex() using a radix sort, but still takes considerable time (as
    benchmarks found in the second series demonstrate).

Both of these can be addressed by storing the reverse index in a new '.rev' file
alongside the packs. This file is written once (during pack creation), and does
not require sorting when accessed, since it is stored in a sorted order.

This series lays the groundwork necessary to introduce the file format (which is
implemented in the second series). I'm splitting these two up since I think the
changes in this series can be queued independently from those in the latter
series.

The goal of this series is to remove direct access of the `struct
revindex_entry` type, as well as `struct packed_git`'s `revindex` field. The
on-disk format will be mmap'd and accessed directly, but the format is
sufficiently different that the whole `revindex` array can't be written as-is.

Separately from our main goal, the new API that is introduced in this series is
IMHO easier to read, and more clearly describes what order the given and
returned values are relative to.

The changes are structured as follows:

  - First, a new API is proposed.

  - Then, uses of the old API are removed one by one and replaced with their
    new counterparts.

  - Finally, without any callers remaining, the old API is removed.

Thanks in advance for your review.

Taylor Blau (20):
  pack-revindex: introduce a new API
  write_reuse_object(): convert to new revindex API
  write_reused_pack_one(): convert to new revindex API
  write_reused_pack_verbatim(): convert to new revindex API
  check_object(): convert to new revindex API
  bitmap_position_packfile(): convert to new revindex API
  show_objects_for_type(): convert to new revindex API
  get_size_by_pos(): convert to new revindex API
  try_partial_reuse(): convert to new revindex API
  rebuild_existing_bitmaps(): convert to new revindex API
  get_delta_base_oid(): convert to new revindex API
  retry_bad_packed_offset(): convert to new revindex API
  packed_object_info(): convert to new revindex API
  unpack_entry(): convert to new revindex API
  for_each_object_in_pack(): convert to new revindex API
  builtin/gc.c: guess the size of the revindex
  pack-revindex: remove unused 'find_pack_revindex()'
  pack-revindex: remove unused 'find_revindex_position()'
  pack-revindex: hide the definition of 'revindex_entry'
  pack-revindex.c: avoid direct revindex access in
    'offset_to_pack_pos()'

 builtin/gc.c           |  2 +-
 builtin/pack-objects.c | 33 +++++++++++++++++-----------
 pack-bitmap.c          | 44 ++++++++++++++++++-------------------
 pack-revindex.c        | 49 +++++++++++++++++++++++++++--------------
 pack-revindex.h        | 10 +++------
 packfile.c             | 50 ++++++++++++++++++++++++++----------------
 6 files changed, 109 insertions(+), 79 deletions(-)

-- 
2.30.0.138.g6d7191ea01
