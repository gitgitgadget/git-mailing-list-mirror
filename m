Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520471F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeH3A5r (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:57:47 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:44809 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3A5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:57:47 -0400
Received: by mail-yw1-f74.google.com with SMTP id w23-v6so3104105ywg.11
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pEW/vUp/fQeWpaJddpS0JvJmi803pBimC2lSQc1e1o8=;
        b=aYVSBmYRHXpGY3/1Z140WzzLvBK1D/nuntrTfMwIcAO10jyvB46ORqy3BIsKqwqhAh
         /ULXuKd4cC7Sk+cnUKdsv8xY2Psa3/45Z0bTvT6jiOrmeYQosnAWPWaqOvtMrvISEqoM
         BEmXGdbV40lKypjcDc/kPOPb7XQj9TKil9oqiksyg4NHh+Szh55YNndWmAGQ8T1RkqfT
         gwbHjGB3S3k6Aw2jRGAZmbMUAZJ0kMXNhEjyWHGTQjqdudM91CyMpWechUxR8B8RfnGO
         klkz1pR3gefbJdmHV8qIQs2oklRKLBdUQRuCsfuxvwMXHp/BB02kLV4O6IXWlY1Kzlm+
         K13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pEW/vUp/fQeWpaJddpS0JvJmi803pBimC2lSQc1e1o8=;
        b=eV0AQ2Fa8bJi4wKhVtTw4KdmRbKOby6JF5RcXteCp+c9qC6W0f5XX8inU4DQx3pAAC
         ILx5ayOmUTRdAT7zAhSCEIGIKXPHwhTaSsZrYq+HCOofjIZ7oMB/pmNk8dDD2IC2rxyG
         mWnxhzspE1aBoz9uhDXEbE+aYPGUplZgNuXB7spvBv+oXvw5Eo/oyRleT6mGzDvaKRz7
         SuQU5Ku8HBkCBUNywONxm++kupruvsVcqLBYrRXnPllDfiJhVY65fH9wBIjQb7fQSnGD
         bmVdAJ7q+aOYyGiqhyu/18veiyLQ5d7mAXhX3IwGdnh6mhqrCnwJ2ce2O3wonhnrGV8M
         7JqQ==
X-Gm-Message-State: APzg51BQtswxMmuhD+45TX68wTzRA+ph4ypskNvVDHpB5Q0qicBV22M3
        x3lFYLVFUut6/ifI4HCSpghj5vW85SZiKKEn6nxI4LZMUBGyh+u6dc4eT6D4asQvD5K2QdC0pXw
        DO303k7cQ4bN6Iw5vCXYvLBjoPkUJM2/TsHnH9PwsS1ayogyr7Q0bTok=
X-Google-Smtp-Source: ANB0VdZUG/WvJL3HY0FwYWvynULXUc4TFkYdcCRhKR9oMVheTIgNOFYuLR6RaCl2hemcHb9ckTVzA6wfZA==
X-Received: by 2002:a25:dd04:: with SMTP id u4-v6mr2265447ybg.76.1535576348131;
 Wed, 29 Aug 2018 13:59:08 -0700 (PDT)
Date:   Wed, 29 Aug 2018 22:58:57 +0200
In-Reply-To: <20180829205857.77340-1-jannh@google.com>
Message-Id: <20180829205857.77340-3-jannh@google.com>
Mime-Version: 1.0
References: <20180829205857.77340-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 3/3] t5303: add tests for corrupted deltas
From:   Jann Horn <jannh@google.com>
To:     git@vger.kernel.org, jannh@google.com
Cc:     gitster@pobox.com,
        "=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?=" 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This verifies the changes from commit "patch-delta: fix oob read".

Signed-off-by: Jann Horn <jannh@google.com>
---
 t/t5303-pack-corruption-resilience.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 3634e258f..7152376b6 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -311,4 +311,22 @@ test_expect_success \
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
 
+test_expect_success \
+    'apply good minimal delta' \
+    'printf "\x00\x01\x01X" > minimal_delta &&
+     test-tool delta -p /dev/null minimal_delta /dev/null
+     '
+
+test_expect_success \
+    'apply truncated delta' \
+    'printf "\x00\x02\x02X" > truncated_delta &&
+     test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null
+     '
+
+test_expect_success \
+    'apply delta with trailing garbage command' \
+    'printf "\x00\x01\x01X\x01" > tail_garbage_delta &&
+     test_must_fail test-tool delta -p /dev/null tail_garbage_delta /dev/null
+     '
+
 test_done
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

