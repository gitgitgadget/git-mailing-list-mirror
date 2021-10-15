Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E40DC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350E6610D1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhJOCID (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhJOCHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 22:07:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AEC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z2so1108634wmc.3
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44kKmWRtN+HJPUx0nF4D1qVsG5oQ/lZKyLNzXzSi4g0=;
        b=Ffin7j2yiDYGEIZ+QdX3V08YGYsAx9e4lYKqTARyaWipxhdxBZYOJQS4LLo+GSqPpX
         KJruSZSUGLmokZTTJ7OcXgUSgAa+M068efVGsD7Ojazfvdl5TOBiQ4PI/vaAlIgs9FCg
         ltVyvTRvCUiCitDP0kKqWv7i8cswhZbT0sZBiF5CHU6ngavY+ZQhlsVtd/4MxU3u2eke
         DcbwIEwPIGufaHdIyyy1URCDnVTmqA/D4fwfODY0ms9D3+Rrcq88WBdJqptScZ5J4dVC
         kPwTih1/EZXFbpQY34Wp+KB8370B6ac1o7taGG1Qm5245Pej7GK94jIGAEbduObbj1D+
         1GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44kKmWRtN+HJPUx0nF4D1qVsG5oQ/lZKyLNzXzSi4g0=;
        b=B8j7RJ0bXiCWtiDod1O47gIzEFq6kssvQ9yNH7+ZjZzjLRDRVNd7VfCqtW8dDze62S
         O1KTL4W07i7egVbogREtRXTw9s6nPdcsbRirht4zXd5Fmegcb5pOqAbuvS2RF49lw78d
         VD8BvjtXHh56JSi4g9N3Y2bgC1LXD8AHA9zfHL5brvAGhYqFIJe7xSX344uGWl7W+0R7
         DL+zuryLPdqF1lT6qP/Kw0/YfFzukGb9VvJLufK6Rbbez0lxA/YBJyBTfwnAjT0350Mi
         3fEuGe8al9Hak1vxqPBpUR7Lg5WIzFPcYdDUEecwcvlbAc6zsIQu4060xGVO+9kF60cI
         RV6w==
X-Gm-Message-State: AOAM531nzhMJpdG4vXFDrS2KHD6S4oMorfkRPn2lTewlJ3qjJ++WjxDm
        WQY1sYu38ECh+SDMQAlXTnEJ45defqMxzg==
X-Google-Smtp-Source: ABdhPJwa46Us3wHYYSr0ONkDt1/Lh9eiUxhsr1ZsKiLr3JmDuuGMc1pOtxqL1wTt/5d6h+mUYelV3g==
X-Received: by 2002:a05:600c:ad7:: with SMTP id c23mr9377621wmr.85.1634263537157;
        Thu, 14 Oct 2021 19:05:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p18sm3742990wrn.41.2021.10.14.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 19:05:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] git(1) doc + "git help": split-out user & git format docs
Date:   Fri, 15 Oct 2021 04:05:18 +0200
Message-Id: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series goes on top of tz/doc-link-to-bundle-format-fix (and my
newly-landed ab/help-config-vars) and creates new "User-facing file
formats" and "Git file and wire formats" sections in the main git
manual page.

My main motivation here was to make the Documentation/technical/* docs
more discoverable and accessible.

2/2 moves over the "bundle-format.txt" into a new gitformat-bundle(5)
manual page, allowing git-bundle(1) to link to it as another man page
(no more links from man pages to generated HTML!).

I've got pending patches to migrate all of the rest of the relevant
"format" documentation in Documentation/technical/*, but setting up
the infrastructure for that first should be easier for reviewers to
consider.

Ævar Arnfjörð Bjarmason (2):
  git(1) docs: split "User-facing file formats" off from "Guides"
  git(1) docs: create a "Git file and wire formats" section

 Documentation/Makefile                        |  4 +-
 Documentation/git-bundle.txt                  | 12 +++--
 Documentation/git-help.txt                    | 11 +++--
 Documentation/git.txt                         | 15 +++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++++---
 Documentation/lint-man-section-order.perl     |  3 ++
 Makefile                                      |  1 +
 builtin/help.c                                | 16 +++++++
 command-list.txt                              | 21 ++++++---
 help.c                                        | 22 ++++++++++
 help.h                                        |  2 +
 t/t0012-help.sh                               | 16 ++++++-
 12 files changed, 145 insertions(+), 22 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (78%)

-- 
2.33.1.1338.g20da966911a

