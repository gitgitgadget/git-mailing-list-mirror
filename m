Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9338C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD8520705
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzwCW4m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEDPtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDPtq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 11:49:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D13C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 08:49:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so3937531pjb.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tg12+j1snV7bTvIXysI8HQaucZdwxkLLjpmlBE00j+4=;
        b=HzwCW4m2U+yNlLcD1UUsiN92C1Xef/8JHSYdiGPKBqwm1/0c5fGoSRs/vzJfszRovM
         C/D9XKQl76Fs7voFOE/PSLCWPm0iKOIbFZEGbQq24Aw6qx62drBQJUhKV4+TXhB0Rlzk
         Qf8IfgSr8KkxKh4FCsLAhUGewukVPvHWaqrWAR9z5T1whuNKvzgijHogJEw4exTATtzF
         xnzjFSjg/Qw/VEWfchzrs0JNuLuGgS5aAtqBT6x8CHSadq4B2yuZVvGtA2vylKSmsSaP
         lYBzXTEj4wSFBHo8trjsflm06Rzthz6LNlHfa2wqgoQbPr7LC3Jj8txc/UZPifH5S+WK
         JZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tg12+j1snV7bTvIXysI8HQaucZdwxkLLjpmlBE00j+4=;
        b=svVvTro6ETsxkgUN8d1xMXHPuSOK/hMd02nv0p5hlknOazH61NlYTtlt/jkecU7SdP
         2q96HGWMlDSUVDfg5DBfRSyldt02O7+tvFFARdMRmd+4yVSi2BJ+MbRFRCsmo2LCyIPh
         kuj3lD07VdfpNOITuGfLrC4+jI5tkhY9FqZxuYKkHJXrmnKZdaDrUR/1hqaGEcLPEp/2
         E3FavL/9YMhx0Vu/LUjOMZLEDlnSdW18FkEAtGakz413l1mH+knr6bmJCv3YTPOpERoc
         C56+CL0JsNXEfB1IXkrYY13DR499WKryS/zrHg0uly+9qCh9jpo3sbWcefD0tvKnFXEZ
         +MFQ==
X-Gm-Message-State: AGi0PuaX2+14ldipJ77hkaCantA3/R4YDehXvbmWWNhjkuheqnJ5D50k
        9PG5P9eqB8l0R55eAeu96oatlc28
X-Google-Smtp-Source: APiQypI5/B9l3pdw5LWvfRsGi/6EL68P2m4H9LepSK5Q3KPw7WnG7gUYvNouDArWdjCWaNwYZv3fow==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6mr17771984pls.318.1588607384397;
        Mon, 04 May 2020 08:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id x63sm9319513pfc.56.2020.05.04.08.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 08:49:43 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] Limit GitHub Actions to designated branches
Date:   Mon,  4 May 2020 22:49:30 +0700
Message-Id: <cover.1588607262.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <20200504150105.GB11373@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like there's at least one contributor like this proposal.

> Yeah, this seems quite reasonable to me. I'd just add a refspec to push
> a duplicate of branches I'm interested in running CI on to for-ci.

I've tweaked the commit message for the proposal and added a new patch to
advertise GitHub Actions to our friends.

With this series applied, we will trigger GitHub Actions CI for those branches
only:

- 5 integration branches: maint, master, next, jch, and pu
- Contributors' opted-in branches: 'for-ci/**'


Đoàn Trần Công Danh (2):
  CI: limit GitHub Actions to designated branches
  SubmittingPatches: advertise GitHub Actions CI

 .github/workflows/main.yml      | 14 +++++++++++++-
 Documentation/SubmittingPatches |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  106620b2d8 ! 1:  73de97dfeb CI: GitHub: limit GitHub Action to intergration branches
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    CI: GitHub: limit GitHub Action to intergration branches
    +    CI: limit GitHub Actions to designated branches
    +
    +    Git's maintainer usually don't have enough time to debug the failure of
    +    invidual feature branch, they usually want to look at intergration
    +    branches.
    +
    +    Contributors now can have GitHub Actions as an opt-in option,
    +    should they want to check their code, they will push into designated
    +    branch.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ .github/workflows/main.yml
     +on:
     +  pull_request:
     +    branches:
    -+      - '*'
    ++      - '**'
     +  push:
     +    branches:
     +      - maint
-:  ---------- > 2:  24a8fefe5a SubmittingPatches: advertise GitHub Actions CI
-- 
2.26.2.672.g232c24e857

