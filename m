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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DAC83010
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35961246D4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwoUD7wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgKRXpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgKRXpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BEDC0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:09 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so4755528wmb.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sOkjXxKg9QmJHMPxZX6XldP1tVgJD4irMIMhMkLqFY8=;
        b=UwoUD7wDAAR2yfc62zdpS69maBlMoPcHeUB4gMXJrIpks8SJgibRDwdhWOt2Rw9Kmc
         yIYp3YCEbNcBbridSZT43eTKU0vZjsrQ4Z1XaT2SrqBezvX9nfcZ+qIfPzcAUV0c9PVb
         ES1Zn6inW8hDi3OKA4orj3mGPUnpwkD0K6YAYYxkI13qrsgMbrRxMjNvaoemA7fRqlN4
         AYe40Vwu9ZaduGxAhGQcpWcuOGETcXd3fQjywPREVyjgBYn/686Y+OV5RyC447q0NBAp
         6l+3XYKjCKiO4iTEpc0Lo+LUf1IKOPCfDjKqxm5VWM7rFNJKpZfqOmpdYRrkdo4scS8B
         0fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sOkjXxKg9QmJHMPxZX6XldP1tVgJD4irMIMhMkLqFY8=;
        b=eUWM5T/E1i9DjCrWbQoONBMg7WMrdaDbg3gJD0uA06h44jVrEZQxN3iQCN500rZMCo
         AhFAVIurLtTU9OWYT+Fd0auCHqCJsKk6DIWkCaYAO4WshOOG+Lwm3AWoRupTQQElof5j
         EJnfRNwh0KZNl0svibFNpJK7KQtsg4eqmXAgWBi23Nu4F1yTqOMhPOJqgt15asTU5VLk
         d0+n60dDrOsI/pXMkLIdvyNIph/Wq2h5nTFmM26X4dch2gc1tcBy4fc4mNjhJfwaKpst
         DlHLk51g7ERuGIHyCDk6dJ98tEWhav7ZO8VAL4RjvZ005SoBFGZ1T1rwxAPfr5SU7Kjj
         2uxA==
X-Gm-Message-State: AOAM531TLaACC/eqNrjKQSsv/0obVO34NXqbZ6li5mmznx7xdRcUGeOd
        OlOfZ9j9H2xF/K2e5lmeDAPgN3fhn4Q=
X-Google-Smtp-Source: ABdhPJx5bgsQbxnKB+YhxhR9SCYmEH2RlgRmhI0pG/pUd9ozoqsbO2d1mTqwXj6G0E6ZLJyQZllFcA==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr1537048wmf.30.1605743108455;
        Wed, 18 Nov 2020 15:45:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm6152896wmh.16.2020.11.18.15.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:08 -0800 (PST)
Message-Id: <0a4bc77dac2422511c1fb35d988116d4c8ad1ae6.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:37 +0000
Subject: [PATCH v3 19/28] t64*: preemptively adjust alignment to prepare for
 `master` -> `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are in the process of renaming the default branch name to `main`,
which is two characters shorter than `master`. Therefore, some lines
need to be adjusted in t6416, t6422 and t6427 that want to align text
involving the default branch name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6416-recursive-corner-cases.sh    | 8 ++++----
 t/t6422-merge-rename-corner-cases.sh | 4 ++--
 t/t6427-diff3-conflict-markers.sh    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 6a740771ed..3d515a8e31 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -388,7 +388,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file  B:file &&
+			master:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :2:file &&
 		test_cmp expect actual
@@ -410,7 +410,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file  B:file &&
+			master:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :3:file &&
 		test_cmp expect actual
@@ -1556,7 +1556,7 @@ test_expect_failure 'check conflicting modes for regular file' '
 # Setup:
 #          L1---L2
 #         /  \ /  \
-#   master    X    ?
+#     master    X    ?
 #         \  / \  /
 #          R1---R2
 #
@@ -1751,7 +1751,7 @@ test_expect_success 'check nested conflicts' '
 # Setup:
 #          L1---L2---L3
 #         /  \ /  \ /  \
-#   master    X1   X2   ?
+#     master    X1   X2   ?
 #         \  / \  / \  /
 #          R1---R2---R3
 #
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 70c8af7f51..9fb4e72ca3 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1133,7 +1133,7 @@ test_conflicts_with_adds_and_renames() {
 	# Setup:
 	#          L
 	#         / \
-	#   master   ?
+	#     master   ?
 	#         \ /
 	#          R
 	#
@@ -1293,7 +1293,7 @@ test_conflicts_with_adds_and_renames add    add
 # Setup:
 #          L
 #         / \
-#   master   ?
+#     master   ?
 #         \ /
 #          R
 #
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index c192ee4e42..3ae2d07ae1 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -46,7 +46,7 @@ test_expect_success 'check no merge base' '
 # Setup:
 #          L1
 #         /  \
-#   master    ?
+#     master    ?
 #         \  /
 #          R1
 #
@@ -104,7 +104,7 @@ test_expect_success 'check unique merge base' '
 # Setup:
 #          L1---L2--L3
 #         /  \ /      \
-#   master    X1       ?
+#     master    X1       ?
 #         \  / \      /
 #          R1---R2--R3
 #
-- 
gitgitgadget

