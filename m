Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05480C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E192E60C40
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhJMN0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJMN0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:26:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1DC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:23:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y3so8457155wrl.1
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xefrSVPy4IEcKzKCCUL/4lzEuKsEhy3CBmZti6V36Us=;
        b=MpN7afGByQTpFSjwYGYSpg+zFOv+AgJJ1a3ZH8EOQqJvh7eW4XJmn7oXZxubIVh2oK
         +Pa+6Nm/RcISlPRgnlIzWZ4/jFMP5RSTEuBYRBNSgF1ZSiVc1X27MwGgWHDr5FoS+M0c
         kKbKb4IQy2WaTufInRWBfYeyubpmxjWWzsuw/4i7YjB5be4j1ADE6B0FDFRWJsaMf6DO
         ity/7/lE6G81s0RORz8OIYo9vdHrRshqcHh3cgUfjIDi64xCqOcIH0nZPRafhVhl8Ngg
         CTpqCBANQqDwTDQw2xPSC0bVi5gnySOkMb9SkXzA60NkwfzH6EqtyEOI/1tJrPQwZjmM
         SFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xefrSVPy4IEcKzKCCUL/4lzEuKsEhy3CBmZti6V36Us=;
        b=UEoshuPkR6UxwrlSVecjoJpx5ACHG6HnaP9FNhVD1HYCpodmWoPKLj2i4JyEakCnnF
         fvDlxl2GxXLEc6yisJWgAm3xaOHrvLNX92cKuUkBYrncV2+9iM+D6T7EkLPjiZou2kJo
         povlD2leHf/Z64fcwxGKEI8kD7iY4whAc9g8vMJ2WoCr3402L6sQkhgTxsDQk+vNEkB4
         xvXmCWr7u85wOtPqUL7DxWbN8VbDut67Ggch+EyHQYiBD/8WPrnCnbEdvcB3cNSY0RS4
         OcMbq+LHT7/+w/mtz3Dw4qZGYbbI2RHZzZ3PY5okVd60ZkcKXJ3UE2PbC1tR8M8+i3k8
         3Wrw==
X-Gm-Message-State: AOAM531Spn9wQLoccLHKDnWjEqpnCEVhU5Kht6qDp/IhPqudRkFt7T7j
        6Rsyl29RbTsoa9D2lhtCwtQjjGOV/5+jVw==
X-Google-Smtp-Source: ABdhPJwmQ8vLB7WJyaCakeOGvP5BO3gZrOzfRxT0p0r68tnxWFSKC+0uBSPaNvAajcCVhT0Qk8gfqw==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr40599969wrz.412.1634131437430;
        Wed, 13 Oct 2021 06:23:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm13044205wrh.64.2021.10.13.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:23:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] unpack-trees: memory-leak fixes
Date:   Wed, 13 Oct 2021 15:23:52 +0200
Message-Id: <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1569.gd2dc77f7abf
In-Reply-To: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit-message-only-change to v2 should address the comments
Elijah had on v2 (see link in the range-diff). I.e. there's probably
bug in adjacent code in leaving a stale lockfile, but I'm punting on
that and just narrowly fixing a memory leak here.

Ævar Arnfjörð Bjarmason (3):
  unpack-trees: don't leak memory in verify_clean_subdirectory()
  sequencer: add a "goto cleanup" to do_reset()
  sequencer: fix a memory leak in do_reset()

 sequencer.c                 | 36 +++++++++++++++---------------------
 t/t1001-read-tree-m-2way.sh |  2 ++
 unpack-trees.c              |  3 ++-
 3 files changed, 19 insertions(+), 22 deletions(-)

Range-diff against v2:
1:  e5ef1be2aa9 = 1:  0ab1e74f50d unpack-trees: don't leak memory in verify_clean_subdirectory()
2:  1d5f5e9fff0 ! 2:  393937e8a98 sequencer: add a "goto cleanup" to do_reset()
    @@ Commit message
         unconditionally free desc.buffer, it won't be initialized on the first
         couple of "goto"'s.
     
    -    There are three earlier "return"'s in this function that I'm not
    -    bothering to covert, those don't need to rollback anything, or free
    -    any resources, so let's leave, even though they could safely "goto
    -    cleanup" as well.
    +    There are three earlier "return"'s in this function which should
    +    probably be made to use this new "cleanup" too, per [1] it looks like
    +    they're leaving behind stale locks. But let's not try to fix every
    +    potential bug here now, I'm just trying to narrowly plug a memory
    +    leak.
    +
    +    1. https://lore.kernel.org/git/CABPp-BH=3DP-dXRCphY53-3eZd1TU8h5GY_M12nnbEGm-UYB9Q@mail.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
3:  66ae63db8fd ! 3:  00b6b469a8c sequencer: fix a memory leak in do_reset()
    @@ Commit message
         setup_unpack_trees_porcelain() without a corresponding call to
         clear_unpack_trees_porcelain().
     
    +    This introduces a change in behavior in that we now start calling
    +    clear_unpack_trees_porcelain() even without having called the
    +    setup_unpack_trees_porcelain(). That's OK, that clear function, like
    +    most others, will accept a zero'd out struct.
    +
         This inches us closer to passing various tests in
         "t34*.sh" (e.g. "t3434-rebase-i18n.sh"), but because they have so many
         other memory leaks in revisions.c this doesn't make any test file or
-- 
2.33.0.1569.gd2dc77f7abf

