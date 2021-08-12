Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF3C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 06:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8996101E
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 06:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhHLGx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 02:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhHLGx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 02:53:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413FC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 23:53:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y130so5419605qkb.6
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tAwXjeO32qJRY7KuNoqEEZI5Zp0yNZOUdnXfIPk3g/Y=;
        b=Gs1hMsa1t9ooSCVk0uHAnUD3qBSq8qoL1t6QzFQpommLYkDqQOwemVe+OmZwyh0nil
         vW4arvTSL/LlHS/aPZ7VzXMyePRnxN0et9xh7HE3zfMeOPxJeYHjDigxV+OFHhf+uqjD
         4SpzpJyHIoHe+AJ5ToBzmmQyl5W9w1dYyNb5uQPvy06c4khoGMgn1jJz6AvcZSGHSuYs
         4k424q/W1wjsxyiaMQF7SAGMcXaI6KP7DrvTAuEodJaaj7bSHr5KKQpQwAxUQqj3OGww
         RnO1trhH/qmhH2ZdryyCwQ8UwMKmmd2gGZYU4jL2g3yCR07wD3ekCZ8opoRJ7liyUiC8
         lq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tAwXjeO32qJRY7KuNoqEEZI5Zp0yNZOUdnXfIPk3g/Y=;
        b=Gxxy3tdSTo6PX4oRDRYBfGXQQArNm0lRPbRJC6jDafGSZRXws1G1EMbO3AOGytGej7
         r/HdhiZUd2F1q4cZZHOyo9oIId/idfMW1y+qjMN5yqCnIPZk05gkxrzoamUv9ZkC7G4x
         pMKIHPw3+SFlnkPZFDXwsIxcXZZ8hhqcykaEJiL7DfV5eeMqCjRJiuyjNteImhajTiDP
         FTfSWNeVJAtLk/hHXYk32pL5lM3e6Wz1J5s8zqPM5a7NAQ/4l0IwVBoILnIPLWj1GcNw
         UROSsuBHtCr2g6ULOT32011zc/m+VzxKEIpIyqPB7O/+/dzt0oLacPeyQYg47X3hs4le
         6lLg==
X-Gm-Message-State: AOAM533CGAbkpCLmw4Ui15fok6YlKzlkYTWDnsY5DzDVGUA9RQ5ljyKd
        qix62LY24ugSknHabUWSnjZdGmh5roQ=
X-Google-Smtp-Source: ABdhPJxJ5tVMzLuaVaZLbrKXIcgC+PilOyDek4SD0/1ieTAnH2sEF3IJTW1qntHysaU2fVIwf20tKw==
X-Received: by 2002:a05:620a:410a:: with SMTP id j10mr3076748qko.185.1628751181964;
        Wed, 11 Aug 2021 23:53:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s32sm717381qtc.66.2021.08.11.23.53.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 23:53:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] ci: use upload-artifacts v1 for dockerized jobs
Date:   Wed, 11 Aug 2021 23:52:34 -0700
Message-Id: <20210812065234.71399-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.379.g2890ef5eb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e9f79acb28 (ci: upgrade to using actions/{up,down}load-artifacts v2,
2021-06-23) changed all calls to that action from v1 to v2, but there
is still an open bug[1] that affects all nodejs actions and prevents
its use in 32-bit linux (as used by the Linux32 container)

move all dockerized jobs to use v1 that was build in C# and therefore
doesn't have this problem which will otherwise manifest with confusing
messages like:

  /usr/bin/docker exec  0285adacc4536b7cd962079c46f85fa05a71e66d7905b5e4b9b1a0e8b305722a sh -c "cat /etc/*release | grep ^ID"
  OCI runtime exec failed: exec failed: container_linux.go:380: starting container process caused: no such file or directory: unknown

[1] https://github.com/actions/runner/issues/1011
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47876a4f02..9dd41a1742 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -258,7 +258,7 @@ jobs:
         - jobname: linux-musl
           image: alpine
         - jobname: Linux32
-          image: daald/ubuntu32:xenial
+          image: i386/ubuntu:xenial
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
@@ -271,7 +271,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v1
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
2.33.0.rc1.379.g2890ef5eb6

