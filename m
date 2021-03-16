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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C496C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AE364FF2
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhCPQSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbhCPQR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9850C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e10so10766191wro.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrjHOAcGbWnM3qrLtxpCpFY34ylFHw5YWtJbZd8GhSg=;
        b=mPEWm78hqvbBpmJphtSs4/O4emed9GHagk3FPTIUVPm0fR8TdFb35Fee1nXJYEDUUq
         maDzGDlTkdnJCj3l0q+IuXdgxfVi8hj5tzDhXoVX4nFcr1O1zd4DVdA8pLeXcVTinTo0
         VsSVS+3NA+nONUqMWKUn/cWw+T4epf/xoysckAQwFeTFkaOffZJAonsbuGMUVjkyb660
         g3PIy1sUYBsM10G6rGO240q9YhmJ2APs/0nNa/u+iUswHbrOKvtS/+0qjv4mS0hC7J/F
         y79dIp4Pof9TdgJrwXh1HbdSHZe8VdLKLv7xcpd6nMRsfN7yh4RS/ycZbJ79+ZQ2CcTX
         lGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrjHOAcGbWnM3qrLtxpCpFY34ylFHw5YWtJbZd8GhSg=;
        b=AtAUhi7KkYWDyBgjLr3Bb6BWF77cjc+zapH5rLvY7XzRjZNivRzovxYhROXjpivzjK
         rVBL7Jgp0lK3FRbvZo8QAlisrzIr7xLogmvLmBi24rdfGzqjGbRzVHmgizYu8dlKBk7o
         kpccyJC1itlpSwZ4l6g2WV/GU+Vocrl5z0wqDznaTFz/bzeZNbud8fStsd+Z0Hsop26N
         SOfcvV0EwEZjOkX7ejbmVFY6YR6n4226fW98ZyFM9q9owdTSXufe1whwcGw+cTGQNkZY
         B10uxB+qNUPKUh+ZrhTAVl0FtC4wi/bn1P/lCH2uYR99L5JmgdIazO8XEIt+qsh6SHFq
         ZyNg==
X-Gm-Message-State: AOAM533QmW2qmFCv88rwVnE4cjL32ep2qfSqsqN0Doa3e51cfO5FruYA
        Tf15LIOWaktUzxjqY6gJi9KHGKQa+n1Nnw==
X-Google-Smtp-Source: ABdhPJyo3GH0XHYPzLd29HcCUrmKmqTaPlXNOO4WwfaZodRg6ynlO21xqufUChjqmiO0dLfb0OssbQ==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr5785896wrr.274.1615911474300;
        Tue, 16 Mar 2021 09:17:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
Date:   Tue, 16 Mar 2021 17:17:17 +0100
Message-Id: <20210316161738.30254-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 733378f126..2274843ba0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,8 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.260.g719c683c1d

