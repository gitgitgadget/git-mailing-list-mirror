Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE65EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGERPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGERPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:15:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86623173F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:15:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0f35579901so6742948276.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577341; x=1691169341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNmDb2hA7/Q6Ow+N1eHIKUVoQGz8G4WM0JtpwloqSPo=;
        b=s18NZ2+QBNX6W4WpChFYDgsQZ3QsJYl1YELbzY4FbQpdv1CSx7DGLwQRk8pyN+rtZJ
         HB7Rrsjhkxrr+PF4ToK+FZejB/eiK11n8OsOImYZf4Q5u47pbHKljfqnwBkYQt10MSG4
         Z/TvGG0fYovUdqDXg07BR1zx8Yz1AkbK8Ck7DBxLw9yzoINmvmxXvtyI3hzhaxZao+lT
         U57WLjscDziaPUF/lpf1SM279QgHqTBmvVtwKfdQ7qapdSQcEOQQK/aqhmZOV6sVsIOL
         JZZ5dvi+fqRXgWYsjB5mRD1Bh8lQgr5yYM6CMLc77EPAlzuGcqEWSxcMK87P2ypr1A0o
         AxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577341; x=1691169341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNmDb2hA7/Q6Ow+N1eHIKUVoQGz8G4WM0JtpwloqSPo=;
        b=kuxwfGGga45F8BeALLYn7wtSDjQw/wgRiyHhfp7dyELTyJkrRkIO0Urw5xpmP+bqdf
         gGRgxLjZ1W0GiLM2AN0Z6F6yT3vf26H0KXZoxUThqFNMd8vWt1l+qtM1lbEvTQr27jnR
         wlwNgGEY8D0A0tw6X6pDhD+IcnxYIL91bHP78m2vuWguZqYrdYzqF2B+FEyLshut4H5z
         ag+qD5pHxKTwx2ua+Qr/eU7IpX+xhjL3yZr8DC97j7fqgSHFIDqhuCs2pA57f7Mr3Rkk
         00J1xSiHrym/Yb/g1+64segpHPGUI80j9S3473zifc5MYgymA9vDjY94n4SHjVhiuuQo
         XadA==
X-Gm-Message-State: ABy/qLaN8SiXDqaFdjFdBoAuA2MqOHuvtdWFAfdKccjznUuk7revBgQZ
        YzuT6HliyA0yhPFOXAEx6bLZ55r+2dXcxtoJ0tv6ScAzEOhOLqm5439fcdvPU/Z97RubZ/F6jKU
        eeFJG8IkNpIIGaz1bz6YE+ik/wrf55IYwThDhzy7BoGkdzPibCsmXyN6b52gkejj2xw==
X-Google-Smtp-Source: APBJJlEY8dYW9pK+8shTzeJPfwbcdDaxkF2eSOqHDk/i54N/EcXxijDf9koIYhJVOQVTjv/98iRGrhPSRo3AuIY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:d304:0:b0:579:fa4c:1f25 with SMTP id
 y4-20020a81d304000000b00579fa4c1f25mr71127ywi.7.1688576904029; Wed, 05 Jul
 2023 10:08:24 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:08:11 +0000
In-Reply-To: <20230630202237.3069327-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705170812.3833103-1-calvinwan@google.com>
Subject: [PATCH v5 0/6] git-compat-util cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally[1], this series intended to move out all non-compat specific
headers and macros to either their respective files or common.h.
However, moving headers specifically to usage.h and common.h would cause
circular header inclusions (i.e usage.h includes git-compat-util.h which
includes usage.h) so that the rest of the codebase would not have to
also include usage.h and common.h. The tradeoff between simplifying
git-compat-util.h versus a confusing inclusion setup was deemed not
worthwhile so those patches have been dropped.

The first 4 patches of this series now focuses on cleaning up and
reducing the scope of git-compat-util.h by moving headers to their
respective files in cases that do not cause circular header inclusions.
The rest of series focuses on removing unnecessary headers.

[1] https://lore.kernel.org/git/cover.1687874975.git.phillip.wood@dunelm.org.uk/T/#m4f75ad7065a74659ee0f648b50200330a925481a

Calvin Wan (6):
  git-compat-util: move strbuf.c funcs to its header
  git-compat-util: move wrapper.c funcs to its header
  sane-ctype.h: create header for sane-ctype macros
  kwset: move translation table from ctype
  treewide: remove unnecessary includes for wrapper.h
  git-compat-util: move alloc macros to git-compat-util.h

 add-patch.c                        |   1 -
 alias.c                            |   1 -
 alloc.h                            |  75 --------
 apply.c                            |   2 -
 archive-tar.c                      |   1 -
 archive.c                          |   1 -
 attr.c                             |   1 -
 builtin/am.c                       |   1 -
 builtin/bisect.c                   |   1 -
 builtin/blame.c                    |   1 -
 builtin/branch.c                   |   1 -
 builtin/bugreport.c                |   1 -
 builtin/cat-file.c                 |   1 -
 builtin/checkout--worker.c         |   1 -
 builtin/clone.c                    |   1 -
 builtin/config.c                   |   2 -
 builtin/credential-cache--daemon.c |   1 -
 builtin/credential-cache.c         |   1 -
 builtin/difftool.c                 |   1 -
 builtin/fast-import.c              |   1 -
 builtin/fetch-pack.c               |   1 -
 builtin/fmt-merge-msg.c            |   1 -
 builtin/fsmonitor--daemon.c        |   1 -
 builtin/gc.c                       |   1 -
 builtin/get-tar-commit-id.c        |   1 -
 builtin/grep.c                     |   1 -
 builtin/index-pack.c               |   2 -
 builtin/init-db.c                  |   1 -
 builtin/log.c                      |   1 -
 builtin/merge.c                    |   2 -
 builtin/mktree.c                   |   1 -
 builtin/mv.c                       |   1 -
 builtin/name-rev.c                 |   1 -
 builtin/pack-objects.c             |   2 -
 builtin/rebase.c                   |   1 -
 builtin/receive-pack.c             |   1 -
 builtin/repack.c                   |   1 -
 builtin/rerere.c                   |   1 -
 builtin/rev-parse.c                |   1 -
 builtin/revert.c                   |   1 -
 builtin/rm.c                       |   1 -
 builtin/submodule--helper.c        |   1 -
 builtin/symbolic-ref.c             |   1 +
 builtin/unpack-file.c              |   1 -
 builtin/unpack-objects.c           |   1 +
 builtin/worktree.c                 |   1 -
 bulk-checkin.c                     |   2 -
 cache-tree.c                       |   1 -
 chunk-format.c                     |   1 -
 combine-diff.c                     |   1 -
 commit-graph.c                     |   1 -
 commit-reach.c                     |   1 -
 compat/terminal.c                  |   1 -
 config.c                           |   2 -
 convert.c                          |   1 -
 copy.c                             |   1 -
 csum-file.c                        |   1 -
 ctype.c                            |  36 ----
 daemon.c                           |   2 -
 delta-islands.c                    |   1 -
 diff.c                             |   2 -
 diffcore-rename.c                  |   1 -
 dir-iterator.c                     |   1 -
 dir.c                              |   2 -
 editor.c                           |   1 -
 entry.c                            |   1 -
 environment.c                      |   1 -
 ewah/bitmap.c                      |   1 -
 ewah/ewah_bitmap.c                 |   1 -
 fetch-pack.c                       |   2 -
 fmt-merge-msg.c                    |   1 -
 fsck.c                             |   1 -
 git-compat-util.h                  | 284 ++++++++---------------------
 gpg-interface.c                    |   1 -
 grep.c                             |   1 -
 help.c                             |   1 -
 http-backend.c                     |   2 -
 imap-send.c                        |   1 -
 kwset.c                            |  36 ++++
 kwset.h                            |   2 +
 line-log.c                         |   1 -
 list-objects-filter-options.c      |   1 -
 list-objects-filter.c              |   1 -
 merge-ll.c                         |   1 -
 merge-recursive.c                  |   1 -
 midx.c                             |   1 -
 notes-merge.c                      |   1 -
 object-file.c                      |   2 -
 oid-array.c                        |   1 -
 oidtree.c                          |   1 -
 pack-bitmap-write.c                |   1 -
 pack-bitmap.c                      |   1 -
 pack-objects.c                     |   1 -
 pack-write.c                       |   1 -
 packfile.c                         |   2 -
 parallel-checkout.c                |   2 -
 path.c                             |   1 -
 pkt-line.c                         |   1 -
 pretty.c                           |   1 -
 prio-queue.c                       |   1 -
 quote.c                            |   1 -
 read-cache.c                       |   2 -
 rebase-interactive.c               |   1 -
 ref-filter.c                       |   1 -
 reflog-walk.c                      |   1 -
 refs.c                             |   2 -
 refspec.c                          |   1 -
 remote-curl.c                      |   1 -
 remote.c                           |   1 -
 rerere.c                           |   2 -
 revision.c                         |   1 -
 sane-ctype.h                       |  66 +++++++
 send-pack.c                        |   1 -
 sequencer.c                        |   2 -
 server-info.c                      |   2 -
 setup.c                            |   1 -
 shallow.c                          |   2 -
 sigchain.c                         |   1 -
 sparse-index.c                     |   1 -
 split-index.c                      |   1 -
 strbuf.c                           |   2 -
 strbuf.h                           |  32 ++++
 streaming.c                        |   1 -
 string-list.c                      |   1 -
 strvec.c                           |   1 -
 submodule-config.c                 |   1 -
 submodule.c                        |   1 -
 t/helper/test-delta.c              |   1 -
 t/helper/test-fsmonitor-client.c   |   1 -
 t/helper/test-reach.c              |   1 -
 t/helper/test-read-cache.c         |   1 -
 tag.c                              |   1 -
 tempfile.c                         |   1 -
 trace.c                            |   1 -
 trace2/tr2_tls.c                   |   1 -
 trailer.c                          |   1 -
 transport-helper.c                 |   1 -
 transport.c                        |   2 -
 tree-walk.c                        |   1 -
 upload-pack.c                      |   1 -
 usage.c                            |   1 -
 userdiff.c                         |   1 -
 versioncmp.c                       |   1 +
 worktree.c                         |   2 -
 wrapper.c                          |   1 -
 wrapper.h                          | 111 +++++++++++
 write-or-die.c                     |   1 -
 147 files changed, 327 insertions(+), 478 deletions(-)
 create mode 100644 sane-ctype.h

Range-diff against v4:
-:  ---------- > 1:  144284a8f1 git-compat-util: move strbuf.c funcs to its header
-:  ---------- > 2:  39913c44e8 git-compat-util: move wrapper.c funcs to its header
-:  ---------- > 3:  c495762940 sane-ctype.h: create header for sane-ctype macros
-:  ---------- > 4:  2750d35e6d kwset: move translation table from ctype
-:  ---------- > 5:  b5fb55d235 treewide: remove unnecessary includes for wrapper.h
1:  140d98111f ! 6:  e4d8ad39d0 common: move alloc macros to common.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    common: move alloc macros to common.h
    +    git-compat-util: move alloc macros to git-compat-util.h
     
         alloc_nr, ALLOC_GROW, and ALLOC_GROW_BY are commonly used macros for
         dynamic array allocation. Moving these macros to git-compat-util.h with
-- 
2.41.0.255.g8b1d071c50-goog

