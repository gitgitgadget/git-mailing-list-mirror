Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D5C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1Rjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjC1Rjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D401AF09
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r16so9478095oij.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lOvPhVSBo7Y8v5+m6IdJfnHPbbEa3V73Omdtcd+xbU=;
        b=YEyL/vkQ4cvjVPrcXCd2U3cEcPhGID1Hc30zI5qxAbxKnHEZqHN38zyksLc+BpXsRh
         avR4lVMVq5NQ6iJ/YwSZL0/kzJ7HzcP1EkjzQrZTGPohIFxDDV9xSC9LrLZHYNjGuWXT
         43kD1aAh5u1ABZZR/N4oiuNSd9BCBmX4ji1sKTw9Z0V0oCX3oDt1gS7xUPID4jjEJLJO
         AFNvaO6fSxHk/+4L2YS15doO/Bt3Z8ZSNrB5TFXY3dIv9ENg1HwJrvlmYARXNvev0Y5r
         umcR/C6CMw/75WOAC+688dNConRMyXmm8bgx6vpqGcyGRvGVeBsMFGDxvmbvblafDU3t
         YRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lOvPhVSBo7Y8v5+m6IdJfnHPbbEa3V73Omdtcd+xbU=;
        b=sNjlZWKElYBJo2xP3m+y13sBHUBY1PMI2Nj/+FTT8zgeDaFE5T3eHERipezxOg8Hfw
         zz6OKrb8CLvRrbFnxjmzDwU99lJm11YYF/weNIXAq0QWHIGcXy4Hwc4tSYOxa3/8Gm/v
         +vgFcJcS2ZEQht8q7zKthmvJRtE/Z/YGl0He0zVjfb8LhET4IuLJm9OO/dvHQXPZvATA
         PzdBPtSA/Acci9cCwJ8L9Xd2gvnMhahdwzcfc1oXDm6rkjSXVrq6Ft51vv1naHHvaHPX
         ctmv9PQ3m13DqMnZy8s6nDjOjfha069Dzu37JB9SrU0rIeaX0AHiFB6uzGsGA0S3yJX9
         qJYQ==
X-Gm-Message-State: AAQBX9fSrM8+r8Sx+U2DBqLiugC6KI79ChqZud7I60CGjxrLI0OF7jnZ
        4xJW5yK9uw4qhzmIsaN1c0HGHpWK7e4=
X-Google-Smtp-Source: AKy350ZwYx83/X1lUcGcJLPEvU1e1Zx3Tia2B903WT1zN9HmMmD/j4ThmXUce8jojIbnZ4byEh3qAA==
X-Received: by 2002:a54:4503:0:b0:389:ad7:95d7 with SMTP id l3-20020a544503000000b003890ad795d7mr4942281oil.29.1680025174067;
        Tue, 28 Mar 2023 10:39:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e17-20020a544f11000000b0038778d9d8efsm5519303oiy.56.2023.03.28.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] test: make the test suite work with zsh
Date:   Tue, 28 Mar 2023 11:39:26 -0600
Message-Id: <20230328173932.3614601-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not difficult to make the testing library work for zsh, so I did that in
the first patch.

The rest of the patches are basically to deal with some variables that are
special in zsh, workaround a bug, and a minor discrepancy.

Felipe Contreras (6):
  test: fix build for zsh
  test: avoid `stat` variable
  test: avoid `options` variable
  test: avoid `path` variable
  test: hack for zsh
  mergetools: vimdiff: check for empty fields

 mergetools/vimdiff               |  4 +--
 t/annotate-tests.sh              | 10 +++----
 t/lib-bash.sh                    |  2 +-
 t/t0001-init.sh                  |  4 +--
 t/t0003-attributes.sh            | 16 +++++------
 t/t1450-fsck.sh                  | 16 +++++------
 t/t3305-notes-fanout.sh          | 12 ++++----
 t/t3432-rebase-fast-forward.sh   |  4 +--
 t/t4013-diff-various.sh          |  6 ++--
 t/t4046-diff-unmerged.sh         | 49 ++++++++++++++++----------------
 t/t4051-diff-function-context.sh |  4 +--
 t/t5329-pack-objects-cruft.sh    |  8 +++---
 t/t5512-ls-remote.sh             |  4 +--
 t/t5516-fetch-push.sh            |  8 +++---
 t/t9300-fast-import.sh           |  4 +--
 t/test-lib.sh                    | 24 ++++++++++------
 16 files changed, 92 insertions(+), 83 deletions(-)

-- 
2.39.2.13.g1fb56cf030

