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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE9CC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2723864E76
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhBRM25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79EBC0617AA
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a207so2601612wmd.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dltjlb4ofR5QGT1TBhX/KDVc9gQRgXc/FVNVjS0zlGY=;
        b=RiDlImXm2DQ7Pj0a7l648V9sx8oOfjHJ7zDw408OB7K6xyKX0/0TsGYcaC+mNWSxXU
         AqHYDfEDQZc1l9pQgxPSv6UmY8v/ZjcLGH20bublZbACLD4FdP9l/9ecWPDc+3XtKQCs
         /4rp/X+mlU/dIcbNJt2XvjQEkH6LMv5MX+4O0J/WPxyVbg715FzXkEd/U/fsrxV11rFK
         gPKQv/LQ0m7imdjj4XeBB8F4Tt89A2K1CzBOshGo1MoMEFIuXoo7V8ZgpFXJ0YjGR/kO
         B7nFVEYWUef+8XNeLNCgCcbq1j8jTm6x4tfXoDKR3UofnnR0SSlydy+IxubBBGWykke1
         nS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dltjlb4ofR5QGT1TBhX/KDVc9gQRgXc/FVNVjS0zlGY=;
        b=i1Fohv0uYnaJ+IhD9Nedvm+nJUUhQyr+64fnsO39m00WmPGu2IzvJtUzMxYdij6nfP
         4xofGHcWzz0WXkvl1MN8peBGfcaRJs3D65BTrnIBCP7rPGYo2NAh/KU6nra6T6re3k5G
         eDhO3BNven/ojuIVnCjoxQU9BHH7KmoWiixxZtN4luJHIS6AGkb5yocfJqGVFwi1eIgk
         ARGFkwMZRwsCIWi9zW7ZMDvfV6T+OH+xwLTYHbwiJ+0F2yZXN/BiC0A/uvScSi9vlZc+
         tPs8IGkVtIdx+1M5ABI2loLbaSlw8+/6gYb/Q3iSM6H3BfK28xFy+xqJGUH7llbeZ0cN
         b5+g==
X-Gm-Message-State: AOAM532swjNwahpJResVEWNA5hwyQC9j8KfncPEFAkQWKfsQ2UfLojHd
        D7jaLb/P3oJICMIbt9F1Z/ibLGzx4OmEAA==
X-Google-Smtp-Source: ABdhPJz4HhSS4N/xzm0k1asEPoNtdkUWip99NYd6UnZvOX1cnQVHjymWOZqlQraRsXNNnCyIb8HIKg==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr1446320wmk.27.1613645931163;
        Thu, 18 Feb 2021 02:58:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] fsck.h: update FSCK_OPTIONS_* for object_name
Date:   Thu, 18 Feb 2021 11:58:40 +0100
Message-Id: <20210218105840.11989-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the object_name member to the initialization macro. This was
omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
go, 2016-07-17) when the field was added.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index c77e8ddf10b..5d44ff1c8e3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -47,8 +47,8 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.30.0.284.gd98b1dd5eaa7

