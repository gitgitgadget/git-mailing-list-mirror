Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA4E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeBUByk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:40 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37366 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUByj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:39 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so89441plb.4
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bkD4MCU5doZVZi8YcmH/vAoy9XDBRMjVQzy+qeWUUbQ=;
        b=W7N41PkphJTBgGaGXyPDBTokQh8BXe+tO0qaEaU4UNB4abMBMV9omHvd7ZtRztJ50R
         o1Pad96f9R90r2VVaGKsNjdKTzcwRuNSBR4UOri1IlUJgS/MBEJbsUz5wJOpN/7fYPRr
         cngIJmhjinLEZP2fs+41ZEVOZLP7buyaJwjLmUUQ4gzhs+1hZ/BicMXTCfTxTIX09XMZ
         M/+EgYirdggiDWSrifW49LRbxArOHiptCJpeF/n4j95MAwX+P3e6FmuuRL+H4VAv75X/
         ijuWy0PhxbEJgL97yiveVuk6ALp2R71h3CHEjtQQeChRLN5gP5gKRSfT5M1nJvQjOsco
         x1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bkD4MCU5doZVZi8YcmH/vAoy9XDBRMjVQzy+qeWUUbQ=;
        b=fcUe1yeeeACY+MyEfsae+hknSLNXna657WpBgwORk8jXfM4pVl+u9S+zTq+9QsXCEN
         TWUEmcd6F2tHStPOd7RlabjAwMi8ogInlfj4jWaVlWeGn3jGEQO92dFIZ85huhMqveUe
         d9N64aAstp2ZNn4R/eQbHueAr0u+Il4e9FmdXtFmoEbXUveJcomkEhqzX9N3djvErz/D
         9LXKvuCv5oYxlfkLgQ+tfLmCFEZ1f4K7aTPHhHs2O5Idap7rmfuECdDLCJBpW4dkk7dc
         9qCBDk+M4emuDdhgRlI5jUBb63/5vWkqjUXgnp9td+pJSWSN2bMwUuY2SGBghKRtkcbQ
         bh+w==
X-Gm-Message-State: APf1xPCMHwf/FVgQZp4tOQWXt29chVxWWUWvTqRVP+eMVa8ad/DqLKil
        DPJKJHbW5LovUOdAfzubtnsndKjLK+8=
X-Google-Smtp-Source: AH8x225584loq4EX25NhTz+WXBkkb84OTJaA+YBvtlqsB9QObUwz4B6yY1mxViRDgFqRxf6VrrjLEw==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5-v6mr1568599plq.160.1519178078985;
        Tue, 20 Feb 2018 17:54:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m5sm1318668pgn.52.2018.02.20.17.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCHv3 00/27] Moving global state into the repository object (part 1)
Date:   Tue, 20 Feb 2018 17:54:03 -0800
Message-Id: <20180221015430.96054-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 builtin/count-objects.c  |   6 +-
 builtin/fetch.c          |   2 +-
 builtin/fsck.c           |  13 ++--
 builtin/gc.c             |   4 +-
 builtin/grep.c           |   2 +-
 builtin/index-pack.c     |   1 +
 builtin/merge.c          |   2 +-
 builtin/pack-objects.c   |  20 +++---
 builtin/pack-redundant.c |   6 +-
 builtin/receive-pack.c   |   3 +-
 cache.h                  |  87 -------------------------
 environment.c            |   5 +-
 fast-import.c            |   6 +-
 http-backend.c           |   6 +-
 http-push.c              |   1 +
 http-walker.c            |   4 +-
 http.c                   |   6 +-
 object-store.h           | 134 +++++++++++++++++++++++++++++++++++++++
 object.c                 |  27 ++++++++
 pack-bitmap.c            |   4 +-
 pack-check.c             |   1 +
 pack-revindex.c          |   1 +
 packfile.c               |  64 +++++++++----------
 packfile.h               |   2 +-
 path.c                   |   2 +-
 reachable.c              |   1 +
 repository.c             |  19 ++++--
 repository.h             |   7 +-
 server-info.c            |   6 +-
 sha1_file.c              | 134 +++++++++++++++++++++------------------
 sha1_name.c              |  11 ++--
 streaming.c              |   5 +-
 34 files changed, 365 insertions(+), 231 deletions(-)
 create mode 100644 object-store.h

-- 
2.16.1.291.g4437f3f132-goog

