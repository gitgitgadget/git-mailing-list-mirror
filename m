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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED3C47093
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0A2613AE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhFAOhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:37:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8AC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:36:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g17so14533805wrs.13
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3jqdZ2NSjz5dUM6gNAy4XNvP7cdUhU8aKgUFA9MSM0Y=;
        b=Pw+gWqHOIMbXA+9a0F2S3IgNi5UpGt+/1I7GzAFGmODgtcnJp/s9gf4eNUk0WWGG4n
         HoGa5xasMccdy0FUdOELODFdAheZkSnk/WtUXSvxv+QWYy358qKD1KIiwXaZKEm/gX0n
         cUNUaDiMIndzRL2+FNW7uXBMiU43rh+KzUmLVD7E9vt5U3QQPAiy+rgmRAv0i/Q1Fhot
         BYNc8P1nAaE39/jXX9ctkfgzwWOjxwtT0jqYCGQwIxz7lXQJpRq305GrHEXk074u72qB
         UGiargQ+3bhRbWw3nGI4uS5fUKMqCRxas+M3SOjsHZT/86cHyiNVKPIElAS0+bjIz+mz
         HcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3jqdZ2NSjz5dUM6gNAy4XNvP7cdUhU8aKgUFA9MSM0Y=;
        b=GTxBHvm0pMEjudsDg6OWniHqtAW9MH5nuArd5G9LK2SJ+z6RwGy4e5faZwhJDPkbmO
         SO0wUS3ZO4G9YfP+KTxhZbSEtAIjxGIPl3qpeyyRCq0VUhtwuP5Kzubr0B6ReYTUDAqi
         9hiA097ZKZfRSJxjOju+Ig9O2m/FKCJmNUSOWXYmQV43phHx/LRndIe6AVLTW23ZRmgF
         b8ZcrLBoE0UuWlKLH4OM7awoLCvzTdag65DWjWuec9uGIWvkSnBT3DrvX44vhvh2szDQ
         e4R0FGv2LD8rNAlnu6LJOixHTYYW5kiSxR3xR65bVArYuOY5hGt1fl+PHv78tEVN8chQ
         d1Kw==
X-Gm-Message-State: AOAM5332Q6Q362MSQ3BlD5T2Zv0xTGD1c5XFU/ZzqBM6UDWkPq+UMju+
        h8leVMW6VQCleRxHBNb2tKZ5pPKsmZk=
X-Google-Smtp-Source: ABdhPJzpuntAtlFNv+F4Enxa2yQJOpUUzme2713OX6KCXNepIROUXuIq9ovbJUDPMC5KAtgATcxibQ==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr28289283wrr.12.1622558159543;
        Tue, 01 Jun 2021 07:35:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm3347383wrz.71.2021.06.01.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:35:59 -0700 (PDT)
Message-Id: <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.967.git.1622558157.gitgitgadget@gmail.com>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:35:56 +0000
Subject: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When `--batch` used with `--batch-all-objects`,
with some format atoms like %(objectname), %(rest)
or even no atoms may cause Git exit and report
"object xxx changed type!?".

E.g. `git cat-file --batch="batman" --batch-all-objects`

This is because we did not get the object type through
oid_object_info_extended(), it's composed of two
situations:

1. Since object_info is empty, skip_object_info is
set to true, We skipped collecting the object type.

2. The formatting atom like %(objectname) does not require
oid_object_info_extended() to collect object types.

The correct way to deal with it is to swap the order
of setting skip_object_info and setting typep. This
will ensure that we must get the type of the object
when using --batch.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c  | 13 +++++++------
 t/t1006-cat-file.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e83..02461bb5ea6f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -512,12 +512,6 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
-	if (opt->all_objects) {
-		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			data.skip_object_info = 1;
-	}
-
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
@@ -525,6 +519,13 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->print_contents)
 		data.info.typep = &data.type;
 
+	if (opt->all_objects) {
+		struct object_info empty = OBJECT_INFO_INIT;
+
+		if (!memcmp(&data.info, &empty, sizeof(empty)))
+			data.skip_object_info = 1;
+	}
+
 	if (opt->all_objects) {
 		struct object_cb_data cb;
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74ad..1502a27142ba 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -586,4 +586,23 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cat-file --batch="%(objectname)" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
+	git -C all-two cat-file --batch="%(objectname)" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >actual &&
+	cmp expect actual
+'
+
+test_expect_success 'cat-file --batch="%(rest)" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch="%(rest)" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="%(rest)" >actual &&
+	cmp expect actual
+'
+
+test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch="batman" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="batman" >actual &&
+	cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

