Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11611C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEDB61C60
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGGKlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGKl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:41:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AEC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:38:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so3836708wmb.3
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK9kVdDYlJsq+3hEAEmRiFOAXBd8+QvtrcSnN3CRHUU=;
        b=fBay/DxvPgJvYfcBTFGOnc41IaO55MIHtwQo6JX5doVh3H8bQUXR2nWdVgzbwuKm7t
         XR+CUcA+YXwIvr9Js/sQNfMML6tYrPUG0YVTtcVx9iR2qn1J7qWiKQnMiy2UbnCudWg/
         v4IqdHkDP/4U2YvS2xYsuObX5IbHzwIjg5iaimSj3hOLE8ASDtOqxw349LON6vX5gyst
         VOOrYtCjZIzahgLW+s08dXbT7xmNPnE+wH32fpQ87GHb94iPW7TZpHIqAx6JIrhCBd9m
         cPH2iqIk1QsvKMlMAqI59xbZ0ICNVmLNL+UGzNiYjRTkyCCVWAzGDrGHUrf2u3AWc62S
         s6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK9kVdDYlJsq+3hEAEmRiFOAXBd8+QvtrcSnN3CRHUU=;
        b=e9W8VFpnwgXMH0bn6HgUkPL9oTvOzD8XNSurcF+Vx75CVfpDFBN5401k5+MmE4Dsor
         WOYN3yvltpjP+jdhfb5D7PYqYbsitadZUCNp7JhHK3SDnasgFjDqQk+I1obP3UykYDxi
         COCk2TXXKdHirQWP/oqw4JcY0g/xlIJM/9DG6/ZDt4p9mTpoGnrkEf/FEFu1OUkRA2y8
         TuOkFZOIZVpGMem7aP5vUXvn3Qe1sxxFm4xKiNmGqQe8z24E3lSVhEO5k72DFpEuxuQr
         x1+sBTn1pymvp51akY2K1huzGTFi1ex9IN5RjcDuT1zVG322IXYzADvrbdlgj9gVdXZl
         fITQ==
X-Gm-Message-State: AOAM533uRMS3H4m53Yg+gLd9v+xdgJNrPSmEHGkIJxolM/HzwH+ILKgI
        LWZjSoOfe7c8DE0LQWzou9KlcB8yBv5CoQ==
X-Google-Smtp-Source: ABdhPJzAD6hIG5uF4YUqvVGsWO85Vf7w9v/11OnQ3JvFXQtxtjR2dYwRoryGV4dNEoeN0n+VmTU3FQ==
X-Received: by 2002:a1c:7411:: with SMTP id p17mr5995539wmc.116.1625654326815;
        Wed, 07 Jul 2021 03:38:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p3sm5859104wmq.17.2021.07.07.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:38:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] strbuf.[ch]: add STRBUF_HINT_SIZE, don't hardcode 8192
Date:   Wed,  7 Jul 2021 12:38:39 +0200
Message-Id: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A rather trivial cleanup series to avoid hardcoding 8192 in N places
in strbuf.[ch], instead we add a STRBUF_HINT_SIZE macro. Then make
strbuf_fread() take a "hint" instead of "size" (like most similar
functions) so we can pass a size of "0" meaning the default hint to
it.

Ævar Arnfjörð Bjarmason (3):
  strbuf.[ch]: add STRBUF_HINT_SIZE macro = 8192
  strbuf.h API users: don't hardcode 8192, use STRBUF_HINT_SIZE
  strbuf.[ch]: make strbuf_fread() take hint, not size

 builtin/am.c |  4 ++--
 cache-tree.c |  2 +-
 commit.c     |  2 +-
 strbuf.c     |  9 +++++----
 strbuf.h     | 14 +++++++++++++-
 5 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.32.0.636.g43e71d69cff

