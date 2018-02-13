Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D261F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933054AbeBMBWr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:22:47 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37143 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeBMBWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:46 -0500
Received: by mail-pl0-f67.google.com with SMTP id ay8so5862434plb.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4gFdr6bocb0sUBrp7RnpzLoTsObLUhz6VuC/tpJAewE=;
        b=nNuQFD0u189ULTje1aEcbHtD30eCmO0uz925gtgft/0yQ+N3aQ8pQC5PSkiJYCbYIP
         PxpYjQbtrD3CBytq9y9BQusWZyKZ7Y2ns9t20cgp7ez0rTtvFBNNO1nfVG+DCB0roo4l
         V8bkQUvgRIPvPrdEZBED17Ky2NZIiRZJPddDmGUgS1VG7uz5EW29qHfIviOtz+gSeCmm
         GnwGHWofUPVHuti6HyZ5d9EFTv9rg4OgD4WfQ8hoG8x414JIZu4GNUxAoLqP8FCpy86q
         Qc5xmhrYnDkl83wk3CHCpsV34AzkXMpVrqh0IOnmODU2p3I/D/rfn8yneoQQqstzdOGP
         9ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4gFdr6bocb0sUBrp7RnpzLoTsObLUhz6VuC/tpJAewE=;
        b=aWas82Pc5bA+ndliXqi1faBIIhOxFx/KazJ/ENqV0K9t+iK+lKsjW2Yo1LyvwDQKXM
         J6j6U6saa56HgTmcOzwc02ypHVYhA+sQ3GakPRrLfS2A90+erT5mOQOEJ4Ww8Zb1DSsF
         IToS8WweOUZV3iRefbIXW68uLmty+vKfglrI2n/vcK7+hCQOns02BlYyN3YPyXhMglbs
         aihRavakLVz4g6eoLbVnEfyHJeErP9dowJg5G/65f5t3ygJoD5rd2FL4QARGmA8ma90r
         vfIc4/36J/W4kheN9kJzsRLzAYX+27CFBGlDAeTVvMVrnzZyCZ2C6mCusyI90+msLC8i
         iMeg==
X-Gm-Message-State: APf1xPApJEx2Bz3Ta85YX89SZCuFZlqKCH8MgpUfdLdL5OqiNx3usYRN
        bO0O8IzAWvtEyM9j51ZYRDZy9A==
X-Google-Smtp-Source: AH8x227lqb19YuBccOciqlr058UK4jtrrwd0fP1nqxNT5xJMuaYe6bhKwG3PGB9qK0Vop2fBiTdeCQ==
X-Received: by 2002:a17:902:522:: with SMTP id 31-v6mr3437812plf.122.1518484965472;
        Mon, 12 Feb 2018 17:22:45 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j12sm50194464pfa.95.2018.02.12.17.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/26] Moving global state into the repository object (part 1)
Date:   Mon, 12 Feb 2018 17:22:15 -0800
Message-Id: <20180213012241.187007-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a real take on the first part of the recent RFC[1].

Jonathan Tan suggested[2] that "sha1_loose_object_info to handle arbitrary repositories"
might be a good breaking point for a first part at that RFC at patch 38.
This series is smaller and contains only 26 patches as the patches in the big
RFC were slightly out of order.

I developed this series partly by writing patches, but mostly by cherrypicking
from that RFC on top of current master. I noticed no external conflicts apart
from one addition to the repositories _INIT macro, which was easy to resolve.

Comments in the early range of that RFC were on 003 where Junio pointed out
that the coccinelle patch ought to be not in contrib/coccinelle, so I put it
in a sub directory there, as 'make coccicheck' doesn't traverse subdirs.

brian had a questoin on patch 25 in the RFC, but that seemed to resolve itself
without any suggestion to include into this series[3].

Duy suggested that we shall not use the repository blindly, but should carefully
examine whether to pass on an object store or the refstore or such[4], which 
I agree with if it makes sense. This series unfortunately has an issue with that
as I would not want to pass down the `ignore_env` flag separately from the object
store, so I made all functions that only take the object store to have the raw
object store as the first parameter, and others using the full repository.

Eric Sunshine brought up memory leaks with the RFC, and I would think to
have plugged all holes.

[1] https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
[2] https://public-inbox.org/git/20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com/
[3] https://public-inbox.org/git/20180206011940.GD7904@genre.crustytoothpaste.net/
[4] https://public-inbox.org/git/CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com/

Thanks,
Stefan

Jonathan Nieder (8):
  pack: move prepare_packed_git_run_once to object store
  pack: move approximate object count to object store
  sha1_file: add repository argument to sha1_file_name
  sha1_file: add repository argument to map_sha1_file
  sha1_file: allow stat_sha1_file to handle arbitrary repositories
  sha1_file: allow open_sha1_file to handle arbitrary repositories
  sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
  sha1_file: allow sha1_loose_object_info to handle arbitrary
    repositories

Stefan Beller (18):
  repository: introduce raw object store field
  object-store: move alt_odb_list and alt_odb_tail to object store
  object-store: free alt_odb_list
  object-store: move packed_git and packed_git_mru to object store
  object-store: close all packs upon clearing the object store
  sha1_file: add raw_object_store argument to alt_odb_usable
  sha1_file: add repository argument to link_alt_odb_entry
  sha1_file: add repository argument to read_info_alternates
  sha1_file: add repository argument to link_alt_odb_entries
  sha1_file: add repository argument to prepare_alt_odb
  sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
  sha1_file: allow prepare_alt_odb to handle arbitrary repositories
  sha1_file: add repository argument to stat_sha1_file
  sha1_file: add repository argument to open_sha1_file
  sha1_file: add repository argument to map_sha1_file_1
  sha1_file: add repository argument to sha1_loose_object_info
  sha1_file: allow sha1_file_name to handle arbitrary repositories
  sha1_file: allow map_sha1_file to handle arbitrary repositories

 builtin/am.c                                    |   2 +-
 builtin/clone.c                                 |   2 +-
 builtin/count-objects.c                         |   6 +-
 builtin/fetch.c                                 |   2 +-
 builtin/fsck.c                                  |  13 ++-
 builtin/gc.c                                    |   4 +-
 builtin/grep.c                                  |   2 +-
 builtin/index-pack.c                            |   1 +
 builtin/merge.c                                 |   2 +-
 builtin/pack-objects.c                          |  21 ++--
 builtin/pack-redundant.c                        |   6 +-
 builtin/receive-pack.c                          |   3 +-
 cache.h                                         |  46 ++------
 contrib/coccinelle/refactoring/packed_git.cocci |   7 ++
 environment.c                                   |   5 +-
 fast-import.c                                   |   6 +-
 http-backend.c                                  |   6 +-
 http-push.c                                     |   1 +
 http-walker.c                                   |   4 +-
 http.c                                          |   6 +-
 mru.h                                           |   1 +
 object-store.h                                  |  75 +++++++++++++
 object.c                                        |  26 +++++
 pack-bitmap.c                                   |   4 +-
 pack-check.c                                    |   1 +
 pack-revindex.c                                 |   1 +
 packfile.c                                      |  64 +++++------
 packfile.h                                      |   2 +-
 path.c                                          |   2 +-
 reachable.c                                     |   1 +
 repository.c                                    |  17 ++-
 repository.h                                    |   7 +-
 server-info.c                                   |   6 +-
 sha1_file.c                                     | 135 +++++++++++++-----------
 sha1_name.c                                     |  11 +-
 streaming.c                                     |   5 +-
 36 files changed, 321 insertions(+), 182 deletions(-)
 create mode 100644 contrib/coccinelle/refactoring/packed_git.cocci
 create mode 100644 object-store.h

-- 
2.16.1.73.ga2c3e9663f.dirty

