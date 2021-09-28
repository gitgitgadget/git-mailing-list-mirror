Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4FEC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0BB61262
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhI1CUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbhI1CUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CEC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t18so55268451wrb.0
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iI+WM2HBrYyDrGeWCfoUsX86fKnG1r5hj88mRCKeUw4=;
        b=A14ZMwq/1r0V8U4GCzyLJIHJP5eNg3/QTW+x7mCYRGqRaqNJ5SUPb4NMeuq7ULEuPu
         cnk5tsBga8R+njNgO2k0XyPegl2BLbGWCuqkOUufAa4GpgIKNo6k6dtt1XJ1xgpI/7RA
         i6iz0A/SFayTT10UvvTlW38QvzS+++otxd/y11dx7G02sxTb8U6cHrCNGvBQXk0FAkt2
         zBbyXWClBsgfrbwpLeOs1vtHW3uI/qpgyJisN9AxL5GW87caUg7LZMeIk6q2vlAxSyua
         ZrYHMteaOJJ05/N1EzO6omf9bIUpJOiLfNv6OPdkqpZQ5acSkjn4KjV3NTibfOOLpkog
         txYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iI+WM2HBrYyDrGeWCfoUsX86fKnG1r5hj88mRCKeUw4=;
        b=jNJ6K5poSt1El3GOO5XbcD+Foz5yIelKrGRR4KK2XDgcddM3sp7I/twlgcA74gct/j
         GOfvUo0AfuCUFHhHhnGokKeJ7WwI3s1rnwCeLhHrANqtANAlVZ2rF6TuXGCKNo9nUqv0
         77Kr5S2pWJpChDDTehCYn6EFQCVSB1Mn6474kwCMJ2fzYdAZPbbv32uj7T36nzi7+ig3
         yYUk2o72K8Ffn6oRny2sJVWuVsSfVszARpj3ixBo55atv11+e/jdmMOH7zBLtR8wvAfI
         gzCKwRYpQBinMctKaDOAsY56kc77Q5jRqEvWiy1XEbCvtacOPLGtjAuPSx+GUiPPO0P7
         xtAQ==
X-Gm-Message-State: AOAM5336j1JLsUyaPTo0gHbR/v8VS6gzYiMDxk/VWYbSzeTizGba+rEL
        NmjTscUSIgRtUGdu62ZIj6mTfrELNmvNnw==
X-Google-Smtp-Source: ABdhPJzcn3h20cBbUS+sM1dm+icmLxgYahXGlt7yVgu6ZPU8bD8R6pACu9XkVETgmxjn1JPlxTUvDA==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr3438449wrx.303.1632795543895;
        Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 05/17] cat-file tests: move bogus_* variable declarations earlier
Date:   Tue, 28 Sep 2021 04:18:46 +0200
Message-Id: <patch-v8-05.17-ab2ea1beaaf-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the short/long bogus bogus object type variables into a form
where the two sets can be used concurrently. This'll be used by
subsequently added tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..ea6a53d425b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,36 +315,39 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
-bogus_type="bogus"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+test_expect_success 'setup bogus data' '
+	bogus_short_type="bogus" &&
+	bogus_short_content="bogus" &&
+	bogus_short_size=$(strlen "$bogus_short_content") &&
+	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+
+	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
+	bogus_long_content="bogus" &&
+	bogus_long_size=$(strlen "$bogus_long_content") &&
+	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+'
 
 test_expect_success "Type of broken object is correct" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of broken object is correct" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
-bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
 test_expect_success "Type of broken object is correct when type is large" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of large broken object is correct when type is large" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
-- 
2.33.0.1327.g9926af6cb02

