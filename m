Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4E21F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDFXVv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:21:51 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:40301 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeDFXVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:50 -0400
Received: by mail-pf0-f170.google.com with SMTP id y66so1793938pfi.7
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VzhQYLZwD5yc8SswzIoyd9ddTBgzFdm/3DuiRXWxouY=;
        b=uxlmVMXILwXqa47nVObbXbIfexOiUj6Fug6IKuZrGOOHtha3iG3FD0ssxnUgthd6bD
         Ka+pZzLFSPZY3+knQh2xBOzYsrM3OFmd3v80JmnuuwQxq2znjh7Gx549uoUInTzr3Vac
         Cqt85JpFo1dhrWYC0s9jF+qX8weZmmoELtTNyOxkEAcdjCfJClXx+yrGdfBFviB9NsjI
         ltGoVV1nfAbWKo/JteZIIMSCi0le+3Wp973KW4FRF17n6HyYmyVOO+FNqVdVHenmYZoz
         qIKTjcM4VPJ3pDULzpJGMK4Hrb6zd4Yn5vaePWIaoWv4hddWRJdgmJxRzbgGRgBjDdp0
         HgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VzhQYLZwD5yc8SswzIoyd9ddTBgzFdm/3DuiRXWxouY=;
        b=pkaDxVO4HhObMs8xleGqksEzSEbRBfpqTGfIvmz3ax3VStP3ze9BQ4lrWqnvWHxPuJ
         l0fqPVJBG+8Ut3cT2OEf2Udbe+40xVtr0S04bEKVZXNREAAnBebLMWxlAfQjO2ix4j/1
         aO1Y3FA8kCHvZoA8ufhNq4207LhtDPwZOgH76Xo/q3eSjRIxhic1otfLcwIO08nKZm9l
         bDgXX297pYL/R7Lu2cuQ/CLpgOgGyrKbPk/gljnRUF1nT5A0jQDDaCMOtqdL9DIv5jPA
         POIrDoIVPJUxuJTLKWynpMZcildGbREUcEhrB0z8K5FWe6ZBrxOt79w8Z3NHKBJDVfU+
         DUyg==
X-Gm-Message-State: AElRT7FjGJ2/Lm6ZiyUMgCy/aYx5mCssp1be15/LsELvealRiQMuLou5
        hFdZZIo1KhHIkNXicXGc8Ot+aQ==
X-Google-Smtp-Source: AIpwx49uz4EqvkAU7CVfHqxvNUDVU8WaCjKcbUrd9t95fR90U+8gXN65R8hFE2wSY9tk2l8vtJEYBw==
X-Received: by 10.98.133.212 with SMTP id m81mr21936814pfk.61.1523056909702;
        Fri, 06 Apr 2018 16:21:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w16sm9166490pfk.125.2018.04.06.16.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 00/19] object-store refactoring 3 (replace objects, main ref store)
Date:   Fri,  6 Apr 2018 16:21:17 -0700
Message-Id: <20180406232136.253950-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
(sb/packfiles-in-repository).
It is also available at https://github.com/stefanbeller/git/tree/object-store-3

This series will bring the replacement mechanism (git replace)
into the object store.

The first patches are cleaning up a bit, and patches 6-19 are converting
one function at a time using the tick-tock pattern with the #define trick.
See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
2018-03-23) for explanation.

Thanks,
Stefan

Stefan Beller (19):
  replace_object.c: rename to use dash in file name
  replace-object: move replace_object to object store
  object-store: move lookup_replace_object to replace-object.h
  replace-object: move replace objects prepared flag to object store
  replace-object: check_replace_refs is safe in multi repo environment
  refs: add repository argument to get_main_ref_store
  refs: add repository argument to for_each_replace_ref
  replace-object: add repository argument to replace_object_pos
  replace-object: add repository argument to register_replace_object
  replace-object: add repository argument to prepare_replace_object
  replace-object: add repository argument to do_lookup_replace_object
  replace-object: add repository argument to lookup_replace_object
  refs: store the main ref store inside the repository struct
  refs: allow for_each_replace_ref to handle arbitrary repositories
  replace-object: allow replace_object_pos to handle arbitrary
    repositories
  replace-object: allow register_replace_object to handle arbitrary
    repositories
  replace-object: allow prepare_replace_object to handle arbitrary
    repositories
  replace-object: allow do_lookup_replace_object to handle arbitrary
    repositories
  replace-object: allow lookup_replace_object to handle arbitrary
    repositories

 Makefile                             |  2 +-
 builtin/mktag.c                      |  3 +-
 builtin/pack-refs.c                  |  3 +-
 builtin/replace.c                    |  4 +-
 cache.h                              | 19 -------
 environment.c                        |  2 +-
 object-store.h                       | 16 ++++++
 object.c                             |  3 +-
 refs.c                               | 80 ++++++++++++++--------------
 refs.h                               |  4 +-
 replace_object.c => replace-object.c | 66 +++++++++++------------
 replace-object.h                     | 35 ++++++++++++
 repository.h                         |  5 ++
 revision.c                           |  5 +-
 sha1_file.c                          |  7 +--
 streaming.c                          |  3 +-
 t/helper/test-ref-store.c            |  3 +-
 17 files changed, 149 insertions(+), 111 deletions(-)
 rename replace_object.c => replace-object.c (56%)
 create mode 100644 replace-object.h
 
 
 $ git diff 464416a2eaadf84d2bfdf795007863d03b222b7c..HEAD -- object-store.h repository.h
diff --git a/object-store.h b/object-store.h
index fef33f345f..be90c02db6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -93,6 +93,22 @@ struct raw_object_store {
        struct alternate_object_database *alt_odb_list;
        struct alternate_object_database **alt_odb_tail;
 
+       /*
+        * Objects that should be substituted by other objects
+        * (see git-replace(1)).
+        */
+       struct replace_objects {
+               /*
+                * An array of replacements.  The array is kept sorted by the original
+                * sha1.
+                */
+               struct replace_object **items;
+
+               int alloc, nr;
+
+               unsigned prepared : 1;
+       } replacements;
+
        /*
         * private data
         *
diff --git a/repository.h b/repository.h
index 09df94a472..2922d3a28b 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,11 @@ struct repository {
         */
        struct raw_object_store *objects;
 
+       /*
+        * The store in which the refs are hold.
+        */
+       struct ref_store *main_ref_store;
+
        /*
         * Path to the repository's graft file.
         * Cannot be NULL after initialization.

-- 
2.17.0.484.g0c8726318c-goog

