Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C4C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2A60EBA
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhIEXwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIEXwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:52:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C6C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 16:51:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so7136200wrn.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=E+bWvzwhdMK33AQOBxK8/ha0gW74kHhrfNOHEKoWU+Q=;
        b=NSNcTpyzBPA78gtSzCfzYpdCvtYenCd0XziUBT+bNOISSkGqwo07gpbgFBgpSQg8IG
         KGYhBU5EPlbwzQX+9KF3OnNtk7ZPszlOOep2HvYL6ozDz5kbaPnTA9bRJiy8ZEfp0rKc
         r7GVf6waVayL38DafCJk6kdVN2kipy9lBXFdTO0NjK7xL1QzeC0qMb6623ln2upNRony
         pD1UGFkvQSln+w4RrAfvExgHhKYMMaA9icAAT0bMaF0I1yYx7Yq92bAGWP042GyCJKHu
         UAFB8GkNc9cQeKr2BdesBecbyN1E6ZFR8HcW7grknwhJ4DBPdGinSaOuZsE/kRlkgf2V
         YNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E+bWvzwhdMK33AQOBxK8/ha0gW74kHhrfNOHEKoWU+Q=;
        b=PZuAgVbdRqifQ1I9dP3iWkJjEQGVAAcX5jiB8Fvp6XypYs6VNqvMR1Dvls64VnvpxD
         r6WXbFoCz9WDkExAq0pN6qBScaBbozigkLnZ5LbM/jg3wyMpa2NJQqhndIl9lYsrpOOM
         /KrJIXTfhvVFXpMC9lwkLJqU5+U4Z3qlC3Q1xQOjOahJ8dnN9dIZ+Ihh9eHFBkavygRh
         XOc0bHW8uU7rxEXp+SckC6f+Y+8+DIcheOTfjrIerCouoZLdw93EyQagkN+jw1PE/mTt
         YA5E6Mb7bswYNvPnP+MtzyrwcNQHi7dLQ2EKnNZjprwA8Y1cTF+id8c3vkhdZEqxqSck
         M3lQ==
X-Gm-Message-State: AOAM530J1/vEjS2CbX4nh4Cvkls12r36I3VHoTO/pRmxoFKilHZJ0URQ
        tQCtlYm2UHnBjBPMBGpVARSuE7QrJAc=
X-Google-Smtp-Source: ABdhPJzjHnnKn8b4RSeK8BcHi34iE0kYwmb2xJWkusLxBDB2oBdp/oQtMDB+26/1yWRtWREQ3wFR3w==
X-Received: by 2002:adf:f450:: with SMTP id f16mr10133629wrp.35.1630885900681;
        Sun, 05 Sep 2021 16:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25sm6450512wrd.42.2021.09.05.16.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 16:51:40 -0700 (PDT)
Message-Id: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   "Andrew Olsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Sep 2021 23:51:35 +0000
Subject: [PATCH 0/4] Compile-time extensions for list-object-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds an extension: option to list-object-filters, these are implemented by
static libraries that must be compiled into Git. The Makefile argument
FILTER_EXTENSIONS makes it easier to compile these extensions into a custom
build of Git. When no custom filter-extensions are supplied, Git works as
normal.

Andrew Olsen (4):
  Compile-time extensions for list-object-filter
  Makefile for list-object-filter extensions
  Sample list-object-filter extensions
  Documentation for list-object-filter extensions

 .gitignore                                    |   1 +
 Documentation/config/uploadpack.txt           |   7 +-
 Documentation/rev-list-options.txt            |   4 +
 Makefile                                      |  35 +++-
 compat/vcbuild/README                         |   5 +-
 config.mak.uname                              |   6 +-
 contrib/buildsystems/CMakeLists.txt           |   7 +
 contrib/filter-extensions/README.txt          | 153 ++++++++++++++++++
 contrib/filter-extensions/rand/.gitignore     |   2 +
 contrib/filter-extensions/rand/Makefile       |  28 ++++
 contrib/filter-extensions/rand/rand.c         | 103 ++++++++++++
 contrib/filter-extensions/rand_cpp/.gitignore |   2 +
 contrib/filter-extensions/rand_cpp/Makefile   |  34 ++++
 .../rand_cpp/adapter_functions.c              |   6 +
 .../rand_cpp/adapter_functions.h              |  10 ++
 contrib/filter-extensions/rand_cpp/rand.cpp   | 103 ++++++++++++
 generate-list-objects-filter-extensions.sh    |  53 ++++++
 list-objects-filter-extensions.h              | 107 ++++++++++++
 list-objects-filter-options.c                 |  47 ++++++
 list-objects-filter-options.h                 |   6 +
 list-objects-filter.c                         |  84 ++++++++++
 21 files changed, 793 insertions(+), 10 deletions(-)
 create mode 100644 contrib/filter-extensions/README.txt
 create mode 100644 contrib/filter-extensions/rand/.gitignore
 create mode 100644 contrib/filter-extensions/rand/Makefile
 create mode 100644 contrib/filter-extensions/rand/rand.c
 create mode 100644 contrib/filter-extensions/rand_cpp/.gitignore
 create mode 100644 contrib/filter-extensions/rand_cpp/Makefile
 create mode 100644 contrib/filter-extensions/rand_cpp/adapter_functions.c
 create mode 100644 contrib/filter-extensions/rand_cpp/adapter_functions.h
 create mode 100644 contrib/filter-extensions/rand_cpp/rand.cpp
 create mode 100755 generate-list-objects-filter-extensions.sh
 create mode 100644 list-objects-filter-extensions.h


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1031%2Fkoordinates%2Flist-objects-filter-extensions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1031/koordinates/list-objects-filter-extensions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1031
-- 
gitgitgadget
