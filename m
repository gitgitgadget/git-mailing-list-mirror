Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4853C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0670613B6
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhDMJI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhDMJIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:08:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C1C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w23so8910244ejb.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knI/JXiPkayzB89rmJ905kOX0W5mVDLDTwrEGwMQ7Rs=;
        b=eUlb16sjR8IOVuV9lMvL1PpTm7Mmfu8Wmu7fvO6hIeaCJ7Jhd0MHKIuIoT4ppjewlc
         /5HwuhOM1kJL0LU504V97kEH8vkTNd5nzYpU91/8SqR02EYjZBSVhMVhfhekU23hbXiM
         t33j0Y/yd6JslhXi2lPSSMD1WXAcDYPJyew19txaUTOeMPjSbSZGigczjJ9kYAlF3qvH
         rmITQPDJO82yqCJfqyxDyH7DOVGIDPLctbsORCd5YHjwto+xHHMEM+yLNvmorW5upIvD
         3otZEiCbDe1epP01RRhIhKemnbFigRvkCs0ZRnVcb7kHhzk9nLGiwP3b0QvmKEq98QaL
         rEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knI/JXiPkayzB89rmJ905kOX0W5mVDLDTwrEGwMQ7Rs=;
        b=J57NDAtxkVwIfnuiK0TFyPeCq6CFcEMwwEVqIgjONK8nLoOSY7F6C1NWE1IwgkYUoB
         doYhH1XJKo/DEWM+M2EziuC7tH0Iy9wzNMGLRXp/hyeJjeR0oTTh2bXo0po85h95VO2v
         8SMEQ3ky3v23H9kIDumD94Nw7BEjCldWh1+/D8GxCLzlyyo04fP4FpAg3phZ2z1Zn6Jk
         yH2quEF3APNdglCwBLtLlp5Pd/vF78FKDO+Dq/5pmejhYLe3zF6MU/YsEfWS3zUPk0Vh
         NC9wesQV3gf7ez1YDS18umonY9phD2rIh0DrdLeqD5v2fguFZr5UdFcQTWsnYuAdmOgg
         rYkw==
X-Gm-Message-State: AOAM530T0AN9EFVYkZtfPaUQTbCO7/jv70/lGts/J8mQFo8iz0zQOYEX
        YMvWVqaxClvZjbbrhOQJaJf5n9RV5Rws5g==
X-Google-Smtp-Source: ABdhPJyGtdYEel3a/wbz/P4/FK2L6FW8FzAdRFWmo+Z+bv/3Ui0EpLg049jWZ6dVD0brRgnbBK5wjQ==
X-Received: by 2002:a17:907:98ae:: with SMTP id ju14mr3734814ejc.287.1618304910525;
        Tue, 13 Apr 2021 02:08:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 28sm8918318edw.82.2021.04.13.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:08:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] trace2 docs: note that BUG() sends an "error" event
Date:   Tue, 13 Apr 2021 11:08:18 +0200
Message-Id: <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial update to the trace2 docs to fix an omission
with "BUG()" not being listed alongside error(), die() etc.

v1 of this[1] added a non-fatal-but-logging bug() function, per the
discussion on v1 that's now gone.

1. http://lore.kernel.org/git/cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (3):
  usage.c: don't copy/paste the same comment three times
  api docs: document BUG() in api-error-handling.txt
  api docs: document that BUG() emits a trace2 error event

 Documentation/technical/api-error-handling.txt | 10 ++++++++--
 Documentation/technical/api-trace2.txt         |  2 +-
 usage.c                                        | 17 +++++------------
 3 files changed, 14 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  a7b329c21cf ! 1:  2e4665b625b usage.c: don't copy/paste the same comment three times
    @@ Metadata
      ## Commit message ##
         usage.c: don't copy/paste the same comment three times
     
    -    In gee4512ed481 (trace2: create new combined trace facility,
    +    In ee4512ed481 (trace2: create new combined trace facility,
         2019-02-22) we started with two copies of this comment,
         0ee10fd1296 (usage: add trace2 entry upon warning(), 2020-11-23) added
         a third. Let's instead add an earlier comment that applies to all
2:  8c8b1dfd184 = 2:  ce78c79c9ac api docs: document BUG() in api-error-handling.txt
3:  f0e0d0daa6e = 3:  982f72345f1 api docs: document that BUG() emits a trace2 error event
4:  515d146cac8 < -:  ----------- usage.c: add a non-fatal bug() function to go with BUG()
-- 
2.31.1.645.g989d83ea6a6

