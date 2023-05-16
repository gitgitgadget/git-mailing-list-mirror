Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747BC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEPRJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEPRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:09:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC63ABC
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5618c444144so16569317b3.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684256989; x=1686848989;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4SNR6ajVQViBGC18i6drQVB9WIbNBXU+U7QCfHVLmQM=;
        b=oc5A2QyhPcPsl0jOPx7wITVJHkvHr9B9J9/umAkbmXNVBBdPEzESq3hF6eHjyQ2coQ
         tiAW48f08VCcKE5xb8EDB44rMFbMWiUYNr6cCE/IRok+RM150H2p4Mv9gQPId+JSuYLj
         0DjTS6USPtK8Co9EZqh3qQvNtzPpWLEjh1/WmxjfKi0/4AORwRkxZNnEFQQV6l1PznCC
         WCVIh3v7eHG8BIxNnxlzoRzqcafgUHNRpTuaq7icZDhvpaiaWW6JckWJ67q1MQUL8Zku
         FP2kpW+QX+Nc0K1otnEZI4cjeDJBqyJUGY7KnFxR6b/WOvJN6G4k0XJW1A+wukeB/bpZ
         0uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256989; x=1686848989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SNR6ajVQViBGC18i6drQVB9WIbNBXU+U7QCfHVLmQM=;
        b=Ub2dXKpFhCLb3ZbRPxwx4A3pCoDpjrB+TenQofuIR+pVIVBaW+s7H36JHnbEQ8dlnB
         0xA/jhVfhpmRvqYpLfGh5+0OexKr1FsepzlTbRayHgRPDgEUsFWJgJxFQXZnF9wBloJB
         UVXcj9cu+eB8nRVMX+Rt8bsI7BTYidofdSy5gJGOq+pG0IjNCbRpDK9pgicBFtT6bWXn
         L/m+jcOCYsOXcDwuNroElRlyM6AVgG7DjSIqbRsr8KIZybcxnsBQWD5QhK9mO5ea0lgP
         EeSXSCln7aWJNwDydfaFvvNTGq3mq6ik8LY+HVyshD1+hAkE4xdTodz4A4fZCPkrRMNS
         kCMg==
X-Gm-Message-State: AC+VfDx8l5BpEQgWJ1sO2ivczLmrjTHJyaWT+MUnoUjUZkwbp1ncx8Zd
        0/TIa0NpqMlG91q2SmUUooc9kahYmU1QI35LbS/LWVRUK1KyKfKZcFVCUo/WmWnGvExNtUJBHGk
        nTNZwujcsof1zfr6uHr/YQA5QpwPbIQmb3ZyfjHVBUaJSMtKcB2Ke6IbHeCx4l92oUw==
X-Google-Smtp-Source: ACHHUZ6ndRabRtlJpkYJp0QPJPlV0yIxArbU6xHyUkUGPEonGNXvfH4zlMTZPTA+FV10ppNyuimlnIRfH2Ij+FY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:4513:0:b0:55d:f929:418f with SMTP id
 s19-20020a814513000000b0055df929418fmr17550928ywa.1.1684256988863; Tue, 16
 May 2023 10:09:48 -0700 (PDT)
Date:   Tue, 16 May 2023 17:09:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516170932.1358685-1-calvinwan@google.com>
Subject: [PATCH 0/6] git-compat-util cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series focuses on cleaning up and reducing the scope of
git-compat-util.h by moving headers to their respective files and
separating out functionality from git-compat-util.h to a new file,
common.h. I go into more detail in patch 3 as to why I believe this
separation is useful. 

By the end of this series, git-compat-util.h includes common.h which
includes wrapper.h and usage.h. Since virtually every file includes
git-compat-util.h and the large majority of files use functions defined
in common.h, wrapper.h, and usage.h, I believe it makes sense that those
are also automatically included with git-compat-util.h.

While this series does not intend to draw clearer boundaries for
common.h, I am open to ideas for how it can be cleaned up more and if
there is a better name for the file. 

Calvin Wan (6):
  strbuf.h: move declarations for strbuf.c functions from
    git-compat-util.h
  wrapper.h: move declarations for wrapper.c functions from
    git-compat-util.h
  common.h: move non-compat specific macros and functions from
    git-compat-util.h
  usage.h: move declarations for usage.c functions from
    git-compat-util.h
  treewide: remove unnecessary includes for wrapper.h
  common: move alloc macros to common.h

 add-patch.c                        |   1 -
 alias.c                            |   1 -
 alloc.h                            |  75 ----
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
 builtin/unpack-file.c              |   1 -
 builtin/worktree.c                 |   1 -
 bulk-checkin.c                     |   2 -
 cache-tree.c                       |   1 -
 chunk-format.c                     |   1 -
 combine-diff.c                     |   1 -
 commit-graph.c                     |   1 -
 commit-reach.c                     |   1 -
 common.h                           | 551 ++++++++++++++++++++++++
 compat/terminal.c                  |   1 -
 config.c                           |   2 -
 convert.c                          |   1 -
 copy.c                             |   1 -
 csum-file.c                        |   1 -
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
 git-compat-util.h                  | 664 +----------------------------
 gpg-interface.c                    |   1 -
 grep.c                             |   1 -
 help.c                             |   1 -
 http-backend.c                     |   2 -
 imap-send.c                        |   1 -
 line-log.c                         |   1 -
 list-objects-filter-options.c      |   1 -
 list-objects-filter.c              |   1 -
 ll-merge.c                         |   1 -
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
 send-pack.c                        |   1 -
 sequencer.c                        |   2 -
 server-info.c                      |   2 -
 setup.c                            |   1 -
 shallow.c                          |   2 -
 sigchain.c                         |   1 -
 sparse-index.c                     |   1 -
 split-index.c                      |   1 -
 strbuf.c                           |   2 -
 strbuf.h                           |  32 ++
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
 usage.h                            |  60 +++
 userdiff.c                         |   1 -
 worktree.c                         |   2 -
 wrapper.c                          |   1 -
 wrapper.h                          | 111 +++++
 write-or-die.c                     |   1 -
 142 files changed, 756 insertions(+), 897 deletions(-)
 create mode 100644 common.h
 create mode 100644 usage.h

-- 
2.40.1.606.ga4b1b128d6-goog

