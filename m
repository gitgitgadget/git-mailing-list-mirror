Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D273C07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7CE610E6
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhGLLtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhGLLtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A5C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d12so24560458wre.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=dXlOroawfuW/BZZASofCOvmzKXiEy/M0hEFDoOPgjyI=;
        b=D5fbQbQGXMmdQih+fAL7i3O4u/0VdnvPtc+vrv4FJOzjMkjpSAqgoFvVVsVg9VlbTd
         xfeOIiGfNDl3NpZzSp7OKf/RD9BB2F7+i0KAx8T3lRaQsJrKQvC6Wb9Ni8wGQVMFTdS0
         OgimobIfhvg/1RyXCGgxhA1jmxFrTpzfzaQhcDxo0e7WS/L5EZKYRZ141TXku0IslOvm
         Jhq248esesNGOxKVxtxCEgaNwVMB/Z7DuhdLDQ+Zs0VJU5Q1BW1P2QXYwhQeF71/K/Bl
         j/5nSP6wzwfXd8ShrsxZjeqgKoqKnXmnmk1alcxcFozG6H4QhQrkowFeWUuFGw7ZDBgd
         Ro+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dXlOroawfuW/BZZASofCOvmzKXiEy/M0hEFDoOPgjyI=;
        b=gRLyU1z+DZ8QmahO0po2VhepxjOrZ8hNjrcDHPboZ6CufWcP8kX8+/GCB340yiyUtW
         g9OR69CHsu0C6rRX/h907FkEnCmulX3qt2u0Vj6zNRpNSfRgt+LaHKKVkXqFFa1ccfC9
         v0/IKCeGLwcKXfzkQVmozdZfpZNiZWe7/5F1Aqq2GYkpYx9Y1N7IAqf4wAGg3bJrgRPu
         0nPYSwW72iQamwnoXsV7MQ3QpSyrDzpzhy8RvX7O+tCF3AJdb3aKhVjMX1eXr2C06co+
         vIUOlyXf72a+t1ewcXSg0/VSRMistsqR9UU9y2gw+qlc5JU1j1JJqHJIm1gQI6fecqF8
         N4tA==
X-Gm-Message-State: AOAM533j+qTT2iJKKYQwZQGAvbIjtserVOawKS0++z7bnHkZkWFX1cl3
        LGKNXpox2MNER4VuOMMcYjrqdobKYDE=
X-Google-Smtp-Source: ABdhPJzIHIKFZOff4gCYSv/bzRhi+hJ/6+2i16lSE++lBkoO6wLlNIVAa4kXmxJkoluakQM98Eherg==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr13232841wrx.181.1626090420829;
        Mon, 12 Jul 2021 04:47:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm13678487wrw.19.2021.07.12.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:00 -0700 (PDT)
Message-Id: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:40 +0000
Subject: [PATCH 00/19] [GSOC] cat-file: reuse ref-filter logic
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
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic.

Change from last version:

 1. Declare buf_size in if (atom_type == ATOM_RAW) block.
 2. Modify the code style of the test.
 3. Delete "use_textconv" and "use_filter" flag. Instead, add member
    cat_file_cmdmode to struct ref_array_item.
 4. Add function reject_atom() to enhance the readability of the code.
 5. Create p1006-cat-file.sh for performance regression testing.
 6. Use a "fast path" to output object data to reduce the performance
    degradation of cat-file --batch with the suggest of Ævar Arnfjörð
    Bjarmason.

ZheNing Hu (19):
  cat-file: handle trivial --batch format with --batch-all-objects
  cat-file: merge two block into one
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: introduce reject_atom()
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options
  [GSOC] ref-filter: remove grab_oid() function
  [GSOC] cat-file: create p1006-cat-file.sh
  [GSOC] cat-file: use fast path when using default_format

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 308 +++++++++----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 346 +++++++++++++++++++++--------
 ref-filter.h                       |  13 +-
 t/perf/p1006-cat-file.sh           |  28 +++
 t/t1006-cat-file.sh                | 273 +++++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 15 files changed, 955 insertions(+), 297 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-993%2Fadlternative%2Fcat-file-batch-refactor-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-993/adlternative/cat-file-batch-refactor-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/993
-- 
gitgitgadget
