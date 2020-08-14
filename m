Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BAC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D579214F1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO8c6SQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHNMWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0DC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s9so4715679lfs.4
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZF/3L/cZUEESEYGxaPF6dOQvJ17EYN+1uBmRO7+NdNI=;
        b=AO8c6SQJYXSxqJmxbvQQhRqJHjg9BAij6BMl9CJ8yr/OBcGkXhQaf9Ez99plPUC0bA
         Z+KjxNLqGjVJWgErVaKAExhmst6l0BMBeAhLYBksu3iNt6b51SgEBMaQlvvnfPE0Q0Nl
         JsNPL1OL1UNHLIJmrNU08HT0GOfDzqwiKvnIXfJLIZWow5yTDQNDnWQQDFlB+RRnGb0i
         joOSbWWD3OyOAxpwtLDepibsfBZAs/pH6fRkjIB4rvxhWmQO8WoGmJwy47a6Wy303a+B
         CY4MDrqwDPUJVIgOgp2a4mEGd2jzATYmRTSXYhinRikOQJMa/ojX6w6zS9DI/4mBU0T1
         y5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZF/3L/cZUEESEYGxaPF6dOQvJ17EYN+1uBmRO7+NdNI=;
        b=uFXqSjm0N/vvt1mrMmRViPg4xYzFJvs2vFxNsVU13hnKpHHb+txPkfy6hx2GdgDPAV
         X2EBwQCX8jnF61edCkwXLvxxQmrj9QS/pcBQRXpaqKeHVQS9uOSLPA5XRTNLIK/NSH6f
         kefSrvuS1l/o189BhSUNVTUSVT3S7HyGj9pZ0hQVvVmhNy5FWsq+SRbnHjxY6DO8yPH8
         bbIFtvQwPCXMJ3FomBp9kEBfLKyn9oDKbbIL7yHponk9JuVOBaRo2CJgXYnnoM/yCLah
         AtKeIfLXTFBItJ/eEHcPj9FbztJcFDaz+oyDYT6j9UY/PCnus4N69iMgfxIz+H33WbhH
         A/FQ==
X-Gm-Message-State: AOAM531iWpb0bc1Ykz2s2vPGnSd073IHMIP7URF5WLT9cyA09AgjE04D
        FfoGXQ/CYun7gXUn6xGNY4jV/hj4uUA=
X-Google-Smtp-Source: ABdhPJzmmyFncsLJyFmjcnspmFBrlqEGD2VSirW6WEaJyS1zsRwfyxYPljSXh4Nz5N2bwM1Ej5Jj9A==
X-Received: by 2002:a05:6512:3af:: with SMTP id v15mr1110129lfp.79.1597407731706;
        Fri, 14 Aug 2020 05:22:11 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:22:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] commit-graph-format.txt: fix "Hash Version" description
Date:   Fri, 14 Aug 2020 14:21:46 +0200
Message-Id: <bbcd97db8a2c94343950bb0cf8cbd5c9c01b4577.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We say that value 1 means "SHA-1", but in fact, it means "whatever
the_hash_algo is", see commit c166599862 ("commit-graph: convert to
using the_hash_algo", 2018-11-14).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 If we want to be more fine-grained in the future, we'll need to say,
 e.g., "2 means SHA-1, 3 means SHA-256" or, perhaps preferrably, bump the
 version number.

 I wonder: Should we instead say "1 means SHA-1, 2 means SHA-256"? It
 could be implemented as "easily" as "if (value_from_header !=
 value_from_the_hash_algo) die(...);" for now. Might that pay off in the
 long run?

 This relates to Stolee's "in a vacuum" comment [1] ... so maybe we're
 fine.

 [1] https://lore.kernel.org/git/da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com/

 Documentation/technical/commit-graph-format.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 440541045d..3535426d32 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -42,8 +42,8 @@ HEADER:
   1-byte version number:
       Currently, the only valid version is 1.
 
-  1-byte Hash Version (1 = SHA-1)
-      We infer the hash length (H) from this value.
+  1-byte Hash Version (1 = SHA-1 in SHA-1 repo, SHA-256 in SHA-256 repo)
+      We infer the hash length (H) from the hash algo derived from this value.
 
   1-byte number (C) of "chunks"
 
-- 
2.28.0.277.g9b3c35fffd

