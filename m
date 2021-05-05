Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A04C43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184786121F
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhEEMPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhEEMPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:15:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BABCC061353
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:12:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso2931467wmh.0
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClmlkijN5HmPpqvULXG3VqqjjQkZAQVWYQfST49OJpU=;
        b=Kyu+hEUQ2dwWu5krFSr+p9E4hhZ70kIEHQsei+Eo+8anrSh25Gax+Jm8kh59gPkgP5
         YLe5JsfLfr8wXJ1QBp54C5Py1B6aiGdzJAICXdZ6Js9WJofsJ5OjifhVJ+fth/7CcZlz
         xGDYX7UszEK5aZT7tAtOE5R4qNpdTtVGTqtwHDfHo8ASDZe0wofupsPmJ0PDjPc+rU5G
         VkexiX2w+7UJdTaWoZzHQcN7Ef7Qwzm+jwzaxcLIOafP8BuNTEvLSBJx5Tihk09IplX+
         f2lhCvmEdKCTsn2cUBvqYUq/YSBPbvMeXppVtNmS3TxLdwTCeE2PFtOkrhCKoaTV8x3K
         +Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClmlkijN5HmPpqvULXG3VqqjjQkZAQVWYQfST49OJpU=;
        b=SpvEy1gU0o32oyUf/PwoizLg7F86xJQPQAZO6GgwFed5hsDbM2iBvQpL0YrhDu8Bp7
         LPyPmqbCfSPms+97D91N7cpDK9EvIlqi3jmqMSSCWa4jBWFgSyeeNnatrT5lGVcD/Egg
         9njkY1GVvUvsEyQ+RkRlbbUfF8TD/leqCDBNwNGt9gg1FdJjs7Qe7BRZCNgLZYYJ+tpL
         geT/fNultTVohZLKCUD3WckqJPrCgihvsGF3KOrdfZl5PgwgCzJs8v1cEPt/Q8ZCXwyq
         aIiqekkk0mvleptHpb+xDN57WYmc70s1MEA/NOl0usB7TS16+5aEl7Buo9TisE+6dzT0
         6snQ==
X-Gm-Message-State: AOAM533HXYSpzQs+dRoATob2DP1ZgsgmEtBbo8KFglnvT6S5Ghc70pLQ
        qYefoTaFZv3GSSCE0UK+ySFskjd7b95Oxg==
X-Google-Smtp-Source: ABdhPJzTalFDF2PShgjOirIkRyh6Oj09QX43WHe5jI9KMT+qzpFasML18igXbc310sKT9Gb0Bg7NDQ==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr9797590wmj.128.1620216721646;
        Wed, 05 May 2021 05:12:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d3sm11144626wri.75.2021.05.05.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:12:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] sparse-index.c: minor prepare_repo_settings() fixes
Date:   Wed,  5 May 2021 14:11:57 +0200
Message-Id: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of minor fixes for the already-landed recent sparse-index.c
work. The sparse setup code is (re-)setting variables it's already set
for no reason, and re-doing work it doesn't need to.

Ævar Arnfjörð Bjarmason (2):
  sparse-index.c: remove set_index_sparse_config()
  sparse-index.c: don't call prepare_repo_settings() twice in a row

 sparse-index.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.31.1.838.g7ac6e98bb53

