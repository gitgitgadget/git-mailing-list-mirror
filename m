Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D71C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE60461051
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhIFQxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhIFQxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BA4C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i6so10708131wrv.2
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=MX6wJ79i7ej7gqyLshlXz4v1uKfdQaSG3n1somUl0oT5Qd9QJx64S5cFz33toTBAsk
         GqktwajJFpwfNvGGvDQhAnA4G3UqCHnYTQdulEFw/IJtvQhVPI9eu70cN+2TimydnhZH
         yhUn5sZ58kCXY+o4riD/xiIj5caQc48mL+54c71k5JW8uoHdRs4N13CV5EX15jOK6jGv
         QuBj5WpyZWeXExjXtIwqOLEHdBmPcUuW1QaEvZZROZEDDPIPPEoqXoO9ggPSV2ZNkJhL
         k8k8v3M9pHM54aDiYLBTqUjbqtcx9GVj343LJCPn4vFEsLzNkggQw1w65crd6O6snK1A
         2VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=DJ3/eVC/QGHAovOnTTMiqM29byvgY9Cp1QSbQqZHwxm0lZstogxjuen3WO4zwCpCCl
         GYWwIrefyJjLKzAkg3RcnziHjhZ4mN1RGrU2ZPkCtSLAKum1Cv0jGTWp1juGPUGNhkuo
         KFCamke3ttczJ8why5viwyZdget6aDeBBsp2tkFf/dJ5EpHFzVViex9BIb4WKum4iXWP
         siPCw2ClJbNlDseOte9ZKZ/yoaWsj1f9zwZN8fF1FHHDAZRg1jBbaR7BLBg3WO4xdpF3
         NsdPj+BYTYAFXmIiGcXRQjINOup69qk2WG+WoCk6/5taTk7BLM6USfw0Ptgls+SEma+c
         I9dA==
X-Gm-Message-State: AOAM530UQ0kQUPsaHBxXe0jn77lAGLcfWVeBo8RNam3nbPooubCGopJs
        KXOAjHdCaZxB0FThX5nDz2Hxe/i1ZMs=
X-Google-Smtp-Source: ABdhPJyLNPfa9E2XXyvpQlK5ChMF+Taq4oFMNH3MG/gLAYg0Qz2uS5yp+ML40sW6/En7RjBbvmS54g==
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr14421114wrd.286.1630947145508;
        Mon, 06 Sep 2021 09:52:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm8906723wrg.50.2021.09.06.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:25 -0700 (PDT)
Message-Id: <11b296a55e9e450575c64ade1a2cb93a1886b9da.1630947142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:19 +0000
Subject: [PATCH v2 2/5] test-ref-store: tweaks to for-each-reflog-ent format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Follow the reflog format more closely, so it can be used for comparing
reflogs in tests without using inspecting files under .git/logs/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 5 ++---
 t/t1405-main-ref-store.sh | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..0fcad9b3812 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a600bedf2cd..76b15458409 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-main &&
 	tail -n1 actual | grep one
 '
 
-- 
gitgitgadget

