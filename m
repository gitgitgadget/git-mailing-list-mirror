Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237CC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 06:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCGGpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 01:45:33 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF564A90
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 22:45:32 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cf14so13362400qtb.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678171531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1836XGQm6UhGm0tQ0WdP+MysGbDAorc8zF24Klt9Pg=;
        b=YwATjN6nViC7gtHYZSE7J4jyGqGMmq+twpl6fQrHEnerpt0LGhVyp0fGdav50AcF5L
         sAmV+GX+iy50+tTARXldQOhOJoJm/3Jjzce/fuWNdDoRac8YzNUfWonL+sB53LSGhFZO
         7lEZWGU4YBsJmOH9gwA+Nym5rKzhSdOk9n8fsZ2F9XdGm/tHiPBiexC9WPjrkxtUCnXl
         2rG/cDHbdOeUcV5X4WGZogXwbMnIPn/kkt0JAH1GDaXyslaoAcMc5kOytI9DcPVLOdRH
         /v3J3laRRnruZdcQtrUteEpigYUDKlse5CvRSlM3swSWH9Ggxoa/5nVkv8TYg372y/mF
         YPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678171531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1836XGQm6UhGm0tQ0WdP+MysGbDAorc8zF24Klt9Pg=;
        b=rn5IsgfBkZ5XJU5UIxg2YLepidV4OY3u6X8iNLfmZ2IoEwKpnM9tGYpauDDZrJRRHL
         xPrk//Uhc9j0csQDyfEbsggBWPm+ElJeQWKb7+biWjZPYzy0N5HYCeG9A7OGHnoCci2c
         WX9fEiUfhn4OVkQ542J3yQy5YTI6sVsbWtHLRqD39d8wqeqUJAPP8OtY/kBq8XyM8/Ah
         ayUMV44ZDY7Gj422w26693YUCPikE2Jb+R4T4MnREZj2ONKvFdsuDCiRPhbO7OxC6BGK
         EZX9QGyxq7e1Vx8cPMTPlFywvx16MFh0xpRamzjWMHgvLm7qAv4QvJjrcn/FbZn8zyRW
         CTJQ==
X-Gm-Message-State: AO0yUKW/TTS+LVolmXSwxZSF3fiLL1756B8nNZpxkUKMP2GWTTYUC78v
        f/hnNfOda5w4vsuGbrdmWNDEDDqV2lw=
X-Google-Smtp-Source: AK7set8kJfQThRsygiu87F9KRxZCHFCEOdSMyaZEHq6sf+VtwP7xd5PbiEGTvn5Lgg9oyWW3d7Bkgw==
X-Received: by 2002:ac8:5dd0:0:b0:3b6:3a12:2bf9 with SMTP id e16-20020ac85dd0000000b003b63a122bf9mr21528993qtx.2.1678171531255;
        Mon, 06 Mar 2023 22:45:31 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm9452864qtw.53.2023.03.06.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:45:30 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [PATCH v2 0/2] diff-files: integrate with sparse index
Date:   Tue,  7 Mar 2023 01:45:04 -0500
Message-Id: <20230307064506.76663-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse-index feature within `git diff-files` command.
Add necessary modifications and test them.

Changes since v1:

1.Add an empty line between the previous test's closing quote
and the start of new test.

2.Use "git add --sparse newdirectory/testfile" instead of 
'git sparse-checkout set' to have staged changes outside 
of the sparse-checkout cone

3.Edit commit message to be more informative


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 52 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

