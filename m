Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6553D1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbeEAVeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:09 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:42279 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAVeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:08 -0400
Received: by mail-pf0-f175.google.com with SMTP id a11so9964789pfn.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rM0+zabTEOlrpFwED1xt7W/HnuKmew8GsBlFNzLxizA=;
        b=qdKvTCiJioo8AYmI4IkgWg94j1XQIDK9L3POj2hjtgZDETrOYMG5/RbIzcydeqOokO
         zajcoIVVNC2uSmvUbXWwxwjojcjjkZSynhqdQAVXOwYdMC0eQxdDgSBihUbjFt3Atw40
         Ik+7ScSno5SMoPQVe6mawI0GGy95fcayYzPiPPZOu/ZNu8tQiei85Y/E3E951QfonS50
         tdtyx0Y9VZ5h453f/1xi0WM76JAIWdBdHeiBZ+fvjuQGmb7A2MNfFZTO8R2U0OKGQho6
         dHSbnlrzr+oulGSQ65wIo9wK9W4YAJalYaNVbNQww1alnAcDeq8YBUSY2GJvLTHMSIJ/
         Gt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rM0+zabTEOlrpFwED1xt7W/HnuKmew8GsBlFNzLxizA=;
        b=KfS/UTZNSWyj1RIL13qstdl+WnJUHIgw7SGWZcmEObIoSL2pRpuri7fbwR7XKBCrgC
         uXDz2Glv/LnUjMTrY929rBmgMKbddyaSKFHXMXz1qOE9GNchxLQhJVpammUj3uCbEz5B
         RAy1bJMc0FSkVzvrnpoOvJToeKksInXtky9Pk6Da9u3wJ6EFu7FOjdqvX9i8KhuCB0LC
         OUR2T6aubCTGitkl2oYHunNhtgSkn3PVkS2oVGbEQ+a8hW30jNHS74bqmcuIo2BXjOOi
         +zPHkVqyjENCfKdDUPD5O/nw91u7Ak+YzmkDAUrkGnsoxIN91AijSeGDHgtTkk/DaoPi
         mWlQ==
X-Gm-Message-State: ALQs6tDFBgAPZfhL2GZcHKgIFF4xjk/t9IDuZ9aS4ulOf/m2ZJ9oCed8
        mjhbSTRMW9Nu/xB3tPHQJpufEazrsMI=
X-Google-Smtp-Source: AB8JxZoB4nTJCnn4J8j11yHBrtHf897rNjwV00fHz4/4QoITd7T4zQ682J9hu8t6oQF7VC9c6i4PdA==
X-Received: by 2002:a63:5fd1:: with SMTP id t200-v6mr14514492pgb.246.1525210447604;
        Tue, 01 May 2018 14:34:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e4sm20650721pfa.128.2018.05.01.14.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/13] object store: alloc 
Date:   Tue,  1 May 2018 14:33:50 -0700
Message-Id: <20180501213403.14643-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on top of sb/oid-object-info and is the logical continuum of
the series that it builds on; this brings the object store into more of
Gits code, removing global state, such that reasoning about the state of
the in-memory representation of the repository is easier.

My original plan was to convert lookup_commit_graft as the next series,
which would be similar to lookup_replace_object, as in sb/object-store-replace.
The grafts and shallow mechanism are very close to each other, such that
they need to be converted at the same time, both depending on the
"parsed object store" that is introduced in this commit.

The next series will then convert code in {object/blob/tree/commit/tag}.c
hopefully finishing the lookup_* functions.

I also debated if it is worth converting alloc.c via this patch series
or if it might make more sense to use the new mem-pool by Jameson[1].

I vaguely wonder about the performance impact, as the object allocation
code seemed to be relevant in the past.

[1] https://public-inbox.org/git/20180430153122.243976-1-jamill@microsoft.com/

Any comments welcome,
Thanks,
Stefan

Jonathan Nieder (1):
  object: add repository argument to grow_object_hash

Stefan Beller (12):
  repository: introduce object parser field
  object: add repository argument to create_object
  alloc: add repository argument to alloc_blob_node
  alloc: add repository argument to alloc_tree_node
  alloc: add repository argument to alloc_commit_node
  alloc: add repository argument to alloc_tag_node
  alloc: add repository argument to alloc_object_node
  alloc: add repository argument to alloc_report
  alloc: add repository argument to alloc_commit_index
  object: allow grow_object_hash to handle arbitrary repositories
  object: allow create_object to handle arbitrary repositories
  alloc: allow arbitrary repositories for alloc functions

 alloc.c           | 69 +++++++++++++++++++++++------------
 alloc.h           | 21 +++++++++++
 blame.c           |  3 +-
 blob.c            |  5 ++-
 cache.h           |  9 -----
 commit.c          |  4 +-
 merge-recursive.c |  3 +-
 object.c          | 93 +++++++++++++++++++++++++++++++++--------------
 object.h          | 18 ++++++++-
 repository.c      |  7 ++++
 repository.h      | 11 +++++-
 tag.c             |  4 +-
 tree.c            |  4 +-
 13 files changed, 182 insertions(+), 69 deletions(-)
 create mode 100644 alloc.h

-- 
2.17.0.441.gb46fe60e1d-goog

