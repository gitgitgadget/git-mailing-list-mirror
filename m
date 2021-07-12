Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C9BC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246EF610E6
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhGLLtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhGLLtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC2C0613E8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v5so25205052wrt.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gcJvRQAqHD2kOOqwmBikpeCsu0xCI+Gpwxqt7a1E8WM=;
        b=T33QOOK4igKSOKsbBnUkhnJCCKkEIlSJStH5Uvm4nv4ATUaKDotJnTnJYT/rhUv7uU
         pdLCBs6EoiNgdevp71vRevwmtBLEpnZRldbDzk8OiMwsjrecYSeo9trA7w2w+bWMWSlV
         qQPtP3c7SVDteNBYy5pmjPXvijkz0mjfbHmmRn9xuCMHsHM6Fe9OSBrnzTx+1/BhzAUk
         RkEZnMeQtooBDbnYtQH9AxMD8WZgqidNWgrMRUbmlssBzzBL/TgsHwNygaaDWvy9n3Vt
         9QGqqUPTpsSOZTXhPbrcl5uFm8SskWzOINU8m/ZjKY8v/+UtR+Chbl60f2PZnwZVj399
         ux6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gcJvRQAqHD2kOOqwmBikpeCsu0xCI+Gpwxqt7a1E8WM=;
        b=EmtM9Zg1sCpKg/IsGnMxZ4iHMSYrHFjdCRyeAtHetfxe7wWEl7y4qhpMi1pUvvuwum
         /A56/pahEe9LGt7z25MskHROTnL64ST3EH8ReuXRzqu+PXiQI8907ee4v0Nu3K0+KwSH
         xFy0iafr/RMGDIyXUcihbZ3nbQwRdbaC4Dx7HGzucWqDgXgw7VDqDbrJT3GIqWkGV2eq
         oSeUddnwYUFiiUJlknmx68TgCZhxQcNtxGpsNlgPFYF91xnI5zSaQg6ycwW9ibrBuP46
         HcPfZwnqvME6vlrXGiIqMBDHwWybhClECdPRaKZPuTN7wESWssm36ZdxV7CRQTZxoflJ
         3hMA==
X-Gm-Message-State: AOAM5332A8ZVc4rqQurtbjzJf2rzypgJoJwPA6IQswURkL7N43J6lxim
        f6S439ehYcJqIZFo9q8yh0vfMS6EZxI=
X-Google-Smtp-Source: ABdhPJzZGaXxm8pdJ5Q3gk2c3s8rq3d0AXHr52Yy7flf8/4iGCjeyb3SVdcKoQzSd8Pzp/ozjzWXiw==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr11376051wrx.96.1626090421472;
        Mon, 12 Jul 2021 04:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm17034258wrw.9.2021.07.12.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:01 -0700 (PDT)
Message-Id: <9aef8882bd1e5e9bdd401d92449190f462310e40.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:41 +0000
Subject: [PATCH 01/19] cat-file: handle trivial --batch format with
 --batch-all-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

The --batch code to print an object assumes we found out the type of
the object from calling oid_object_info_extended(). This is true for
the default format, but even in a custom format, we manually modify
the object_info struct to ask for the type.

This assumption was broken by 845de33a5b (cat-file: avoid noop calls
to sha1_object_info_extended, 2016-05-18). That commit skips the call
to oid_object_info_extended() entirely when --batch-all-objects is in
use, and the custom format does not include any placeholders that
require calling it.

Or when the custom format only include placeholders like %(objectname) or
%(rest), oid_object_info_extended() will not get the type of the object.

This results in an error when we try to confirm that the type didn't
change:

$ git cat-file --batch=batman --batch-all-objects
batman
fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?

and also has other subtle effects (e.g., we'd fail to stream a blob,
since we don't realize it's a blob in the first place).

We can fix this by flipping the order of the setup. The check for "do
we need to get the object info" must come _after_ we've decided
whether we need to look up the type.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c  | 13 +++++++------
 t/t1006-cat-file.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..02461bb5ea6 100644
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
index 5d2dc99b74a..18b3779ccb6 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -586,4 +586,26 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up object list for --batch-all-objects tests' '
+	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects
+'
+
+test_expect_success 'cat-file --batch="%(objectname)" with --batch-all-objects will work' '
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

