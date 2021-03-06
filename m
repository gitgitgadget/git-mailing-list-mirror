Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F2C432C3
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF565023
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCFLFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCFLFD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771CC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u16so5233988wrt.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sy7XlJ9JgWcfbOqMqk37pw+XFJpHNa2w+LfOgCD62nk=;
        b=Aq1WsRlaryvF9VHhbIQ49/+fMMEoAC8/YbiO1kiQMx4IXJo43JRSinrfzg6PhxA/eo
         L/fwqnx8drnlmYyhIVBlAx1jnyEdJdMOpQPWcuEwdZuQ9Tu20kGAN+r2398UXxvM5EgI
         BR29sAjcfO6bCghiGrD1zghkpyD2cHPSPF9ZpCNMgq7/xSvMbk/dxyGCwCAf0fcM3SN9
         OcJFalo8dKDnQnssSeBNOn0zJr1Bt8kJBUvGYPgDtvAtJRTc3RaPVciDU6RCFUDePMNG
         e6IuvDq+ld7Hc0LuEw08s/MQxS5jV68R6tC/daYwNvVu5QPUW4z80OXA5S+/Wtw7mvgL
         qDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy7XlJ9JgWcfbOqMqk37pw+XFJpHNa2w+LfOgCD62nk=;
        b=Sa2qB7fB/053FfNCVHccijNuvRiJKNsS/cK5zPK/69caS+8v0o0DFydrVZxHVQY9Vy
         2YO65D148NMNDPNp5wHLhx4raPxbv5aTWe7HFQWHFvx6qd+xV/mpcVZ9WCCZGzqa0nTT
         SvPCOyZGZqKN9oumFvZ4QAI/BjarnxdK1MOUXLAI+4gsSiujtCt48kahYAPEA/vBslya
         dCK/MLfqFuK3FpPU4EUV/Y71cYeQhy91t+LOQVKfE7giKHaepsYcO+QoYqBHYwsGWNd1
         tz5OQRQE8CBCwjz211oAW6MNsjEAft3Q54Tj74pmFchkny02ZwbKGB4wrB0/W1Tsr/ua
         TNRQ==
X-Gm-Message-State: AOAM533XCuTLhDqGw5ZmcWDv27i/Ofbaa2AFY8vFJgGC/0BUXu2XEgSh
        J8iwOWU3vGQOuts9iu5MYqCGbErh4FSVXg==
X-Google-Smtp-Source: ABdhPJwoq24bupWLIblatoVfbLXyru1KcnKPPgOX+G/t118iGQOL0P3dqpbEavIuqybYwbR6ekNVSw==
X-Received: by 2002:adf:f3c2:: with SMTP id g2mr13924519wrp.300.1615028702036;
        Sat, 06 Mar 2021 03:05:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/22] fsck.h: re-order and re-assign "enum fsck_msg_type"
Date:   Sat,  6 Mar 2021 12:04:29 +0100
Message-Id: <20210306110439.27694-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the values in the "enum fsck_msg_type" from being manually
assigned to using default C enum values.

This means we end up with a FSCK_IGNORE=0, which was previously
defined as "2".

I'm confident that nothing relies on these values, we always compare
them explicitly. Let's not omit "0" so it won't be assumed that we're
using these as a boolean somewhere.

This also allows us to re-structure the fields to mark which are
"private" v.s. "public". See the preceding commit for a rationale for
not simply splitting these into two enums, namely that this is used
for both the private and public fsck API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fsck.h b/fsck.h
index 2ecc15eee77..fce9981a0cb 100644
--- a/fsck.h
+++ b/fsck.h
@@ -4,11 +4,13 @@
 #include "oidset.h"
 
 enum fsck_msg_type {
-	FSCK_INFO  = -2,
-	FSCK_FATAL = -1,
-	FSCK_ERROR = 1,
+	/* for internal use only */
+	FSCK_IGNORE,
+	FSCK_INFO,
+	FSCK_FATAL,
+	/* "public", fed to e.g. error_func callbacks */
+	FSCK_ERROR,
 	FSCK_WARN,
-	FSCK_IGNORE
 };
 
 struct fsck_options;
-- 
2.31.0.rc0.126.g04f22c5b82

