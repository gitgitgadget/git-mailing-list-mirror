Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B884C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E4222207
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Obc7iOvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIKS6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKS6N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:58:13 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D3C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:58:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h6so8688422qtd.6
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vspfcz6JSV885bGYVU307h60pvKEhzTFhEq23yQZ1ss=;
        b=Obc7iOvu6RADSjFFiJTR99rc+egvL0IPB2EGBdtvPimJXt+VrbYkrm56ovf6ko1lWo
         Fg9rXx7Z7ncpjQKmgo6zo11ze3vyzxno9qJDOMpFRkkKSDehS/HgpeEstjNr5byjswGI
         Povd86c/tJooSRIoXGj3suP3rDTZ8b45vtwyjn8fOZsVjKnbFxr3Lp9iPHO2MDVurpY1
         t+NM9RQIk0vX0VA6/qboIqBd5Bbqt84T07J8DgagU+PtlAHOGEZRgYzlK4UgjYnvP4kM
         uMqZb6wewqIQAdEISUfNVHD09OSWvVF3q9T0ilF9CrKbzOWVj59HT2v1/Qo1QtGODPrd
         CtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vspfcz6JSV885bGYVU307h60pvKEhzTFhEq23yQZ1ss=;
        b=Set8QptDVKtAJhkHaEtC/I8/VJJZo4IL/DEBLC18q7cSkjm20eRZeEwbj1iTKd16hb
         Trqg6JHY+NrOCC72a8RLPA3LDasM/u8QXe8sX+dYVQXrcy8KuMHcdLiY3CRQwGpshzU5
         Kc7nvlf1aa97h8uBJQcFP81YraHzMshnKzVzBDS9f/YVYK5LV19v82/oNopU70lKT2hk
         aCJ/FD8npK2kliv4lMFKv8S56C4Vekn6o0fDxS54zYkvIAIWAm7jP0beYN8rEU6N7/bb
         iIgD2ngnn9ephUdxEfU4yQHlV65a55in3t4OXg2sJVzWvXLKdBFaidILw+HKXwtwf5Xs
         q6Pw==
X-Gm-Message-State: AOAM530HsF7Q8x2cUul2XoP3KS5KF06opX0CkKUANlU9UIhORJyIDfe8
        nb2Bx+aDR8TTC/zOPNLx380xgcCKZs1pAQ==
X-Google-Smtp-Source: ABdhPJxk8Uln/Q5FsN9a3/aLBQPq0qSgFfNrVstq4HMmKn2RCdLlvw93GghnvK6MD9p5TyfbI9kPQg==
X-Received: by 2002:ac8:4b6f:: with SMTP id g15mr3250068qts.328.1599850691488;
        Fri, 11 Sep 2020 11:58:11 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id u46sm2181008qth.31.2020.09.11.11.58.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:58:10 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] git branch: allow combining merged and no-merged filters
Date:   Fri, 11 Sep 2020 14:57:52 -0400
Message-Id: <20200911185754.64173-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200908153759.36504-1-alipman88@gmail.com>
References: <20200908153759.36504-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable ref-filter to process multiple merged and no-merged filters,
and extend functionality to git branch, git tag and git
for-each-ref. This provides an easy way to check for branches that
are "graduation candidates:"

$ git branch --merged next --no-merged master

Currently, this required a command like:

$ grep -xf \
  <(git branch --merged next) \
  <(git branch --no-merged master)

Also, add tests describing git branch's behavior when combining
multiple contains/no-contains filters - this helps demonstrate
consistency between merged/no-merged and contains/no-contains.

Aaron Lipman (2):
  t3201: test multiple branch filter combinations
  ref-filter: allow merged and no-merged filters

 Documentation/git-branch.txt       |  6 +--
 Documentation/git-for-each-ref.txt |  6 +--
 Documentation/git-tag.txt          |  4 +-
 builtin/branch.c                   |  4 +-
 builtin/tag.c                      |  6 +--
 ref-filter.c                       | 71 ++++++++++++++++--------------
 ref-filter.h                       |  9 +---
 t/t3200-branch.sh                  |  4 +-
 t/t3201-branch-contains.sh         | 69 +++++++++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh     |  4 +-
 t/t7004-tag.sh                     |  2 +-
 11 files changed, 122 insertions(+), 63 deletions(-)

-- 
2.24.3 (Apple Git-128)

