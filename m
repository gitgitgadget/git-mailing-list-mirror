Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D06E20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdHIBXC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:02 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35617 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdHIBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:01 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so21577558pgd.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zGx03m1vsfIyWQTjF/c//uIxzivShY+RaLJb3EVb40s=;
        b=HgI1GLRtVPaehbvJTRRFCd+quk+YU+3mR3DueoiqWFweG+dZUkCzfBNsfzRf7aTlEt
         /uRgYBNDboAYrSSI3hHK6Kh6UUolot6NZnDzwIvnpW9s36TEkNcnMPpftjO8sC9RHa1c
         24SgK7pjdobytoeA9fCSxfAJDOM2Fgg/jt3ENdhzmDyeD+9Ll9yaUsY0W9zY2x0+X4FD
         XcBaUC0VcvimXvMdPxJvoOiuJIECpYLWGjD1ZewfgIr6dCVXQfUW0EWsrIIyB7poC7h2
         EOdorqhLj094uA3OLI+xLF9bivbYs/EpqLD2ndqT3TQag417jM6ARGk+0QzswQa8Yluk
         2b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zGx03m1vsfIyWQTjF/c//uIxzivShY+RaLJb3EVb40s=;
        b=FX0eIoIfeJMbzc+4AdwMktE9mUaCbVC6bsOsXpjS+3HP/wUIype1Sf1JFNTK10sI8B
         KvjfDRq1h5tbrI8jKVHDAgCV/qgeaR0zMa4djb1Blcj/b9R4CeyKvRmURDCWtpG4iUhI
         XLOs4UK4pH4U+xFWBTlIWhoLCBdqw7vaEeRuuIoAehV4xU1jt6bQCDQvdi69Bqt9cQ1W
         kTjL7GZSBV2BqwD7LSaP8PEbGL0fYeu7Z3iz6q9FvGhPAyESDv/L2c/47zPbYfE06Vi2
         wFLjkb9Y8nHJZiW4VnrZNMB4BBBa3sNjsNBVoV4Gb6nObzLUC/uLFjftSEIxILBACXvt
         y1Yw==
X-Gm-Message-State: AHYfb5iVVIuc/FQ4iCPSVinoN+BRCKzb8n3RSDbDht3Rc557XlBnvS3y
        nsO7IfjFVXHaU5XYtOcAlA==
X-Received: by 10.84.131.71 with SMTP id 65mr6915726pld.35.1502241780809;
        Tue, 08 Aug 2017 18:23:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:00 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 00/25] Move exported packfile funcs to its own file
Date:   Tue,  8 Aug 2017 18:22:32 -0700
Message-Id: <cover.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the complete patch set. I have only moved the exported functions
that operate with packfiles and their static helpers - for example,
static functions like freshen_packed_object() that are used only by
non-pack-specific functions are not moved.

In the end, 3 functions needed to be made global. They are
find_pack_entry(), mark_bad_packed_object(), and has_packed_and_bad().

Of the 3, find_pack_entry() is probably legitimately promoted. But I
think that the latter two functions needing to be accessed from
sha1_file.c points to a design that could be improved - they are only
used when packed_object_info() detects corruption, and used for marking
as bad and printing messages to the user respectively, which
packed_object_info() should probably do itself. But I have not made this
change in this patch set.

(Other than the 3 functions above, there are some variables and
functions that are temporarily made global, but reduced back to static
when the wide scope is no longer needed.)

Jonathan Tan (25):
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
  pack: move unpack_object_header()
  pack: move get_size_from_delta()
  pack: move unpack_object_header()
  sha1_file: set whence in storage-specific info fn
  sha1_file: remove read_packed_sha1()
  pack: move packed_object_info(), unpack_entry()
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
 builtin/gc.c             |    1 +
 builtin/merge.c          |    1 +
 builtin/pack-redundant.c |    1 +
 builtin/prune-packed.c   |    1 +
 cache.h                  |  122 +--
 connected.c              |    1 +
 diff.c                   |    1 +
 git-compat-util.h        |    2 -
 http-backend.c           |    1 +
 http-push.c              |    1 +
 http-walker.c            |    1 +
 pack.h                   |  137 +++
 packfile.c               | 1905 +++++++++++++++++++++++++++++++++++
 path.c                   |    1 +
 reachable.c              |    1 +
 revision.c               |    1 +
 server-info.c            |    1 +
 sha1_file.c              | 2484 ++++++----------------------------------------
 sha1_name.c              |    1 +
 streaming.c              |    1 +
 26 files changed, 2350 insertions(+), 2321 deletions(-)
 create mode 100644 packfile.c

-- 
2.14.0.434.g98096fd7a8-goog

