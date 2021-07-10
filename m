Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5621EC11F6F
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128BE613BE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhGJNkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhGJNkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA4C06178A
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d12so15872712wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96if8fanmUd+XYMGydTnLu0UhpqNW1O/ECyN0bL+AgA=;
        b=dD4x4szmSumxSDWKM3U7nWPVfLBGt3vD/A5bKGCjI8LQyDSor9Vs9EA7eaRW+J/HdU
         QOY9IQxg7SXeNRxDdKcbxQV1WhR1KVLgSPlmGMvK2VwbRmkvD2jFfPzG8nKi919flOmi
         tBhoOLyg/Vb7/GI4mCRwMSslT3T+7DoCxE2dNEl+UlJQcaBjXCITuwLhMjgmVqEBWfZi
         dU5zz+Vl1ezRYFFxCbsXXBr1j/zMzU/50X76uQsSl8UZ5L+/Xw8G1uaMVpwm9/P3dEyw
         ncPJCOWN6NqijLmpPtHktA2Vco5H6ZtAKfD7TygVwCH28R86N6Ll2bIThD1/zgdTI3rE
         klsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96if8fanmUd+XYMGydTnLu0UhpqNW1O/ECyN0bL+AgA=;
        b=lWfN0FFw+dCSoE8gxKYb5h0LSei09HJ2jhhPqXHJ8TJGYeFF7p2Wve/hqHID6yVrlx
         t992bS+np1KVgH1ymcgyADhBr8fbSeAOuV7mwC00FX5dTBAmeS3HZGEQflAL9UFHfRVo
         2ROHErGkHusNE7XC9N9yXmwL1MqjlsdQyebugg/N7mRQqf3mLURCiTziMJnQhtTwBhhE
         kGywUUSWnbrz9sZ+H5GbAKvEzroolDuoIuGYKvQu3G9PNh9rVHhrCvNhBvMUoQW7wMlH
         5cDbpll2FoVttLw84P/VHe/uc1R+pxAGJqmqx+Xe/RuPKQb0B10TVZrx37bxURnLN9Rk
         C68A==
X-Gm-Message-State: AOAM532JFOR5MfDC2zawWymY3ODe+03CiNxkbi2U37PXb5goO2TFE8uL
        zqhxdw4Hxc3jfCJOF1wnMil6a9v/kgk6dg==
X-Google-Smtp-Source: ABdhPJxHINJgg++leZEvcouXOs7sLRhF2G5+zK+ekdp7UasPFEFS6fhpBiSPEVk/l3AnusOQ9buACw==
X-Received: by 2002:a5d:6dd2:: with SMTP id d18mr48529890wrz.94.1625924265100;
        Sat, 10 Jul 2021 06:37:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 19/21] object-store.h: move read_loose_object() below 'struct object_info'
Date:   Sat, 10 Jul 2021 15:37:22 +0200
Message-Id: <patch-19.21-ad920362594-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of read_loose_object() below "struct
object_info". In the next commit we'll add a "struct object_info *"
parameter to it, moving it will avoid a forward declaration of the
struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-store.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index 94ff03072c1..72d668b1674 100644
--- a/object-store.h
+++ b/object-store.h
@@ -234,20 +234,6 @@ int pretend_object_file(void *, unsigned long, enum object_type,
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents,
-		      unsigned int oi_flags);
-
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
 
@@ -388,6 +374,20 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents,
+		      unsigned int oi_flags);
+
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
-- 
2.32.0.636.g43e71d69cff

