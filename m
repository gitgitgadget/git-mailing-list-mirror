Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F7CC7EE37
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbjFFTs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjFFTss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8A10D7
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659c7dad06so108706897b3.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080926; x=1688672926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Me8fC0GJGFHq0cZ62aFPQeZZE7cpulW1nJzI6lf+GjI=;
        b=sv8BWLS+Wm8uigw9H/FKRmRhzqsTHSois3tBDx6Aq67I8kkkVD83eQTS0fkBWuKy2T
         OxRJcLXS4xPn43VKqs/k5ztlxkhHkXBiR+zcu71mJVLErcHl7ldkAuPfoXTEixk1G6lM
         Wp9C11Qv+Ngb7qN3bARb35wPTZLuYzrCgAxniXjWfgaZLFhSTV1zBbxOD/WRWP6nQ7nf
         JAa2XkAKQZhEj/MJHRsKZ1WPtJQtYyMS0T4BdzMe2waiQ2N8fWxJ449hMprqLgU3TB+5
         R75QhdMLEsn0FaUcTAFXUPKG9lfTZKXRvcwRQ00sDfu2Hz3qt6N7PXzOro43nn7cMTT3
         ljSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080926; x=1688672926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Me8fC0GJGFHq0cZ62aFPQeZZE7cpulW1nJzI6lf+GjI=;
        b=l+o+Fci67L5SH23OWtXCiSjbQNTCwmEYhW+QioggwoEJ6LfNGMqLRHZSI+r0FF4Lks
         d5tJJjAyks1Hk3gKUi8nEBeXJv+xnaEzVC1aXf0PKYHi8YidCV6PM0PeKATDYhxj36Fe
         x6AjF5JKx9wQ8OWyE+H3Y6avk0+4BiWG+64YDVwjE9/Ds2AGxsWcPsV7uT/DDcNvI+Pk
         7/3jWjuJr8rT4Z4catCZE+yEpSMWuAhqi7EfQ7vkE6jSXDd9L+OJPhKiimFlnDWhjPQ/
         rcbRJmev5k3LIfm3BE3IbKpY3wxCEC9StMNbjZQV2o4Zp4fS4BEKyMfoqocibeJaKv7e
         shMA==
X-Gm-Message-State: AC+VfDyulsbzzsNvKhS9iXCggcoPGgorhCDLmraQWKyjOZEQPzDblQFU
        j/GEiIAP4Ew8uoneILNHfL844W1FW2RdPmKUUvLibai6LymenyuCnStUFbAN6ZRsGcCjoiDz2HL
        tG8Sz3GkRFLjXLha9vHwIUsew3klcL2lbBdppS1RrEIHzliewmCXQ+2AWflsQAPWLIQ==
X-Google-Smtp-Source: ACHHUZ6E/Yn7qj6o4XP2a26cG8zTEQlimm1HGhdWKYxvPr0DS2EXc+GqHOF8RrG91qbewpUzTno4dL9HVRZcXn0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:dc03:0:b0:55d:8472:4597 with SMTP id
 h3-20020a81dc03000000b0055d84724597mr1651848ywj.10.1686080926669; Tue, 06 Jun
 2023 12:48:46 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:37 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-1-calvinwan@google.com>
Subject: [PATCH v7 1/7] strbuf: clarify API boundary
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf, as a generic and widely used structure across the codebase,
should be limited as a library to only interact with primitives. Add
documentation so future functions can appropriately be placed. Older
functions that do not follow this boundary should eventually be moved or
refactored.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..70778c6e10 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,14 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+/*
+ * NOTE FOR STRBUF DEVELOPERS
+ *
+ * strbuf is a low-level primitive; as such it should interact only
+ * with other low-level primitives. Do not introduce new functions
+ * which interact with higher-level APIs.
+ */
+
 struct string_list;
 
 /**
-- 
2.41.0.162.gfafddb0af9-goog

