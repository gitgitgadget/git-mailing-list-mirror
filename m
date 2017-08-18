Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90962208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdHRWUq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:46 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38230 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdHRWUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:45 -0400
Received: by mail-pg0-f48.google.com with SMTP id t80so44556803pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEMqUK/jbQQQ/D8fpIV+NdCTZCBodSqhoLuuZOmbJV4=;
        b=jObEm1kzdsqOJXOq94k0Eq3+Q3uSMNgbfsIq/HkxwrXzaCSaQjRT79PgnTaSaFaqs7
         Iup6UZSlZI+v4d0vo/irZ5Gb5l/UhZ18Ebv2gUGj1orcJ4zxx27zIo5w9a8rRZ+fqQwI
         aIADrTnf06qWgqF5w36MInJRTMC1YqrISUgY2d17NwReUn3l5XZ2vGG33RuriKo5pSZZ
         exzwNJyCMWW0o+iJ4sIIS/C1DP34Tl5qrDZJ8C7NKYTkQZpEXq+hcqDwGjOtFVK1RUbP
         HVkdNOsm7+jMMok1VLVUBgWKSqvEKXJQrxD4WNCPnOoHtOK6ELwy79q1ffRKyeg0d2EO
         qwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEMqUK/jbQQQ/D8fpIV+NdCTZCBodSqhoLuuZOmbJV4=;
        b=FDgs9HpYiJQifMdxn153E0e3yL4qN9gVxelwt920+QR09yUb5Rl2LOENR2ZjeqxqOu
         SbsPCHjc9l+MHb/2/b5VXeJKf7+saIVzxvL0xqH1xjvfG1M0M2wOzBnrK1qgU/LEi/7O
         teL6sGeG8KgnU4O6rWvJiO7T/JCcltg0vpWVx6oWYolvKTlDlYNM0i4CD0crPiHOLi1B
         UdkIUH+D/520zuo7K8G9wqKCMxFX/Mi0KLg/KhGOMtJvTMrn46XWDbErjj0Zwf464pPc
         Pa851o5YXo3P1QZo9ITGQQKP2RfsWy/hu3p7xiC37ZmVX04OsWbiMG4eFmnxc6UncW7d
         XL3Q==
X-Gm-Message-State: AHYfb5hbx9xfH4ydmNqqfZ8+mwdKxD2w2Q1NI+EzdSHwVdTJA+IrQc2P
        ++rnIZQ38IjtcrhcDRhiSQ==
X-Received: by 10.84.168.5 with SMTP id e5mr11573840plb.468.1503094844230;
        Fri, 18 Aug 2017 15:20:44 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 00/23] Move exported packfile funcs to its own file
Date:   Fri, 18 Aug 2017 15:20:15 -0700
Message-Id: <cover.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You'd need to double check, but I think the topics that cause
> trouble are rs/find-apck-entry-bisection and jk/drop-sha1-entry-pos;
> you can start from v2.14.1 and merge these topics on top and then
> build your change on top.  That would allow you to start cooking
> before both of them graduate to 'master', as I expect they are both
> quick-to-next material.  There might be other topics that interfere
> with what you are doing, but you can easily find out what they are
> if you do a trial merge to 'next' and 'pu' yourself.

OK - in addition to the 2 you mentioned, I have found some others
(likely added after you wrote that). The complete list is:
 - rs/find-pack-entry-bisection
 - jk/drop-sha1-entry-pos
 - jt/sha1-file-cleanup (formerly part of this set)
 - mk/use-size-t-in-zlib
 - rs/unpack-entry-leakfix

I have merged all of these and rebased my patches on top.

Other changes:
 - Used packfile.h instead of pack.h (following most people's
   preference)
 - Ensured that I added functions to packfile.h retaining the order they
   were originally in, so that if you run "git diff <base> --color-moved
   --patience", there are much fewer zebra stripes

The merge base commit can be accessed online [1], if you need it.

[1] https://github.com/jonathantanmy/git/commits/packmigrate

Jonathan Tan (23):
  pack: move pack name-related functions
  pack: move static state variables
  pack: move pack_report()
  pack: move open_pack_index(), parse_pack_index()
  pack: move release_pack_memory()
  pack: move pack-closing functions
  pack: move use_pack()
  pack: move unuse_pack()
  pack: move add_packed_git()
  pack: move install_packed_git()
  pack: move {,re}prepare_packed_git and approximate_object_count
  pack: move unpack_object_header_buffer()
  pack: move get_size_from_delta()
  pack: move unpack_object_header()
  pack: move clear_delta_base_cache(), packed_object_info(),
    unpack_entry()
  pack: move nth_packed_object_{sha1,oid}
  pack: move check_pack_index_ptr(), nth_packed_object_offset()
  pack: move find_pack_entry_one(), is_pack_valid()
  pack: move find_sha1_pack()
  pack: move find_pack_entry() and make it global
  pack: move has_sha1_pack()
  pack: move has_pack_index()
  pack: move for_each_packed_object()

 Makefile                 |    1 +
 builtin/am.c             |    1 +
 builtin/cat-file.c       |    1 +
 builtin/clone.c          |    1 +
 builtin/count-objects.c  |    1 +
 builtin/fetch.c          |    1 +
 builtin/fsck.c           |    1 +
 builtin/gc.c             |    1 +
 builtin/index-pack.c     |    1 +
 builtin/merge.c          |    1 +
 builtin/pack-objects.c   |    1 +
 builtin/pack-redundant.c |    1 +
 builtin/prune-packed.c   |    1 +
 builtin/receive-pack.c   |    1 +
 bulk-checkin.c           |    1 +
 cache.h                  |  122 +--
 connected.c              |    1 +
 diff.c                   |    1 +
 fast-import.c            |    1 +
 fetch-pack.c             |    1 +
 git-compat-util.h        |    2 -
 http-backend.c           |    1 +
 http-push.c              |    1 +
 http-walker.c            |    1 +
 http.c                   |    1 +
 outgoing/packfile.h      |    0
 pack-bitmap.c            |    1 +
 pack-check.c             |    1 +
 packfile.c               | 1896 +++++++++++++++++++++++++++++++++++
 packfile.h               |  138 +++
 path.c                   |    1 +
 reachable.c              |    1 +
 revision.c               |    1 +
 server-info.c            |    1 +
 sha1_file.c              | 2452 ++++++----------------------------------------
 sha1_name.c              |    1 +
 streaming.c              |    1 +
 37 files changed, 2354 insertions(+), 2287 deletions(-)
 create mode 100644 outgoing/packfile.h
 create mode 100644 packfile.c
 create mode 100644 packfile.h

-- 
2.14.1.480.gb18f417b89-goog

