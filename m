Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF69BC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbhKYQMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbhKYQKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:10:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738EC0619DE
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so12579034wrw.10
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8IP/LxAVD/5QBEpqfvIaHlWtJbsr2xHZCM/kCh7CoI0=;
        b=QzErc/jl3Lv36y1uIwxk9Ege2R2HPmHqjgGZ79RYgvpn7fgf9PKSn1UAUbvrmIJmzj
         21/RpSTi5/eSUnDpcrlXiYxdkKJ6krLvhoxe3wsfF8MdAhtUq+QtQDdWmZ0XO2PhkXZW
         Ovf8umTZVyUuogqel0TbAMDJ3nwXvz+XFR224haxTjg6baPrzWTIAkbJFNY9Y5++2Re9
         jk50aM4d/JyUvBcIou1Xr8Prjj5TPVSYRimWvEhvT0d3vPKiERm4BsFPDaN6ehA3Rlob
         P2rOARcfq4ptXnqzTtwNb7vLP/Z5qihSRhGFZXvejVUkSnO1N4edj5fRrfFtY8qCtQ3b
         67UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8IP/LxAVD/5QBEpqfvIaHlWtJbsr2xHZCM/kCh7CoI0=;
        b=Ayrxq0TSfSWP4JbVrOvqCk3pRt7G+gejwhzvE9dvn0lP5kCFurg8tpDNroFKDmQgpB
         zFQVo9nhqPWguAvlUAGINJxD5TZ9s98vzoHnu1wx0fbmgiGArzAZSgYT6GCmm63iuHTR
         N4nFFyWWt66Qa8TdHnMiajfAhvz2cx99K5NABjsSULDACQN2yZ5frEuMr6Ldk7/B2cCO
         QH3ikmHzOakK0Gax8/tJrxogNkBHZFGEnBbt7w+kEyq27e4aIb4sR3HB/c/MNQD7UZS6
         rQmHblaIoAihUjbjF5jOxapRiER9g1krjpfxPowhZUVkYgRxvdmNpWpRXzSNRnXFtzs0
         xUog==
X-Gm-Message-State: AOAM532EdZ4kZ8G5U0dDuT9k6OaLbe4Ux4Q5xsO3ZaUEKhTNs0i6HS6a
        5APUfHScieObJSaCvnbzqJ0QVvjEZ+I=
X-Google-Smtp-Source: ABdhPJzou38VR5NTe47vYJ8FNiuXuV/03JoiLisQ1zPRbTokDmhUY+WQ6fbv5t3p3/SCoEYxE3EJHw==
X-Received: by 2002:adf:cd89:: with SMTP id q9mr7643951wrj.205.1637855762865;
        Thu, 25 Nov 2021 07:56:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm3418893wme.39.2021.11.25.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:56:02 -0800 (PST)
Message-Id: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:55:59 +0000
Subject: [PATCH 0/2] Allow writing invalid OIDs into refs for testing purposes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this covers a few cases of direct filesystem access to the ref database in
tests.

Han-Wen Nienhuys (2):
  refs: update comment.
  refs: allow skipping OID verification

 refs.h               |  8 ++++++-
 refs/files-backend.c | 53 +++++++++++++++++++++++++-------------------
 t/t1006-cat-file.sh  |  5 ++---
 t/t3800-mktag.sh     |  6 +++--
 4 files changed, 43 insertions(+), 29 deletions(-)


base-commit: 5f439a0ecfb4657100ec1e56ef9c6eca963b5a94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1147%2Fhanwen%2Fskip-verification-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1147/hanwen/skip-verification-v1
Pull-Request: https://github.com/git/git/pull/1147
-- 
gitgitgadget
