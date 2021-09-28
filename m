Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B6C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ADD610E5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhI1NEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbhI1NEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB98C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d21so57788581wra.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJWeihyOwXczD2vITE5O4cVsUD95JspMAfSOODmooeM=;
        b=PWuCwZKFiDwyhQFcaGOSH6xoFFb72uwh+u8qhxZmkMGB4mEGkz3SP+ZUCSL9Q4L/HY
         8ZXNe5qUcsZ/Dc6THQESUOWnUlnSUHYe+/6MbPKgcWOkTsa0PDTYjgsbXVzLbjY/qr5x
         EKBWb+KuMHtJUbE7WwhZUYUaf71QfnK1ykzpiKnfCVmCrfYc0y6pDFdsPMJjFrMU/YAQ
         aILsBJLGdTOD2Nbv2t67m+DJdhn3GaPgtT1GSAuZavIG61jjmapXVweWMa2rap2q05OR
         zhRjm3tINq/sbdZmWerICf8YzWYGLFXuT0Yqe25Jua8bBgIFKc1+Pmiw5zA8+f9deca8
         or8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJWeihyOwXczD2vITE5O4cVsUD95JspMAfSOODmooeM=;
        b=MLEy4X0t9FAzYKcBxAA/VCYxBgKMgF6V6F5Gq/xjq7NEs+SDS3MEcORIpOdF/Gp6pb
         spFp1Hs6o/YGyz2ARd/DZR7H5FEW7fq+BkOIjC1F05XChhVw2twYBqLugtq7cqZM6s+Z
         p9qV7dVBKIwQarBcEryOkQYV/pCQOJR0cUDBMb+/HFt+IZHEAPBroaG8bAur6Mi7YXkn
         MWjJMt+WcFKK+3Q2YHfXLFLUX2QaoVu7bEal9UUfgPKPK3GhR0Oa0E84tbUI/DD7rxTu
         BXYh08XhCwLCtO/eJs8RCTvplklq558XnIspQSNA3edwsPNNOkRAhHI7wHsUXU5av8Ug
         MNdA==
X-Gm-Message-State: AOAM532sWiCI0WAZ+qmKOg6leHmA0O410O9c7vrRGnyVd3UJX0kGGJaf
        0KOlyUGhnOorQrAkVh3rvUPFRVvj0qmbHw==
X-Google-Smtp-Source: ABdhPJyuUL0i+kWN/DPm5vpDb3I1Qd0Bng89Rt1ZzDEJPaCf08P5m8d1TnOvB9XhnhUAqrpnE4hTcA==
X-Received: by 2002:adf:b35c:: with SMTP id k28mr6139615wrd.209.1632834147443;
        Tue, 28 Sep 2021 06:02:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] refs: remove long-dead code
Date:   Tue, 28 Sep 2021 15:02:19 +0200
Message-Id: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes dead code in the refs backend, mainly in the
ref-cache. By line count this is mostly a straightforward follow-up to
9939b33d6a3 (packed-backend: rip out some now-unused code, 2017-09-08)
and 9dd389f3d8d (packed_ref_store: get rid of the `ref_cache`
entirely, 2017-09-25).

Ævar Arnfjörð Bjarmason (5):
  refs.[ch]: remove unused ref_storage_backend_exists()
  refs/ref-cache.[ch]: remove unused remove_entry_from_dir()
  refs/ref-cache.[ch]: remove unused add_ref_entry()
  refs/ref-cache.c: remove "mkdir" parameter from find_containing_dir()
  refs/ref-cache.[ch]: remove "incomplete" from create_dir_entry()

 refs.c               |  5 ---
 refs.h               |  2 -
 refs/files-backend.c |  6 +--
 refs/ref-cache.c     | 87 ++++++++------------------------------------
 refs/ref-cache.h     | 26 +------------
 5 files changed, 19 insertions(+), 107 deletions(-)

-- 
2.33.0.1340.ge9f77250f2b

