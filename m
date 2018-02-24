Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2A51F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeBXAsA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:00 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33565 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBXAr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:47:59 -0500
Received: by mail-pl0-f68.google.com with SMTP id c11-v6so2431782plo.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4jFlI4YFAGR/qFEH+r24gmlKMTNJkWEPlTgt3Ci5mJU=;
        b=g/FhTFuXQiw5ZM9eHbChg/NpWY48aCB1Lpp17Jp/KuaEzZPFtUiQm0nsfSHNtSaUU9
         cW6gwD/w342mGRrfcN+1o2it/EqAlUuPp3MzYoji+aTalem/ZFXTuVYJVwqEJksYOvGu
         bvjiqKO9jcgWkzJQxV9zafg2ukAJGd2fd2l03iE0019mHREyZoZNkfSVuVn6th/uIJ+c
         ExTne3JitcXJuy8bveoftnf9dv6kzlQR8Kiwt4olNeWW9/I5ssrnJ5vTR1ByvqG3PGK9
         o+0qKEZftiZe9Jk3SLWKCIDgYe/skslzWf5gUnc6MLqUgQGxgu6qrdC2fM+1V7/OnztY
         eBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4jFlI4YFAGR/qFEH+r24gmlKMTNJkWEPlTgt3Ci5mJU=;
        b=hLMBhaqZPE42WwJZdMLGqB+ve/6QsP32KhIXox1whm89SS52ScT3Jy4fNGmn9+Sgus
         tql2bAk4XJT/gSwSTwQDWiEt7GLbQmrEi/ZNAApniN4Y6xCuP2aWa4SNZoJrKKBXHozn
         PdUzAb2edYR8lr0G/QkoBv8viGzGGvJ6ahQ5iBoxoEi/Bs8UvWfhhBdiYxeOeUEK6tnw
         JELjYMXyrA1tKsKGD+HytaG8grdBYQ6+zAymdHSo4deNsf0yTbuIooKjQmmKDEQJeekt
         cRmZOe57P6kPDUDmGPdar82zE2teAbBnjyYsLf4iZrYMYpcNE+MXdsgE+GFMVDvxBajo
         k8HQ==
X-Gm-Message-State: APf1xPBrvvus1z9flHc8w9O1FusjN9FDQMtvsi+wLtG2ZcJgdqMiMRzP
        Mq7rdBs7qV1gLzKKDEtp1BAHx0ggCDs=
X-Google-Smtp-Source: AH8x226ItkZ+0EyUZgXCx7Y9J3NyneD0h2vncR0UP8VRjVyt38RPIcQr6GwvgZ/GYIqFo6sgX4tBvw==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr3311148plp.69.1519433279040;
        Fri, 23 Feb 2018 16:47:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b8sm6906402pff.31.2018.02.23.16.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:47:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 00/27] Moving global state into the repository object (part 1)
Date:   Fri, 23 Feb 2018 16:47:27 -0800
Message-Id: <20180224004754.129721-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* addressed feedback from the single patches (mostly nits)
* rebased on latest master

v3:
* reverted back to use the repository for most of the functions
  (including unduplicating 'ignore_env')
* rebased on master again (I lost that state when doing v2, as
  I did both rebase as well as conversion to object store in one go)
* one additional patch, that moves the alternates related things to
  object-store.h, such that inclusion of cache.h (in object-store.h)
  is not required any more.

v2:
* duplicated the 'ignore_env' bit into the object store as well
* the #define trick no longer works as we do not have a "the_objectstore" global,
  which means there is just one patch per function that is converted.
  As this follows the same structure of the previous series, I am still confident
  there is no hidden dependencies to globals outside the object store in these
  converted functions.
* rebased on top of current master, resolving the merge conflicts.
  I think I used the list.h APIs right, but please double check.

Thanks,
Stefan

v1:
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

Jonathan Nieder (2):
  sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
  sha1_file: allow sha1_loose_object_info to handle arbitrary
    repositories

Stefan Beller (25):
  repository: introduce raw object store field
  object-store: migrate alternates struct and functions from cache.h
  object-store: move alt_odb_list and alt_odb_tail to object store
  object-store: free alt_odb_list
  object-store: move packed_git and packed_git_mru to object store
  object-store: close all packs upon clearing the object store
  pack: move prepare_packed_git_run_once to object store
  pack: move approximate object count to object store
  sha1_file: add raw_object_store argument to alt_odb_usable
  sha1_file: add repository argument to link_alt_odb_entry
  sha1_file: add repository argument to read_info_alternates
  sha1_file: add repository argument to link_alt_odb_entries
  sha1_file: add repository argument to prepare_alt_odb
  sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
  sha1_file: allow prepare_alt_odb to handle arbitrary repositories
  sha1_file: add repository argument to sha1_file_name
  sha1_file: add repository argument to stat_sha1_file
  sha1_file: add repository argument to open_sha1_file
  sha1_file: add repository argument to map_sha1_file_1
  sha1_file: add repository argument to map_sha1_file
  sha1_file: add repository argument to sha1_loose_object_info
  sha1_file: allow sha1_file_name to handle arbitrary repositories
  sha1_file: allow stat_sha1_file to handle arbitrary repositories
  sha1_file: allow open_sha1_file to handle arbitrary repositories
  sha1_file: allow map_sha1_file to handle arbitrary repositories

 builtin/am.c             |   2 +-
 builtin/clone.c          |   2 +-
 builtin/count-objects.c  |   5 +-
 builtin/fetch.c          |   2 +-
 builtin/fsck.c           |  12 ++--
 builtin/gc.c             |   3 +-
 builtin/grep.c           |   2 +-
 builtin/merge.c          |   2 +-
 builtin/pack-objects.c   |  20 ++++---
 builtin/pack-redundant.c |   5 +-
 builtin/receive-pack.c   |   2 +-
 cache.h                  |  87 ---------------------------
 environment.c            |   5 +-
 fast-import.c            |   7 ++-
 http-backend.c           |   5 +-
 http-walker.c            |   3 +-
 http.c                   |   5 +-
 object-store.h           | 124 ++++++++++++++++++++++++++++++++++++++
 object.c                 |  27 +++++++++
 pack-bitmap.c            |   3 +-
 packfile.c               |  64 ++++++++++----------
 packfile.h               |   2 +-
 path.c                   |   2 +-
 repository.c             |  21 +++++--
 repository.h             |   7 ++-
 server-info.c            |   5 +-
 sha1_file.c              | 125 +++++++++++++++++++++------------------
 sha1_name.c              |  10 ++--
 streaming.c              |   5 +-
 29 files changed, 335 insertions(+), 229 deletions(-)
 create mode 100644 object-store.h

-- 
2.16.1.291.g4437f3f132-goog

