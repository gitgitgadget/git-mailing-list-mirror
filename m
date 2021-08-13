Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE9C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ACA6056B
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhHMIXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhHMIXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE23C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k4so6336176wms.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=+e/GXE9YD/RlJPgIRKE46qzuvSibw50YYxZgzbWEJ2Y=;
        b=GMC7BSuixS1Wo+Pz7PKCCZcB4ogLhlbOI/GSP2jgWyePanKdlS1xDknfzitLFigz+f
         RC0KPsxaCgnSOiQ8AEqfJxZhD/Pkg9MakjdPHfq+vYSw3+IqTT5fpUNGLZNsHt5oorX0
         QtJKnrEAlNgbxDm9qkeOyHH/1hxQZloIhP6mArPM9jNi/4U5yom0NgMHk2Pqftr/XHUs
         ygOgY8bZ/TSu0Vj9/1CNUtU2kz7sWu+a/gmqhfkCT1VfDZIpU+6vF7LH8sjT13UkRBj0
         DOr9U/ZH8sO2uj8WU6Xx8uWmZhQTVEQyi7l253S/LnkGpy4szor3a+Ats2KNZ3ztCYW7
         3hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+e/GXE9YD/RlJPgIRKE46qzuvSibw50YYxZgzbWEJ2Y=;
        b=f8mjXRMhY5+WKTp+WeSHmTOYke1fgSMRhj0xEDaVAF+dOmtEevtcV8nVn4GAvr1ukV
         2xmhVwxjzxKCBMsVA2UwMKG5Kys+2nAU4PTFmDYcGwynmwVwknZLgZpEtHNbWRmxXV2v
         QV4QeJFEDJ1pZGFWd0A994JpMlWJu2cUymRc0GzVwMx+pAWIUgYJ8wchfdM0KMIytUF0
         qt6Of3BhQc15sB2RS/7R+tBhzsre5Kiwjjl8JOtUpJ9CShC9rPklJg7WGB+8qjWY+PeF
         LEXSxW5Tkhce/IqRHATRQko4Adap/VUTRhRbemfeM12aS7XbUmzheLm4pOYcIjsGlz5x
         zMJA==
X-Gm-Message-State: AOAM532BXipTFHTAv0WJCmr3/fVjzjmdiuqmoKxnrbqRoGDlVN4HVgEv
        JtBkt5f6rMPAKMVu6Vl1rLXY7BQB8i4=
X-Google-Smtp-Source: ABdhPJwHQvEWndJMyTmyLilVHsNbZ8Fgv4DEzYwr+3Glq0+rMGbJ/MJ4OV8fNY90iSXqk8+1R/SZHA==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr1465240wmq.101.1628842991845;
        Fri, 13 Aug 2021 01:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm655396wmq.30.2021.08.13.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:11 -0700 (PDT)
Message-Id: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:43 +0000
Subject: [PATCH 00/27] [GSOC] [RFC] cat-file: reuse ref-filter logic
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes cat-file reuse ref-filter logic. At the same time,
some performance optimizations have been carried out. It's last version is
here:
https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gmail.com/#t

It seems that zh/ref-filter-raw-data is still hovering in the next branch
(Because git is rc2) So I now want to show some recent performance
optimizations first.

Change from last version:

 1.  Use free_global_resource() to avoid memory leaks.
 2.  Skip parse_object_buffer() which bring 12.5% performance optimization.
 3.  Merge two for loop in grab_person() which bring 2% performance
     optimization.
 4.  Remove strlen from find_subpos.
 5.  Introducing xstrvfmt_len() and xstrfmt_len().
 6.  Remove second parsing in format_ref_array_item() which bring 1.9%
     performance optimization
 7.  Introduction ref_filter_slopbuf to instread xstrdup("").
 8.  Add deref member to struct used_atom to simplify the logic of the
     program.
 9.  Introduce symref_atom_parser() to make the program logic more concise.
 10. Use switch/case instread of if/else to increase the readability of the
     code.
 11. Reuse finnal buffer which bring 2% performance optimization.
 12. Add need_get_object_info flag to reduce memory comparing.

This is the result of the performance test after I did some optimization:

Test                                        upstream/master   this tree
------------------------------------------------------------------------------------
1006.2: cat-file --batch-check              0.08(0.07+0.00)   0.09(0.08+0.01) +12.5%
1006.3: cat-file --batch-check with atoms   0.06(0.04+0.02)   0.08(0.06+0.02) +33.3%
1006.4: cat-file --batch                    0.49(0.46+0.02)   0.50(0.47+0.03) +2.0%
1006.5: cat-file --batch with atoms         0.47(0.45+0.01)   0.49(0.47+0.02) +4.3%


We can see that the performance of the current patch of git cat-file --batch
is very close to upstream/master. The optimization of git cat-file
--batch-check does not seem obvious, because its optimization degree will be
affected by noise, which may appear in the range of +12.5% to +50.0%. From
an optimistic point of view, the execution time of git cat-file
--batch-check itself is relatively short, the optimization is of course not
obvious.

As GSOC is about to end, this patch series is estimated to be adjusted for
some time, I can only wish this patch can be accepted in the future.

Note: The previous part of this patch series is the duplicate content
belonging to zh/ref-filter-raw-data.

ZheNing Hu (27):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: add cat_file_mode to ref_format
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: create p1006-cat-file.sh
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options
  [GSOC] ref-filter: remove grab_oid() function
  [GSOC] ref-filter: performance optimization by skip
    parse_object_buffer
  [GSOC] ref-filter: use atom_type and merge two for loop in grab_person
  [GSOC] ref-filter: remove strlen from find_subpos
  [GSOC] ref-filter: introducing xstrvfmt_len() and xstrfmt_len()
  [GSOC] ref-filter: remove second parsing in format_ref_array_item
  [GSOC] ref-filter: introduction ref_filter_slopbuf
  [GSOC] ref-filter: add deref member to struct used_atom
  [GSOC] ref-filter: introduce symref_atom_parser()
  [GSOC] ref-filter: use switch case instread of if else
  [GSOC] ref-filter: reuse finnal buffer if no stack need
  [GSOC] ref-filter: add need_get_object_info flag to struct expand_data

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/branch.c                   |   2 +
 builtin/cat-file.c                 | 275 +++------
 builtin/for-each-ref.c             |   3 +-
 builtin/tag.c                      |   4 +-
 builtin/verify-tag.c               |   2 +
 quote.c                            |  17 +
 quote.h                            |   1 +
 ref-filter.c                       | 902 +++++++++++++++++++----------
 ref-filter.h                       |  30 +-
 strbuf.c                           |  21 +
 strbuf.h                           |   6 +
 t/perf/p1006-cat-file.sh           |  28 +
 t/t1006-cat-file.sh                | 239 ++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 20 files changed, 1283 insertions(+), 511 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh


base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1016%2Fadlternative%2Fcat-file-reuse-ref-filter-logic-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1016/adlternative/cat-file-reuse-ref-filter-logic-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1016
-- 
gitgitgadget
