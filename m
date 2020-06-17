Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0911621556
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlDDoUtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQRYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 13:24:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4165DC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so3214143wrt.5
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=3H2kTsxhuYqri7lWR7zL372JotU2060mim+6J4D8MHw=;
        b=KlDDoUtMKu5NY4fWebRgT20VJ+fLn8u4AI/LEDq6/75aEv9hdF2zKcIrb+cjLhbrfp
         AVm+A22NWti0m+PBba5nWRykmaeQRsNUxRcotgCqq2qdo3EfqcJGZZWvhx5knp4bS8wT
         Vt9Gt/KbDXK0//4zcCniECDSx6vyHrCizezTrAXosO1NAXGpkb8hKgUJ9AdRvr3dNW4w
         EOuRCmxxywCw6AXR0mnCuiGIgLidPpA3rgMIevVCxhBEgVzBP9gWWCR4st+WDmOgALN5
         sibonDdEDdbR0Ty6SNUHoJK66ZzEGFQb4RW/R+DnX2oagtOeb1yKRbl+sIZVK2r3CAlM
         IPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3H2kTsxhuYqri7lWR7zL372JotU2060mim+6J4D8MHw=;
        b=GRwU5v7VByQ1WgLppkS4RXN9ihv0l+4X0IKrlWH4ox4uapGWzffwKOnxSaLyNkuwJ/
         YhIb5aX3tbcxqsSMdw1JdASOcn9HH+/dJS3yDtK4ClfWOCMx3OMClAc4DV/W7sYsfziA
         c+/2ZjtqXO/6dwV6kaeUp5WRDXRR843ImUTLuN847kIt8yaZ/6zoM1OrmtyB/9p1yYDG
         F2S40jN8taiFwPlyYsUGKAzZfecxa6gfjheVB5I2CUOzvTIZhWUNsDuyJXG11fMCSJv5
         9H8kgazFZc3fUZSAIm/bnnJ2zKqBOahlM985zsEhjghdh2xobw6sWD+2EMYq0WJXbSt0
         OVAQ==
X-Gm-Message-State: AOAM5330vXoojgA14uKuOlL2GXgiusAQ1BNy6ptIDoVCBhO7JOuC8xGJ
        eA3xKCW6u+NaVyInLqrc31HjxVVS
X-Google-Smtp-Source: ABdhPJzvUUaYkTd96eBSmV+FH2mgu3wuunaV2nWZ4qKTmNC2dyYxEFoOZcGfDyPSZoJpP6d6kAp3jQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr282680wrx.133.1592414671788;
        Wed, 17 Jun 2020 10:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm258728wro.71.2020.06.17.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:24:31 -0700 (PDT)
Message-Id: <pull.664.git.1592414670.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 17:24:27 +0000
Subject: [PATCH 0/2] Accelerate "git merge-base --is-ancestor"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was recently [1] reported (and not-so-recently [2] reported) that "git
merge-base --is-ancestor" can be pretty slow. In fact, it is regularly
slower than "git branch --contains" or "git tag --contains", which are
answering a "harder" query.

[1] https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/

[2] https://lore.kernel.org/git/87608bawoa.fsf@evledraar.gmail.com/

The root cause is that the in_merge_base() implementation is skipping the
fast can_all_from_reach() implementation and using paint_down_to_common()
instead. Note that these are equivalent: a commit A is in the set of
merge-bases between A and B if and only if B can reach A.

This fixes the issue, and makes the performance degradation reported by
Szeder a non-issue.

Thanks, -Stolee

Derrick Stolee (2):
  commit-reach: create repo_is_descendant_of()
  commit-reach: use fast logic in repo_in_merge_base

 commit-reach.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)


base-commit: b3d7a52fac39193503a0b6728771d1bf6a161464
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-664%2Fderrickstolee%2Fmerge-base-is-ancestor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-664/derrickstolee/merge-base-is-ancestor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/664
-- 
gitgitgadget
