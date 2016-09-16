Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE51207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934485AbcIPRha (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:37:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33184 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759216AbcIPRh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:37:28 -0400
Received: by mail-pa0-f45.google.com with SMTP id cm16so27987887pac.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erZHtlc7V8fxWm8ZMftsIv6eatklt32xyCKKCY0uw1k=;
        b=S3XwKBr2beqVVCZZrVqiR6kPFpp+aXuMo93fqSUTnmN/frzBbdDQmhetetKl0gubXC
         c5J5qewqmYAbpuw6r4EB+u2gYuPzUPOZWGcg2YVfuxTztCOOfTey65BxTC2GsFmHlixX
         eb6qstcYTH4DxMr24eRMHcWz22wl79pMCFUbZArzukDShotjeTa77Aqlv7o8CP8913LL
         9BV+ybfdor17y1NVJ56Usj7ALjMhmhomhaBZ948u4o3TqmYTdofd6A6SWoZ/L+FnH9YS
         PV6msbWpvNPreSVxqf7vi7iFzRR3+2syM6gnifky2nRA0OBOWO6x4lJ0lPG52qRxTizV
         I1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erZHtlc7V8fxWm8ZMftsIv6eatklt32xyCKKCY0uw1k=;
        b=M6/CdhZ670wWVeI/Pr90JUHzimgmB2ohaZvVE2my67fSZQUBtVWmB3lRtEHGg57bL0
         BaQWVITcixPMAZT1vbdDc/Q3ueT2cEhajL1WaHBVeabLBLBV9iKB2bnIBBMDd50fAlBS
         Wu/XSL3f/ajA7qWS8fBAUZJLincy6OtP1TXoU8w5P84fleQ/yt/iVM1ZK5npdYcTRSJn
         RuCwke23jLfZe6g2tC5wMVYQnohhDWlh7M5LItWH+92ecB4T6Od4ezBegnia9igg6xSm
         CqDyhh2Gtp9IgDIa06o5vMFliKWWYLoftmLevF0MUeVW3yA797ZKboNuAoiqQXo0qDGl
         1tQA==
X-Gm-Message-State: AE9vXwNdza0FLsinYOtx3xyZI/qWyBFdJjHvHxhROwHAtAY7vFy9pal1renICb3MOBFbU5gZ
X-Received: by 10.66.249.164 with SMTP id yv4mr24971940pac.89.1474047448081;
        Fri, 16 Sep 2016 10:37:28 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id m128sm53664348pfm.42.2016.09.16.10.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Sep 2016 10:37:26 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [RFC/PATCH 0/3] handle multiline in-body headers
Date:   Fri, 16 Sep 2016 10:37:21 -0700
Message-Id: <cover.1474047135.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff, for the explanation and the method to reproduce the issue.

The issue seems to be in mailinfo.c - this patch set addresses that, and I have
also included a test for "git am" in t/t4150-am.sh to show the effect of this
patch set on that command.

Jonathan Tan (3):
  mailinfo: refactor commit message processing
  mailinfo: correct malformed test example
  mailinfo: handle in-body header continuations

 mailinfo.c                           | 165 ++++++++++++++++++++++++++++-------
 mailinfo.h                           |   1 +
 t/t4150-am.sh                        |  23 +++++
 t/t5100-mailinfo.sh                  |   4 +-
 t/t5100/info0008--no-inbody-headers  |   5 ++
 t/t5100/info0018                     |   5 ++
 t/t5100/msg0008--no-inbody-headers   |   6 ++
 t/t5100/msg0015--no-inbody-headers   |   1 +
 t/t5100/msg0018                      |   2 +
 t/t5100/patch0008--no-inbody-headers |   0
 t/t5100/patch0018                    |   6 ++
 t/t5100/sample.mbox                  |  20 +++++
 12 files changed, 206 insertions(+), 32 deletions(-)
 create mode 100644 t/t5100/info0008--no-inbody-headers
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/msg0008--no-inbody-headers
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/patch0008--no-inbody-headers
 create mode 100644 t/t5100/patch0018

-- 
2.10.0.rc2.20.g5b18e70

