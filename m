Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829FFC433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BCF2224B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkAZeFfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393582AbgJTLn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392769AbgJTLnz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 07:43:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3330AC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:43:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so883317plr.9
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njxmNop5c/A5cfyWFc2DZAsc9ESxKED4rbrIY+qXNT8=;
        b=HkAZeFfKTuTq2cuGKZ/sv9QzQ1cqBsz+hDQtrB80d6as2NzqYINkluP7DKUgWvLFD2
         zlyM8HsK3ftSmT/y6+39OYF7hvxL3i6UFowBvuoy96w0rl6QMUldPd4GgTyoOEAX21jI
         1SrahWUQxu6SYrOkyducjQIsiDOHSRjFD3TuG2ZS9C2BT9+UzRwNpksCdYKoetYFsIOX
         NLtlnYPB7KU5/77NaUhF/pP1mQPGttuBYdjoYR7Uel8NZw5JjPh1yZM1c1exSR3UpxS4
         TkhhUasCJ65v6sQqSZh72niZANZBW2uPQnf2ZE5jPjmHazv4/cN45bD/uv9srnBtXFY4
         yPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njxmNop5c/A5cfyWFc2DZAsc9ESxKED4rbrIY+qXNT8=;
        b=awMmHKgXQwJjFOiKsuSQPivTNaw1DwiUrgf2DeuV6X+TLQlFA6CziIIP92JIYxwyuD
         PwhQK7DXi66XG0GNDomgd8HVpdSJyHSibI/ujnhZDHMcqC0n1N/l0HzO4/UjajENcR33
         mSiw2wPU3o+RDC+eu+AtmjJyWKQBd2YS+gRLSnTXVBsyegG5u204tmYyP3wQbSFQml92
         //DmaQmqfC0fhGXe0Pipoy04A/Ioja/PCXTB6bVmSLyIKpERRSVwwe0srjmZUGWhVh/U
         3mdSZCWQbWxZ0cDkFAU3P+cgD446Iue+kFXPUzJ4ub8oMmRK4a0sZEQQZZmO/lCL9gEB
         rbvA==
X-Gm-Message-State: AOAM530jHn8z8lKN+ZaHchVMBtbCQImU5GbG4Gh8cEWhMoVz3yf5mc/M
        wt/EjwBlTSvdTc7v1dO8NHYrAxPMh3BiZdhA
X-Google-Smtp-Source: ABdhPJxPUsybe4r3uGvLUtnklydpDW3WoKJBHukRZr2RgCRV9iVCAd9i0FkvpBEnOWeP2Ubaakelqw==
X-Received: by 2002:a17:90b:1644:: with SMTP id il4mr2344385pjb.151.1603194233447;
        Tue, 20 Oct 2020 04:43:53 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.gmail.com with ESMTPSA id y22sm2204615pfr.62.2020.10.20.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 04:43:53 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 0/5][Outreachy] modernize the test scripts 
Date:   Tue, 20 Oct 2020 17:13:14 +0530
Message-Id: <20201020114319.18245-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thanks to the community for reviewing my patches, in this patch 
series I have updated my commits messages and body as suggested 
by the community.  

This patch series :
 -modernize the three test scripts : t7101, t7201 and t7102.
 - cleans up with 5 types of changes in all the three scripts.
   1. Converting the old style test format to new one
   2. Removing blankspaces in test bodies
   3. Removing whitespaces after the redirect operator, according to
      CodingGuidelines 
   4. Using 'git -C' to avoid use of another subshell 
   5. Placing commands in separate lines

Charvi Mendiratta (5):
  t7101,t7102,t7201: modernize test formatting
  t7102,t7201: remove unnecessary blank spaces in test body
  t7102,t7201: remove whitespace after redirect operator
  t7201: use 'git -C' to avoid subshell
  t7201: put each command on a seperate line

 t/t7101-reset-empty-subdirs.sh |  66 ++++++++++-----------
 t/t7102-reset.sh               |  63 ++++++++------------
 t/t7201-co.sh                  | 102 +++++++++++++--------------------
 3 files changed, 96 insertions(+), 135 deletions(-)

-- 
2.29.0.rc1

