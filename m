Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5154C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C41B6115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhGQSGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGQSF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:05:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCCC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:03:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so13403055otf.9
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wECuIHxbhxBtjzZQVi4w8rIj99+6tiGCBK6dljGJ2nE=;
        b=UlHgaD6ZZK9xn967ujbcmdrQPtDSm0jcx2jcgNzbz7HWVVYCjLIZA2S7gGXPh5g3EJ
         1L59QZv/X/KLKoK9dGWNggFI7tDz/4YTnFbGUTdP69RUOGIVPwnOaQsWNgRI1VaXxpr8
         drE+/K7Xm5ErOpAljEs9U5BFI6ugmn6Z2OaGj4p/JvxJKAoh6+SvvQpYwYvE3biYZOMd
         qDyUWeIQtszeJLdRa70QCQ8zj2713WQk7p3c3oeS49OyGrgQy831/WAh8fvV82XE6bUq
         GcqQ6JX+sybPFlSIsUE8yV6NDUY8q/psm426eMZZqouwGLRjSI9OZdXqqRTeYZx7V/f2
         wyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wECuIHxbhxBtjzZQVi4w8rIj99+6tiGCBK6dljGJ2nE=;
        b=Fr06WSvO48UAcpQknvCNYCM9BTB7+huemf/bgDZKPa/aX632T6uSkkk+QooP/IDx8w
         XYbFO9uaDsedAAB1/hQV1ZRWtQ51CHd58JT7LznZU1+xb00/P9ZBepi//syv4PbpVhrl
         ksFucGrBN/xdFqAupTbFYmHYv4uf181XAvPH9k5UFKhzO/KSHVWMbkMnxb94ZLZ1lNI9
         aRAbI/RGy8qZ5+Z0U5V74NCl1DIBhXn/V2yFrg0v2hj5q8AVWffbW7CCXCkiH3LK22Yx
         EKanM5AcUZdQ4gB5YObK2bTfqWarlhMPEp4KILUer0YKVvweqtR9XmQZRXdn0C6BFcXD
         mDdw==
X-Gm-Message-State: AOAM533BnZwU/VgoJEOJ/v0bvyokpzYknGU/SBCIKidLKMZABdYVVIU0
        hxegGVLEF1pvlesigtbSRzQ=
X-Google-Smtp-Source: ABdhPJwUPEU8ZGzZmdvZJi7UIYblUivD7x+PyrwXbc96OTCI6v4VEyu+8rgjtVmVsCEXb09v+PCufw==
X-Received: by 2002:a9d:1444:: with SMTP id h62mr13084534oth.166.1626544982469;
        Sat, 17 Jul 2021 11:03:02 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id q13sm2624521oov.6.2021.07.17.11.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:03:02 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:03:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f31b54b0429_25f2208b9@natae.notmuch>
In-Reply-To: <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 1/9] t7601: add relative precedence tests for merge and
 rebase flags/options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The interaction of rebase and merge flags and options was not well
> tested.  Add several tests to check for correct behavior from the
> following rules:
>     * --ff-only takes precedence over --[no-]rebase
>       * Corollary: pull.ff=only overrides pull.rebase
>     * --rebase[=!false] takes precedence over --no-ff and --ff
>       * Corollary: pull.rebase=!false overrides pull.ff=!only
>     * command line flags take precedence over config, except:
>       * --no-rebase heeds pull.ff=!only
>       * pull.rebase=!false takes precedence over --no-ff and --ff

This is wrong, --ff-only is meant only for merge, not rebase.

You are testing for behavior that 1) has not been agreed to, and 2) is
not documented.

This is what the current documentation says about all the --*ff*
options:

  --ff::
  --no-ff::
  --ff-only::
    Specifies how a merge is handled when the merged-in history is
    already a descendant of the current history.  `--ff` is the
    default unless merging an annotated (and possibly signed) tag
    that is not stored in its natural place in the `refs/tags/`
    hierarchy, in which case `--no-ff` is assumed.
  +
  With `--ff`, when possible resolve the merge as a fast-forward (only
  update the branch pointer to match the merged branch; do not create a
  merge commit).  When not possible (when the merged-in history is not a
  descendant of the current history), create a merge commit.
  +
  With `--no-ff`, create a merge commit in all cases, even when the merge
  could instead be resolved as a fast-forward.
  +
  With `--ff-only`, resolve the merge as a fast-forward when possible.
  When not possible, refuse to merge and exit with a non-zero status.

-- 
Felipe Contreras
