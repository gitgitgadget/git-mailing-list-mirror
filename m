Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FDC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C1760FF3
	for <git@archiver.kernel.org>; Thu,  6 May 2021 07:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhEFHfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhEFHfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 03:35:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D7C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 00:34:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v191so4473649pfc.8
        for <git@vger.kernel.org>; Thu, 06 May 2021 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFhy6NEd04J6c2CfI4hVy6zFvxAXSqlPtQ3SMtMUVw=;
        b=iG0gj4vze+FMlGAznSIoDRfiwcIHn4r2xOtFdKNP2DRyoZjKZIl4MOrxYVplKmrqhO
         2MkQKdHmZqL9Jhv3b+R0cTjEGbuTURmEUajXrsuUNBZ2UnuHSg6EHYgrXNeC75k7iyGZ
         rls6Z3KMmyMbnl5YFA+6WLaZyV6xkoiA6RcZ1lvgcmXpTrGBU3VPkTIUyhkwC5fV2WOW
         s+9Ed+415DCqrrSKB7asuy7tJaOAieaQPRjTA6b7SdYXLVSGDpybECcSb6qSd6kx6re7
         aun5tjoZDwIsFQUc8VqUVgOLrysn5rKzhvDQ4NAy75ZKvjGfBygTrILmZO8gDYDSkzID
         WNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFhy6NEd04J6c2CfI4hVy6zFvxAXSqlPtQ3SMtMUVw=;
        b=RP8vN0r4miOM7d6J5jIsVJlBEQ82OHb2OgvopgKMuAEmTXZDhVlCNIZNRCJTeeI6DM
         4KshGRGvi3Xgc+J2fciAt2jH3SXFGNSQqrXNttinNHgfo1N9wpbc34sqZmMY7DdCltwE
         IMB1xci/3DUft3KTkxCe+IKdd0JUvc4mbwlcLrqn2fCxPMxaL/tlrzoamiKObovlllwH
         IH2CefQCsCnUvJkVUjZ44LVXVO1KetAfHEPhp4Z8Z7HSR9avE8sQrkPqmQPbDj08wC27
         5xZSK79/z0t8W8t2tTQq6/W8XecgooAaC/MIxNO5oezF5h+4zZSIFZPys71HZddI9Z5T
         /Vrg==
X-Gm-Message-State: AOAM532A8L5SA8dJ5jMUG4nXWS+rIZOAwmJjbyQu1K9U+A7yQh+9ee6+
        eZN9p2kSjJEKAHTB+Rdx1sp4ixgvO9wAOKadM8Rc3g==
X-Google-Smtp-Source: ABdhPJzU8R3vu/r96Umui9pfxNGTzi+HnzyQaxMXq3TEJXedGHkC+O3nA5y4h2q1fBvWX1nmQwrBjQ==
X-Received: by 2002:a63:164a:: with SMTP id 10mr3102830pgw.186.1620286457022;
        Thu, 06 May 2021 00:34:17 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id t19sm1332678pjs.23.2021.05.06.00.34.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 00:34:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] Optimize the description of the configuration in packfile-uris doc
Date:   Thu,  6 May 2021 15:33:54 +0800
Message-Id: <20210506073354.27833-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a description problem in the document about packfile-uris. This
patch describes the configuration format of `uploadpack.blobPackfileUri`
more accurately.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..1eb525fe76 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,14 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
 This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+server to be configured by one or more `uploadpack.blobPackfileUri=
+<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects to be
+sent is assembled, all such blobs are excluded, replaced with URIs. As noted
+in "Future work" below, the server can evolve in the future to support
+excluding other objects (or other implementations of servers could be made
+that support excluding other objects) without needing a protocol change, so
+clients should not expect that packfiles downloaded in this way only contain
+single blobs.
 
 Client design
 -------------
-- 
2.31.1

