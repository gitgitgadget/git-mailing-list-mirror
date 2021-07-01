Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46415C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286BC61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhGAQKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGAQKr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD3C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u6so8921167wrs.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=eDFmhgNTWru9CN/MR0JjCqMG8cVKyGA7Zp3RqMm/jSY=;
        b=YlhyJVy3Fbdw2YT8LM1NR9YjCmkfm61gx/vSiWCmIr5UtmUuqfdjMBkIFcVsvU/+u0
         AJcjeWOIjs2hk7aWptqguO74vApHm9f5u96wkI6a6FCue/X2qRgXjlQaWBgmrpu4p+iG
         t7hn0+DUhuqEpoUMRAjjO9w1FbzTh5vggy0S4zmut0X2Q1Tkeg0Z7Oab6HoVcSSp4pUS
         2HGp8iDuORdGhHyVCW35m+zK/WJe0Aye0fw2nEls+TFjonV4f6J0J/8ILTEAjfiKK8Yl
         datp/SRuBGKJHbkkHlgRMTTwhp0qUa35K6pY+AnhcYHWt13tD+BheH66vSIl1EeZcUV9
         MncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eDFmhgNTWru9CN/MR0JjCqMG8cVKyGA7Zp3RqMm/jSY=;
        b=W5igmJoZd+y3lVccdUHgqR1XxOaIeI3N51wrzOOJRX5gbljJGz+jao8YtGtkTujF7T
         +MmRVtlxjT5s2j4WB8i/5fCFbEZUH0a/VTDoas3zsfgUv9v4tlkoE/SwVfEuospU+604
         YfWRWDMe3famnnBjjoXoS+roakahIrx+Ha9YNguc5zSN2xAB2b41Xb+GYCQujZqQPpbV
         LkzrDXDnhOlLt7dqUXwznvPz7CxrtNSuV0aIsGt9jIKRwQTGswJQVS8RsgvDXH12xRIl
         q6Yl2/uKeZUeyQj+zImq/zV5K7x001H6G7aKQ4rTqWhMvuzh5gyjviXGMf4NaojLiOsa
         Tc6w==
X-Gm-Message-State: AOAM530hxZGqWOO1S9jb8aQ16z8s/ww+uw7NlN/EysE24KpZj9EFdTk6
        XskEy7wZgkAJpdXBKOcYI5uS3/Lqd94=
X-Google-Smtp-Source: ABdhPJy/olg4aphA20oYdH/B8YIhQ+R6NCbGg7BABOmsrnFeWujbC0mqhY5XseQO2N3QTueNEDijQw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr505324wru.380.1625155694788;
        Thu, 01 Jul 2021 09:08:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm336929wrh.67.2021.07.01.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:13 -0700 (PDT)
Message-Id: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:07:58 +0000
Subject: [PATCH 00/15] [GSOC] cat-file: reuse ref-filter logic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic.

Change from last version:

 1. Amend part of the description of git for-each-ref.txt.
 2. Modify commit messages about why cat-file reject some atoms.
 3. Resolve conflicts with the 'seen' branch, rebase this patch on
    (bb9a3a8f77 Merge branch 'zh/cat-file-batch-fix' into jch).

ZheNing Hu (15):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: add cat_file_mode in struct ref_format
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options
  [GSOC] ref-filter: remove grab_oid() function

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 275 ++++++----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 357 ++++++++++++++++++++++-------
 ref-filter.h                       |  14 +-
 t/t1006-cat-file.sh                | 251 ++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 +++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 14 files changed, 887 insertions(+), 294 deletions(-)


base-commit: bb9a3a8f77e13b7a414cf64bf294c3f59f2444c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-989%2Fadlternative%2Fcat-file-batch-refactor-rebase-version-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-989/adlternative/cat-file-batch-refactor-rebase-version-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/989
-- 
gitgitgadget
