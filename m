Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53463C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D2161108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhEaRla (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhEaRks (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925CC008743
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j14so11534160wrq.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iwyDmYWUtN9qOZ33DFhfLNUp0QHVGfIU6ynUmuS/1ZQ=;
        b=lb1bcd5HRu/ORP2RqGaXCoLYx4JKZmLdmgXUVY4sgeEP7eK8WNV61L/w4+EJTTT1hk
         aldiG42zQjzsR52uT47BlGeRvimCjRpkPLNTzx44hqwTJZUl4UOItg2C4LXHs2aMRALC
         pdejsJL7iZbAYJD78Z9QyuF5pr3EKR0TeUuWeO9+DG6uPdTdzWn4Fw9xoKR1jl741Qix
         G4Mq9GCSGnHm47lOeQpY4uGy9ttShDfdxGbRTvVgIpOUrKW4Vev5GoJEqpUi7+v63nQ/
         bcVTrKpsJgnQrV5luJyFM/Z9Ki8CdZ62a6WXe6GK2b7hBTMNt38OI2VqdEnyiS9iARDG
         PfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iwyDmYWUtN9qOZ33DFhfLNUp0QHVGfIU6ynUmuS/1ZQ=;
        b=s7+QLd4WH6FCQ3go3OEQjeIiGI68lQ4UiA5FSYMJsSO6k3qhRXVKpwmmmTuLmuyt4i
         FxrwPjm0EyMFx8eFtWvuUn6X1xYw2VWs3ybH4kXaPC96kQBewV5aPsdnlnHgXKldhXG3
         NKfyYHoUzHt1eyaz2fQ2F+VqD/s2REiqEOUcSO1mHL3Aq3/1sylTRMpPfD1yCt6r51Ic
         TSvwCi6AZ7Drb2qmoHeVe6IZX3SiIkxrjyMy8ISuAdw++wb2JUdIZeGSEToIRde9+XAD
         zbb9k5hqL20NsvPGRMFjDydnXk1pwYUrBhIu86fGfjAtMWWDMT476HOxUFHhV6Bec4wN
         1wtw==
X-Gm-Message-State: AOAM531ZjEujJ4+jNgnTRvyu4BFMtlWYGxpKVvGMYdQGWq+o8E0e3CCF
        K3ntIHh3S45MzX4/nBo7EtotEhCBCng=
X-Google-Smtp-Source: ABdhPJx8jP/79swYNUk3593Cn+oBzNv499lxCrV8sOAHi1XoxqAF8+TyqdkelJ70f0jVLmj/jDdDLw==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr23917448wrp.97.1622480202685;
        Mon, 31 May 2021 09:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm263439wrr.48.2021.05.31.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:42 -0700 (PDT)
Message-Id: <f05817d805650f6e8aa3a1a8e625a460f51037bb.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:21 +0000
Subject: [PATCH v3 06/22] t1401-symbolic-ref: avoid direct filesystem access
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Use symbolic-ref and rev-parse to inspect refs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1401-symbolic-ref.sh | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 7a9629fb9f0e..132a1b885acb 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -17,14 +17,9 @@ test_expect_success 'setup' '
 	"$TAR" cf .git.tar .git/
 '
 
-test_expect_success 'symbolic-ref writes HEAD' '
-	git symbolic-ref HEAD refs/heads/foo &&
-	echo ref: refs/heads/foo >expect &&
-	test_cmp expect .git/HEAD
-'
-
-test_expect_success 'symbolic-ref reads HEAD' '
-	echo refs/heads/foo >expect &&
+test_expect_success 'symbolic-ref read/write roundtrip' '
+	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
+	echo refs/heads/read-write-roundtrip >expect &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expect actual
 '
@@ -32,12 +27,13 @@ test_expect_success 'symbolic-ref reads HEAD' '
 test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 	test_must_fail git symbolic-ref HEAD foo
 '
+
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	echo content >file && git add file && git commit -m one &&
 	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
 '
+
 reset_to_sane
 
 test_expect_success 'HEAD cannot be removed' '
@@ -49,16 +45,16 @@ reset_to_sane
 test_expect_success 'symbolic-ref can be deleted' '
 	git symbolic-ref NOTHEAD refs/heads/foo &&
 	git symbolic-ref -d NOTHEAD &&
-	test_path_is_file .git/refs/heads/foo &&
-	test_path_is_missing .git/NOTHEAD
+	git rev-parse refs/heads/foo &&
+	test_must_fail git symbolic-ref NOTHEAD
 '
 reset_to_sane
 
 test_expect_success 'symbolic-ref can delete dangling symref' '
 	git symbolic-ref NOTHEAD refs/heads/missing &&
 	git symbolic-ref -d NOTHEAD &&
-	test_path_is_missing .git/refs/heads/missing &&
-	test_path_is_missing .git/NOTHEAD
+	test_must_fail git rev-parse refs/heads/missing &&
+	test_must_fail git symbolic-ref NOTHEAD
 '
 reset_to_sane
 
-- 
gitgitgadget

