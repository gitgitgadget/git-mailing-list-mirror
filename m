Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48AC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F323A208E4
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niYG6EOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCSOAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCSOAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so1323885pgj.7
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yDDw6zp6Sg2n8oW+oy5bUDoP0OIUCoud78P2doTvdU=;
        b=niYG6EOW70GxTbgF5t6xtQJ2WI2djKyskWUOmV8N1gGHNHGCSeoBoAvMUUlL74Lk4O
         0FUQTjgIsh0gg5Ckp/7aLjP7nSodt1WfBgpdxItbZdg9RbQ5qDWXxC0bCuWBXrn541pI
         wnqVNue3kjWSwRrmS2QoOf9qtgagr5EdrDwOdb8fyxCvMUHOwP+FbvlT9OHWf83AJsl+
         MsZOguMz/4GkI7XiCDUaIQbxDr8EPK6sYvPZW7QfuKGmnYGw6Jq1ucjouoTo9Llb/8Kl
         8kPbE6GlTvjt9N8wbpsdo5LyBxwRwlNosRG1ObNKIrszczM0Yub+6yvN37S72BHNtxO8
         46Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yDDw6zp6Sg2n8oW+oy5bUDoP0OIUCoud78P2doTvdU=;
        b=mdPBdobw1qE0Jct6TEcwotNavU9JC05R9ZJzTkVXY9HjgBgSweUNPavo1A9n+o9u2G
         XnD14ui7qAI+ljpr6UZVbNpJrBuwIJJo0E6U9MauU9/PXfoXh1iKOXgB5NF+IGA6tbue
         ASAgavfbWFNG9Ycphr9Brcv0CnQZi3g8TRBvcyv/kfO0a4unxQnOr5tYVadMWnvuU4EQ
         VJ/Brp2wDwExRofx/2VsCID0iRbmsmAnHq9NcBIISssV5nzRmkQawBIzEFo7lrsNy2r0
         gACnHfgf5gUTewgT0TIfGQSGAIch/ug8QVQA6Mhams432Q/JlOyvhHgLnoECnOl7naXL
         IPiA==
X-Gm-Message-State: ANhLgQ3HoXLnaGDZ1pL7vD8gPiFrNNhWPg2bB+Q3U7yt2QgpPOX89UiO
        CNa83c4YfPrG5o7hKHOyBujCQ5Wi
X-Google-Smtp-Source: ADFU+vtC1WK26HyGGLXL9XEXrMV8VDe0DHczjaH3P+LVMHf82Ay4relPYP6Qz7Ttr1sKAsM9VLkypw==
X-Received: by 2002:a63:1210:: with SMTP id h16mr3511915pgl.408.1584626440547;
        Thu, 19 Mar 2020 07:00:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/6] fix test failure with busybox
Date:   Thu, 19 Mar 2020 21:00:01 +0700
Message-Id: <cover.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite some non-compiance from busybox's sh(1), grep(1), diff(1),
Alpine Linux is still a popular choice for container these days.

Fix false-positive failure in testsuite when run in Alpine Linux.

t5703.{4,5,6,7} is still failing.
Despite git pack-objects behaves correctly,
upload-pack.c works incorrectly on this platform.

I haven't dig deeper, yet.

Đoàn Trần Công Danh (6):
  t4061: use POSIX compliance regex(7)
  test-lib-functions: test_cmp: eval $GIT_TEST_CMP
  t5003: skip conversion test if unzip -a is unavailable
  t5616: use rev-parse instead to get HEAD's object_id
  t7063: use POSIX find(1) syntax
  t4124: fix test for non-compliance diff

 t/t4061-diff-indent.sh            |  2 +-
 t/t4124-apply-ws-rule.sh          |  6 ++++++
 t/t5003-archive-zip.sh            | 20 ++++++++++++++------
 t/t5616-partial-clone.sh          |  2 +-
 t/t7063-status-untracked-cache.sh |  2 +-
 t/test-lib-functions.sh           |  2 +-
 6 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.26.0.rc2.234.g969ad452ca

