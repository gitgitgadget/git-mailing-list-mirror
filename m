Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97DC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F0520715
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxCkh+/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgIPTKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgIPTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC2C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l9so4157282wme.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3I3AZC9ekOuxLVGP3+AITtctZhSju/qNN4SLrNBIPII=;
        b=pxCkh+/lk69WtHClgiSwhqWJSmwYedrNMl9j8rXS7hHRpGgKEB0OR8BWEPf+NlI1f5
         F6no6AYwzXtbqUtW7mnKO7TaR7im8lHOdzMhHneOtHUY3/RaGqDVxhj3mgF0COUXPrm+
         8dIPKURj+TDOVze1nQzGgUjVnzlH34hDg+CZlsso19axD96POHztuRmQxmiF203Lh7wa
         wJyKoGGn4/qlrdDJaPqk9o5/c53CHId+P7BAfTgpFxttmY9rw7/mvgQJaqjtcIRyfdRy
         YvjJZ/LH3iszivua7BCG9OY3FZm2+gqYlinaPwcVf/ZHrgTKYrD86Wthq31u7pkK77xV
         yrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3I3AZC9ekOuxLVGP3+AITtctZhSju/qNN4SLrNBIPII=;
        b=OYb5r0BuNzesiU2tbmw9Hb2vL2UDjuYcmC4Y5YlZcvj+OfstPdy+ct2l1sxFgzx+Cs
         0pkXq1P8fcIIfGryFTuxcw3LVkfBAnM8M+tocgC3VjB3fs65LqOqqfI61B8nvUQJu9p0
         764/k0iTVzMoBif05UCkPsGwe149oZzYQUHV0yH1DYBa9cmo4YkxE9KEpxu5hCaJKQ4A
         AGxZmixJrlst5Cutm37v9HJD4q4hJEk2mgGjml0BPimHTpHKyz5FZVa5R2hLWgHzX2uw
         rSnCfwka1HyAhgRb4biAO+yf8gJjWWk+V8r3eKjnxHLdfSGY3mt2I24xXQovr5pbouiR
         C8Iw==
X-Gm-Message-State: AOAM5317x0DtLcC8wJxHvoBNikUd9X50elRHLbWxuD+AKxpfxtVdQjgj
        DLrIBD+bqTzsDfKr1r5XKTOOtTqni/c=
X-Google-Smtp-Source: ABdhPJyRp0HvLHT9RnwVHryDxYLBBtae7HHJ5lpmPBdnpfsTsGACOcAy4pyny6HqnW0DEiJrZnKPow==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr6292098wma.18.1600283417527;
        Wed, 16 Sep 2020 12:10:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23sm6996996wmi.19.2020.09.16.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:17 -0700 (PDT)
Message-Id: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:03 +0000
Subject: [PATCH 00/13] reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from 
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

The final commit should also be split up, but I want to wait until we have
consensus that the bottom commits look good.

Han-Wen Nienhuys (12):
  reftable: add LICENSE
  reftable: define the public API
  reftable: add a barebones unittest framework
  reftable: utility functions
  reftable: (de)serialization for the polymorphic record type.
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: read reftable files
  reftable: file level tests
  reftable: rest of library
  reftable: "test-tool dump-reftable" command.

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 Makefile                                   |   46 +-
 config.mak.uname                           |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 reftable/.gitattributes                    |    1 +
 reftable/LICENSE                           |   31 +
 reftable/VERSION                           |    1 +
 reftable/basics.c                          |  131 +++
 reftable/basics.h                          |   48 +
 reftable/block.c                           |  443 +++++++
 reftable/block.h                           |  129 +++
 reftable/block_test.c                      |  158 +++
 reftable/blocksource.c                     |  148 +++
 reftable/blocksource.h                     |   22 +
 reftable/compat.c                          |  110 ++
 reftable/compat.h                          |   48 +
 reftable/constants.h                       |   21 +
 reftable/dump.c                            |  212 ++++
 reftable/iter.c                            |  242 ++++
 reftable/iter.h                            |   72 ++
 reftable/merged.c                          |  358 ++++++
 reftable/merged.h                          |   39 +
 reftable/merged_test.c                     |  331 ++++++
 reftable/pq.c                              |  115 ++
 reftable/pq.h                              |   34 +
 reftable/publicbasics.c                    |  100 ++
 reftable/reader.c                          |  733 ++++++++++++
 reftable/reader.h                          |   78 ++
 reftable/record.c                          | 1114 ++++++++++++++++++
 reftable/record.h                          |  143 +++
 reftable/record_test.c                     |  410 +++++++
 reftable/refname.c                         |  209 ++++
 reftable/refname.h                         |   38 +
 reftable/refname_test.c                    |  100 ++
 reftable/reftable-tests.h                  |   22 +
 reftable/reftable.c                        |  104 ++
 reftable/reftable.h                        |  585 ++++++++++
 reftable/reftable_test.c                   |  585 ++++++++++
 reftable/stack.c                           | 1224 ++++++++++++++++++++
 reftable/stack.h                           |   50 +
 reftable/stack_test.c                      |  787 +++++++++++++
 reftable/strbuf.c                          |  142 +++
 reftable/strbuf.h                          |   80 ++
 reftable/strbuf_test.c                     |   37 +
 reftable/system.h                          |   51 +
 reftable/test_framework.c                  |   68 ++
 reftable/test_framework.h                  |   60 +
 reftable/tree.c                            |   63 +
 reftable/tree.h                            |   34 +
 reftable/tree_test.c                       |   62 +
 reftable/update.sh                         |   22 +
 reftable/writer.c                          |  664 +++++++++++
 reftable/writer.h                          |   60 +
 reftable/zlib-compat.c                     |   92 ++
 t/helper/test-reftable.c                   |   20 +
 t/helper/test-tool.c                       |    2 +
 t/helper/test-tool.h                       |    2 +
 56 files changed, 10489 insertions(+), 5 deletions(-)
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/strbuf.c
 create mode 100644 reftable/strbuf.h
 create mode 100644 reftable/strbuf_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 t/helper/test-reftable.c


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v1
Pull-Request: https://github.com/git/git/pull/847
-- 
gitgitgadget
