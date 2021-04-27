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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A0C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9806B61026
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhD0Kjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhD0KjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4AC061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so58956171wrr.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iD0BXpO9xlab9dehGoOiVpCYvoRZe7NGBa9X/lpNxPU=;
        b=F7MS6nb4KPDOJBgWqHlSufGNNH1WgjmgtcPtSuh4Mh4JMRUAsoN6EL/C2muw/vEgK6
         C0qF/qZhiF2QwhAVW002QD/A+NptWPHFOlQLaJbgCU9EHKTUskAb+GriPVU0Pq3MCOzp
         4/60eRrQioThIyj4IlS84fdpb19jealhOEbjVcnPzAVPuHtaM4IbNlNJg3PxNYKHXOzM
         8f96sl0zkq9sTmyWbxfg9QHyLOQC8FyfyFH+vEiQOmJqzOAG/ydE2K3FK2QLbI6+GDGM
         Ivewj2Eokku397gMVSicR+FUAqM1irLrJgtQ7wIwIjyGhGBSiqUKUV7fn46RJHDDcLlw
         TBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iD0BXpO9xlab9dehGoOiVpCYvoRZe7NGBa9X/lpNxPU=;
        b=XBwIFoCoWqw3OWk3R2UkpbXn1DAA2zutGPSIxsHpCfGr+m5hcdJcp3NTV0yP2Wsb2r
         kCtG8gJI3yoshQqA6Wy4ELXJx8iF7aAE6BdVglkwS6IMIytYxWGdPxrnM4xxmq6vFUVf
         0ZXcxUxBc8wxY9ZA8fKmhppz5EG7cSTqQxTQ88zy9hySmkl1q9Q/3evqweQxR/DOJG05
         4h/jPV18u8XKjiLcSjbg6ETY0dy2kXsEsyDYFm74UJzpLfrqKriJ2md79NzmXYbwX0Kw
         nGdHgY4vL1Ta6kpca/Cbd3YO39ryZKE0cQB52/B9O9EXTHyuZ93i03DXxMSQUPRcUN+q
         +v8g==
X-Gm-Message-State: AOAM5302zXFh8ukS4EQA039QpHtj/8sV4s2kc7hbx/wXYN9ug4TeAxrE
        H5gTTSmjoBT+j2YV39zZGNUdePFhvGU=
X-Google-Smtp-Source: ABdhPJytcCOEYX9Cx460s6gmtxieTC/ihLN+/qbsxBBPsXRlP/onorg9IulAvtIdFuldDrHNpITDJw==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr27724523wrc.378.1619519907710;
        Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm3244000wrx.32.2021.04.27.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
Message-Id: <248d9ffe79272c7a6efef64512d72ccb9a91349a.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:06 +0000
Subject: [PATCH v2 05/21] t1401-symbolic-ref: avoid direct filesystem access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a4ebb0b65fec..315a62f78019 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -3,21 +3,20 @@
 test_description='basic symbolic-ref tests'
 . ./test-lib.sh
 
-# If the tests munging HEAD fail, they can break detection of
-# the git repo, meaning that further tests will operate on
-# the surrounding git repo instead of the trash directory.
-reset_to_sane() {
-	echo ref: refs/heads/foo >.git/HEAD
-}
-
-test_expect_success 'symbolic-ref writes HEAD' '
+test_expect_success 'setup' '
 	git symbolic-ref HEAD refs/heads/foo &&
-	echo ref: refs/heads/foo >expect &&
-	test_cmp expect .git/HEAD
+	test_commit file &&
+	"$TAR" cf .git.tar .git/
 '
 
-test_expect_success 'symbolic-ref reads HEAD' '
-	echo refs/heads/foo >expect &&
+reset_to_sane() {
+	rm -rf .git &&
+	"$TAR" xf .git.tar
+}
+
+test_expect_success 'symbolic-ref read/write roundtrip' '
+	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
+	echo refs/heads/read-write-roundtrip >expect &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expect actual
 '
@@ -25,12 +24,13 @@ test_expect_success 'symbolic-ref reads HEAD' '
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
@@ -42,16 +42,16 @@ reset_to_sane
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

